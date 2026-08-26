local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

-- LIVE rebalance: base heal 400 -> 500.
local HEAL_SCALE = 500 / 400

function onGetFormulaValues(player, level, magicLevel, basePower) -- already compared to the official tibia | compared date: 05/07/19(m/d/y)
	local min = (calculateBaseDamageHealing(level) + magicLevel * 12) + 75
	local max = (calculateBaseDamageHealing(level) + magicLevel * 20) + 125
	return math.floor(min * HEAL_SCALE), math.floor(max * HEAL_SCALE)
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("Salvation")
spell:words("exura gran san")
spell:group("healing")
spell:vocation("paladin;true", "royal paladin;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_SALVATION)
spell:id(36)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:level(60)
spell:mana(210)
spell:basePower(500)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)
spell:register()
