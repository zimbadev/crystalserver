local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_LIFEDRAIN)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onTargetTileArtillerist(cid, pos)
	local tile = Tile(pos)
	if tile and tile:getTopCreature() then
		local creature = tile:getTopCreature()
		if creature then
			if creature:isMonster() and creature:getName():lower() == "rum barrel" then
				local damage = math.random(66666, 99999)
				creature:addHealth(-damage)
			elseif creature:isPlayer() then
				local lifeDrainDamage = math.random(500, 1000)
				doTargetCombatHealth(cid, creature, COMBAT_LIFEDRAIN, -lifeDrainDamage, -lifeDrainDamage, CONST_ME_MAGIC_RED)
			end
		end
	end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTileArtillerist")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if not creature or not var then
		return false
	end
	return combat:execute(creature, var)
end

spell:name("pirat artillerist ball")
spell:words("###6877")
spell:blockWalls(true)
spell:needTarget(true)
spell:range(5)
spell:needLearn(true)
spell:register()
