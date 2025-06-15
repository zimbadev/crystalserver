local shadowNexusPosition = Position(3074, 4333, 6)
local effectPositions = {
    Position(3073, 4333, 6),
    Position(3075, 4333, 6),
}

local function revertItem(position, itemId, transformId)
	local item = Tile(position):getItemById(itemId)
	if item then
		item:transform(transformId)
	end
end

local function nexusMessage(player, message)
	local spectators = Game.getSpectators(shadowNexusPosition, false, true, 3, 3)
	for i = 1, #spectators do
		player:say(message, TALKTYPE_MONSTER_YELL, false, spectators[i], shadowNexusPosition)
	end
end

local config = {
	antler_talisman = 22008,
	sacred_antler_talisman = 22009,
}

local othersHolyWater = Action()

function othersHolyWater.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- Tylko Inquisition Quest!
	-- Przemiana Antler Talisman
	if target.itemid == config.antler_talisman then
		target:transform(config.sacred_antler_talisman)
		item:remove(1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You besprinkle the antler talisman with holy water. It glitters faintly.")
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		return true

	-- Shadow Nexus Quest, **dostosowane storage pod Twój system**
	elseif table.contains({ 7925, 7927, 7929 }, target.itemid) then
		if target.itemid == 7929 then
			Game.setStorageValue(GlobalStorage.Quest.Inquisition, math.random(4, 5))
		end
		local newShadowNexus = Game.createItem(target.itemid + 1, 1, shadowNexusPosition)
		if newShadowNexus then
			target:remove()
			newShadowNexus:decay()
		end
		nexusMessage(player, player:getName() .. " damaged the shadow nexus! You can't damage it while it's burning.")
		toPosition:sendMagicEffect(CONST_ME_ENERGYHIT)

	-- Ostateczna przemiana/shadow nexus "destroy"
	elseif target.itemid == 7931 then
		if Game.getStorageValue(GlobalStorage.Quest.Inquisition) > 0 then
			Game.setStorageValue(GlobalStorage.Quest.Inquisition, Game.getStorageValue(GlobalStorage.Quest.Inquisition) - 1)
			if player:getStorageValue(Storage.Quest.U8_0.TheInquisitionQuest.Questline) < 22 then
				player:setStorageValue(Storage.Quest.U8_0.TheInquisitionQuest.Mission07, 2)
				player:setStorageValue(Storage.Quest.U8_0.TheInquisitionQuest.Questline, 22)
			end
			for i = 1, #effectPositions do
				effectPositions[i]:sendMagicEffect(CONST_ME_HOLYAREA)
			end
			nexusMessage(player, player:getName() .. " destroyed the shadow nexus! In 10 seconds it will return to its original state.")
			item:remove(1)
			toPosition:sendMagicEffect(CONST_ME_HOLYAREA)
		else
			target:transform(7925)
		end
	end

	return true
end

othersHolyWater:id(133)
othersHolyWater:register()
