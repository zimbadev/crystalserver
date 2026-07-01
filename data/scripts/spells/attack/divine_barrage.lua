-- Divine Barrage (Paladin) - Vocation Adjustment
-- Crosshair/target spell: needTarget + setArea so the engine resolves the
-- target creature and applies a diamond burst (AREA_CIRCLE2X2, 13-square
-- diamond-arrow-size) centered on the target's tile.
-- Holy damage, scales with MAGIC LEVEL like Divine Caldera (LEVELMAGICVALUE).

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 319)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)
combat:setArea(createCombatArea(AREA_CIRCLE2X2))

-- Base 140. Scales with magic level (and a little with level) like Divine Caldera.
local BASE = 140
local DAMAGE_SCALE = BASE / 140

function onGetFormulaValues(player, level, maglevel, basePower)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 4)
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 6)
	return -math.floor(min * DAMAGE_SCALE), -math.floor(max * DAMAGE_SCALE)
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	-- needPosition: var is the clicked tile (cursor/crosshair); the area is cast there.
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(302)
spell:name("Divine Barrage")
spell:words("exori dir san")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_CALDERA)
spell:level(70)
spell:mana(175)
spell:basePower(140)
spell:isPremium(true)
spell:isAggressive(true)
spell:range(7)
spell:needPosition(true) -- cast at the clicked tile (cursor/crosshair); var is VARIANT_POSITION
spell:blockWalls(true)
spell:needLearn(false)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()
