local function formulaFunction(player, level, maglevel)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 1.8) + 11
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 3) + 19
	return -min, -max
end

function onGetFormulaValues(player, level, maglevel, basePower)
	return formulaFunction(player, level, maglevel)
end

function onGetFormulaValuesWOD(player, level, maglevel)
	return formulaFunction(player, level, maglevel)
end

local function createCombat(area, areaDiagonal, combatFunc)
	local initCombat = Combat()
	initCombat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, combatFunc)
	initCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
	initCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
	initCombat:setArea(createCombatArea(area, areaDiagonal))
	return initCombat
end

local combat = createCombat(AREA_BEAM5, AREADIAGONAL_BEAM5, "onGetFormulaValues")
local combatWOD = createCombat(AREA_BEAM7, AREADIAGONAL_BEAM7, "onGetFormulaValuesWOD")

-- Vocation Adjustment: Beam Mastery fires two identical beams parallel to the main one (left + right),
-- each dealing 40/60/80% of the beam damage at Beam Mastery stage 1/2/3. Flank length matches the
-- Beam-Mastery (combatWOD) beam length; orthogonal flank, diagonal casts approximate.
function onGetFormulaValuesBeamFlank(player, level, maglevel)
	local stage = player:revelationStageWOD("Beam Mastery")
	local factor = (stage >= 3 and 0.80) or (stage >= 2 and 0.60) or (stage >= 1 and 0.40) or 0
	local min = ((calculateBaseDamageHealing(level)) + (maglevel * 1.8) + 11) * factor
	local max = ((calculateBaseDamageHealing(level)) + (maglevel * 3) + 19) * factor
	return -min, -max
end

local flankCombat = Combat()
flankCombat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValuesBeamFlank")
flankCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
flankCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
flankCombat:setArea(createCombatArea({ { 1, 0, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 0, 3, 0 } }))

-- Vocation Adjustment: a Master Sorcerer's elemental stance reshapes the beam (element + impact effect).
-- Master of Flames -> fire (eff 329), Master of Decay -> death (eff 330), Thunder/none -> base energy.
local function applyStanceElement(player)
	local combatType, effect = COMBAT_ENERGYDAMAGE, CONST_ME_ENERGYHIT
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

spell:group("attack")
spell:id(22)
spell:name("Energy Beam")
spell:words("exevo vis lux")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_ENERGY_BEAM)
spell:level(23)
spell:mana(40)
spell:basePower(60)
spell:isPremium(false)
spell:needDirection(true)
spell:blockWalls(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
