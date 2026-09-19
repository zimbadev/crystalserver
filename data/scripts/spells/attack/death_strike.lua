-- Vocation Adjustment: a Master Sorcerer's elemental stance reshapes Death Strike (element + impact
-- effect + missile):
--   Master of Flames  -> fire,   effect 334, missile 4
--   Master of Thunder -> energy, effect 335, missile 5
--   Master of Decay / no stance -> base death (CONST_ME_MORTAREA / CONST_ANI_DEATH)
local function deathStrikeFormula(level, maglevel)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 1.403) + 8
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 2.203) + 13
	return -min, -max
end

-- Each combat needs its OWN callback name (Canary won't let two combats share a callback name); all
-- delegate to the same formula.
function onGetFormulaValues(player, level, maglevel, basePower)
	return deathStrikeFormula(level, maglevel)
end
function onGetFormulaValuesFlames(player, level, maglevel)
	return deathStrikeFormula(level, maglevel)
end
function onGetFormulaValuesThunder(player, level, maglevel)
	return deathStrikeFormula(level, maglevel)
end

local function createDeathStrikeCombat(combatType, effect, missile, callbackName)
	local c = Combat()
	c:setParameter(COMBAT_PARAM_TYPE, combatType)
	c:setParameter(COMBAT_PARAM_EFFECT, effect)
	c:setParameter(COMBAT_PARAM_DISTANCEEFFECT, missile)
	c:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, callbackName)
	return c
end

local combat = createDeathStrikeCombat(COMBAT_DEATHDAMAGE, CONST_ME_MORTAREA, CONST_ANI_DEATH, "onGetFormulaValues")
local combatFlames = createDeathStrikeCombat(COMBAT_FIREDAMAGE, 334, 4, "onGetFormulaValuesFlames")
local combatThunder = createDeathStrikeCombat(COMBAT_ENERGYDAMAGE, 335, 5, "onGetFormulaValuesThunder")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player then
		local stance = player:getElementalStance()
		if stance == STANCE_MASTER_OF_FLAMES then
			return combatFlames:execute(creature, var)
		elseif stance == STANCE_MASTER_OF_THUNDER then
			return combatThunder:execute(creature, var)
		end
	end
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(87)
spell:name("Death Strike")
spell:words("exori mort")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_DEATH_STRIKE)
spell:level(16)
spell:mana(20)
spell:basePower(45)
spell:isPremium(true)
spell:range(3)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
