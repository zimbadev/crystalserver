local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PURPLESMOKE)

combat:setArea(createCombatArea({
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 3, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
}))

function onTargetTile(creature, pos)
	local tile = Tile(pos)
	if tile then
		local topCreature = tile:getTopCreature()
		if topCreature and topCreature:isMonster() then
			if topCreature:getName():lower() == "leiden" then
				topCreature:registerEvent("SpawnBoss")
				local damage = -math.random(3000, 6000)
				local newHealth = topCreature:getHealth() + damage
				if newHealth <= 0 then
					topCreature:unregisterEvent("LeidenDeath")
				end
				topCreature:addHealth(damage)
			elseif topCreature:getName():lower() == "ravenous hunger" then
				topCreature:addHealth(math.random(3000, 6000))
			end
			return
		end
	end
end

combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local evaporate = CreatureEvent("Evaporate")
function evaporate.onThink(creature)
	local hp = (creature:getHealth() / creature:getMaxHealth()) * 100
	if hp < 60.0 then
		addEvent(function(cid)
			local creature = Creature(cid)
			if not creature then
				return
			end
			creature:say("The liquor spirit evaporates!", TALKTYPE_MONSTER_YELL)
			local var = { type = 1, number = creature:getId() }
			combat:execute(creature, var)
			creature:remove(1)
			return true
		end, 100, creature:getId())
	end
end

evaporate:register()
