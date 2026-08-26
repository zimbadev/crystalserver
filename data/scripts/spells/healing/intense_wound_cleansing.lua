local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

-- Vocation Adjustment: base power 500, scales with magic level + shielding.
function onGetFormulaValues(player, level, magicLevel, basePower)
	return calculateKnightHealing(player, magicLevel, basePower, 20.0, 40.0, 5.0, 2)
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("Intense Wound Cleansing")
spell:words("exura gran ico")
spell:group("healing")
spell:vocation("knight;true", "elite knight;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_INTENSE_WOUND_CLEANSING)
spell:id(158)
spell:cooldown(120000) -- Vocation Adjustment: 10min -> 2min
spell:groupCooldown(2 * 1000) -- Phase A rebalance: 1s -> 2s
spell:level(80)
spell:mana(200)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)
spell:basePower(500)
spell:register()
