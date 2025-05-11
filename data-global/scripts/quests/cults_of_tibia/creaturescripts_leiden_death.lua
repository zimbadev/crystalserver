local event = CreatureEvent("LeidenDeath")

function event.onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
	local position = creature:getPosition()
	local spawnCount = 1

	for i = 1, spawnCount do
		local offsetX = math.random(-1, 1)
		local offsetY = math.random(-1, 1)
		local spawnPos = Position(position.x + offsetX, position.y + offsetY, position.z)
		Game.createMonster("Ravenous Hunger", spawnPos)
	end

	return true
end

event:register()
