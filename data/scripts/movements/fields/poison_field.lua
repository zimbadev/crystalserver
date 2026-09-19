local poisonField = MoveEvent()

local poisonCondition = Condition(CONDITION_POISON)
poisonCondition:setParameter(CONDITION_PARAM_DELAYED, true)

poisonCondition:addDamage(4, 1000, -5)
poisonCondition:addDamage(5, 1000, -4)
poisonCondition:addDamage(7, 1000, -3)
poisonCondition:addDamage(10, 1000, -2)
poisonCondition:addDamage(19, 1000, -1)

function poisonField.onStepIn(creature, item, position, fromPosition)
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

	doTargetCombatHealth(0, creature, COMBAT_EARTHDAMAGE, -10, -10, CONST_ME_POISON)
	creature:addCondition(poisonCondition)

	return true
end

poisonField:type("stepin")
poisonField:id(2134)
poisonField:register()
