local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
combat:setArea(createCombatArea({
	{ 0, 0, 1, 0, 0 },
	{ 0, 1, 3, 1, 0 },
	{ 0, 1, 0, 1, 0 },
	{ 0, 0, 1, 0, 0 },
}))

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
combat2:setArea(createCombatArea({
	{ 1, 1, 1, 1, 1 },
	{ 0, 1, 0, 1, 0 },
	{ 0, 0, 2, 0, 0 },
}))

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	addEvent(runSpell, 1, creature:getId(), combat, var)
	addEvent(runSpell, 1, creature:getId(), combat2, var)
	return true
end

function runSpell(cid, combat, var)
	local creature = Creature(cid)
	if creature then
		combat:execute(creature, var)
	end
end

spell:name("candy horror wave")
spell:words("###9700")
spell:blockWalls(true)
spell:needDirection(true)
spell:needLearn(false)
spell:register()
