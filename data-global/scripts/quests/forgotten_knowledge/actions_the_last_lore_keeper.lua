local config = {
	{ newPosition = Position(31985, 32851, 14) },
	{ pos = Position(31986, 32840, 14), monster = "a shielded astral glyph" },
	{ pos = Position(31975, 32856, 15), monster = "bound astral power" },
	{ pos = Position(31987, 32839, 14), monster = "the astral source" },
	{ pos = Position(31986, 32823, 15), monster = "the distorted astral source" },
	{ pos = Position(31989, 32823, 15), monster = "an astral glyph" },
}

local leverLoreKeeper = Action()

local function formatTimeRemaining(seconds)
	local days = math.floor(seconds / (60 * 60 * 24))
	local hours = math.floor((seconds % (60 * 60 * 24)) / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	if days > 0 then
		return string.format("%d days, %d hours and %d minutes", days, hours, minutes)
	else
		return string.format("%d hours and %d minutes", hours, minutes)
	end
end

function leverLoreKeeper.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 8911 then
		-- Check player position
		if player:getPosition() ~= Position(32019, 32844, 14) then
			item:transform(8912)
			return true
		end

		-- Check cooldown for all players in lever area
		for x = 32018, 32020 do
			for y = 32844, 32848 do
				local tilePos = Position(x, y, 14)
				local tile = Tile(tilePos)
				if tile then
					local creature = tile:getTopCreature()
					if creature and creature:isPlayer() then
						local storage = creature:getStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LastLoreKilled)
						if storage > os.time() then
							local remainingTime = storage - os.time()
							player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You or a party member has recently fought the Last Lorekeeper. You must wait %s before attempting again.", formatTimeRemaining(remainingTime)))
							return true
						end
					end
				end
			end
		end

		-- Check boss room and spawn
		if player:doCheckBossRoom("The Last Lorekeeper", Position(31968, 32821, 14), Position(32004, 32865, 15)) then
			-- Teleport players and set cooldown (14 days)
			local playersTable = {}
			for x = 32018, 32020 do
				for y = 32844, 32848 do
					local tilePos = Position(x, y, 14)
					local tile = Tile(tilePos)
					if tile then
						local playerTile = tile:getTopCreature()
						if playerTile and playerTile:isPlayer() then
							playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
							playerTile:teleportTo(config[1].newPosition)
							playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
							playerTile:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LastLoreKilled, os.time() + 60 * 60 * 14 * 24) -- 14 days
							table.insert(playersTable, playerTile:getId())
						end
					end
				end
			end

			-- Spawn all monsters
			for b = 2, #config do
				Game.createMonster(config[b].monster, config[b].pos, true, true)
			end

			-- Reset counters
			Game.setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AstralPowerCounter, 1)
			Game.setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.AstralGlyph, 0)
			player:say("The Astral Glyph begins to draw upon bound astral power to expel you from the room!", TALKTYPE_MONSTER_SAY)

			-- Kick players after 30 minutes
			addEvent(kickPlayersAfterTime, 30 * 60 * 1000, playersTable, Position(31968, 32821, 14), Position(32004, 32865, 15), Position(32035, 32859, 14))
			item:transform(8912)
		end
	elseif item.itemid == 8912 then
		item:transform(8911)
	end

	return true
end

leverLoreKeeper:position(Position(32019, 32843, 14))
leverLoreKeeper:register()
