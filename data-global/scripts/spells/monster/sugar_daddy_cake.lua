local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_CAKE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_CAKE)

local exhaustSpellGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustSpellGroup:setParameter(CONDITION_PARAM_SUBID, 3)
exhaustSpellGroup:setParameter(CONDITION_PARAM_TICKS, 5000)
combat:addCondition(exhaustSpellGroup)

local exhaustHealGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustHealGroup:setParameter(CONDITION_PARAM_SUBID, 2)
exhaustHealGroup:setParameter(CONDITION_PARAM_TICKS, 5000)
combat:addCondition(exhaustHealGroup)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local target = creature:getTarget()
	if not target or not target:isPlayer() then
		return false
	end

	return combat:execute(creature, var)
end

spell:name("sugar daddy cake")
spell:words("###sdc")
spell:isAggressive(true)
spell:needTarget(true)
spell:needLearn(true)
spell:register()
