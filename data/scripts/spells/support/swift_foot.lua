local spellDuration = 10000

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

local condition = Condition(CONDITION_HASTE)
condition:setParameter(CONDITION_PARAM_TICKS, spellDuration)
condition:setFormula(1.8, 72, 1.8, 72)
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local summons = creature:getSummons()
	if summons and type(summons) == "table" and #summons > 0 then
		for i = 1, #summons do
			local summon = summons[i]
			local summon_t = summon:getType()
			if summon_t and summon_t:familiar() then
				local deltaSpeed = math.max(creature:getBaseSpeed() - summon:getBaseSpeed(), 0)
				local FamiliarSpeed = ((summon:getBaseSpeed() + deltaSpeed) * 0.8) - 72
				local FamiliarHaste = Condition(CONDITION_HASTE)
				FamiliarHaste:setParameter(CONDITION_PARAM_TICKS, spellDuration)
				FamiliarHaste:setParameter(CONDITION_PARAM_SPEED, FamiliarSpeed)
				summon:addCondition(FamiliarHaste)
			end
		end
	end

	if combat:execute(creature, var) then
		local grade = creature:upgradeSpellsWOD("Swift Foot")
		if grade == WHEEL_GRADE_NONE then
			-- Vocation Adjustment: attacking/casting is now ALLOWED while active; -30% damage instead.
			local damageDebuff = Condition(CONDITION_ATTRIBUTES)
			damageDebuff:setParameter(CONDITION_PARAM_TICKS, spellDuration)
			damageDebuff:setParameter(CONDITION_PARAM_BUFF_DAMAGEDEALT, 70) -- 70% of damage dealt = -30%
			creature:addCondition(damageDebuff)
		elseif grade == WHEEL_GRADE_REGULAR then
			local damageDebuff = Condition(CONDITION_ATTRIBUTES)
			damageDebuff:setParameter(CONDITION_PARAM_TICKS, spellDuration)
			damageDebuff:setParameter(CONDITION_PARAM_BUFF_DAMAGEDEALT, 50)
			creature:addCondition(damageDebuff)
		end
		return true
	end

	return false
end

spell:name("Swift Foot")
spell:words("utamo tempo san")
spell:group("support", "focus")
spell:vocation("paladin;true", "royal paladin;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_SWIFT_FOOT)
spell:id(134)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000, 2 * 1000)
spell:level(55)
spell:mana(400)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)
spell:needLearn(false)

spell:register()
