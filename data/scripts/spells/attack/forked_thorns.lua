local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 325)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLEARTH)
-- Vocation Adjustment: forked chain to up to 5 additional targets (6 total).
combat:setParameter(COMBAT_PARAM_CHAIN_EFFECT, CONST_ME_CARNIPHILA)

-- Base damage 105 (ML-scaled). Modeled on strong_terra_strike's formula curve.
function onGetFormulaValues(player, level, maglevel, basePower)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 2.6) + 16
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 4.1) + 26
	return -math.floor(min), -math.floor(max)
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

-- Hits the target plus up to 5 nearby creatures (6 total), jump distance 5.
function getChainValue(creature)
	local targets = 6
	local player = creature:getPlayer()
	if creature and player then
		targets = targets + player:getWheelSpellAdditionalTarget("Forked Thorns") -- Vocation Adjustment: wheel +1 target
	end
	return targets, 5, false
end

combat:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValue")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack", "special")
spell:id(318)
spell:name("Forked Thorns")
spell:words("exevo fur tera")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_STRONG_TERRA_STRIKE)
spell:level(80)
spell:mana(180)
spell:basePower(105)
spell:isPremium(true)
spell:range(7)
spell:needTarget(false)
spell:blockWalls(true)
spell:cooldown(6 * 1000)
spell:groupCooldown(2 * 1000, 2 * 1000)
spell:needLearn(false)

spell:vocation("druid;true", "elder druid;true")
spell:register()
