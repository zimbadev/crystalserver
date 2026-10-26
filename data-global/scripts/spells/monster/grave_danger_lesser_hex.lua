-- Sir Baeloc / Sir Nictros: Lesser Hex on the target (TibiaWiki: ability "Hex"; Spoiler: "Lesser Hex effect, which will
-- greatly reduce the healing received"). 10 s duration NOT CONFIRMED; the healing reduction is the engine's.
local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)

local hex = Condition(CONDITION_LESSERHEX)
hex:setParameter(CONDITION_PARAM_TICKS, 10000)
combat:addCondition(hex)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("grave danger lesser hex")
spell:words("###99604")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(true)
spell:needLearn(true)
spell:range(7)
spell:register()
