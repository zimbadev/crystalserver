local config = {
	enableTemples = true,
	Temples = {
		{ fromPos = Position(434, 503, 7), toPos = Position(443, 508, 7), townId = TOWNS_LIST.KARMIA },
		{ fromPos = Position(32358, 31777, 7), toPos = Position(32364, 31787, 7), townId = TOWNS_LIST.DESERT_CITY },
		{ fromPos = Position(32642, 31921, 11), toPos = Position(32656, 31929, 11), townId = TOWNS_LIST.TIQUANDA },
		{ fromPos = Position(32365, 32231, 7), toPos = Position(32374, 32243, 7), townId = TOWNS_LIST.INFERNO },
		{ fromPos = Position(32953, 32072, 7), toPos = Position(32963, 32081, 7), townId = TOWNS_LIST.VENORE },
		{ fromPos = Position(33188, 32844, 8), toPos = Position(33201, 32857, 8), townId = TOWNS_LIST.PREMIUM_ISLAND },
		{ fromPos = Position(33208, 31803, 8), toPos = Position(33225, 31819, 8), townId = TOWNS_LIST.FOLDA },
		{ fromPos = Position(33018, 31514, 11), toPos = Position(33032, 31531, 11), townId = TOWNS_LIST.LIBERTY_BAY },
	},
}

local adventurersStone = Action()

local function doNotTeleport(player)
	local enabledLocations = {}
	if config.enableTemples then
		table.insert(enabledLocations, "temple")
	end

	local message = "Try to move more to the center of a " .. table.concat(enabledLocations, " or ") .. " to use the spiritual energy for a teleport."
	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
end

function adventurersStone.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local tile = Tile(player:getPosition())
	if not tile:hasFlag(TILESTATE_PROTECTIONZONE) or tile:hasFlag(TILESTATE_HOUSE) or player:isPzLocked() then
		doNotTeleport(player)
		return false
	end

	local playerPos, allowed, townId = player:getPosition(), false, player:getTown():getId()

	if config.enableTemples then
		for _, temple in ipairs(config.Temples) do
			if playerPos:isInRange(temple.fromPos, temple.toPos) then
				allowed, townId = true, temple.townId
				break
			end
		end
	end

	if not allowed then
		doNotTeleport(player)
		return false
	end

	player:setStorageValue(Storage.CrystalServer.AdventurersGuild.Stone, townId)
	playerPos:sendMagicEffect(CONST_ME_TELEPORT)

	local destination = Position(352, 643, 6)
	player:teleportTo(destination)
	destination:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

adventurersStone:id(16277)
adventurersStone:register()
