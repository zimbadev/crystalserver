-- Vocation Adjustment: a Master Sorcerer's elemental stance reshapes Curse (element + impact EFFECT +
-- missile). With no stance (or a non-matching stance) the BASE death version is kept unchanged:
--   Master of Flames  -> fire,   effect 334, missile 4
--   Master of Thunder -> energy, effect 335, missile 5
--   no stance / other -> base death (CONST_ME_SMALLCLOUDS, CONST_ANI_DEATH)

-- Curse has no damage formula (damage comes from the cursed condition), so no formula callbacks are
-- needed. Each variant builds its own combat with its own cursed condition.
local function buildCursedCondition()
	local condition = Condition(CONDITION_CURSED)
	condition:setParameter(CONDITION_PARAM_DELAYED, 1)

	condition:addDamage(1, 3000, -45)
	condition:addDamage(1, 3000, -40)
	condition:addDamage(1, 3000, -35)
	condition:addDamage(1, 3000, -34)
	condition:addDamage(2, 3000, -33)
	condition:addDamage(2, 3000, -32)
	condition:addDamage(2, 3000, -31)
	condition:addDamage(2, 3000, -30)
	condition:addDamage(3, 3000, -29)
	condition:addDamage(3, 3000, -25)
	condition:addDamage(3, 3000, -24)
	condition:addDamage(4, 3000, -23)
	condition:addDamage(4, 3000, -20)
	condition:addDamage(5, 3000, -19)
	condition:addDamage(5, 3000, -15)
	condition:addDamage(6, 3000, -10)
	condition:addDamage(10, 3000, -5)
	return condition
end

local function createCurseCombat(combatType, effect, missile)
	local c = Combat()
	c:setParameter(COMBAT_PARAM_TYPE, combatType)
	c:setParameter(COMBAT_PARAM_EFFECT, effect)
	c:setParameter(COMBAT_PARAM_DISTANCEEFFECT, missile)
	c:addCondition(buildCursedCondition())
	return c
end

local combat = createCurseCombat(COMBAT_DEATHDAMAGE, CONST_ME_SMALLCLOUDS, CONST_ANI_DEATH)
local combatFlames = createCurseCombat(COMBAT_FIREDAMAGE, 334, 4)
local combatThunder = createCurseCombat(COMBAT_ENERGYDAMAGE, 335, 5)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player then
		local stance = player:getElementalStance()
		if stance == STANCE_MASTER_OF_FLAMES then
			return combatFlames:execute(creature, var)
		elseif stance == STANCE_MASTER_OF_THUNDER then
			return combatThunder:execute(creature, var)
		end
	end
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(139)
spell:name("Curse")
spell:words("utori mort")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_CURSE)
spell:level(75)
spell:mana(30)
spell:basePower(120)
spell:isAggressive(true)
spell:range(3)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(40 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
