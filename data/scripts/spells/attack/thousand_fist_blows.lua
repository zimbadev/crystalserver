-- harmony gain (builder)
-- Thousand Fist Blows (Monk) id 301 - Vocation Adjustment
-- Crosshair/target spell: needTarget + setArea so the engine resolves the
-- target creature and applies a burst (AREA_CIRCLE3X3, matches client radius 3)
-- centered on the target's tile, hitting the target and its surroundings.
-- Physical monk-fist damage with weapon-elemental-bond conversion
-- (physical/energy/earth) like Mystic Repulse / Flurry of Blows.
-- Builder: grants 1 harmony per cast (creature:addHarmony(1)).

local AREA = AREA_CIRCLE3X3

local combatPhysical = Combat()
combatPhysical:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatPhysical:setParameter(COMBAT_PARAM_EFFECT, 326)
combatPhysical:setArea(createCombatArea(AREA))

local combatEnergy = Combat()
combatEnergy:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combatEnergy:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PINK_FLURRYOFBLOWS)
combatEnergy:setArea(createCombatArea(AREA))

local combatEarth = Combat()
combatEarth:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combatEarth:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_FLURRYOFBLOWS)
combatEarth:setArea(createCombatArea(AREA))

function onGetFormulaValues(player, skill, weaponDamage, attackFactor, basePower)
	local attackValue = calculateAttackValue(player, skill, weaponDamage)
	local spellFactor = 0.8
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

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local combat = combatPhysical
	local weapon = creature:getSlotItem(CONST_SLOT_LEFT)
	if weapon then
		local itemType = weapon:getType()
		if itemType and itemType.getElementalBond then
			local elementalBondType = itemType:getElementalBond():lower()
			if elementalBondType then
				combat = combatTypes[elementalBondType] or combat
			end
		end
	end

	creature:addHarmony(1)
	-- needPosition: var is the clicked tile (cursor/crosshair); the area is cast there.
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(301)
spell:name("Thousand Fist Blows")
spell:words("exori mas amp pug")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FLURRY_OF_BLOWS)
spell:level(120)
spell:mana(145)
spell:basePower(62)
spell:isPremium(true)
spell:isAggressive(true)
spell:range(7)
spell:needPosition(true) -- cast at the clicked tile (cursor/crosshair); var is VARIANT_POSITION
spell:blockWalls(true)
spell:needWeapon(false)
spell:needLearn(false)
spell:cooldown(12 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("monk;true", "exalted monk;true")
spell:register()
