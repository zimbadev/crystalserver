-- Vocation Adjustment: a Master Sorcerer's elemental stance reshapes Ultimate Energy Strike (element +
-- impact EFFECT + missile DISTANCEEFFECT):
--   Master of Flames -> fire,  effect 329, missile 4
--   Master of Decay  -> death, effect 330, missile 11
--   Master of Thunder / no stance -> base energy (CONST_ME_ENERGYAREA / CONST_ANI_ENERGY)

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
function onGetFormulaValuesFlames(player, level, maglevel)
	return strikeFormula(level, maglevel)
end
function onGetFormulaValuesDecay(player, level, maglevel)
	return strikeFormula(level, maglevel)
end

local function createStrikeCombat(combatType, effect, missile, callbackName)
	local c = Combat()
	c:setParameter(COMBAT_PARAM_TYPE, combatType)
	c:setParameter(COMBAT_PARAM_EFFECT, effect)
	c:setParameter(COMBAT_PARAM_DISTANCEEFFECT, missile)
	c:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, callbackName)
	return c
end

local combatEnergy = createStrikeCombat(COMBAT_ENERGYDAMAGE, CONST_ME_ENERGYAREA, CONST_ANI_ENERGY, "onGetFormulaValues")
local combatFlames = createStrikeCombat(COMBAT_FIREDAMAGE, 329, 4, "onGetFormulaValuesFlames")
local combatDecay = createStrikeCombat(COMBAT_DEATHDAMAGE, 330, 11, "onGetFormulaValuesDecay")

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

spell:group("attack", "ultimatestrikes")
spell:id(155)
spell:name("Ultimate Energy Strike")
spell:words("exori max vis")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_ULTIMATE_ENERGY_STRIKE)
spell:level(100)
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
