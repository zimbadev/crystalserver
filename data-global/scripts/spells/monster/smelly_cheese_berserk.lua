local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYPOISON)
combat:setArea(createCombatArea({
	{ 1, 1, 1 },
	{ 1, 3, 1 },
	{ 1, 1, 1 },
}))

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POISONAREA)
combat2:setArea(createCombatArea({
	{ 1, 1, 1 },
	{ 1, 3, 1 },
	{ 1, 1, 1 },
}))

function spellCallbackCheeseBerserk(param)
	local tile = Tile(Position(param.pos))

	if tile then
		local creature = tile:getTopCreature()
		if creature then
			if creature:isPlayer() then
				local damage = math.random(400, 800)
				doTargetCombatHealth(param.cid, creature, COMBAT_EARTHDAMAGE, -damage, -damage, CONST_ME_HITBYPOISON)
			end
		end
	end
end

function onTargetTileSmellyCheeseBerserk(cid, pos)
	local param = {}
	param.cid = cid
	param.pos = pos
	param.count = 0
	param.removeCaster = false
	spellCallbackCheeseBerserk(param)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTileSmellyCheeseBerserk")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	addEvent(runSpell, 500, creature:getId(), combat, var)
	addEvent(runSpell, 700, creature:getId(), combat2, var)
	return true
end

function runSpell(cid, combat, var)
	local creature = Creature(cid)
	if creature then
		combat:execute(creature, var)
	end
end

spell:name("smelly cheese berserk")
spell:words("###6874")
spell:blockWalls(true)
spell:needDirection(false)
spell:needLearn(true)
spell:register()
