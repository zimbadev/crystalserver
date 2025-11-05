local fistCondition = Condition(CONDITION_ATTRIBUTES)
fistCondition:setParameter(CONDITION_PARAM_SUBID, JeanPierreMelee)
fistCondition:setParameter(CONDITION_PARAM_BUFF_SPELL, 1)
fistCondition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
fistCondition:setParameter(CONDITION_PARAM_SKILL_FIST, 10)
fistCondition:setParameter(CONDITION_PARAM_FORCEUPDATE, true)

local zaoanSauce = Action()

function zaoanSauce.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:hasExhaustion("special-foods-cooldown") then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to wait before using it again.")
		return true
	end

	player:addCondition(fistCondition)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You feel more balanced.")
	player:say("Slurp.", TALKTYPE_MONSTER_SAY)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	player:setExhaustion("special-foods-cooldown", 10 * 60)
	item:remove(1)
	return true
end

zaoanSauce:id(50334)
zaoanSauce:register()
