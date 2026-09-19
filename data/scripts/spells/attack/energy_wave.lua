-- Vocation Adjustment: a Master Sorcerer's elemental stance reshapes Energy Wave (element + impact
-- EFFECT id + missile):
--   Master of Flames -> fire,  effect 329, missile 4
--   Master of Decay  -> death, effect 330, missile 11
--   Master of Thunder / no stance -> base energy (CONST_ME_ENERGYAREA / CONST_ANI_ENERGY)
local function formulaFunction(player, level, maglevel)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 4.5)
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 9)
	return -min, -max
end

-- Each combat needs its OWN callback name (Canary won't let two combats share a callback name); all
-- delegate to the same formula.
function onGetFormulaValues(player, level, maglevel, basePower)
	return formulaFunction(player, level, maglevel)
end

function onGetFormulaValuesWOD(player, level, maglevel)
	return formulaFunction(player, level, maglevel)
end

function onGetFormulaValuesFlames(player, level, maglevel)
	return formulaFunction(player, level, maglevel)
end

function onGetFormulaValuesFlamesWOD(player, level, maglevel)
	return formulaFunction(player, level, maglevel)
end

function onGetFormulaValuesDecay(player, level, maglevel)
	return formulaFunction(player, level, maglevel)
end

function onGetFormulaValuesDecayWOD(player, level, maglevel)
	return formulaFunction(player, level, maglevel)
end

local function createCombat(area, areaDiagonal, combatType, effect, missile, combatFunc)
	local initCombat = Combat()
	initCombat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, combatFunc)
	initCombat:setParameter(COMBAT_PARAM_TYPE, combatType)
	initCombat:setParameter(COMBAT_PARAM_EFFECT, effect)
	initCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, missile)
	initCombat:setArea(createCombatArea(area, areaDiagonal))
	return initCombat
end

-- Base energy
local combat = createCombat(AREA_SQUAREWAVE5, AREADIAGONAL_SQUAREWAVE5, COMBAT_ENERGYDAMAGE, CONST_ME_ENERGYAREA, CONST_ANI_ENERGY, "onGetFormulaValues")
local combatWOD = createCombat(AREA_WAVE7, AREADIAGONAL_WAVE7, COMBAT_ENERGYDAMAGE, CONST_ME_ENERGYAREA, CONST_ANI_ENERGY, "onGetFormulaValuesWOD")

-- Master of Flames -> fire, effect 329, missile 4
local combatFlames = createCombat(AREA_SQUAREWAVE5, AREADIAGONAL_SQUAREWAVE5, COMBAT_FIREDAMAGE, 329, 4, "onGetFormulaValuesFlames")
local combatFlamesWOD = createCombat(AREA_WAVE7, AREADIAGONAL_WAVE7, COMBAT_FIREDAMAGE, 329, 4, "onGetFormulaValuesFlamesWOD")

-- Master of Decay -> death, effect 330, missile 11
local combatDecay = createCombat(AREA_SQUAREWAVE5, AREADIAGONAL_SQUAREWAVE5, COMBAT_DEATHDAMAGE, 330, 11, "onGetFormulaValuesDecay")
local combatDecayWOD = createCombat(AREA_WAVE7, AREADIAGONAL_WAVE7, COMBAT_DEATHDAMAGE, 330, 11, "onGetFormulaValuesDecayWOD")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player then
		local stance = player:getElementalStance()
		local wod = player:getWheelSpellAdditionalArea("Energy Wave")
		if stance == STANCE_MASTER_OF_FLAMES then
			return (wod and combatFlamesWOD or combatFlames):execute(creature, var)
		elseif stance == STANCE_MASTER_OF_DECAY then
			return (wod and combatDecayWOD or combatDecay):execute(creature, var)
		end
		if wod then
			return combatWOD:execute(creature, var)
		end
	end
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(13)
spell:name("Energy Wave")
spell:words("exevo vis hur")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_ENERGY_WAVE)
spell:level(38)
spell:mana(170)
spell:basePower(150)
spell:needDirection(true)
spell:cooldown(8 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
