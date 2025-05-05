local config = {
	centerRoom = Position(32624, 32880, 14),
	bossPosition = Position(32624, 32880, 14),
	newPosition = Position(32624, 32886, 14),
}

local leverThornKnight = Action()

local function formatTimeRemaining(seconds)
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	return string.format("%d hours and %d minutes", hours, minutes)
end

function leverThornKnight.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 8911 then
		-- Check player position
		if player:getPosition() ~= Position(32657, 32877, 14) then
			item:transform(8912)
			return true
		end

		-- Check cooldown for all players in lever area
		for y = 32877, 32881 do
			local tilePos = Position(32657, y, 14)
			local tile = Tile(tilePos)
			if tile then
				local creature = tile:getTopCreature()
				if creature and creature:isPlayer() then
					local storage = creature:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.ThornKnightKilled)
					if storage > os.time() then
						local remainingTime = storage - os.time()
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You or a party member has recently killed the Thorn Knight. You must wait %s before fighting again.", formatTimeRemaining(remainingTime)))
						return true
					end
				end
			end
		end

		-- Check boss room and spawn
		if player:doCheckBossRoom("Thorn Knight", Position(32613, 32869, 14), Position(32636, 32892, 14)) then
			-- Spawn possessed trees
			for d = 1, 6 do
				Game.createMonster("possessed tree", Position(math.random(32619, 32629), math.random(32877, 32884), 14), true, true)
			end

			-- Spawn Thorn Knight
			Game.createMonster("mounted thorn knight", config.bossPosition, true, true)

			-- Teleport players and set cooldown
			local playersTable = {}
			for y = 32877, 32881 do
				local tilePos = Position(32657, y, 14)
				local tile = Tile(tilePos)
				if tile then
					local playerTile = tile:getTopCreature()
					if playerTile and playerTile:isPlayer() then
						playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
						playerTile:teleportTo(config.newPosition)
						playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
						playerTile:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.ThornKnightKilled, os.time() + 20 * 60 * 60)
						table.insert(playersTable, playerTile:getId())
					end
				end
			end

			addEvent(kickPlayersAfterTime, 30 * 60 * 1000, playersTable, Position(32613, 32869, 14), Position(32636, 32892, 14), Position(32678, 32888, 14))
			item:transform(8912)
		end
	elseif item.itemid == 8912 then
		item:transform(8911)
	end
	return true
end

leverThornKnight:position(Position(32657, 32876, 14))
leverThornKnight:register()
