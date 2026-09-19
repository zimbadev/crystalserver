local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)

combat:setArea(createCombatArea({
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 3, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
}))

function spellCallbackRatmiralBall(param)
	local tile = Tile(Position(param.pos))

	if tile then
		local creature = tile:getTopCreature()
		if creature then
			if creature:isMonster() and creature:getName():lower() == "elite pirat" then
				creature:addHealth(math.random(0, 1000))
				param.removeCaster = true -- Marca para eliminar al caster
			elseif creature:isMonster() and creature:getName():lower() == "1st mate ratticus" then
				creature:addHealth(math.random(0, 1000))
			elseif creature:isMonster() and creature:getName():lower() == "mister catkiller" then
				creature:addHealth(math.random(0, 1000))
			end
		end
	end
end

function onTargetTileRatmiralBall(cid, pos)
	local param = {}

	param.cid = cid
	param.pos = pos
	param.count = 0
	param.removeCaster = false
	spellCallbackRatmiralBall(param)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTileRatmiralBall")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("ratmiral ball")
spell:words("###9459")
spell:isAggressive(false)
spell:blockWalls(true)
spell:isSelfTarget(true)
spell:needLearn(true)
spell:register()
