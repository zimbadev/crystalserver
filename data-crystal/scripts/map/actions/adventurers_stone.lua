local config = {
	enableTemples = true,
	Temples = {
		{ fromPos = Position(434, 503, 7), toPos = Position(443, 508, 7), townId = TOWNS_LIST.KARMIA },
		{ fromPos = Position(356, 490, 7), toPos = Position(364, 497, 7), townId = TOWNS_LIST.DESERT_CITY },
		{ fromPos = Position(556, 459, 6), toPos = Position(560, 462, 6), townId = TOWNS_LIST.TIQUANDA },
		{ fromPos = Position(478, 427, 7), toPos = Position(484, 431, 7), townId = TOWNS_LIST.INFERNO },
		{ fromPos = Position(399, 381, 6), toPos = Position(408, 390, 6), townId = TOWNS_LIST.VENORE },
		{ fromPos = Position(422, 629, 7), toPos = Position(429, 636, 7), townId = TOWNS_LIST.PREMIUM_ISLAND },
		{ fromPos = Position(240, 306, 7), toPos = Position(245, 313, 7), townId = TOWNS_LIST.FOLDA },
		{ fromPos = Position(545, 705, 7), toPos = Position(550, 711, 7), townId = TOWNS_LIST.LIBERTY_BAY },
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
