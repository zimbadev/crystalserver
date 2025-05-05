local config = {
	centerRoom = Position(32912, 31599, 14),
	bossPosition = Position(32912, 31599, 14),
	newPosition = Position(32911, 31603, 14),
}

local leverLadyTenebris = Action()
local function formatTimeRemaining(seconds)
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	return string.format("%d hours and %d minutes", hours, minutes)
end

function leverLadyTenebris.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 8911 then
		if player:getPosition() ~= Position(32902, 31623, 14) then
			return true
		end
		for y = 31623, 31627 do
			local tilePos = Position(32902, y, 14)
			local tile = Tile(tilePos)
			if tile then
				local creature = tile:getTopCreature()
				if creature and creature:isPlayer() then
					local storage = creature:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LadyTenebrisKilled)
					if storage > os.time() then
						local remainingTime = storage - os.time()
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You or a party member has recently killed Lady Tenebris. You must wait must wait %s before fighting again.", formatTimeRemaining(remainingTime)))
						return true
					end
				end
			end
		end

		if player:doCheckBossRoom("Lady Tenebris", Position(32902, 31589, 14), Position(32924, 31610, 14)) then
			for d = 1, 6 do
				Game.createMonster("shadow tentacle", Position(math.random(32909, 32914), math.random(31596, 31601), 14), true, true)
			end
			Game.createMonster("lady tenebris", config.bossPosition, true, true)

			local playersTable = {}
			for y = 31623, 31627 do
				local tilePos = Position(32902, y, 14)
				local tile = Tile(tilePos)
				if tile then
					local playerTile = tile:getTopCreature()
					if playerTile and playerTile:isPlayer() then
						playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
						playerTile:teleportTo(config.newPosition)
						playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
						playerTile:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LadyTenebrisKilled, os.time() + 20 * 60 * 60)
						table.insert(playersTable, playerTile:getId())
					end
				end
			end

			addEvent(kickPlayersAfterTime, 30 * 60 * 1000, playersTable, Position(32902, 31589, 14), Position(32924, 31610, 14), Position(32919, 31639, 14))
			item:transform(8912)
		end
	elseif item.itemid == 8912 then
		item:transform(8911)
	end
	return true
end

leverLadyTenebris:position(Position(32902, 31622, 14))
leverLadyTenebris:register()
