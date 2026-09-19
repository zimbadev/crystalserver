local combatGrenade = Combat()
combatGrenade:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combatGrenade:setArea(createCombatArea(AREA_CIRCLE2X2))
combatGrenade:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)

function onGetFormulaValues(player, level, maglevel, basePower)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 4)
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 6)

	local grade = player:upgradeSpellsWOD("Divine Grenade")

	local multiplier = 1.0
	if grade ~= WHEEL_GRADE_NONE then
		local multiplierByGrade = { 1.3, 1.6, 2.0 }
		multiplier = multiplierByGrade[grade]
	end

	min = min * multiplier
	max = max * multiplier

	return -min, -max
end

combatGrenade:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local explodeGrenade = function(position, playerId)
	local tile = Tile(position)
	if not tile then
		return
	end

	local player = Player(playerId)
	if not player then
		return
	end

	local var = {}
	var.instantName = "Divine Grenade"
	var.runeName = ""
	var.type = 2 -- VARIANT_POSITION
	var.pos = position
	combatGrenade:execute(player, var)
end

local function removeGrenadeEffect(position)
	position:removeMagicEffect(CONST_ME_DIVINE_GRENADE)
end

-- A grenade may only land on a walkable, non-PZ tile (Tile:isWalkable(true) = has ground,
-- no wall/blocksolid/blockprojectile, and not a protection zone / house).
local function grenadeTileValid(position)
	local tile = Tile(position)
	if not tile then
		return false
	end
	return tile:isWalkable(true)
end

function onTargetCreature(creature, target)
	if not (creature and target and creature:isPlayer()) then
		return false
	end

	local position = creature:getPosition():getWithinRange(target:getPosition(), 4)
	if not grenadeTileValid(position) then
		creature:sendCancelMessage("You cannot throw the grenade there.")
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	addEvent(explodeGrenade, 3000, position, creature:getId())
	addEvent(removeGrenadeEffect, 3000, position)
	return true
end

local combatCast = Combat()
combatCast:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if not creature or not creature:isPlayer() then
		return false
	end

	-- needPosition: var is the clicked tile (cursor/crosshair). Only allow walkable, non-PZ tiles.
	local position = var:getPosition()
	if not grenadeTileValid(position) then
		creature:sendCancelMessage("You cannot throw the grenade there.")
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	position:sendMagicEffect(CONST_ME_DIVINE_GRENADE)
	addEvent(explodeGrenade, 3000, position, creature:getId())
	addEvent(removeGrenadeEffect, 3000, position)
	return true
end

spell:group("attack")
spell:id(258)
spell:name("Divine Grenade")
spell:words("exevo tempo mas san")
spell:level(300)
spell:mana(160)
spell:basePower(190)
spell:isPremium(true)
spell:range(7)
spell:needPosition(true) -- cast at the clicked tile (cursor/crosshair); var is VARIANT_POSITION
spell:blockWalls(true)
spell:isAggressive(true) -- attack grenade: applies in-fight and is blocked in protection zones
spell:cooldown(26 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()
