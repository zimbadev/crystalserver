local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)
combat:setArea(createCombatArea(AREA_WAVE6, AREADIAGONAL_WAVE6))

-- Vocation Adjustment: base power 72 -> 80
-- Vocation Adjustment: wheel Front Sweep grade II augment widens the shape (+2 squares to the sides, 3 -> 5 SQM).
local BASE_SCALE = 80 / 72

local function getFrontSweepFormula(player, skill, attack, factor)
	local skillTotal = skill * attack
	local levelTotal = calculateBaseDamageHealing(player:getLevel())
	return -(((skillTotal * 0.04) + 31) + levelTotal) * 1.1 * BASE_SCALE, -(((skillTotal * 0.08) + 45) + levelTotal) * 1.1 * BASE_SCALE -- TODO : Use New Real Formula instead of an %
end

function onGetFormulaValues(player, skill, attack, factor)
	return getFrontSweepFormula(player, skill, attack, factor)
end

function onGetFormulaValuesWOD(player, skill, attack, factor)
	return getFrontSweepFormula(player, skill, attack, factor)
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local combatWOD = Combat()
combatWOD:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatWOD:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combatWOD:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combatWOD:setParameter(COMBAT_PARAM_USECHARGES, 1)
combatWOD:setArea(createCombatArea(AREA_FRONT_SWEEP_WOD, AREADIAGONAL_FRONT_SWEEP_WOD))
combatWOD:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesWOD")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player and player:getWheelSpellAdditionalArea("Front Sweep") then
		return combatWOD:execute(creature, var)
	end
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(59)
spell:name("Front Sweep")
spell:words("exori min")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FRONT_SWEEP)
spell:level(70)
spell:mana(200)
spell:basePower(80)
spell:isPremium(true)
spell:needDirection(true)
spell:needWeapon(true)
spell:cooldown(6 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("knight;true", "elite knight;true")
spell:register()
