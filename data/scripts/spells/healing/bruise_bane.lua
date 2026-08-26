local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

-- Vocation Adjustment: base power 15, scales with magic level + shielding.
function onGetFormulaValues(player, level, magicLevel, basePower)
	local shielding = player:getEffectiveSkillLevel(SKILL_SHIELD) or 0
	local common = calculateBaseDamageHealing(level) + magicLevel * 0.9 + shielding * 0.3 + basePower
	return common, common + 5
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("Bruise Bane")
spell:words("exura infir ico")
spell:group("healing")
spell:vocation("knight;true", "elite knight;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_BRUISE_BANE)
spell:id(170)
spell:cooldown(1000)
spell:groupCooldown(2 * 1000) -- Phase A rebalance: 1s -> 2s
spell:level(1)
spell:mana(10)
spell:isSelfTarget(true)
spell:isAggressive(false)

spell:isPremium(false)
spell:basePower(15)
spell:register()
