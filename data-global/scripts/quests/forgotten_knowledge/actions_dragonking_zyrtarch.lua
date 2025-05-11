local config = {
	bossPosition = Position(33357, 31182, 10),
	newPosition = Position(33359, 31186, 10),
	soulPosition = Position(33359, 31182, 12),
}

local monsters = {
	{ position = Position(33352, 31187, 10) },
	{ position = Position(33363, 31187, 10) },
	{ position = Position(33353, 31176, 10) },
	{ position = Position(33363, 31176, 10) },
}

local leverZyrtarch = Action()

local function formatTimeRemaining(seconds)
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	return string.format("%d hours and %d minutes", hours, minutes)
end

function leverZyrtarch.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 8911 then
		-- Check player position
		if player:getPosition() ~= Position(33391, 31178, 10) then
			item:transform(8912)
			return true
		end

		-- Check cooldown for all players in lever area
		for y = 31178, 31182 do
			local tilePos = Position(33391, y, 10)
			local tile = Tile(tilePos)
			if tile then
				local creature = tile:getTopCreature()
				if creature and creature:isPlayer() then
					local storage = creature:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.DragonkingKilled)
					if storage > os.time() then
						local remainingTime = storage - os.time()
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You or a party member has recently killed Dragonking Zyrtarch. You must wait %s before fighting again.", formatTimeRemaining(remainingTime)))
						return true
					end
				end
			end
		end

		-- Check boss room and spawn
		if player:doCheckBossRoom("Dragonking Zyrtarch", Position(33348, 31172, 10), Position(33368, 31190, 12)) then
			-- Spawn soulcatchers
			for d = 1, #monsters do
				Game.createMonster("soulcatcher", monsters[d].position, true, true)
			end

			-- Spawn Dragonking and his soul
			Game.createMonster("dragonking zyrtarch", config.bossPosition, true, true)
			Game.createMonster("soul of dragonking zyrtarch", config.soulPosition, true, true)

			-- Teleport players and set cooldown
			local playersTable = {}
			for y = 31178, 31182 do
				local tilePos = Position(33391, y, 10)
				local tile = Tile(tilePos)
				if tile then
					local playerTile = tile:getTopCreature()
					if playerTile and playerTile:isPlayer() then
						playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
						playerTile:teleportTo(config.newPosition)
						playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
						playerTile:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.DragonkingKilled, os.time() + 20 * 60 * 60)
						table.insert(playersTable, playerTile:getId())
					end
				end
			end

			addEvent(kickPlayersAfterTime, 30 * 60 * 1000, playersTable, Position(33348, 31172, 10), Position(33368, 31190, 12), Position(33407, 31172, 10))
			item:transform(8912)
		end
	elseif item.itemid == 8912 then
		item:transform(8911)
	end

	return true
end

leverZyrtarch:position(Position(33391, 31177, 10))
leverZyrtarch:register()
