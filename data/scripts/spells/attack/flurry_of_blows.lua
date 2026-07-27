-- harmony gain (builder)

local AREA_WAVE = {
	{ 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 1, 3, 1, 0 },
	{ 0, 1, 0, 1, 0 },
}

local combatPhysical = Combat()
combatPhysical:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatPhysical:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_WHITE_FLURRYOFBLOWS)
combatPhysical:setArea(createCombatArea(AREA_WAVE))

local combatEnergy = Combat()
combatEnergy:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combatEnergy:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PINK_FLURRYOFBLOWS)
combatEnergy:setArea(createCombatArea(AREA_WAVE))

local combatEarth = Combat()
combatEarth:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combatEarth:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_FLURRYOFBLOWS)
combatEarth:setArea(createCombatArea(AREA_WAVE))

function onGetFormulaValues(player, skill, weaponDamage, attackFactor, basePower)
	local attackValue = calculateAttackValue(player, skill, weaponDamage)
	local spellFactor = 0.6
	local total = calculateMonkSpellDamage(player, skill, weaponDamage, basePower, spellFactor)
	return -total * 0.9, -total * 1.1
end

onGetFormulaValuesEnergy = onGetFormulaValues
onGetFormulaValuesEarth = onGetFormulaValues
onGetFormulaValuesPhysical = onGetFormulaValues

combatPhysical:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesPhysical")
combatEnergy:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesEnergy")
combatEarth:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesEarth")

local combatTypes = {
	["physical"] = combatPhysical,
	["energy"] = combatEnergy,
	["earth"] = combatEarth,
}

-- Vocation Adjustment: wheel Flurry of Blows grade I augment enlarges the affected area.
local AREA_WAVE_WOD = {
	{ 0, 0, 1, 0, 0 },
	{ 0, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1 },
	{ 1, 1, 3, 1, 1 },
	{ 1, 1, 0, 1, 1 },
}
local combatPhysicalWOD = Combat()
combatPhysicalWOD:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatPhysicalWOD:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_WHITE_FLURRYOFBLOWS)
combatPhysicalWOD:setArea(createCombatArea(AREA_WAVE_WOD))
onGetFormulaValuesPhysicalWOD = loadstring(string.dump(onGetFormulaValues))
combatPhysicalWOD:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesPhysicalWOD")
local combatEnergyWOD = Combat()
combatEnergyWOD:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combatEnergyWOD:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PINK_FLURRYOFBLOWS)
combatEnergyWOD:setArea(createCombatArea(AREA_WAVE_WOD))
onGetFormulaValuesEnergyWOD = loadstring(string.dump(onGetFormulaValues))
combatEnergyWOD:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesEnergyWOD")
local combatEarthWOD = Combat()
combatEarthWOD:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combatEarthWOD:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_FLURRYOFBLOWS)
combatEarthWOD:setArea(createCombatArea(AREA_WAVE_WOD))
onGetFormulaValuesEarthWOD = loadstring(string.dump(onGetFormulaValues))
combatEarthWOD:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesEarthWOD")
local combatTypesWOD = {
	["physical"] = combatPhysicalWOD,
	["energy"] = combatEnergyWOD,
	["earth"] = combatEarthWOD,
}

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local types = combatTypes
	local player = creature:getPlayer()
	if player and player:getWheelSpellAdditionalArea("Flurry of Blows") then
		types = combatTypesWOD
	end

	local combat = types["physical"]
	local weapon = creature:getSlotItem(CONST_SLOT_LEFT)
	if weapon then
		local itemType = weapon:getType()
		if itemType and itemType.getElementalBond then
			local elementalBondType = itemType:getElementalBond():lower()
			if elementalBondType then
				combat = types[elementalBondType] or combat
			end
		end
	end

	creature:addHarmony(1)

	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(287)
spell:name("Flurry of Blows")
spell:words("exori mas pug")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FLURRY_OF_BLOWS)
spell:level(35)
spell:mana(110)
spell:basePower(55)
spell:isPremium(true)
spell:needDirection(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("monk;true", "exalted monk;true")
spell:register()
