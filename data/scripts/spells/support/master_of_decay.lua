local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_SUBID, AttrSubId_SorcererMasterOfDecay)
condition:setParameter(CONDITION_PARAM_TICKS, -1)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 285)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	local player = creature:getPlayer()
	if player and player:getElementalStance() == STANCE_MASTER_OF_DECAY then
		player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, AttrSubId_SorcererMasterOfDecay)
		player:setElementalStance(STANCE_NONE)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end
	if player then
		player:setElementalStance(STANCE_MASTER_OF_DECAY)
	end
	return combat:execute(creature, variant)
end

spell:name("Master of Decay")
spell:words("uteta mort")
spell:group("support", "stance")
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:id(306)
spell:cooldown(30 * 1000)
spell:groupCooldown(2 * 1000, 30 * 1000)
spell:level(20)
spell:mana(400)
spell:needLearn(false)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)

spell:register()
