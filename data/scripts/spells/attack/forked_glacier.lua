local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 324)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLICE)
-- Vocation Adjustment: forked chain to up to 6 additional targets (7 total).
combat:setParameter(COMBAT_PARAM_CHAIN_EFFECT, CONST_ME_ICEATTACK)

-- Base damage 97 (ML-scaled). Modeled on strong_ice_strike's formula curve.
function onGetFormulaValues(player, level, maglevel, basePower)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 2.4) + 14
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 3.8) + 24
	return -math.floor(min), -math.floor(max)
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

-- Hits the target plus up to 6 nearby creatures (7 total), jump distance 5.
function getChainValue(creature)
	local targets = 7
	local player = creature:getPlayer()
	if creature and player then
		targets = targets + player:getWheelSpellAdditionalTarget("Forked Glacier") -- Vocation Adjustment: wheel +1 target
	end
	return targets, 5, false
end

combat:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValue")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack", "special")
spell:id(317)
spell:name("Forked Glacier")
spell:words("exevo fur frigo")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_STRONG_ICE_STRIKE)
spell:level(90)
spell:mana(180)
spell:basePower(97)
spell:isPremium(true)
spell:range(7)
spell:needTarget(false)
spell:blockWalls(true)
spell:cooldown(6 * 1000)
spell:groupCooldown(2 * 1000, 2 * 1000)
spell:needLearn(false)
spell:vocation("druid;true", "elder druid;true")
spell:register()
