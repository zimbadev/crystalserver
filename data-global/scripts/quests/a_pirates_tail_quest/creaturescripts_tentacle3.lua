local tentacle3_death = CreatureEvent("tentacle3_death")

local config = {
	line = {
		from = Position(33727, 31184, 7),
		to = Position(33727, 31185, 7),
		itemId = 35112,
	},
	monsterName = "Tentacle3",

	finalTile = {
		position = Position(33727, 31186, 7),
		fromId = 35109,
		toId = 35110,
	},
}

local function getLinePositions()
	local positions = {}

	for x = config.line.from.x, config.line.to.x do
		for y = config.line.from.y, config.line.to.y do
			table.insert(positions, Position(x, y, config.line.from.z))
		end
	end

	return positions
end

function tentacle3_death.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	local deathPos = creature:getPosition()
	local positions = getLinePositions()

	local currentIndex = nil
	for i, pos in ipairs(positions) do
		if pos.x == deathPos.x and pos.y == deathPos.y and pos.z == deathPos.z then
			currentIndex = i
			break
		end
	end

	if not currentIndex then
		currentIndex = 0
	end

	local nextIndex = currentIndex + 1
	local nextPos = positions[nextIndex]

	if nextPos then
		local tile = Tile(nextPos)
		if tile then
			local item = tile:getItemById(config.line.itemId)
			if item then
				item:remove()
			end
		end

		local monster = Game.createMonster(config.monsterName, nextPos, true, true)
		if monster then
			nextPos:sendMagicEffect(CONST_ME_ENERGYHIT)
		end
	else
		local tile = Tile(config.finalTile.position)
		if tile then
			local item = tile:getItemById(config.finalTile.fromId)
			if item then
				item:transform(config.finalTile.toId)
			end
		end
	end

	return true
end

tentacle3_death:register()
