--[[
Char Bazaar - in game auction setup.

The client already ships the whole "Character Auction Settings" dialog. The
server only has to answer the data requests it sends when the dialog opens and,
at the end, create the auction the website already knows how to run.

Everything that happens after an auction exists - bids, proxy bidding, cancelling,
paying, transferring the character - stays on the website. This module covers the
setup wizard only, which is the one part the client owns.

The request opcode was found by dumping unhandled packets: clicking the auction
button inside the Store sends 0x76 twice in the same instant, carrying a data type
of 0 and 1. The trailing byte is a per packet token the client appends to several
Store packets; the gamestore module never reads its own and the Store works, so it
is read and discarded here as well.
]]

CharBazaar = {
	ModuleName = "CharBazaar",
	Version = "0.1",
}

-- Mirrors the website's own Char Bazaar settings, in MyAAC's config.local.php. The
-- two sides have to agree: the fee charged here is the fee the site quotes, and a
-- character parked on the wrong account would never show up in the auction list.
CharBazaar.Config = {
	fee = 50, -- bazaar_create, in transferable coins
	taxPercent = 12, -- bazaar_tax, the commission kept from a sale
	vaultAccount = 1, -- bazaar_accountid, the account an auctioned character is moved to
	minLevel = 8, -- CHARBAZAAR_MIN_LEVEL
	showcaseSlots = 4, -- CHARBAZAAR_SHOWCASE_SLOTS
	minDays = 1,
	maxDays = 28,

	-- bazaar_create_enabled. The website gates createcharacterauction.php on it and
	-- this is the second door into the same table, so it needs the same switch:
	-- turning creation off there and leaving it on here means the client can create
	-- auctions the website itself would refuse.
	enabled = true,
}

CharBazaar.RecvPackets = {
	C_ConfigurationAction = 0x76,
}

-- Proven by reverse engineering the client, not by convention.
--
-- The read dispatcher builds each incoming message from a table of entries shaped
-- as [opcode u64][pointer to the class vftable]. Walking from the type name string
-- "tibia.protobuf.protocol.GameserverMessageCharacterTradeConfiguration" to the
-- method that emits it, to the vftable holding that method, to the table entry
-- pointing at that vftable, lands on opcode 0x80. The destructor in slot 0 of that
-- vftable names the class outright, which is the confirmation.
--
-- Answering on 0x76 - the request opcode, which convention suggested - was wrong.
-- 0x76 belongs to GameserverMessageInspectionList. The client accepted those
-- packets and fed them to a model that is not on screen, which is why the dialog
-- stayed empty while nothing ever reported an error.
CharBazaar.SendPackets = {
	S_Configuration = 0x80,
}

-- The dialog asks for two blocks when it opens, 0 and 1. Which is which is not
-- known: ECharacterTradeDataType is only ever used as a parameter type in the
-- client, never registered as a Q_ENUM, so its values are not in the binary. The
-- CharacterTradeEnums.DialogState found in the QML does start with Conditions, but
-- that is a different enum and proves nothing about this one.
--
-- Sending the conditions as data type 1 settled it. The client refused them there,
-- asking for a string at offset 9 where type 0 wants one at offset 8, so the two
-- carry different layouts and type 1 is not the conditions. Type 0 had consumed the
-- very same bytes without a single complaint, so type 0 is.
CharBazaar.conditionsDataType = 0

-- Data types 1 and 2 share one branch in the parser and carry the same thing: a
-- list of item id, tier and amount. Which of the two the message answers is kept
-- as a field on the message itself, so the controller can tell them apart without
-- the layouts differing. The client asks for 0 and 1 when the dialog opens and
-- never for 2, so 1 is the one the item picker is waiting on.
CharBazaar.itemsDataType = 1

-- The sales arguments, which the client calls highlights: the "Add sales argument
-- #N" rows, and the search dialog behind them. Data type 3 in the parser is a list
-- of groups, each with a category and a list of pickable entries, which is exactly
-- the shape of the model that dialog binds to.
--
-- Nothing requests it. CharacterTradeDialog.qml only ever calls requestConditions,
-- requestCheckConfiguration, requestConfirmConfiguration and requestClose; opening
-- the picker just flips configurationState to Highlights and binds a model that is
-- already meant to be full. So this block is pushed, not answered, and the moment
-- to push it is right after the conditions.
CharBazaar.highlightsDataType = 3

-- Off in production: this logs a character name every time anyone opens the dialog.
CharBazaar.debug = false

local function debugLog(fmt, ...)
	if CharBazaar.debug then
		logger.info("[CharBazaar] " .. fmt, ...)
	end
end

--[[ ==================== helpers ==================== ]]

--- Escapes the characters a JSON string may not carry raw.
--
-- Everything written through here is built from our own wording and numbers, so it
-- rarely has anything to do. It exists because "the input is ours" stops being true
-- the moment a quest name or a sales argument carries an apostrophe or a quote.
local function jsonEscape(text)
	return (text:gsub("[\\\"]", "\\%0"):gsub("%c", " "))
end

--- Whether a query returns at least one row.
--
-- A query that fails counts as "no rows". The bazaar tables belong to the website
-- and may be absent from a test database; refusing every auction in that case
-- would make the dialog impossible to test at all. The permissive direction is
-- safe here because create() re-checks against the website's own tables before
-- anything is written.
local function rowExists(query)
	local resultId = db.storeQuery(query)
	if not resultId then
		return false
	end

	Result.free(resultId)
	return true
end

--- Runs a query and hands each row to a function.
local function eachRow(query, handle)
	local resultId = db.storeQuery(query)
	if not resultId then
		return
	end

	repeat
		handle(resultId)
	until not Result.next(resultId)

	Result.free(resultId)
end

--- One number out of a query, or the default when there is no row.
local function scalar(query, column, default)
	local value = default

	eachRow(query, function(resultId)
		value = Result.getNumber(resultId, column)
	end)

	return value
end

--- How many of an item a count column really means.
--
-- Mirrors charbazaarItemQuantity() on the website. Only a stackable item keeps a
-- real amount in `count`; on everything else the column is the subtype - charges,
-- fluid, doses - and a rune with five charges is still one rune. Reading it as an
-- amount is how a single blank rune turns into "5 items" on the auction page.
local function quantityOf(itemId, count)
	if ItemType(itemId):isStackable() then
		return math.max(1, count)
	end

	return 1
end

--- A JSON array of strings.
local function jsonList(values)
	local parts = {}

	for _, value in ipairs(values) do
		parts[#parts + 1] = '"' .. jsonEscape(tostring(value)) .. '"'
	end

	return "[" .. table.concat(parts, ",") .. "]"
end

--- The names stored under a kv prefix, i.e. what follows it in each key.
--
-- Same read as kvPlayerKeys() on the website, which is where the shape of these
-- keys comes from: unlocked entries are one key each, named after the entry, so
-- the list doubles as the counter.
--
-- An earlier note in this file said nothing in Lua could enumerate keys by prefix.
-- kv.keys(prefix) does, and returns exactly the suffixes - KVStore::keys walks both
-- what is in memory and a LIKE over kv_store, stripping the prefix off each.
local function kvNames(guid, prefix)
	local names = kv.keys(string.format("player.%d.%s", guid, prefix)) or {}
	table.sort(names)

	return names
end

--- One kv scalar of a character, as a whole number.
local function kvInt(player, key)
	local value = player:kv():get(key)

	return type(value) == "number" and math.floor(value) or 0
end

--- The house's cut of a sale, rounded down.
--
-- Rounded down deliberately and in the player's favour, matching
-- charbazaarCommission() on the website.
function CharBazaar.commission(price)
	local tax = CharBazaar.Config.taxPercent
	if price <= 0 or tax <= 0 then
		return 0
	end

	return math.floor(price * tax / 100)
end

--- Lowest starting price an auction may be created with.
--
-- Below it the sale would cost the seller money, because the commission and the
-- auction fee together would eat more than the winning bid. Walks up from the fee
-- the same way the website does, so both sides land on the same number for
-- whatever fee and tax this server is configured with.
function CharBazaar.minimumStartingBid()
	if CharBazaar.cachedMinimumBid then
		return CharBazaar.cachedMinimumBid
	end

	local fee = math.max(0, CharBazaar.Config.fee)
	local ceiling = fee * 2 + 100

	for price = math.max(1, fee), ceiling do
		if price - CharBazaar.commission(price) - fee >= 1 then
			CharBazaar.cachedMinimumBid = price
			return price
		end
	end

	-- Only reachable with a tax of 100% or more, where no price ever pays off.
	CharBazaar.cachedMinimumBid = math.max(1, fee + 1)
	return CharBazaar.cachedMinimumBid
end

--[[ ==================== sell conditions ==================== ]]

--- The full requirement list for putting a character up for auction.
--
-- Same list, same order and same wording as charbazaarAuctionRequirements() in
-- the website's system/libs/charbazaar.php, so a seller reads the identical
-- checklist whether they start in the client or on the site.
--
-- Two of them are stricter here, and better for it. The website has to use "is
-- the character offline" as a stand in for "is it in a protection zone" and "does
-- it have a logout block", because it cannot see either from outside the game.
-- In game both are readable directly.
function CharBazaar.conditions(player)
	local accountId = player:getAccountId()
	local guid = player:getGuid()
	local conditions = {}

	local function add(status, text)
		conditions[#conditions + 1] = { status = status, text = text }
	end

	local tile = player:getTile()
	local inProtectionZone = tile ~= nil and tile:hasFlag(TILESTATE_PROTECTIONZONE)

	add(not rowExists(string.format(
		"SELECT 1 FROM `myaac_charbazaar` WHERE `account_old` = %d AND `status` = 0 LIMIT 1", accountId
	)), "You may not have any open character trade auctions.")

	add(not rowExists(string.format(
		"SELECT 1 FROM `account_bans` WHERE `account_id` = %d AND (`expires_at` <= 0 OR `expires_at` > %d) LIMIT 1",
		accountId, os.time()
	)), "Your account may not be banned.")

	add(player:getTransferableCoins() >= CharBazaar.Config.fee,
		"You need to have enough transferable Coins to create this auction.")

	add(rowExists(string.format(
		"SELECT 1 FROM `accounts` WHERE `id` = %d AND `key` IS NOT NULL AND `key` <> '' LIMIT 1", accountId
	)), "Your account must be registered.")

	add(player:getLevel() >= CharBazaar.Config.minLevel,
		"The character needs to be at least level " .. CharBazaar.Config.minLevel .. ".")

	add(not rowExists(string.format("SELECT 1 FROM `houses` WHERE `owner` = %d LIMIT 1", guid)),
		"The character may not own any houses.")

	add(not rowExists(string.format("SELECT 1 FROM `houses` WHERE `bidder` = %d LIMIT 1", guid)),
		"The character may not bid for a house.")

	add(not rowExists(string.format("SELECT 1 FROM `houses` WHERE `new_owner` = %d AND `new_owner` > 0 LIMIT 1", guid)),
		"The character may not be involved in a house transfer.")

	add(player:getGuild() == nil, "The character may not be a member of a guild.")

	add(not rowExists(string.format("SELECT 1 FROM `guild_invites` WHERE `player_id` = %d LIMIT 1", guid)),
		"The character may not have applied to a guild.")

	add(not rowExists(string.format("SELECT 1 FROM `market_offers` WHERE `player_id` = %d LIMIT 1", guid)),
		"The character may not have any running auctions in the Market.")

	add(not rowExists(string.format("SELECT 1 FROM `players` WHERE `id` = %d AND `deletion` <> 0 LIMIT 1", guid)),
		"The character may not be scheduled for deletion.")

	add(player:getSkull() == SKULL_NONE, "The character may not be marked with a skull.")

	add(not rowExists(string.format("SELECT 1 FROM `player_namelocks` WHERE `player_id` = %d LIMIT 1", guid)),
		"There may not be an open namelock for the character.")

	add(inProtectionZone, "The character must be in a protection zone.")

	add(not player:isPzLocked(), "Your character may not have a logout block.")

	return conditions
end

--- Whether every condition is met.
function CharBazaar.conditionsMet(conditions)
	for _, condition in ipairs(conditions) do
		if not condition.status then
			return false
		end
	end

	return true
end

--[[ ==================== protocol ==================== ]]

--- Answers a request for the sell conditions.
--
-- This is the dialog's first page: every rule for putting a character up for
-- auction, each marked met or unmet, and the gate on whether the seller may go on.
--
-- Measured against the real message by sending an all zero body and growing it one
-- field at a time. Every refusal names the offset the client stopped at and how many
-- bytes it wanted there, so the skeleton mapped itself:
--
--   18 bytes -> wants 4 at offset 16   offsets 1 to 15 pass, a u32 sits at 16
--   20 bytes -> wants 2 at offset 20   a u16 follows it
--   22 bytes -> wants 1 at offset 22   a u8 follows that
--   23 bytes -> accepted, empty list   that is the whole skeleton
--
-- then, with offset 22 set to one instead of zero:
--
--   wants 2 at offset 23   so offset 22 is the entry count and an entry opens with
--                          a string
--   wants 1 at offset 25   so a single byte closes the entry, which is the status
--
-- Final layout:
--
--   [0]      opcode 0x80
--   [1]      data type
--   [2..15]  fourteen bytes, unidentified, zeros accepted
--   [16..19] u32, unidentified
--   [20..21] u16, unidentified
--   [22]     entry count
--   then per entry: [text string][status u8]
--
-- An earlier version of this file carried a different layout, measured just as
-- carefully but against opcode 0x76, which turned out to be a different message
-- entirely. None of it applied and it has been removed.
--
-- The skeleton above is what probing saw; sendConditions() writes the real fields,
-- read out of the parser afterwards, so nothing here is a table any more.

-- From EYesNoWarning in the client. The status of a condition is not a boolean: the
-- delegate in CharacterTradeNotifications.qml picks its icon by comparing against
-- TibiaEnums.Yes, .No and .Warning.
--
-- The values do not follow the order the names are listed in the client's metadata.
-- Reading that order gave Yes = 0, and sending 0 for sixteen conditions the server
-- had just confirmed as met drew sixteen red crosses. So 0 is No, and the ordering
-- in the metadata says nothing about the numbering.
CharBazaar.Status = {
	YES = 1,
	NO = 0,
	WARNING = 2,
}

-- Probe mode, kept because it is what mapped the layout and what will map the other
-- blocks. Set probeBytes to a count and the body becomes that many zero bytes and
-- nothing else; the client then names the offset and width of the first field it
-- still wants. probeSetOffset and probeSetValue poke one of those bytes to a non
-- zero value, which is how a count gets told apart from a plain field. Leave
-- probeBytes nil for normal operation.
-- Walk for data type 1, message being [0x80][01][probe bytes]:
--   21 bytes -> "Unknown Gameserver Message: 0", meaning the message ended early and
--               a leftover zero was taken for the next opcode. So this block is
--               shorter than the conditions one and the skeleton is not shared.
--
-- Restarting from nothing:
--   0 bytes -> wants 2 at offset 2, so a u16 opens the block
--   2 bytes -> accepted. The whole block is [0x80][01][u16], four bytes, and it
--              renders a page with no items to pick, so that u16 reads like a count
--              that ends the message when it is zero.
--
-- Poking it to one to see what an entry looks like:
--   count of 1 -> wants 2 at offset 4, so an entry opens with a u16 as well
--   4 bytes    -> wants 4 at offset 6, so a u32 follows it
--   8 bytes    -> "The TAppearanceType::ID 0 does not exist in OBJECTS!"
--
-- That last one is the first answer about meaning rather than width: the u16 at
-- offset 4 is an appearance id, so this block is the list behind the item picker.
-- Sending a real one to see the entry render.
--   8 bytes with a valid id and a one in that u32 -> accepted, and nothing drew.
--     So the entry is being read without complaint but the row is dropped, which
--     means either the entry carries more fields after the u32 or this block is not
--     the item picker at all. Widths are all this technique can settle; that
--     question needs the meaning of the fields.
--
-- Back on the conditions block, to find what those fourteen bytes really are.
--
-- They are only fourteen because they are zero. The Cyclopedia character info in
-- this same server is built as [opcode][subtype][error byte][name][vocation][level]
-- [outfit], and AddOutfit is itself variable: four bytes for a null look type, seven
-- for a real one. So some of those fourteen are string length prefixes reading as
-- empty, which is why a page that accepts them still draws no character.
--
-- Sending an unmistakable length in the first candidate: if offsets 2 and 3 are a
-- string prefix, the client will ask for exactly 200 bytes at offset 4.
-- Which block the probe answers, how many body bytes it sends, and which of those
-- bytes carry a value instead of zero, keyed by their offset in the message.
CharBazaar.probeDataType = 0
CharBazaar.probeBytes = nil
CharBazaar.probePokes = {}

--- Writes an outfit the way this client reads one.
--
-- Mirrors ProtocolGame::AddOutfit with addMount false: the look type first, then
-- either the four colours and the addons, or a second u16 when the look type is
-- zero. The size is not fixed, which is why probing the surrounding bytes could
-- never have settled this field.
function CharBazaar.addOutfit(msg, outfit)
	msg:addU16(outfit.lookType or 0)

	if (outfit.lookType or 0) ~= 0 then
		msg:addByte(outfit.lookHead or 0)
		msg:addByte(outfit.lookBody or 0)
		msg:addByte(outfit.lookLegs or 0)
		msg:addByte(outfit.lookFeet or 0)
		msg:addByte(outfit.lookAddons or 0)
	else
		msg:addU16(outfit.lookTypeEx or 0)
	end
end

--- Sends a body of zero bytes for a block whose layout is not mapped yet.
--
-- Every count inside stays zero, so nothing nested expands and the client walks the
-- message by its shortest path. Each refusal then names the offset it stopped at and
-- how many bytes it wanted, which is one field of the layout per round.
function CharBazaar.sendProbe(player, dataType)
	local msg = NetworkMessage()
	msg:addByte(CharBazaar.SendPackets.S_Configuration)
	msg:addByte(dataType)

	local pokes = CharBazaar.probePokes or {}

	for index = 1, CharBazaar.probeBytes do
		-- The probe body starts at message offset 2, so offset 2 is the first byte.
		msg:addByte(pokes[index + 1] or 0)
	end

	msg:sendToPlayer(player)

	local described = {}
	for offset, value in pairs(pokes) do
		described[#described + 1] = string.format("%d=0x%02X", offset, value)
	end
	table.sort(described)

	debugLog("probe: {} bytes for dataType {}, pokes [{}]",
		CharBazaar.probeBytes, dataType, table.concat(described, " "))
end

function CharBazaar.sendConditions(player, dataType)
	local conditions = CharBazaar.conditions(player)

	local msg = NetworkMessage()
	msg:addByte(CharBazaar.SendPackets.S_Configuration)
	msg:addByte(dataType)

	-- Read straight out of the client's parser rather than guessed. The reader for
	-- opcode 0x80 takes the data type as a byte, then for type 0 walks:
	--
	--   string  -> the character overview's first text
	--   u16
	--   byte    -> stored twice, as value % 10 and as a flag for value > 9
	--   a nested read on the reader's own vtable, four bytes when zeroed, which is
	--           the size of an outfit whose look type is zero
	--   byte
	--   u32
	--   u32
	--   u16
	--   byte    -> the entry count, then that many [text][status] pairs
	--
	-- The nested read explains the missing outfit: a look type of zero is a valid
	-- outfit that draws nothing.
	-- The two bytes around the outfit were the other way round. Sending a vocation id
	-- of 4 in the one after it drew "retro hardcore pvp", which is world type 4, so
	-- that byte is the world type and the one before the outfit is the vocation.
	--
	-- That also explains the halves the parser splits the earlier byte into: the base
	-- vocation in value % 10, and promotion in value > 9. The server's world type enum
	-- already numbers open, optional, hardcore, retro and retro hardcore from zero to
	-- four, which is the client's own numbering, so it goes out unmapped.
	--
	-- The vocation is not. The server numbers sorcerer to knight as 1 to 4 and the
	-- client numbers them the other way round, so sending the server id showed a
	-- knight as a druid. vocations.xml already carries the client's own numbering in
	-- its clientid attribute, and it is built exactly as the parser splits it: 1 to 5
	-- for the base vocations and 11 to 15 for their promotions. So the client id goes
	-- out whole, with no arithmetic of ours on top of it.
	local now = os.time()
	local vocation = player:getVocation()

	msg:addString(player:getName(), "CharBazaar.sendConditions - character name")
	msg:addU16(player:getLevel())
	msg:addByte(vocation:getClientId())

	CharBazaar.addOutfit(msg, player:getOutfit())

	msg:addByte(Game.getWorldType())
	msg:addU32(now + 86400) -- a timestamp, confirmed to drive the dates on screen
	msg:addU32(now + 29 * 86400)

	-- The lowest starting price the seller may enter. UNVERIFIED, and worth trying
	-- because of what the settings page does with it: the price field's validator
	-- takes its floor from auctionConfiguration.minimumMinimumBid, and
	-- hasConfigurationError is nothing more than that field refusing its contents.
	-- This u16 is the only number in the block with nowhere else to go, and while it
	-- went out as zero the floor was zero, so an empty price passed the client
	-- untouched and only the server ever objected.
	--
	-- Clamped because the field is a u16 and the floor is derived from the fee: a
	-- server configured with a large enough fee would wrap it silently, and a wrapped
	-- floor reads to the client as "any price is fine".
	local floor = CharBazaar.minimumStartingBid()
	if floor > 65535 then
		logger.warn("[CharBazaar] the minimum starting bid of {} does not fit the client's "
			.. "u16 field: it is being sent as 65535, so only the server will enforce the real floor", floor)
		floor = 65535
	end

	msg:addU16(floor)
	msg:addByte(#conditions)

	-- The delegate reads two roles per row, model.notification for the text and
	-- model.status for the icon, and the measured layout puts the text first.
	for _, condition in ipairs(conditions) do
		msg:addString(condition.text, "CharBazaar.sendConditions - text")
		msg:addByte(condition.status and CharBazaar.Status.YES or CharBazaar.Status.NO)
	end

	msg:sendToPlayer(player)

	debugLog("sent conditions to {}: {} entries, all met: {}",
		player:getName(), #conditions, tostring(CharBazaar.conditionsMet(conditions)))
end

--[[ ==================== items ==================== ]]

--- Adds one item id to a running count, keyed by item id and tier.
local function tally(totals, itemId, tier, amount)
	local byTier = totals[itemId]
	if not byTier then
		byTier = {}
		totals[itemId] = byTier
	end

	byTier[tier] = (byTier[tier] or 0) + amount
end

--- Adds one live item to a running count.
local function tallyItem(totals, item)
	if not item then
		return
	end

	local itemId = item:getId()
	tally(totals, itemId, item:getTier() or 0, quantityOf(itemId, item:getCount()))
end

--- Adds everything inside an item that holds things, nested bags included.
--
-- getItems(true) walks with the same ContainerIterator the server uses to build
-- the Cyclopedia item summary, so both arrive at the same totals.
--
-- The presence of getItems is the test for whether the item is a container,
-- because the server only gives the userdata the Container metatable when it is
-- one. item:getContainer() looks like the obvious route and is a trap: it pushes
-- the container with no metatable at all, so every method called on it fails.
local function tallyContents(totals, item)
	if not item or not item.getItems then
		return
	end

	for _, contained in ipairs(item:getItems(true)) do
		tallyItem(totals, contained)
	end
end

--- Adds the rows of an item table in the database to a running count.
--
-- Everything read this way lands on tier zero, because a stored item keeps its tier
-- in a serialized blob rather than in a column. That is only ever used for tables
-- whose items cannot carry a tier in the first place.
local function tallyDatabaseItems(totals, query, idColumn, countColumn)
	eachRow(query, function(resultId)
		local itemId = Result.getNumber(resultId, idColumn)

		if itemId > 0 then
			tally(totals, itemId, 0, quantityOf(itemId, Result.getNumber(resultId, countColumn)))
		end
	end)
end

--- Sorts a tally into a list of { id, tier, count }, by id and then by tier.
local function flatten(totals)
	local itemIds = {}
	for itemId in pairs(totals) do
		itemIds[#itemIds + 1] = itemId
	end
	table.sort(itemIds)

	local entries = {}
	for _, itemId in ipairs(itemIds) do
		local tiers = {}
		for tier in pairs(totals[itemId]) do
			tiers[#tiers + 1] = tier
		end
		table.sort(tiers)

		for _, tier in ipairs(tiers) do
			entries[#entries + 1] = { id = itemId, tier = tier, count = totals[itemId][tier] }
		end
	end

	return entries
end

--- Everything that changes hands with the character, split the way the website
--- splits it: `owned` is what the auction page lists, `store` is the Store Inbox.
--
-- Returns { owned = { { id, tier, count }, ... }, store = the same shape }.
--
-- The split is not cosmetic. charbazaarPlayerItems() puts the Store Inbox in its
-- own block and everything else in one list, and the auction list's item search
-- runs over that list - so an item filed under the wrong one is an item nobody can
-- search for.
--
-- Owned means the inventory and its bags, the mailbox, the depot and the stash.
--
-- The depot is walked live, one box at a time, which is what gives its items their
-- tier - the database keeps a stored item's tier inside a serialized blob no query
-- can read. Asking for a box that does not exist returns false rather than creating
-- one, and a character with anything in a box has that box in memory since login,
-- where iologindata loads it.
--
-- Reading it used to move the player's Market. player:getDepotChest wrote the last
-- depot id as a side effect, so counting boxes left it pointing at a box number; the
-- binding no longer does that, and Actions::internalUseItem stayed the one place
-- that answers "which depot did this player open".
--
-- The stash still comes from its table, because Lua can ask how many of one item is
-- in there but cannot list it. It costs nothing: the stash only ever holds stackable
-- items, which carry no tier.
--
-- The Store Inbox is slot CONST_SLOT_LAST, so it is already inside the loop. An
-- earlier version walked it there and then walked it again by hand, which doubled
-- the amount of everything a character had bought.
function CharBazaar.itemTotals(player)
	local guid = player:getGuid()
	local owned, store = {}, {}

	for slot = CONST_SLOT_FIRST, CONST_SLOT_LAST do
		local item = player:getSlotItem(slot)

		if item then
			if slot == CONST_SLOT_STORE_INBOX then
				-- The container itself belongs to nobody and is not sold with the
				-- character, so only what is inside it counts.
				tallyContents(store, item)
			else
				tallyItem(owned, item)
				tallyContents(owned, item)
			end
		end
	end

	tallyContents(owned, player:getInbox())

	for box = 1, configManager.getNumber(configKeys.DEPOT_BOXES) do
		-- The box itself is furniture, so only its contents are counted.
		tallyContents(owned, player:getDepotChest(box, false))
	end

	tallyDatabaseItems(owned, string.format(
		"SELECT `item_id`, `item_count` FROM `player_stash` WHERE `player_id` = %d AND `item_id` > 0", guid
	), "item_id", "item_count")

	return { owned = flatten(owned), store = flatten(store) }
end

--- Answers a request for the character's items.
--
-- Read straight out of the client's parser, which for data types 1 and 2 walks:
--
--   [u16] entry count
--   then per entry:
--     [u16]  item id
--     [byte] tier, only for some items
--     [u32]  amount
--
-- That middle byte is the part probing could never have found, because it is not
-- always there. The client looks the item id up in a table of its own before
-- deciding to read it, so a packet carrying no such item parses perfectly and one
-- carrying a single one desynchronises everything after it - which is what an
-- earlier attempt saw as "accepted, and nothing drew".
--
-- The condition is the item type having an upgrade classification, the same rule
-- the server already applies in every message that names an item:
--
--   if (it.upgradeClassification > 0) { msg.addByte(tier); }
--
-- ProtocolGame::sendCyclopediaCharacterItemSummary sends this exact entry shape,
-- which is why this block could be written from the C++ next door instead of
-- being measured a byte at a time.
--
-- Only the owned items are offered. The showcase is picked out of this list, and
-- charbazaarBuildShowcase() on the website re-checks every pick against the same
-- set - so offering Store Inbox items here would offer picks that both sides then
-- silently drop.
function CharBazaar.sendItems(player, dataType)
	local entries = CharBazaar.itemTotals(player).owned

	local msg = NetworkMessage()
	msg:addByte(CharBazaar.SendPackets.S_Configuration)
	msg:addByte(dataType)
	msg:addU16(#entries)

	for _, entry in ipairs(entries) do
		msg:addU16(entry.id)

		if ItemType(entry.id):getClassification() > 0 then
			msg:addByte(entry.tier)
		end

		msg:addU32(entry.count)
	end

	msg:sendToPlayer(player)

	debugLog("sent items to {}: {} entries", player:getName(), #entries)
end

--[[ ==================== sales arguments ==================== ]]

-- The fifteen category names are in the binary as Q_ENUM metadata:
--
--   CHARACTERTRADE_HIGHLIGHT_CATEGORY_ACHIEVEMENTS, _BESTIARY, _BLESSINGS,
--   _BOSSTIARY, _CHARACTER_WORLD_TRANSFER, _CYCLOPEDIA_MAP, _DAILY_REWARD_STREAK,
--   _EXALTATION_SUMMARY, _GOLD, _PREY_HUNTING_TASKS, _PROMOTIONPOINTSBONUS,
--   _QUESTS, _SKILLS, _STORE_ASSETS, _STORE_ITEMS
--
-- The numbers are NOT. Only the names are stored, and stored alphabetically, which
-- is the same trap the condition status byte was.
--
-- The numbers below do not come from that order - they come from the website, whose
-- "Special Character Features" block was built from real tibia.com markup and so
-- carries CipSoft's own numbering in its usp-category-N classes. Reading
-- charbazaarFeatureEntries() in system/libs/charbazaar.php back to front gives:
--
--   0 skills and level, 2 achievement points, 4 exalted dust, 5 mounts and outfits
--   and hirelings, 6 quests, 7 charm points, 8 titles and badges, 9 hunting task
--   points and prey wildcards, 12 boss points
--
-- which lines up with the client's enum names one for one, and rules the
-- alphabetical reading out: it would have put SKILLS at 12 and ACHIEVEMENTS at 0.
--
-- Using the website's numbers rather than a second set of our own is also what lets
-- a sales argument chosen in game render on the website with the icon it had here.
--
-- GOLD and BLESSINGS are the two the website never draws, so they have no known
-- number and the ones here are placeholders. Set CharBazaar.categoryProbe to true to
-- send one group per id and read the whole sheet off the screen.
CharBazaar.HighlightCategory = {
	SKILLS = 0,
	ACHIEVEMENTS = 2,
	EXALTATION_SUMMARY = 4,
	STORE_ASSETS = 5,
	QUESTS = 6,
	BESTIARY = 7,
	TITLES_AND_BADGES = 8,
	PREY_HUNTING_TASKS = 9,
	BOSSTIARY = 12,

	-- Not drawn by the website, so not readable from it. Settled by looking at the
	-- icons themselves in api/tibiacom/images/charactertrade: usp-category-1 is a
	-- gold coin, dominant colours #E0C000 over #A04000, which no other icon in the
	-- set comes close to.
	GOLD = 1,

	-- UNVERIFIED. Three numbers are still unspoken for - 3 amber, 10 orange, 11 blue
	-- - and at ten pixels square none of them says "blessing" on sight. The client
	-- draws this icon next to the row in the picker, so opening it is the cheapest
	-- way to settle it; CharBazaar.categoryProbe settles the whole sheet at once.
	BLESSINGS = 3,
}

CharBazaar.categoryProbe = false

-- Every sales argument a seller may pick, in the order they are offered.
--
-- The ids are fixed here on purpose and must stay fixed: the client sends one back
-- with addHighlight when the seller picks a row, and the auction stores it. Numbers
-- generated per request would rot the moment the catalogue grows.
--
-- Only arguments this server can actually back with a number are listed. The client
-- has categories for things crystalserver has no notion of - Character World
-- Transfer, the Cyclopedia map, Exaltation, store assets - and those stay out
-- rather than being filled with something invented.
CharBazaar.Highlights = {
	{ id = 1, category = "SKILLS", text = function(player) return "Level " .. player:getLevel() end },
	{ id = 2, category = "SKILLS", text = function(player) return "Magic Level " .. player:getMagicLevel() end },
	{ id = 3, category = "SKILLS", text = function(player) return "Fist Fighting " .. player:getSkillLevel(SKILL_FIST) end },
	{ id = 4, category = "SKILLS", text = function(player) return "Club Fighting " .. player:getSkillLevel(SKILL_CLUB) end },
	{ id = 5, category = "SKILLS", text = function(player) return "Sword Fighting " .. player:getSkillLevel(SKILL_SWORD) end },
	{ id = 6, category = "SKILLS", text = function(player) return "Axe Fighting " .. player:getSkillLevel(SKILL_AXE) end },
	{ id = 7, category = "SKILLS", text = function(player) return "Distance Fighting " .. player:getSkillLevel(SKILL_DISTANCE) end },
	{ id = 8, category = "SKILLS", text = function(player) return "Shielding " .. player:getSkillLevel(SKILL_SHIELD) end },
	{ id = 9, category = "SKILLS", text = function(player) return "Fishing " .. player:getSkillLevel(SKILL_FISHING) end },
	{ id = 10, category = "GOLD", text = function(player) return "Bank Balance " .. player:getBankBalance() end },
	{ id = 11, category = "BLESSINGS", text = function(player) return CharBazaar.blessingCount(player) .. " of 7 Blessings" end },
	{ id = 12, category = "ACHIEVEMENTS", text = function(player) return player:getAchievementPoints() .. " Achievement Points" end },
	{ id = 13, category = "PREY_HUNTING_TASKS", text = function(player) return player:getTaskHuntingPoints() .. " Hunting Task Points" end },
}

-- The section header drawn above each group. Ours to write, so it is the wording
-- the website already uses rather than the client's enum names.
CharBazaar.HighlightCategoryNames = {
	SKILLS = "Skills",
	GOLD = "Gold",
	BLESSINGS = "Blessings",
	ACHIEVEMENTS = "Achievements",
	PREY_HUNTING_TASKS = "Prey and Hunting Tasks",
}

--- How many of the seven blessings that count the character carries.
--
-- Index 1 is Twist of Fate, which is not one of the seven, so it is skipped - the
-- same split the website's history page had to make. See the note there about
-- players.blessings being a dead column.
function CharBazaar.blessingCount(player)
	local count = 0
	for index = 2, 8 do
		if player:getBlessingCount(index) > 0 then
			count = count + 1
		end
	end

	return count
end

--- The catalogue as groups, ready to go on the wire.
--
-- Groups keep the order the highlights are listed in, so the catalogue table is the
-- single place that decides what the seller sees and in which order.
function CharBazaar.highlightGroups(player)
	if CharBazaar.categoryProbe then
		local probe = {}
		for category = 0, 14 do
			probe[#probe + 1] = {
				category = category,
				name = "category " .. category,
				entries = { { id = 1000 + category, text = "category " .. category } },
			}
		end

		return probe
	end

	local groups = {}
	local byCategory = {}

	for _, highlight in ipairs(CharBazaar.Highlights) do
		local group = byCategory[highlight.category]
		if not group then
			group = {
				category = CharBazaar.HighlightCategory[highlight.category],
				name = CharBazaar.HighlightCategoryNames[highlight.category] or highlight.category,
				entries = {},
			}
			byCategory[highlight.category] = group
			groups[#groups + 1] = group
		end

		group.entries[#group.entries + 1] = { id = highlight.id, text = highlight.text(player) }
	end

	return groups
end

--- Sends the sales arguments the seller may pick from.
--
-- Layout, read off the data type 3 branch of the parser:
--
--   [byte] group count
--   then per group:
--     [byte]   category, which picks the row icon
--     [string] section header
--     [u16]    entry count
--     then per entry:
--       [u16]    highlight id, the one addHighlight sends back
--       [string] the row's text
--
-- It lines up field for field with what CharacterTradeHighlightPicker.qml binds to:
-- section.property "category", model.categoryicon, model.highlight and
-- model.highlightid.
function CharBazaar.sendHighlights(player, dataType)
	local groups = CharBazaar.highlightGroups(player)

	local msg = NetworkMessage()
	msg:addByte(CharBazaar.SendPackets.S_Configuration)
	msg:addByte(dataType)
	msg:addByte(#groups)

	local total = 0

	for _, group in ipairs(groups) do
		msg:addByte(group.category)
		msg:addString(group.name, "CharBazaar.sendHighlights - category")
		msg:addU16(#group.entries)

		for _, entry in ipairs(group.entries) do
			msg:addU16(entry.id)
			msg:addString(entry.text, "CharBazaar.sendHighlights - text")
			total = total + 1
		end
	end

	msg:sendToPlayer(player)

	debugLog("sent highlights to {}: {} groups, {} entries", player:getName(), #groups, total)
end

--[[ ==================== summary ==================== ]]

-- The last of the three pages: what the seller is agreeing to, and the gate on the
-- Confirm button.
--
-- Named by the client's own sub message list. The binary carries the type names of
-- everything nested inside GameserverMessageCharacterTradeConfiguration, and they
-- line up one for one with the branches in the parser:
--
--   CharacterTradeBaseData              -> data type 0
--   CharacterTradeHighlightsItemsData   -> data types 1 and 2
--   CharacterTradeHighlightsTextualData -> data type 3
--   CharacterTradeSummaryData           -> data type 4
--
-- Unlike the sales arguments this one IS requested: pressing Next on the settings
-- page calls requestCheckConfiguration and only then switches to the confirmation
-- page, so the empty box is the answer that never came.
CharBazaar.summaryDataType = 4

--- Sends the confirmation page's contents.
--
-- Layout, read off the data type 4 branch of the parser:
--
--   [u16]  the auction fee
--   [byte] extra line count
--   then per line: [string]
--
-- The u16 is not a header field to fill in with anything: the whole confirmation
-- page hangs off it. The function that builds the page opens with
--
--     if (*(short *)(summary + 0xe8) != 0) { ... }
--
-- and everything is inside that branch - the six standard lines, and the reset of
-- the flag the Confirm button reads. Send a zero there and the page is built empty
-- and the button stays disabled, with no parse error anywhere, because nothing was
-- malformed. It was simply never told the fee.
--
-- Further down the same function the value is spent as the argument of
-- charactertrade_confirmation_auction_fee, "an auction fee of %1", which is what it
-- is. So it goes out as the fee, and the fee is never zero.
--
-- The six lines the page shows are the client's own, from its translation file, and
-- it fills them from state it already has: the character's name and the price and
-- end time the seller just typed. Only the fee had to come from here.
--
-- The extra lines are what a refusal is said with. Each one appended sets a byte on
-- the controller that is cleared right before the loop and set nowhere else, which
-- is the shape of the flag the Confirm button is gated on - so a summary carrying
-- problems should both show them and lock the button, and one carrying none should
-- leave it open. UNVERIFIED, but it is the only lever this message has, and the six
-- standard lines are drawn either way.
function CharBazaar.sendSummary(player, dataType, problems)
	problems = problems or {}

	local msg = NetworkMessage()
	msg:addByte(CharBazaar.SendPackets.S_Configuration)
	msg:addByte(dataType)
	msg:addU16(CharBazaar.Config.fee)
	msg:addByte(#problems)

	for _, problem in ipairs(problems) do
		msg:addString(problem, "CharBazaar.sendSummary - problem")
	end

	msg:sendToPlayer(player)

	-- Said twice on purpose. The list on the confirmation page is the answer if the
	-- flag really does gate the button; the message in the game window is the answer
	-- if it does not, and costs one line.
	for _, problem in ipairs(problems) do
		player:sendTextMessage(MESSAGE_FAILURE, problem)
	end

	debugLog("sent summary to {}: fee {}, {} problems",
		player:getName(), CharBazaar.Config.fee, #problems)
end

-- sendBaseData and sendEmptyBlock lived here: two guesses at blocks that turned out
-- not to exist. Nothing ever called either, and sendEmptyBlock would have thrown if
-- anything had - it read CharBazaar.Layout.headerU32, a field that was never
-- defined. The four blocks the dialog really uses are all answered above.

--[[ ==================== creating the auction ==================== ]]

-- Highest starting price the website accepts, from CHARBAZAAR_MAX_BID.
CharBazaar.maximumStartingBid = 999999999

--- Reads the configuration the seller assembled, off actions 2 and 3.
--
-- Layout, decoded from real packets rather than from the client's writer:
--
--   [u32]  starting price
--   [u32]  auction end timestamp
--   [byte] item count, then that many items
--   [byte] store item count, then that many items
--   [byte] sales argument count, then that many [u16] highlight ids
--   [byte] the trailing token
--
-- An item is a [u16] id, followed by a [byte] tier only when the item type has an
-- upgrade classification - the same rule the server applies on the way down.
--
-- That rule is the reason a first reading failed. items.xml has no
-- upgradeClassification on a plain remedy crossbow, yet the client sent a tier byte
-- for one, and every alignment that ignored it produced an item id that does not
-- exist. items.xml is simply not where the value comes from: Items::loadFromProtobuf
-- takes it from the appearances, the same file the client reads, so the runtime
-- value agrees with the client even when the XML looks like it does not. Asking
-- ItemType is right; asking items.xml is not.
--
-- The store item list is always empty for now because the block that would offer
-- them, data type 2, is never sent.
function CharBazaar.parseConfiguration(msg)
	local function readItems()
		local items = {}

		for _ = 1, msg:getByte() do
			local itemId = msg:getU16()
			local tier = 0

			if ItemType(itemId):getClassification() > 0 then
				tier = msg:getByte()
			end

			items[#items + 1] = { id = itemId, tier = tier }
		end

		return items
	end

	local configuration = {
		price = msg:getU32(),
		endTimestamp = msg:getU32(),
	}

	configuration.items = readItems()
	configuration.storeItems = readItems()

	configuration.highlights = {}
	for _ = 1, msg:getByte() do
		configuration.highlights[#configuration.highlights + 1] = msg:getU16()
	end

	return configuration
end

--- The chosen showcase items as the website stores them: comma separated ids.
--
-- The four items the seller picked have to survive somewhere, and the snapshot that
-- would normally hold them is written by the website's PHP, out of the database,
-- long after this. So they are parked on the auction row instead and
-- charbazaarSnapshotAuction() reads them back when it first freezes the character.
-- Nothing here has to know how a snapshot is built.
--
-- Ids only: the website re-checks each one against what the character owns and
-- takes the count from there, so a tier or a stale count would be thrown away
-- anyway. Capped at the same four slots the website caps at.
function CharBazaar.showcaseIds(items)
	local ids = {}

	for _, item in ipairs(items) do
		if #ids == CharBazaar.Config.showcaseSlots then
			break
		end

		ids[#ids + 1] = tostring(item.id)
	end

	return table.concat(ids, ",")
end

--[[ ==================== the snapshot ==================== ]]

-- The frozen copy of the character, written the moment the auction is created.
--
-- The website has its own writer, charbazaarSnapshotAuction(), and would eventually
-- run it - charbazaarCurrentEnsureSnapshots() freezes any running auction that has
-- no snapshot yet, on the next page view. Doing it here instead means the auction is
-- complete when it is created rather than when someone happens to look at it.
--
-- Which makes this the only writer that will ever run for an auction created in the
-- game. The website's "freeze it later" is `WHERE status = 0 AND s.id IS NULL`: a row
-- written here is a row it never looks at again. So a value this module does not know
-- how to read is not a value the website fills in afterwards - it is a zero on the
-- auction page for as long as the auction exists. That is why every key
-- charbazaarPlayerFeatures() writes is written here too, even the ones that cost a
-- query apiece, and why the ones that genuinely have no source say so out loud.
--
-- Every value comes from the character standing in front of us or from its own row,
-- never from a second reading of the same thing. That is also why the scalars go in
-- as INSERT ... SELECT: the columns that are already correct in `players` are copied
-- across without Lua touching them, and only what has to be computed is computed.

--- The ten worn slots, as "slot": item id.
function CharBazaar.snapshotEquipment(player)
	local parts = {}

	for slot = CONST_SLOT_HEAD, CONST_SLOT_AMMO do
		local item = player:getSlotItem(slot)
		if item then
			parts[#parts + 1] = string.format('"%d":%d', slot, item:getId())
		end
	end

	return "{" .. table.concat(parts, ",") .. "}"
end

--- Everything the character owns, in the shape the website's item summary reads.
function CharBazaar.snapshotItems(totals)
	local parts = {}

	for _, entry in ipairs(totals) do
		parts[#parts + 1] = string.format('{"id":%d,"count":%d}', entry.id, entry.count)
	end

	return "[" .. table.concat(parts, ",") .. "]"
end

--- The Store Inbox, in the shape the website's store block reads: id to amount.
--
-- An object rather than a list, because that block is read as `foreach ($store_items
-- as $id => $count)` - charbazaarPlayerStoreItems() hands it back already aggregated.
function CharBazaar.snapshotStoreItems(totals)
	local amounts, itemIds = {}, {}

	for _, entry in ipairs(totals) do
		if not amounts[entry.id] then
			itemIds[#itemIds + 1] = entry.id
		end

		amounts[entry.id] = (amounts[entry.id] or 0) + entry.count
	end
	table.sort(itemIds)

	local parts = {}
	for _, itemId in ipairs(itemIds) do
		parts[#parts + 1] = string.format('"%d":%d', itemId, amounts[itemId])
	end

	return "{" .. table.concat(parts, ",") .. "}"
end

--- The four chosen items with the amount the character holds of each.
function CharBazaar.snapshotShowcase(totals, chosen)
	local held = {}
	for _, entry in ipairs(totals) do
		held[entry.id] = (held[entry.id] or 0) + entry.count
	end

	local parts = {}
	local seen = {}

	for _, item in ipairs(chosen) do
		if #parts == CharBazaar.Config.showcaseSlots then
			break
		end

		-- Same rule as charbazaarBuildShowcase(): only what the character really
		-- has, and no repeats.
		if held[item.id] and not seen[item.id] then
			seen[item.id] = true
			parts[#parts + 1] = string.format('{"id":%d,"count":%d}', item.id, held[item.id])
		end
	end

	return "[" .. table.concat(parts, ",") .. "]"
end

--- Unlocked outfits, as the website stores them: outfit id to addons.
function CharBazaar.snapshotOutfits(guid)
	local parts = {}

	eachRow(string.format(
		"SELECT `outfit_id`, `addons` FROM `player_outfits` WHERE `player_id` = %d", guid
	), function(resultId)
		parts[#parts + 1] = string.format('"%d":%d',
			Result.getNumber(resultId, "outfit_id"), Result.getNumber(resultId, "addons"))
	end)

	return "{" .. table.concat(parts, ",") .. "}"
end

--- Unlocked mounts, as a list of ids.
function CharBazaar.snapshotMounts(guid)
	local parts = {}

	eachRow(string.format(
		"SELECT `mount_id` FROM `player_mounts` WHERE `player_id` = %d", guid
	), function(resultId)
		parts[#parts + 1] = tostring(Result.getNumber(resultId, "mount_id"))
	end)

	return "[" .. table.concat(parts, ",") .. "]"
end

--- Quests the character has finished, by name.
--
-- The website stores names because storage keys are a server detail, and it reads
-- its own name to storage map out of config.local.php. That map is a copy; the real
-- one is Quests in data-global/lib/core/quests.lua, which is right here, so this
-- reads the original.
--
-- Finished means every mission at its end value, not merely started - the block this
-- feeds says "N Quests completed", and a quest someone opened and walked away from
-- is not one of them. A quest with no missions falls back to its own start storage,
-- which is all such a quest has.
function CharBazaar.snapshotQuests(player)
	local names = {}

	for _, quest in ipairs(Quests or {}) do
		local completed

		if quest.missions and #quest.missions > 0 then
			completed = true
			for _, mission in ipairs(quest.missions) do
				if player:getStorageValue(mission.storageId) < (mission.endValue or 1) then
					completed = false
					break
				end
			end
		else
			completed = player:getStorageValue(quest.startStorageId) >= (quest.startStorageValue or 1)
		end

		if completed then
			names[#names + 1] = quest.name
		end
	end

	return jsonList(names)
end

--- How many of each blessing the character carries, by blessing id.
--
-- One amount per blessing rather than the two summary columns, which is what
-- charbazaarSnapshotBlessings() draws the table from. Ids 1 to 8, where 1 is Twist
-- of Fate; a snapshot without this list falls back to the columns and can only say
-- whether Twist is there.
function CharBazaar.blessingAmounts(player)
	local parts = {}

	for index = 1, 8 do
		parts[#parts + 1] = string.format('"%d":%d', index, player:getBlessingCount(index))
	end

	return "{" .. table.concat(parts, ",") .. "}"
end

--- Charm names by id, from the server's own charm list.
--
-- The bit index in `UnlockedRunesBit` is the charm's id: IOBestiary sets
-- `binary = 1 << id`. So the mask decodes against the list the server loaded rather
-- than against a second copy of the names, and a server carrying charms the website
-- has never heard of still names them.
--
-- Read through Game.createBestiaryCharm because Charm(id) cannot be used:
-- luaCharmCreate pushes the charm it found and then pushes nil on top of it, so it
-- always returns nil. createBestiaryCharm registers a blank charm for an id it does
-- not know, which is why this only ever asks for ids the list already holds.
function CharBazaar.charmNames()
	if CharBazaar.cachedCharmNames then
		return CharBazaar.cachedCharmNames
	end

	local names = {}

	for id = 0, #Game.getBestiaryCharm() - 1 do
		local charm = Game.createBestiaryCharm(id)
		if charm then
			names[id] = charm:name()
		end
	end

	CharBazaar.cachedCharmNames = names
	return names
end

--- Unlocked charms by name, decoded from the rune bitmask.
--
-- Arithmetic rather than bit operators: this runs on Lua 5.1, which has none.
function CharBazaar.unlockedCharms(bitmask)
	local names = CharBazaar.charmNames()
	local unlocked = {}

	for id, name in pairs(names) do
		if math.floor(bitmask / 2 ^ id) % 2 == 1 then
			unlocked[#unlocked + 1] = name
		end
	end

	table.sort(unlocked)
	return unlocked
end

--- The counters behind the "Special Character Features" block.
--
-- Keys are the website's, because the website reads this blob by name, and the full
-- set charbazaarPlayerFeatures() writes is written here - every one of them is read
-- with `?? 0` on the other side, so a key left out does not fail loudly, it draws a
-- zero next to a label that says the character has none of something it has.
--
-- `loyalty_points` is the one key the website drops on purpose: this server runs no
-- loyalty system, so the row would only advertise a feature the game does not have.
-- Dropped here too, so the two blobs carry the same keys.
function CharBazaar.snapshotFeatures(player, guid, salesArguments, storeTotals)
	local counters = {
		boss_points = 0,
		task_points = 0,
		prey_wildcard = 0,
		forge_dusts = 0,
		forge_dust_level = 0,
		lookfamiliarstype = 0,
	}

	eachRow(string.format(
		"SELECT `boss_points`, `task_points`, `prey_wildcard`, `forge_dusts`, `forge_dust_level`, "
			.. "`lookfamiliarstype` FROM `players` WHERE `id` = %d", guid
	), function(resultId)
		for column in pairs(counters) do
			counters[column] = Result.getNumber(resultId, column)
		end
	end)

	local charms = {
		charm_points = 0,
		charm_points_unused = 0,
		minor_charm_echoes = 0,
		minor_charm_echoes_unused = 0,
		charm_expansion = 0,
		unlocked = 0,
	}

	eachRow(string.format(
		"SELECT `charm_points`, `max_charm_points`, `minor_charm_echoes`, `max_minor_charm_echoes`, "
			.. "`charm_expansion`, `UnlockedRunesBit` FROM `player_charms` WHERE `player_id` = %d", guid
	), function(resultId)
		-- The server keeps the running balance in charm_points and the lifetime
		-- total in max_charm_points, which is the pair the website shows as
		-- "total (Unused: balance)".
		charms.charm_points = Result.getNumber(resultId, "max_charm_points")
		charms.charm_points_unused = Result.getNumber(resultId, "charm_points")
		charms.minor_charm_echoes = Result.getNumber(resultId, "max_minor_charm_echoes")
		charms.minor_charm_echoes_unused = Result.getNumber(resultId, "minor_charm_echoes")
		charms.charm_expansion = Result.getNumber(resultId, "charm_expansion")
		charms.unlocked = Result.getNumber(resultId, "UnlockedRunesBit")
	end)

	-- Unlocked entries are one kv key each, named after the entry, so each list is
	-- its own counter. Same prefixes charbazaarPlayerFeatures() reads.
	local titles = kvNames(guid, "titles.unlocked.")
	local badges = kvNames(guid, "badges.unlocked.")
	local achievements = kvNames(guid, "achievements.unlocked.")

	-- The website falls back to the kv counter when the table is absent, and a
	-- failed query lands on the default here, so the fallback is the same shape.
	local hirelings = scalar(string.format(
		"SELECT COUNT(*) AS `total` FROM `player_hirelings` WHERE `player_id` = %d", guid), "total", 0)
	if hirelings == 0 then
		hirelings = kvInt(player, "summary.hirelings.amount")
	end

	local preySlots = scalar(string.format(
		"SELECT COUNT(*) AS `total` FROM `player_prey` WHERE `player_id` = %d AND `slot` >= 2 AND `state` > 0",
		guid), "total", 0)

	local weeklyTaskExpansion = scalar(string.format(
		"SELECT `has_expansion` FROM `player_weekly_tasks` WHERE `player_id` = %d", guid), "has_expansion", 0)

	return table.concat({
		"{",
		string.format('"charm_points":%d,', charms.charm_points),
		string.format('"charm_points_unused":%d,', charms.charm_points_unused),
		string.format('"minor_charm_echoes":%d,', charms.minor_charm_echoes),
		string.format('"minor_charm_echoes_unused":%d,', charms.minor_charm_echoes_unused),
		string.format('"charm_expansion":%d,', charms.charm_expansion),
		string.format('"charms_list":%s,', jsonList(CharBazaar.unlockedCharms(charms.unlocked))),
		string.format('"store_items":%s,', CharBazaar.snapshotStoreItems(storeTotals)),
		-- The live counter rather than the kv key the website has to read, which is
		-- the same number: getAchievementPoints() is what writes it.
		string.format('"achievement_points":%d,', player:getAchievementPoints()),
		string.format('"achievements_list":%s,', jsonList(achievements)),
		string.format('"titles":%d,', #titles),
		string.format('"titles_list":%s,', jsonList(titles)),
		string.format('"badges":%d,', #badges),
		string.format('"badges_list":%s,', jsonList(badges)),
		string.format('"hirelings":%d,', hirelings),
		string.format('"hireling_jobs":%d,', #kvNames(guid, "hireling-skills.")),
		string.format('"hireling_outfits":%d,', #kvNames(guid, "hireling-outfits.")),
		string.format('"xp_boosts":%d,', kvInt(player, "summary.xp-boosts.amount")),
		string.format('"daily_reward_streak":%d,', kvInt(player, "daily-reward.streak")),
		string.format('"weekly_task_expansion":%d,', weeklyTaskExpansion),
		string.format('"prey_slots":%d,', preySlots),
		string.format('"blessings_list":%s,', CharBazaar.blessingAmounts(player)),
		string.format('"boss_points":%d,', counters.boss_points),
		string.format('"task_points":%d,', counters.task_points),
		string.format('"prey_wildcard":%d,', counters.prey_wildcard),
		string.format('"forge_dusts":%d,', counters.forge_dusts),
		string.format('"forge_dust_level":%d,', counters.forge_dust_level),
		string.format('"lookfamiliarstype":%d,', counters.lookfamiliarstype),
		string.format('"sales_arguments":%s', salesArguments),
		"}",
	}, "")
end

--- Freezes the character against an auction.
--
-- One statement. The scalars are copied straight out of the character's own row, and
-- the world name off the server's own configuration - the website stores it resolved
-- rather than looked up, because a world can be renamed long after the auction ends.
--
-- Written with ON DUPLICATE KEY UPDATE for the same reason the website's writer is:
-- the row is keyed on the auction, and freezing twice has to mean the second reading
-- wins rather than an error.
function CharBazaar.writeSnapshot(player, auctionId, configuration)
	local guid = player:getGuid()
	local totals = CharBazaar.itemTotals(player)

	local blessings = CharBazaar.blessingCount(player)
	local twist = player:getBlessingCount(1) > 0 and 1 or 0

	local blobs = {
		equipment = CharBazaar.snapshotEquipment(player),
		items = CharBazaar.snapshotItems(totals.owned),
		outfits = CharBazaar.snapshotOutfits(guid),
		mounts = CharBazaar.snapshotMounts(guid),
		quests = CharBazaar.snapshotQuests(player),
		features = CharBazaar.snapshotFeatures(player, guid,
			CharBazaar.salesArguments(player, configuration.highlights), totals.store),
		showcase = CharBazaar.snapshotShowcase(totals.owned, configuration.items),
	}

	local columns = {
		"skill_fist", "skill_club", "skill_sword", "skill_axe", "skill_dist",
		"skill_shielding", "skill_fishing",
		"skill_fist_tries", "skill_club_tries", "skill_sword_tries", "skill_axe_tries",
		"skill_dist_tries", "skill_shielding_tries", "skill_fishing_tries",
		"looktype", "lookaddons", "lookhead", "lookbody", "looklegs", "lookfeet",
		"lookmounthead", "lookmountbody", "lookmountlegs", "lookmountfeet",
		"health", "healthmax", "mana", "manamax", "maglevel", "manaspent",
		"cap", "soul", "balance", "experience", "created", "level", "vocation", "sex",
	}

	local copied = "`" .. table.concat(columns, "`, `") .. "`"
	local selected = "`p`.`" .. table.concat(columns, "`, `p`.`") .. "`"

	local query = string.format(
		"INSERT INTO `myaac_charbazaar_snapshot` "
			.. "(`auction_id`, `player_id`, `name`, `world_name`, `blessings_count`, `blessings_twist`, "
			.. "`equipment`, `items`, `outfits`, `mounts`, `quests`, `features`, `showcase`, "
			.. "`created_at`, %s) "
			-- The world name is written in rather than looked up. The website stores it
			-- resolved for the same reason it keeps a snapshot at all - a world can be
			-- renamed long after the auction ended - and the game server is only ever
			-- the one world, which is the name in config.lua.
			.. "SELECT %d, `p`.`id`, `p`.`name`, %s, "
			.. "%d, %d, %s, %s, %s, %s, %s, %s, %s, %d, %s "
			.. "FROM `players` `p` WHERE `p`.`id` = %d "
			.. "ON DUPLICATE KEY UPDATE `created_at` = VALUES(`created_at`)",
		copied, auctionId, db.escapeString(configManager.getString(configKeys.SERVER_NAME)), blessings, twist,
		db.escapeString(blobs.equipment), db.escapeString(blobs.items),
		db.escapeString(blobs.outfits), db.escapeString(blobs.mounts),
		db.escapeString(blobs.quests), db.escapeString(blobs.features),
		db.escapeString(blobs.showcase), os.time(), selected, guid
	)

	if not db.query(query) then
		logger.warn("[CharBazaar] could not freeze {} for auction {}: the website will "
			.. "freeze it on the next page view instead", player:getName(), auctionId)
		return false
	end

	debugLog("froze {} for auction {}", player:getName(), auctionId)
	return true
end

--- Everything wrong with a configuration, worded for the seller to read.
--
-- Re-checked here and not trusted from the dialog for the same reason the website
-- re-runs its own checklist in create_confirm.php: everything the client sent is
-- the client's word for it.
--
-- A list rather than the first problem, because these are shown on the confirmation
-- page all at once and a seller fixing one thing at a time is a seller pressing
-- Confirm four times.
function CharBazaar.configurationProblems(player, configuration)
	local problems = {}

	if not CharBazaar.Config.enabled then
		problems[#problems + 1] = "Character auctions are currently disabled."
	end

	if not CharBazaar.conditionsMet(CharBazaar.conditions(player)) then
		problems[#problems + 1] = "Your character no longer meets all the conditions for an auction."
	end

	local minimum = CharBazaar.minimumStartingBid()
	if configuration.price < minimum then
		problems[#problems + 1] = string.format(
			"The starting price must be at least %d Tibia Coins.", minimum)
	elseif configuration.price > CharBazaar.maximumStartingBid then
		problems[#problems + 1] = string.format(
			"The starting price may not be higher than %d Tibia Coins.", CharBazaar.maximumStartingBid)
	end

	local now = os.time()
	if configuration.endTimestamp < now + CharBazaar.Config.minDays * 86400
		or configuration.endTimestamp > now + (CharBazaar.Config.maxDays + 1) * 86400 then
		problems[#problems + 1] = string.format(
			"The auction must end between %d and %d days from now.",
			CharBazaar.Config.minDays, CharBazaar.Config.maxDays)
	end

	return problems
end

--- Whether the auction table has one of the columns this module writes.
--
-- Answered once per column and remembered: a schema does not change under a running
-- server, and the answer is needed on every auction. Reload the module after running
-- the website's migrations and it is asked again.
--
-- Asked rather than attempted, so a game server running ahead of the website logs
-- one warning instead of a MySQL error per auction - the kind of error line that
-- teaches people to stop reading error lines.
CharBazaar.knownColumns = {}

function CharBazaar.hasColumn(column, migration)
	if CharBazaar.knownColumns[column] == nil then
		CharBazaar.knownColumns[column] = rowExists(string.format(
			"SHOW COLUMNS FROM `myaac_charbazaar` LIKE '%s'", column))

		if not CharBazaar.knownColumns[column] then
			logger.warn("[CharBazaar] myaac_charbazaar has no `{}` column: what the seller "
				.. "picks in game will not reach the website until its migration {} has run",
				column, migration)
		end
	end

	return CharBazaar.knownColumns[column]
end

--- The chosen sales arguments, frozen the way the website draws features.
--
-- Text and icon rather than our own highlight ids, for two reasons. The website has
-- no idea what a highlight id means and should not have to learn - it already draws
-- exactly this shape, `{icon, text}`, in charbazaarFeatureEntries(). And the text is
-- a measurement: "Level 308" is only true at the moment it is read, which is the
-- same reason the auction keeps a snapshot at all rather than following the
-- character.
--
-- Unknown ids are dropped rather than guessed at. The catalogue can shrink between
-- the dialog opening and the seller confirming - a module reload is enough.
function CharBazaar.salesArguments(player, chosen)
	local byId = {}
	for _, highlight in ipairs(CharBazaar.Highlights) do
		byId[highlight.id] = highlight
	end

	local entries = {}
	for _, id in ipairs(chosen) do
		local highlight = byId[id]

		if highlight then
			entries[#entries + 1] = string.format(
				'{"icon":%d,"text":"%s"}',
				CharBazaar.HighlightCategory[highlight.category] or 0,
				jsonEscape(highlight.text(player))
			)
		end
	end

	return "[" .. table.concat(entries, ",") .. "]"
end

--- The id of the auction just written for a character.
--
-- Not db.lastInsertId(). The server itself warns that it reads LAST_INSERT_ID on
-- whichever connection it happens to hold, which is not necessarily the one the
-- insert ran on, and it returns zero when the insert failed - a zero that reads
-- exactly like a successful insert of auction number zero. Asking for the row is
-- both the id and the proof that the row is there.
function CharBazaar.openAuctionId(guid)
	local resultId = db.storeQuery(string.format(
		"SELECT `id` FROM `myaac_charbazaar` WHERE `player_id` = %d AND `status` = 0 ORDER BY `id` DESC LIMIT 1",
		guid
	))

	if not resultId then
		return 0
	end

	local auctionId = Result.getNumber(resultId, "id")
	Result.free(resultId)

	return auctionId
end

--- Turns an auction down and says so, on the page the seller is looking at.
--
-- Pressing Confirm and having nothing happen at all is the worst answer a dialog can
-- give, and it is what this module used to do: the refusal only ever reached the
-- server console. Sending the reason back as a summary puts it in the list on the
-- confirmation page, where the seller is already reading.
function CharBazaar.refuse(player, reasons)
	if type(reasons) == "string" then
		reasons = { reasons }
	end

	debugLog("refused auction for {}: {}", player:getName(), table.concat(reasons, " "))
	CharBazaar.sendSummary(player, CharBazaar.summaryDataType, reasons)

	return false
end

--- Puts the character up for auction.
--
-- Mirrors charactertrade/create_confirm.php on the website, which is the other door
-- into the same table and has to stay the only definition of what an auction is:
-- claim the character so two doors cannot sell it twice, charge the fee, write the
-- row, then move the character onto the vault account.
--
-- Two things differ from the website's order, and both were paid for.
--
-- The row is written FIRST, before anything is taken or claimed. The first version
-- claimed the character up front and inserted afterwards, and when the insert failed
-- - the column it named did not exist on that database - the character had already
-- been marked deleted, moved to the vault account, charged and logged out, with no
-- auction to show for it. An orphan row can be deleted; a character that belongs to
-- nobody and is listed nowhere cannot be found. So the reversible step goes first,
-- and every step after it undoes the ones before if it fails.
--
-- Every db.query is checked. It returns false on a failed query and says so in the
-- log, and a Lua script that ignores that is a script that carries on as if the
-- write had happened.
--
-- The second difference is forced: the website works on a character that is offline,
-- while here it is standing in front of us, and logging out writes the players row
-- again. So the claim happens while the player is still here, the player is then
-- removed, and only the position is rewritten afterwards - loginPosition is the one
-- column of ours the logout save would put back. It does not touch account_id,
-- deletion or charbazaar.
--
-- The save before the claim matters: the snapshot reads the depot, the stash and the
-- rest out of the database, so whatever is still only in memory would be missing from
-- the frozen copy.
--
-- Both saves here have to have finished before the next query runs, which holds while
-- toggleSaveAsync is off, which is the default. See the warning at
-- the end of this file for what breaks when it is not.
function CharBazaar.create(player, configuration)
	local guid = player:getGuid()
	local accountId = player:getAccountId()
	local name = player:getName()

	local problems = CharBazaar.configurationProblems(player, configuration)
	if #problems > 0 then
		return CharBazaar.refuse(player, problems)
	end

	-- The conditions already refuse an account with an auction open, but they ask
	-- about the account and this asks about the character, which is what the row is
	-- keyed on.
	if rowExists(string.format(
		"SELECT 1 FROM `myaac_charbazaar` WHERE `player_id` = %d AND `status` = 0 LIMIT 1", guid
	)) then
		return CharBazaar.refuse(player, "This character is already up for auction.")
	end

	local now = os.time()
	local dateStart = os.date("%Y%m%d%H%M%S", now)
	local dateEnd = os.date("%Y%m%d%H%M%S", configuration.endTimestamp)

	-- The column list is the website's, exactly. The showcase is deliberately not
	-- here: it goes in on its own below, so that a database still missing that
	-- column costs four item pictures instead of the whole auction.
	--
	-- The dates are quoted because the column is a datetime and the website writes
	-- fourteen digits into it, which MySQL reads as YYYYMMDDHHMMSS either way.
	local inserted = db.query(string.format(
		"INSERT INTO `myaac_charbazaar` (`account_old`, `account_new`, `player_id`, `price`, "
			.. "`date_end`, `date_start`, `bid_account`, `bid_price`, `status`) "
			.. "VALUES (%d, %d, %d, %d, '%s', '%s', 0, 0, 0)",
		accountId, CharBazaar.Config.vaultAccount, guid, configuration.price, dateEnd, dateStart
	))

	local auctionId = inserted and CharBazaar.openAuctionId(guid) or 0
	if auctionId == 0 then
		return CharBazaar.refuse(player, "The auction could not be created. Please try again later.")
	end

	-- What the seller picked. Written after the row and each on its own, so a
	-- database still missing either column costs only what that column carried
	-- rather than the whole auction - which is the mistake that cost a character.
	if CharBazaar.hasColumn("showcase", 54) then
		db.query(string.format(
			"UPDATE `myaac_charbazaar` SET `showcase` = '%s' WHERE `id` = %d",
			CharBazaar.showcaseIds(configuration.items), auctionId
		))
	end

	if CharBazaar.hasColumn("sales_arguments", 55) then
		db.query(string.format(
			"UPDATE `myaac_charbazaar` SET `sales_arguments` = %s WHERE `id` = %d",
			db.escapeString(CharBazaar.salesArguments(player, configuration.highlights)), auctionId
		))
	end

	if not player:removeTransferableCoins(CharBazaar.Config.fee) then
		db.query(string.format("DELETE FROM `myaac_charbazaar` WHERE `id` = %d", auctionId))
		return CharBazaar.refuse(player, "The auction fee could not be charged.")
	end

	player:save()

	-- Claims the character. The guard is what stops the website from creating a
	-- second auction for it in the same moment, and reading the column back is how a
	-- Lua script finds out whether the guard held - db.query says whether the query
	-- ran, never how many rows it touched.
	local claimed = db.query(string.format(
		"UPDATE `players` SET `deletion` = 1, `charbazaar` = 1 WHERE `id` = %d AND `charbazaar` = 0", guid
	)) and rowExists(string.format("SELECT 1 FROM `players` WHERE `id` = %d AND `charbazaar` = 1", guid))

	if not claimed then
		player:addTransferableCoins(CharBazaar.Config.fee)
		db.query(string.format("DELETE FROM `myaac_charbazaar` WHERE `id` = %d", auctionId))
		return CharBazaar.refuse(player, "This character could not be put up for auction.")
	end

	if not db.query(string.format(
		"UPDATE `players` SET `account_id` = %d WHERE `id` = %d", CharBazaar.Config.vaultAccount, guid
	)) then
		player:addTransferableCoins(CharBazaar.Config.fee)
		db.query(string.format(
			"UPDATE `players` SET `deletion` = 0, `charbazaar` = 0 WHERE `id` = %d", guid))
		db.query(string.format("DELETE FROM `myaac_charbazaar` WHERE `id` = %d", auctionId))
		return CharBazaar.refuse(player, "This character could not be put up for auction.")
	end

	-- Last, and on purpose. Freezing the character is the only step here that cannot
	-- fail in a way worth undoing: the auction exists, the fee is paid, the character
	-- is claimed and cannot change again, so a snapshot that does not get written now
	-- is written by the website the next time anyone opens the auction list. Putting
	-- it earlier would mean rolling back a live auction over a copy.
	CharBazaar.writeSnapshot(player, auctionId, configuration)

	logger.info("[CharBazaar] created auction {} for {}: price {}, ends {}, {} items, {} sales arguments",
		auctionId, name, configuration.price, dateEnd,
		#configuration.items, #configuration.highlights)

	player:remove()

	-- After the logout save, so it is not put back. A position of nothing is read as
	-- the town temple on the next login, which is where the buyer should start.
	db.query(string.format(
		"UPDATE `players` SET `posx` = 0, `posy` = 0, `posz` = 0 WHERE `id` = %d", guid
	))

	return true
end

--- Everything left unread in an incoming message, as hex.
--
-- Remaining bytes are length minus what has been consumed past the header, which is
-- the same sum canRead does on the C++ side.
--
-- The request carries far more than the one byte this module used to read. It is
-- GameclientMessageCharacterTradeConfigurationAction, an action and its arguments,
-- and the actions the dialog can send are requestConditions, addHighlight(id),
-- addItem(appearanceID, tier), removeHighlight(id), removeItem(appearanceID, tier),
-- requestCheckConfiguration, requestConfirmConfiguration and requestClose. The one
-- that carries the settings - the price, the end time, what was picked - is
-- requestCheckConfiguration, so this is where those arrive.
local function dumpRest(msg)
	local remaining = msg:getLength() - (msg:getBufferPosition() - 7)
	local bytes = {}

	for _ = 1, remaining do
		bytes[#bytes + 1] = string.format("%02X", msg:getByte())
	end

	return table.concat(bytes, " ")
end

-- The actions the client actually sends, named by the dump.
--
--   0  requestConditions            payload: the token byte only
--   1  the items request            payload: the token byte only
--   2  requestCheckConfiguration    payload: the whole configuration
--   3  requestConfirmConfiguration  payload: the same configuration again
--
-- And that is the complete list. Picking and unpicking items and sales arguments
-- sends nothing at all - addHighlight, addItem, removeHighlight and removeItem only
-- change the client's own copy of the configuration, and the whole thing travels in
-- one piece when Next or Confirm is pressed. So there is no add or remove to answer,
-- and the auction can be built from the single request that creates it.
--
-- Actions 2 and 3 carry the identical payload, which is what makes checking cheap:
-- the same parse serves both, one to answer with the summary and one to act on.
--
-- The sales argument ids come back exactly as they were sent, which is the proof
-- that the catalogue round trips.
CharBazaar.Actions = {
	CONDITIONS = 0,
	ITEMS = 1,
	CHECK_CONFIGURATION = 2,
	CONFIRM_CONFIGURATION = 3,
}

function onRecvbyte(player, msg, byte)
	if byte ~= CharBazaar.RecvPackets.C_ConfigurationAction then
		return
	end

	local action = msg:getByte()

	debugLog("request from {}: action {}", player:getName(), action)

	if CharBazaar.probeBytes and action == CharBazaar.probeDataType then
		CharBazaar.sendProbe(player, action)
	elseif action == CharBazaar.Actions.CONDITIONS then
		CharBazaar.sendConditions(player, CharBazaar.conditionsDataType)

		-- Nobody ever asks for the sales arguments, so they ride along with the
		-- conditions - the one request the dialog makes when it opens.
		CharBazaar.sendHighlights(player, CharBazaar.highlightsDataType)
	elseif action == CharBazaar.Actions.ITEMS then
		CharBazaar.sendItems(player, CharBazaar.itemsDataType)
	elseif action == CharBazaar.Actions.CHECK_CONFIGURATION then
		-- The name of the request is the whole point of it: the client is asking
		-- whether what the seller assembled is acceptable, one page before it lets
		-- them confirm it. Answering with the problems is what turns Confirm from a
		-- button that does nothing into a page that says why.
		CharBazaar.sendSummary(player, CharBazaar.summaryDataType,
			CharBazaar.configurationProblems(player, CharBazaar.parseConfiguration(msg)))
	elseif action == CharBazaar.Actions.CONFIRM_CONFIGURATION then
		CharBazaar.create(player, CharBazaar.parseConfiguration(msg))
	else
		-- Consumes the rest, which is the only way to see what an action nobody
		-- has mapped actually carries.
		debugLog("action {} from {} left unanswered, payload [{}]",
			action, player:getName(), dumpRest(msg))
	end
end

-- create() reads the database right after saving the character to it, and rewrites
-- the login position right after logging the character out. Both assume the save has
-- already landed.
--
-- SaveManager hands a save to a thread pool when toggleSaveAsync is on and runs it
-- inline when it is off. With it on, the snapshot would freeze a character out of
-- rows the save has not written yet, and the logout save would put the seller's last
-- position back over the reset that sends the buyer to the temple.
--
-- Said once at load rather than guessed at per auction, because the answer cannot
-- change while the server is up.
if configManager.getBoolean(configKeys.TOGGLE_SAVE_ASYNC) then
	logger.warn("[CharBazaar] toggleSaveAsync is on: an auction created from the client may "
		.. "freeze an incomplete copy of the character and may leave the buyer starting at the "
		.. "seller's last position. Turn it off to create auctions in game.")
end
