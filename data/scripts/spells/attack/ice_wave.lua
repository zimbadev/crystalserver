local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)
combat:setArea(createCombatArea(AREA_WAVE4, AREADIAGONAL_WAVE4))

function onGetFormulaValues(player, level, maglevel, basePower)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 0.81) + 4
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 2) + 12
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(121)
spell:name("Ice Wave")
spell:words("exevo frigo hur")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_ICE_WAVE)
spell:level(18)
spell:mana(25)
spell:basePower(35)
spell:needDirection(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("druid;true", "elder druid;true")
spell:register()
