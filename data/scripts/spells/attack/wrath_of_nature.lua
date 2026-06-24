local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLPLANTS)
combat:setArea(createCombatArea(AREA_CIRCLE6X6))

-- Phase III LIVE rebalance: base 150 -> 175 (factor 1.1667).
local DAMAGE_SCALE = 175 / 150

function onGetFormulaValues(player, level, maglevel, basePower)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 5)
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 10)
	return -math.floor(min * DAMAGE_SCALE), -math.floor(max * DAMAGE_SCALE)
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack", "focus")
spell:id(56)
spell:name("Wrath of Nature")
spell:words("exevo gran mas tera")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_WRATH_OF_NATURE)
spell:level(55)
spell:mana(700)
spell:basePower(175)
spell:isPremium(true)
spell:isSelfTarget(true)
spell:cooldown(40 * 1000)
spell:groupCooldown(4 * 1000, 40 * 1000)
spell:vocation("druid;true", "elder druid;true")
spell:register()
