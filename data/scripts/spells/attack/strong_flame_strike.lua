local function strikeFormula(level, maglevel, basePower)
	local min, max = calculateMagicSpellDamage(level, maglevel, basePower)
	return -min, -max
end

function onGetFormulaValues(player, level, maglevel, basePower)
	return strikeFormula(level, maglevel, basePower)
end
function onGetFormulaValuesThunder(player, level, maglevel, basePower)
	return strikeFormula(level, maglevel, basePower)
end
function onGetFormulaValuesDecay(player, level, maglevel, basePower)
	return strikeFormula(level, maglevel, basePower)
end

function onTargetSecondEffectThunder(creature, target)
	target:getPosition():sendMagicEffect(333)
	return true
end
function onTargetSecondEffectDecay(creature, target)
	target:getPosition():sendMagicEffect(336)
	return true
end

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
