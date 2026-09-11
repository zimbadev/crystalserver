-- Death Echo (exevo mort ora) - Sorcerer attack spell, Vocation Adjustment
-- Hits a 5x5 area at the target position for DEATH damage, then after a 1s
-- delay the SAME area is struck again for 50% of the initial damage.
-- Crosshair / target mode: needPosition(true) + setArea, the server resolves the
-- target position (modeled on divine_grenade.lua's position-variant recast).
-- A Master Sorcerer's elemental stance reshapes it: Master of Flames -> fire (eff 323),
-- Master of Thunder -> energy (eff 322), Decay/none -> base death (eff 321). The echo
-- keeps the element chosen at cast time (passed through addEvent).

-- 5x5 square area centered on the target tile (3 = center reference)
local DEATH_ECHO_AREA = {
	{ 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1 },
	{ 1, 1, 3, 1, 1 },
	{ 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1 },
}

-- Base power 85. Formula mirrors the project's death-AoE idioms (great_death_beam
-- / death_strike) scaled to an 85 base spell.
function onGetDeathEchoValues(player, level, maglevel)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 2.4)
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 3.6)
	return -min, -max
end

-- Echo hit deals 50% of the initial damage (halved formula).
function onGetDeathEchoEchoValues(player, level, maglevel)
	local min = ((calculateBaseDamageHealing(level)) + (maglevel * 2.4)) * 0.5
	local max = ((calculateBaseDamageHealing(level)) + (maglevel * 3.6)) * 0.5
	return -min, -max
end

-- First (immediate) hit - 5x5 area, full damage. One Combat, retuned to the cast-time element.
local combatMain = Combat()
combatMain:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatMain:setParameter(COMBAT_PARAM_EFFECT, 321)
combatMain:setArea(createCombatArea(DEATH_ECHO_AREA))
combatMain:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetDeathEchoValues")

-- Second (echo) hit - same 5x5 area, 50% damage.
local combatEcho = Combat()
combatEcho:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatEcho:setParameter(COMBAT_PARAM_EFFECT, 321)
combatEcho:setArea(createCombatArea(DEATH_ECHO_AREA))
combatEcho:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetDeathEchoEchoValues")

-- Vocation Adjustment: pick element (type + impact effect) from the caster's active elemental stance.
local function elementForStance(player)
	local stance = player:getElementalStance()
	if stance == STANCE_MASTER_OF_FLAMES then
		return COMBAT_FIREDAMAGE, 323
	elseif stance == STANCE_MASTER_OF_THUNDER then
		return COMBAT_ENERGYDAMAGE, 322
	end
	return COMBAT_DEATHDAMAGE, 321
end

-- Re-hit the SAME area at the stored position after the delay (position variant,
-- modeled on divine_grenade.lua's explodeGrenade). combatType/effect = the element chosen at cast time
-- (echoStrike runs to completion before any other Lua event, so retuning the shared Combat here is safe).
local function echoStrike(position, playerId, combatType, effect)
	local tile = Tile(position)
	if not tile then
		return
	end

	local player = Player(playerId)
	if not player then
		return
	end

	combatEcho:setParameter(COMBAT_PARAM_TYPE, combatType)
	combatEcho:setParameter(COMBAT_PARAM_EFFECT, effect)

	local var = {}
	var.instantName = "Death Echo"
	var.runeName = ""
	var.type = 2 -- VARIANT_POSITION
	var.pos = position
	combatEcho:execute(player, var)
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	-- needPosition: the engine set var to the clicked tile (cursor/crosshair). Cast the 5x5
	-- area there, then re-strike the same tile after 1s for the echo.
	local center = var:getPosition()
	local player = creature:getPlayer()
	local combatType, effect = COMBAT_DEATHDAMAGE, 321
	if player then
		combatType, effect = elementForStance(player)
	end
	combatMain:setParameter(COMBAT_PARAM_TYPE, combatType)
	combatMain:setParameter(COMBAT_PARAM_EFFECT, effect)
	combatMain:execute(creature, var)
	addEvent(echoStrike, 1000, center, creature:getId(), combatType, effect)
	return true
end

spell:group("attack")
spell:id(310)
spell:name("Death Echo")
spell:words("exevo mort ora")
spell:level(120)
spell:mana(155)
spell:basePower(85)
spell:isPremium(true)
spell:range(7)
spell:needPosition(true) -- cast at the clicked tile (cursor/crosshair); var is VARIANT_POSITION
spell:blockWalls(true)
spell:cooldown(6 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)

spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
