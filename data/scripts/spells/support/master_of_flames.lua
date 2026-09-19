local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_SUBID, AttrSubId_SorcererMasterOfFlames)
condition:setParameter(CONDITION_PARAM_TICKS, -1)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 5)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	local player = creature:getPlayer()
	if player and player:getElementalStance() == STANCE_MASTER_OF_FLAMES then
		player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, AttrSubId_SorcererMasterOfFlames)
		player:setElementalStance(STANCE_NONE)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end
	if player then
		player:setElementalStance(STANCE_MASTER_OF_FLAMES)
	end
	return combat:execute(creature, variant)
end

spell:name("Master of Flames")
spell:words("uteta flam")
spell:group("support", "stance")
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:id(304)
spell:cooldown(30 * 1000)
spell:groupCooldown(2 * 1000, 30 * 1000)
spell:level(20)
spell:mana(400)
spell:needLearn(false)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)

spell:register()
