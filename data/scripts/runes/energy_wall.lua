local combatPvp = Combat()
combatPvp:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combatPvp:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
combatPvp:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGYBALL)
combatPvp:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_ENERGYFIELD_PVP)
combatPvp:setArea(createCombatArea(AREA_WALLFIELD_ENERGY, AREADIAGONAL_WALLFIELD_ENERGY))

local combatNoPvp = Combat()
combatNoPvp:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combatNoPvp:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
combatNoPvp:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGYBALL)
combatNoPvp:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_ENERGYFIELD_NOPVP)
combatNoPvp:setArea(createCombatArea(AREA_WALLFIELD_ENERGY, AREADIAGONAL_WALLFIELD_ENERGY))

local rune = Spell("rune")

function rune.onCastSpell(creature, var, isHotkey)
	if not creature:isPlayer() then
		return false
	end

	if creature:isPzLocked() then
		combatPvp:execute(creature, var)
		rune:setPzLocked(true)
		return true
	else
		combatNoPvp:execute(creature, var)
		return true
	end
end

rune:id(33)
rune:group("attack")
rune:name("energy wall rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_ENERGY_WALL_RUNE)
rune:runeId(3166)
rune:allowFarUse(true)
rune:charges(4)
rune:level(41)
rune:magicLevel(9)
rune:cooldown(2 * 1000)
rune:groupCooldown(2 * 1000)
rune:isBlocking(false)
rune:register()
