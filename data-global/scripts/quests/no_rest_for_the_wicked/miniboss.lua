local conjureBoss = Action()

local validPos = {
	{ id = 50054, miniBoss = "Twisterror", globalStorage = 47976, pos = Position(33824, 32295, 9), monsterPos = Position(33825, 32294, 9) },
	{ id = 50055, miniBoss = "Gralvalon", globalStorage = 47977, pos = Position(33809, 32295, 10), monsterPos = Position(33808, 32293, 10) },
	{ id = 50101, miniBoss = "Malvaroth", globalStorage = 47978, pos = Position(33770, 32393, 8), monsterPos = Position(33768, 32391, 8) },
}

local function resetGlobalStorage(globalStorage)
	Game.setStorageValue(globalStorage, 0)
end

function conjureBoss.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	for _, data in ipairs(validPos) do
		if item.itemid == data.id and toPosition == data.pos then
			local currentStorage = Game.getStorageValue(data.globalStorage)
			if currentStorage < 0 then
				currentStorage = 0
			end

			if currentStorage == 10 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must wait before summoning this boss again.")
				return false
			end

			currentStorage = currentStorage + 1
			Game.setStorageValue(data.globalStorage, currentStorage)
			toPosition:sendMagicEffect(CONST_ME_MAGIC_RED)
			item:remove(1)

			if currentStorage == 10 then
				local spectators = Game.getSpectators(toPosition, false, true, 5, 5, 5, 5)
				for _, spectator in ipairs(spectators) do
					if spectator:isPlayer() then
						spectator:say("You feel a malevolent aura growing stronger!", TALKTYPE_MONSTER_SAY, false, spectator, toPosition)
					end
				end

				addEvent(function()
					local boss = Game.createMonster(data.miniBoss, data.monsterPos)
					if boss then
						data.monsterPos:sendMagicEffect(CONST_ME_TELEPORT)

						addEvent(function()
							if boss then
								boss:getPosition():sendMagicEffect(CONST_ME_POFF)
								boss:remove()
							end
						end, 600 * 1000)
					end
				end, 10000)

				addEvent(resetGlobalStorage, 3600 * 1000, data.globalStorage)
			end
			return true
		end
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This item cannot be used here.")
	return false
end

conjureBoss:id(50054, 50055, 50101)
conjureBoss:register()
