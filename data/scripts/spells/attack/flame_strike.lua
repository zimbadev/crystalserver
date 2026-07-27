-- Vocation Adjustment: a Master Sorcerer's elemental stance reshapes Flame Strike (element + impact
-- effect(s) + missile):
--   Master of Thunder -> energy, effects 331+333, missile 5
--   Master of Decay   -> death,  effects 332+336, missile 11
--   Master of Flames / no stance -> base fire (CONST_ME_FIREATTACK, CONST_ANI_FIRE)
local function flameFormula(level, maglevel, basePower)
	local avg = spellMagicDamage(basePower, level, maglevel)
	return -math.floor(avg * 0.9), -math.ceil(avg * 1.1)
end

-- Each combat needs its OWN callback name (Canary won't let two combats share a callback name); all
-- three delegate to the same formula.
function onGetFormulaValues(player, level, maglevel, basePower)
	return flameFormula(level, maglevel, basePower)
end
function onGetFormulaValuesThunder(player, level, maglevel, basePower)
	return flameFormula(level, maglevel, basePower)
end
function onGetFormulaValuesDecay(player, level, maglevel, basePower)
	return flameFormula(level, maglevel, basePower)
end

-- Second impact effect for two-effect variants, registered per-variant via TARGETCREATURE callback.
function onTargetSecondEffectThunder(creature, target)
	target:getPosition():sendMagicEffect(333)
	return true
end
function onTargetSecondEffectDecay(creature, target)
	target:getPosition():sendMagicEffect(336)
	return true
end

-- Base combat (fire)
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREATTACK)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

-- Variant: Master of Thunder (energy, effects 331+333, missile 5)
local combatThunder = Combat()
combatThunder:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combatThunder:setParameter(COMBAT_PARAM_EFFECT, 331)
combatThunder:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 5)
combatThunder:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValuesThunder")
combatThunder:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetSecondEffectThunder")

-- Variant: Master of Decay (death, effects 332+336, missile 11)
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

spell:group("attack")
spell:id(89)
spell:name("Flame Strike")
spell:words("exori flam")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_FLAME_STRIKE)
spell:level(14)
spell:mana(20)
spell:basePower(45)
spell:isPremium(true)
spell:range(3)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("sorcerer;true", "druid;true", "master sorcerer;true", "elder druid;true")
spell:register()
