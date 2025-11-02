local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)

local arr = {
	{ 1, 1, 1, 1, 1 },
	{ 1, 0, 0, 0, 1 },
	{ 1, 0, 3, 0, 1 },
	{ 1, 0, 0, 0, 1 },
	{ 1, 1, 1, 1, 1 },
}

local area = createCombatArea(arr)
combat:setArea(area)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("blood ring")
spell:words("###blood_ring")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(false)
spell:register()
