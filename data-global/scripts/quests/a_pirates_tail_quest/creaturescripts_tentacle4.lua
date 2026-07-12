local tentacle4_death = CreatureEvent("tentacle4_death")

local config = {
	line = {
		from = Position(33731, 31180, 7),
		to = Position(33735, 31180, 7),
		itemId = 35126,
	},
	monsterName = "Tentacle4",

	finalTile = {
		position = Position(33736, 31180, 7),
		fromId = 35119,
		toId = 35120,
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

function tentacle4_death.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
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

tentacle4_death:register()
