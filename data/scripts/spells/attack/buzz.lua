-- Vocation Adjustment: a Master Sorcerer's elemental stance reshapes Buzz (element + impact EFFECT id +
-- missile DISTANCEEFFECT):
--   Master of Flames -> fire,  effect 329, missile 4
--   Master of Decay  -> death, effect 330, missile 11
--   Master of Thunder / no stance -> base energy (CONST_ME_ENERGYAREA / CONST_ANI_ENERGY)
local function buzzFormula(level, maglevel)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 0.4) + 3
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 0.7) + 5
	return -min, -max
end

-- Each combat needs its OWN callback name (Canary won't let two combats share a callback name); all
-- three delegate to the same formula.
function onGetFormulaValues(player, level, maglevel, basePower)
	return buzzFormula(level, maglevel)
end
function onGetFormulaValuesFlames(player, level, maglevel)
	return buzzFormula(level, maglevel)
end
function onGetFormulaValuesDecay(player, level, maglevel)
	return buzzFormula(level, maglevel)
end

local function createBuzzCombat(combatType, effect, missile, callbackName)
	local c = Combat()
	c:setParameter(COMBAT_PARAM_TYPE, combatType)
	c:setParameter(COMBAT_PARAM_EFFECT, effect)
	c:setParameter(COMBAT_PARAM_DISTANCEEFFECT, missile)
	c:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, callbackName)
	return c
end

local combatEnergy = createBuzzCombat(COMBAT_ENERGYDAMAGE, CONST_ME_ENERGYAREA, CONST_ANI_ENERGY, "onGetFormulaValues")
local combatFlames = createBuzzCombat(COMBAT_FIREDAMAGE, 329, 4, "onGetFormulaValuesFlames")
local combatDecay = createBuzzCombat(COMBAT_DEATHDAMAGE, 330, 11, "onGetFormulaValuesDecay")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player then
		local stance = player:getElementalStance()
		if stance == STANCE_MASTER_OF_FLAMES then
			return combatFlames:execute(creature, var)
		elseif stance == STANCE_MASTER_OF_DECAY then
			return combatDecay:execute(creature, var)
		end
	end
	return combatEnergy:execute(creature, var)
end

spell:group("attack")
spell:id(177)
spell:name("Buzz")
spell:words("exori infir vis")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_BUZZ)
spell:level(1)
spell:mana(6)
spell:basePower(15)
spell:isAggressive(true)
spell:isPremium(false)
spell:range(3)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
