local tentacle5_death = CreatureEvent("tentacle5_death")

local config = {
	line = {
		from = Position(33718, 31180, 7),
		to = Position(33718, 31178, 7),
		itemId = 35112,
	},
	monsterName = "Tentacle5",

	finalTile = {
		triggerPos = Position(33718, 31177, 7),
		itemPos = Position(33718, 31176, 7),
		fromId = 35510,
		toId = 35107,
	},
}

local function getLinePositions()
	local positions = {}

	if config.line.from.x == config.line.to.x then
		local step = config.line.from.y <= config.line.to.y and 1 or -1
		for y = config.line.from.y, config.line.to.y, step do
			table.insert(positions, Position(config.line.from.x, y, config.line.from.z))
		end
	elseif config.line.from.y == config.line.to.y then
		local step = config.line.from.x <= config.line.to.x and 1 or -1
		for x = config.line.from.x, config.line.to.x, step do
			table.insert(positions, Position(x, config.line.from.y, config.line.from.z))
		end
	end

	return positions
end

function tentacle5_death.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
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
		local visualTile = Tile(config.finalTile.triggerPos)
		if visualTile then
			local item = visualTile:getItemById(config.finalTile.fromId)
			if item then
				item:remove()
			end
		end

		Game.createItem(config.finalTile.toId, 1, config.finalTile.itemPos)
	end

	return true
end

tentacle5_death:register()
