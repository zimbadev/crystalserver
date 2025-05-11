local config = {
	centerRoom = Position(32977, 31662, 14),
	newPosition = Position(32977, 31667, 14),
}

local bosses = {
	{ bossPosition = Position(32977, 31662, 14), bossName = "The Time Guardian" },
	{ bossPosition = Position(32975, 31664, 13), bossName = "The Freezing Time Guardian" },
	{ bossPosition = Position(32980, 31664, 13), bossName = "The Blazing Time Guardian" },
}

local leverTimeGuardian = Action()

local function formatTimeRemaining(seconds)
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	return string.format("%d hours and %d minutes", hours, minutes)
end

function leverTimeGuardian.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 8911 then
		-- Check player position
		if player:getPosition() ~= Position(33010, 31660, 14) then
			item:transform(8912)
			return true
		end

		-- Check cooldown for all players in lever area
		for y = 31660, 31664 do
			local tilePos = Position(33010, y, 14)
			local tile = Tile(tilePos)
			if tile then
				local creature = tile:getTopCreature()
				if creature and creature:isPlayer() then
					local storage = creature:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.TimeGuardianKilled)
					if storage > os.time() then
						local remainingTime = storage - os.time()
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You or a party member has recently killed the Time Guardians. You must wait %s before fighting again.", formatTimeRemaining(remainingTime)))
						return true
					end
				end
			end
		end

		-- Check boss room and spawn
		if player:doCheckBossRoom("The Time Guardian", Position(32967, 31654, 13), Position(32989, 31677, 14)) then
			-- Spawn all three guardians
			for q = 1, #bosses do
				Game.createMonster(bosses[q].bossName, bosses[q].bossPosition, true, true)
			end

			-- Teleport players and set cooldown
			local playersTable = {}
			for y = 31660, 31664 do
				local tilePos = Position(33010, y, 14)
				local tile = Tile(tilePos)
				if tile then
					local playerTile = tile:getTopCreature()
					if playerTile and playerTile:isPlayer() then
						playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
						playerTile:teleportTo(config.newPosition)
						playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
						playerTile:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.TimeGuardianKilled, os.time() + 20 * 60 * 60)
						table.insert(playersTable, playerTile:getId())
					end
				end
			end

			addEvent(kickPlayersAfterTime, 30 * 60 * 1000, playersTable, Position(32967, 31654, 13), Position(32989, 31677, 14), Position(32870, 32724, 14))
			item:transform(8912)
		end
	elseif item.itemid == 8912 then
		item:transform(8911)
	end
	return true
end

leverTimeGuardian:position(Position(33010, 31659, 14))
leverTimeGuardian:register()
