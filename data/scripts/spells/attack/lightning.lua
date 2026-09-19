local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setParameter(COMBAT_PARAM_CHAIN_EFFECT, CONST_ME_PINK_ENERGY_SPARK)

function onGetFormulaValues(player, level, maglevel, basePower)
	local min, max = calculateMagicSpellDamage(level, maglevel, basePower)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function getChainValue(creature)
	return 3, 5, false
end

combat:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValue")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack", "special")
spell:id(149)
spell:name("Lightning")
spell:words("exori amp vis")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_LIGHTNING)
spell:level(55)
spell:mana(60)
spell:basePower(110)
spell:isPremium(true)
spell:range(7)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(8 * 1000)
spell:groupCooldown(2 * 1000, 8 * 1000)

spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
