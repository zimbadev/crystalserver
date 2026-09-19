local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 319)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)
combat:setArea(createCombatArea(AREA_CIRCLE2X2))

function onGetFormulaValues(player, level, maglevel, basePower)
	local min, max = calculateMagicSpellDamage(level, maglevel, basePower)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(302)
spell:name("Divine Barrage")
spell:words("exori dir san")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_CALDERA)
spell:level(70)
spell:mana(175)
spell:basePower(130)
spell:isPremium(true)
spell:isAggressive(true)
spell:range(7)
spell:needPosition(true)
spell:needTarget(true)
spell:blockWalls(true)
spell:needLearn(false)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()
