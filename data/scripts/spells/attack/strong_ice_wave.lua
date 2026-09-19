local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)
-- Vocation Adjustment: size increased (AREA_SHORTWAVE3 -> AREA_SQUAREWAVE5)
combat:setArea(createCombatArea(AREA_SQUAREWAVE5, AREADIAGONAL_SQUAREWAVE5))

function onGetFormulaValues(player, level, maglevel, basePower)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 4.5) + 20
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 7.6) + 48
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

-- Vocation Adjustment: wheel Strong Ice Wave grade II augment enlarges the area.
local combatWOD = Combat()
combatWOD:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combatWOD:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)
combatWOD:setArea(createCombatArea(AREA_WAVE7, AREADIAGONAL_WAVE7))
function onGetFormulaValuesWOD(player, level, maglevel)
	return onGetFormulaValues(player, level, maglevel)
end
combatWOD:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValuesWOD")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player and player:getWheelSpellAdditionalArea("Strong Ice Wave") then
		return combatWOD:execute(creature, var)
	end
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(43)
spell:name("Strong Ice Wave")
spell:words("exevo gran frigo hur")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_STRONG_ICE_WAVE)
spell:level(40)
spell:mana(170)
spell:basePower(150)
spell:needDirection(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("druid;true", "elder druid;true")
spell:register()
