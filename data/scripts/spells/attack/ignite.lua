-- Vocation Adjustment: a Master Sorcerer's elemental stance reshapes Ignite (element + impact effect(s)
-- + missile). With no stance (or a stance that doesn't override this spell) it keeps the BASE fire form.
--   Master of Thunder -> energy, effects [331, 333], missile 5
--   Master of Decay   -> death,  effects [332, 336], missile 11

-- Base fire combat (unchanged mechanic: delayed fire damage-over-time condition + fire missile).
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)

local condition = Condition(CONDITION_FIRE)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(25, 3000, -45)
combat:addCondition(condition)

-- Variant: Master of Thunder (energy).
local combatThunder = Combat()
combatThunder:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combatThunder:setParameter(COMBAT_PARAM_EFFECT, 331)
combatThunder:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 5)

local conditionThunder = Condition(CONDITION_ENERGY)
conditionThunder:setParameter(CONDITION_PARAM_DELAYED, 1)
conditionThunder:addDamage(25, 3000, -45)
combatThunder:addCondition(conditionThunder)

-- Variant: Master of Decay (death).
local combatDecay = Combat()
combatDecay:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatDecay:setParameter(COMBAT_PARAM_EFFECT, 332)
combatDecay:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 11)

local conditionDecay = Condition(CONDITION_CURSED)
conditionDecay:setParameter(CONDITION_PARAM_DELAYED, 1)
conditionDecay:addDamage(25, 3000, -45)
combatDecay:addCondition(conditionDecay)

-- Second impact effect per variant (each combat needs a uniquely-named global callback).
function onTargetSecondEffectThunder(creature, target)
	target:getPosition():sendMagicEffect(333)
	return true
end
function onTargetSecondEffectDecay(creature, target)
	target:getPosition():sendMagicEffect(336)
	return true
end
combatThunder:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetSecondEffectThunder")
combatDecay:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetSecondEffectDecay")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player then
		local stance = player:getElementalStance()
		if stance == STANCE_MASTER_OF_THUNDER then
			return combatThunder:execute(creature, var)
		elseif stance == STANCE_MASTER_OF_DECAY then
			return combatDecay:execute(creature, var)
		end
	end
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(138)
spell:name("Ignite")
spell:words("utori flam")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_IGNITE)
spell:level(26)
spell:mana(30)
spell:basePower(120)
spell:isAggressive(true)
spell:range(3)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(30 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
