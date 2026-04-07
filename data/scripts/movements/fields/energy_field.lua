local energyField = MoveEvent()

local energyCondition = Condition(CONDITION_ENERGY)
energyCondition:setParameter(CONDITION_PARAM_DELAYED, true)
energyCondition:addDamage(5, 2000, -25)

function energyField.onStepIn(creature, item, position, fromPosition)
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

	doTargetCombatHealth(0, creature, COMBAT_ENERGYDAMAGE, -30, -30, CONST_ME_ENERGYHIT)
	creature:addCondition(energyCondition)

	return true
end

energyField:type("stepin")
energyField:id(2135)
energyField:register()
