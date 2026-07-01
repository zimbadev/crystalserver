local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

-- Vocation Adjustment: base power 70, scales with magic level + shielding.
function onGetFormulaValues(player, level, magicLevel, basePower)
	return calculateKnightHealing(player, magicLevel, basePower, 4.0, 7.95, 1.0)
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("Wound Cleansing")
spell:words("exura ico")
spell:group("healing")
spell:vocation("knight;true", "elite knight;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_WOUND_CLEANSING)
spell:id(123)
spell:cooldown(1 * 1000)
spell:groupCooldown(2 * 1000) -- Phase A rebalance: 1s -> 2s
spell:level(8)
spell:mana(40)
spell:basePower(70)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:register()
