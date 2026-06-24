local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

function onGetFormulaValues(player, level, magicLevel, basePower) -- already compared to the official tibia | compared date: 05/07/19(m/d/y)
	local min = (calculateBaseDamageHealing(level) + magicLevel * 1.4) + 8
	local max = (calculateBaseDamageHealing(level) + magicLevel * 1.795) + 11
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("Light Healing")
spell:words("exura")
spell:group("healing")
spell:vocation("druid;true", "elder druid;true", "paladin;true", "royal paladin;true", "sorcerer;true", "master sorcerer;true", "monk;true", "exalted monk;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_LIGHT_HEALING)
spell:id(1)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:level(8)
spell:mana(20)
spell:basePower(40)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:register()
