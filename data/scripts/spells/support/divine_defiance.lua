local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_SUBID, AttrSubId_DivineDefiance)
condition:setParameter(CONDITION_PARAM_TICKS, -1)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 299)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	local player = creature:getPlayer()
	if player and player:getStance() == STANCE_DIVINE_DEFIANCE then
		player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, AttrSubId_DivineDefiance)
		player:setStance(STANCE_NONE)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end
	if player then
		player:setStance(STANCE_DIVINE_DEFIANCE)
	end
	return combat:execute(creature, variant)
end

spell:name("Divine Defiance")
spell:words("utori hur")
spell:group("support", "stance")
spell:vocation("paladin;true", "royal paladin;true")
spell:id(314)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000, 2 * 1000)
spell:level(100)
spell:mana(200)
spell:needLearn(false)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)

spell:register()
