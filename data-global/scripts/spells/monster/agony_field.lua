local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_AGONYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POISONAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)

combat:setParameter(COMBAT_PARAM_CREATEITEM, 43297)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("agonyfield")
spell:words("###agonyfield")
spell:needLearn(true)
spell:cooldown("2000")
spell:isSelfTarget(false)
spell:register()
