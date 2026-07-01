-- Vocation Adjustment: a Master Sorcerer's elemental stance reshapes Ultimate Flame Strike (element +
-- impact effect + missile):
--   Master of Thunder -> energy, effects 331+333, missile 5
--   Master of Decay   -> death,  effects 332+336, missile 11
--   Master of Flames / no stance -> base fire (CONST_ME_FIREATTACK, CONST_ANI_FIRE)

-- Phase III LIVE rebalance: base 150 -> 210.
local DAMAGE_SCALE = 210 / 150

local function strikeFormula(level, maglevel)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 4.5) + 35
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 7.3) + 55
	return -math.floor(min * DAMAGE_SCALE), -math.floor(max * DAMAGE_SCALE)
end

-- Each combat needs its OWN callback name (Canary won't let two combats share a callback name); all
-- three delegate to the same formula.
function onGetFormulaValues(player, level, maglevel, basePower)
	return strikeFormula(level, maglevel)
end
function onGetFormulaValuesThunder(player, level, maglevel)
	return strikeFormula(level, maglevel)
end
function onGetFormulaValuesDecay(player, level, maglevel)
	return strikeFormula(level, maglevel)
end

-- Second-effect target callbacks (variants list two impact effects each).
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

-- Master of Thunder variant: energy, effects 331+333, missile 5.
local combatThunder = Combat()
combatThunder:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combatThunder:setParameter(COMBAT_PARAM_EFFECT, 331)
combatThunder:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 5)
combatThunder:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValuesThunder")
combatThunder:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetSecondEffectThunder")

-- Master of Decay variant: death, effects 332+336, missile 11.
local combatDecay = Combat()
combatDecay:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatDecay:setParameter(COMBAT_PARAM_EFFECT, 332)
combatDecay:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 11)
combatDecay:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValuesDecay")
combatDecay:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetSecondEffectDecay")

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

spell:group("attack", "ultimatestrikes")
spell:id(154)
spell:name("Ultimate Flame Strike")
spell:words("exori max flam")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_ULTIMATE_FLAME_STRIKE)
spell:level(90)
spell:mana(100)
spell:basePower(210)
spell:isPremium(true)
spell:range(7)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(30 * 1000)
spell:groupCooldown(2 * 1000, 30 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
