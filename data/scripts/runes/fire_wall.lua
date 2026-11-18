local combatPvp = Combat()
combatPvp:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combatPvp:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
combatPvp:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combatPvp:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_FIREFIELD_PVP_FULL)
combatPvp:setArea(createCombatArea(AREA_WALLFIELD, AREADIAGONAL_WALLFIELD))

local combatNoPvp = Combat()
combatNoPvp:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combatNoPvp:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
combatNoPvp:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combatNoPvp:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_FIREFIELD_NOPVP)
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

rune:id(28)
rune:group("attack")
rune:name("fire wall rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_FIRE_WALL_RUNE)
rune:runeId(3190)
rune:allowFarUse(true)
rune:charges(4)
rune:level(33)
rune:magicLevel(6)
rune:cooldown(2 * 1000)
rune:groupCooldown(2 * 1000)
rune:isBlocking(false)
rune:register()
