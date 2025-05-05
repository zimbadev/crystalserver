local config = {
	centerRoom = Position(32799, 32832, 14),
	bossPosition = Position(32799, 32827, 14),
	newPosition = Position(32800, 32831, 14),
}

local monsters = {
	{ cosmic = "cosmic energy prism a", pos = Position(32801, 32827, 14) },
	{ cosmic = "cosmic energy prism b", pos = Position(32798, 32827, 14) },
	{ cosmic = "cosmic energy prism c", pos = Position(32803, 32826, 14) },
	{ cosmic = "cosmic energy prism d", pos = Position(32796, 32826, 14) },
}

local leverLloyd = Action()

local function formatTimeRemaining(seconds)
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	return string.format("%d hours and %d minutes", hours, minutes)
end

function leverLloyd.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 8911 then
		-- Check player position
		if player:getPosition() ~= Position(32759, 32868, 14) then
			item:transform(8912)
			return true
		end

		-- Check cooldown for all players in lever area
		for y = 32868, 32872 do
			local tilePos = Position(32759, y, 14)
			local tile = Tile(tilePos)
			if tile then
				local creature = tile:getTopCreature()
				if creature and creature:isPlayer() then
					local storage = creature:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LloydKilled)
					if storage > os.time() then
						local remainingTime = storage - os.time()
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You or a party member has recently killed Lloyd. You must wait %s before fighting again.", formatTimeRemaining(remainingTime)))
						return true
					end
				end
			end
		end

		-- Check boss room and spawn
		if player:doCheckBossRoom("Lloyd", Position(32785, 32814, 14), Position(32812, 32838, 14)) then
			-- Spawn cosmic prisms
			for n = 1, #monsters do
				Game.createMonster(monsters[n].cosmic, monsters[n].pos, true, true)
			end

			-- Spawn Lloyd
			Game.createMonster("lloyd", config.bossPosition, true, true)

			-- Teleport players and set cooldown
			local playersTable = {}
			for y = 32868, 32872 do
				local tilePos = Position(32759, y, 14)
				local tile = Tile(tilePos)
				if tile then
					local playerTile = tile:getTopCreature()
					if playerTile and playerTile:isPlayer() then
						playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
						playerTile:teleportTo(config.newPosition)
						playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
						playerTile:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LloydKilled, os.time() + 20 * 60 * 60)
						table.insert(playersTable, playerTile:getId())
					end
				end
			end

			addEvent(kickPlayersAfterTime, 30 * 60 * 1000, playersTable, Position(32785, 32814, 14), Position(32812, 32838, 14), Position(32815, 32873, 13))
			item:transform(8912)
		end
	elseif item.itemid == 8912 then
		item:transform(8911)
	end

	return true
end

leverLloyd:position(Position(32759, 32867, 14))
leverLloyd:register()
