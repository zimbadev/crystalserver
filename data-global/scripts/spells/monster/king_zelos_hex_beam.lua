-- King Zelos: beam that applies Greater Hex (TibiaWiki: "Great Hex beam"; Spoiler: "reduces the target's total
-- health to 40% of its maximum"). No damage of its own. Length 7 and 10 s duration NOT CONFIRMED.
local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
combat:setArea(createCombatArea(AREA_BEAM7))

local hex = Condition(CONDITION_GREATERHEX)
hex:setParameter(CONDITION_PARAM_TICKS, 10000)
hex:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, 40)
combat:addCondition(hex)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("king zelos hex beam")
spell:words("###99603")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()
