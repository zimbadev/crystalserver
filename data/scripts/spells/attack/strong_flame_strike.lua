-- Vocation Adjustment: a Master Sorcerer's elemental stance reshapes Strong Flame Strike
-- (element + impact effect + missile):
--   Master of Thunder -> energy, effects [331, 333], missile 5
--   Master of Decay   -> death,  effects [332, 336], missile 11
--   Master of Flames / no stance -> base fire (CONST_ME_FIREATTACK, CONST_ANI_FIRE)

-- Phase III LIVE rebalance: base 90 -> 125.
local DAMAGE_SCALE = 125 / 90

-- Shared formula; each combat needs its OWN callback name (Canary won't let two combats share a
-- callback name), so the variants delegate to this.
local function strikeFormula(level, maglevel)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 2.8) + 16
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 4.4) + 28
	return -math.floor(min * DAMAGE_SCALE), -math.floor(max * DAMAGE_SCALE)
end

function onGetFormulaValues(player, level, maglevel, basePower)
	return strikeFormula(level, maglevel)
end
function onGetFormulaValuesThunder(player, level, maglevel)
	return strikeFormula(level, maglevel)
end
function onGetFormulaValuesDecay(player, level, maglevel)
	return strikeFormula(level, maglevel)
end

-- Second impact effect (the first is set via COMBAT_PARAM_EFFECT) is delivered through a uniquely
-- named target callback per variant.
function onTargetSecondEffectThunder(creature, target)
	target:getPosition():sendMagicEffect(333)
	return true
end
function onTargetSecondEffectDecay(creature, target)
	target:getPosition():sendMagicEffect(336)
	return true
end

-- Base combat (unchanged element/effect/missile).
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREATTACK)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local function createStrikeVariant(combatType, firstEffect, missile, formulaCallback, secondEffectCallback)
	local c = Combat()
	c:setParameter(COMBAT_PARAM_TYPE, combatType)
	c:setParameter(COMBAT_PARAM_EFFECT, firstEffect)
	c:setParameter(COMBAT_PARAM_DISTANCEEFFECT, missile)
	c:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, formulaCallback)
	c:setCallback(CALLBACK_PARAM_TARGETCREATURE, secondEffectCallback)
	return c
end

local combatThunder = createStrikeVariant(COMBAT_ENERGYDAMAGE, 331, 5, "onGetFormulaValuesThunder", "onTargetSecondEffectThunder")
local combatDecay = createStrikeVariant(COMBAT_DEATHDAMAGE, 332, 11, "onGetFormulaValuesDecay", "onTargetSecondEffectDecay")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player then
		local stance = player:getElementalStance()
		if stance == STANCE_MASTER_OF_THUNDER then
			return combatThunder:execute(creature, var)
		elseif stance == STANCE_MASTER_OF_DECAY then
			return combatDecay:execute(creature, var)
		end
	end
	return combat:execute(creature, var)
end

spell:group("attack", "special")
spell:id(150)
spell:name("Strong Flame Strike")
spell:words("exori gran flam")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_STRONG_FLAME_STRIKE)
spell:level(70)
spell:mana(60)
spell:basePower(125)
spell:isPremium(true)
spell:range(7)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(8 * 1000)
spell:groupCooldown(2 * 1000, 8 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
