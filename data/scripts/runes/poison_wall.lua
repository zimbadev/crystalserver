local combatPvp = Combat()
combatPvp:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combatPvp:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
combatPvp:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)
combatPvp:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_POISONFIELD_PVP)
combatPvp:setArea(createCombatArea(AREA_WALLFIELD, AREADIAGONAL_WALLFIELD))

local combatNoPvp = Combat()
combatNoPvp:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combatNoPvp:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
combatNoPvp:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)
combatNoPvp:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_POISONFIELD_NOPVP)
combatNoPvp:setArea(createCombatArea(AREA_WALLFIELD, AREADIAGONAL_WALLFIELD))

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

rune:id(32)
rune:group("attack")
rune:name("poison wall rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_POISON_WALL_RUNE)
rune:runeId(3176)
rune:allowFarUse(true)
rune:charges(4)
rune:level(29)
rune:magicLevel(5)
rune:cooldown(2 * 1000)
rune:groupCooldown(2 * 1000)
rune:isBlocking(false)
rune:register()
