local boss = {
	[3193] = "fury of the emperor",
	[3194] = "wrath of the emperor",
	[3195] = "scorn of the emperor",
	[3196] = "spite of the emperor",
}

local COOLDOWN_STORAGE = 147225
local COOLDOWN_TIME = 60

local wrathEmperorMiss10Message = Action()
function wrathEmperorMiss10Message.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target then
		return true
	end
	if boss[target.uid] and target.itemid == 11427 then
		target:transform(10797)
		Game.createMonster(boss[target.uid], { x = toPosition.x + 4, y = toPosition.y, z = toPosition.z })
		Game.setStorageValue(target.uid - 4, 1)
	elseif target.itemid == 11361 then
		local bossStatus = player:getStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.BossStatus)
		local timeNow = os.time()
		local cooldownExpires = player:getStorageValue(COOLDOWN_STORAGE)
		if cooldownExpires ~= -1 and timeNow < cooldownExpires then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must wait before using this again.")
			return true
		end
		if bossStatus == 1 or bossStatus <= 4 then
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.BossStatus, bossStatus + 1)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission10, math.max(1, player:getStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission10)) + 1)
			player:setStorageValue(COOLDOWN_STORAGE, timeNow + COOLDOWN_TIME)
			player:say("The sceptre is almost torn from your hand as you banish the presence of the emperor.", TALKTYPE_MONSTER_SAY)
		end
	elseif target.itemid == 11429 then
		if player:getStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Questline) == 31 then
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Questline, 32)
			player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission11, 2) --Questlog, Wrath of the Emperor "Mission 11: Payback Time"
		end
		player:say("NOOOoooooooo...!", TALKTYPE_MONSTER_SAY, false, player, toPosition)
		player:say("This should have dealt the deathblow to the snake things' ambitions.", TALKTYPE_MONSTER_SAY)
		if not player:hasAchievement("Godslayer") then
			player:addAchievement("Godslayer")
		end
	end
	return true
end

wrathEmperorMiss10Message:id(11362)
wrathEmperorMiss10Message:register()
