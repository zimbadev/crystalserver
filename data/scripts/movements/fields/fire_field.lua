local fireField = MoveEvent()

local fireCondition20 = Condition(CONDITION_FIRE)
fireCondition20:setParameter(CONDITION_PARAM_DELAYED, true)
fireCondition20:setParameter(CONDITION_PARAM_TICKINTERVAL, 2000)
fireCondition20:setParameter(CONDITION_PARAM_TICKS, 7000)
fireCondition20:setParameter(CONDITION_PARAM_PERIODICDAMAGE, -20)

local fireCondition10 = Condition(CONDITION_FIRE)
fireCondition10:setParameter(CONDITION_PARAM_DELAYED, true)
fireCondition10:setParameter(CONDITION_PARAM_TICKINTERVAL, 2000)
fireCondition10:setParameter(CONDITION_PARAM_TICKS, 7000)
fireCondition10:setParameter(CONDITION_PARAM_PERIODICDAMAGE, -10)

function fireField.onStepIn(creature, item, position, fromPosition)
	if not creature:isCreature() then
		return true
	end

	if creature:isPlayer() and creature:getGroup():getId() >= 2 then
		return true
	end

	if creature:isPlayer() or (creature:isMonster() and creature:getMaster() and creature:getMaster():isPlayer()) then
		position:sendMagicEffect(CONST_ME_POFF)
		return true
	end

	if item:getId() == 2132 then
		doTargetCombatHealth(0, creature, COMBAT_FIREDAMAGE, -10, -10, CONST_ME_HITBYFIRE)
		creature:addCondition(fireCondition10)
	else
		doTargetCombatHealth(0, creature, COMBAT_FIREDAMAGE, -20, -20, CONST_ME_HITBYFIRE)
		creature:addCondition(fireCondition20)
	end

	return true
end

fireField:type("stepin")
fireField:id(2131, 2132)
fireField:register()
