local function formulaFunction(player, level, maglevel)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 4)
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 7)
	return -min, -max
end

function onGetFormulaValues(player, level, maglevel, basePower)
	return formulaFunction(player, level, maglevel)
end

function onGetFormulaValuesWOD(player, level, maglevel)
	return formulaFunction(player, level, maglevel)
end

-- Vocation Adjustment: Beam Mastery fires two identical beams parallel to the main one (left + right),
-- each dealing 40/60/80% of the beam damage at Beam Mastery stage 1/2/3 (length matches the combatWOD beam).
function onGetFormulaValuesBeamFlank(player, level, maglevel)
	local stage = player:revelationStageWOD("Beam Mastery")
	local factor = (stage >= 3 and 0.80) or (stage >= 2 and 0.60) or (stage >= 1 and 0.40) or 0
	local min = ((calculateBaseDamageHealing(level)) + (maglevel * 4)) * factor
	local max = ((calculateBaseDamageHealing(level)) + (maglevel * 7)) * factor
	return -min, -max
end

local FLANK_AREA = { { 1, 0, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 0, 3, 0 } }

local function createCombat(area, combatFunc)
	local initCombat = Combat()
	initCombat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, combatFunc)
	initCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
	initCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
	initCombat:setArea(createCombatArea(area))
	return initCombat
end

local combat = createCombat(AREA_BEAM8, "onGetFormulaValues")
local combatWOD = createCombat(AREA_BEAM10, "onGetFormulaValuesWOD")
local flankCombat = createCombat(FLANK_AREA, "onGetFormulaValuesBeamFlank")

-- Vocation Adjustment: a Master Sorcerer's elemental stance reshapes the beam (element + impact effect).
-- Master of Flames -> fire (eff 329), Master of Decay -> death (eff 330), Thunder/none -> base energy.
-- The formula/area are identical per element, so we keep one Combat per role and retune its element each
-- cast (single-threaded: setParameter happens immediately before execute).
local function applyStanceElement(player)
	local combatType, effect = COMBAT_ENERGYDAMAGE, CONST_ME_ENERGYAREA
	local stance = player:getElementalStance()
	if stance == STANCE_MASTER_OF_FLAMES then
		combatType, effect = COMBAT_FIREDAMAGE, 329
	elseif stance == STANCE_MASTER_OF_DECAY then
		combatType, effect = COMBAT_DEATHDAMAGE, 330
	end
	for _, c in ipairs({ combat, combatWOD, flankCombat }) do
		c:setParameter(COMBAT_PARAM_TYPE, combatType)
		c:setParameter(COMBAT_PARAM_EFFECT, effect)
	end
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not creature or not player then
		return false
	end
	applyStanceElement(player)
	local hasBeamMastery = player:instantSkillWOD("Beam Mastery")
	local result = hasBeamMastery and combatWOD:execute(creature, var) or combat:execute(creature, var)
	-- Beam Mastery: fire the parallel left + right beams (scaled inside onGetFormulaValuesBeamFlank).
	if hasBeamMastery then
		flankCombat:execute(creature, var)
	end
	return result
end

spell:group("attack", "greatbeams")
spell:id(23)
spell:name("Great Energy Beam")
spell:words("exevo gran vis lux")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_GREAT_ENERGY_BEAM)
spell:level(29)
spell:mana(110)
spell:basePower(170)
spell:isPremium(false)
spell:needDirection(true)
spell:blockWalls(true)
spell:cooldown(6 * 1000)
spell:groupCooldown(2 * 1000, 6 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
