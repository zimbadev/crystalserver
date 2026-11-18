local combatPvp = Combat()
combatPvp:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combatPvp:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
combatPvp:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)
combatPvp:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_POISONFIELD_PVP)

local combatNoPvp = Combat()
combatNoPvp:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combatNoPvp:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
combatNoPvp:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)
combatNoPvp:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_POISONFIELD_NOPVP)

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

rune:id(26)
rune:group("attack")
rune:name("poison field rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_POISON_FIELD_RUNE)
rune:runeId(3172)
rune:allowFarUse(true)
rune:charges(3)
rune:level(14)
rune:magicLevel(0)
rune:cooldown(2 * 1000)
rune:groupCooldown(2 * 1000)
rune:isBlocking(true)
rune:register()
