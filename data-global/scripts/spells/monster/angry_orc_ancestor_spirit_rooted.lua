local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_NONE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SOUND_RED)

local area = createCombatArea(AREA_CIRCLE2X2)
combat:setArea(area)

local condition = Condition(CONDITION_ROOTED)
condition:setParameter(CONDITION_PARAM_TICKS, 3000)
combat:addCondition(condition)

local spell = Spell("instant")

local function executeCombat(cid, var)
	local creature = Creature(cid)
	if not creature then
		return
	end
	return combat:execute(creature, var)
end

function spell.onCastSpell(creature, var)
	addEvent(executeCombat, 2000, creature:getId(), var)
	return true
end

spell:name("angry orc ancestor spirit root")
spell:words("###angry_orc_ancestor_spirit_root")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(false)
spell:register()
