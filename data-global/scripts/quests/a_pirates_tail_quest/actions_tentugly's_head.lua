local config = {
	boss = {
		name = "Tentugly's Head",
		position = Position(33722, 31182, 7),
	},
	requiredLevel = 150,
	playerPositions = {
		{ pos = Position(33792, 31391, 6), teleport = Position(33722, 31186, 7), effect = CONST_ME_TELEPORT },
		{ pos = Position(33793, 31391, 6), teleport = Position(33722, 31186, 7), effect = CONST_ME_TELEPORT },
		{ pos = Position(33794, 31391, 6), teleport = Position(33722, 31186, 7), effect = CONST_ME_TELEPORT },
		{ pos = Position(33795, 31391, 6), teleport = Position(33722, 31186, 7), effect = CONST_ME_TELEPORT },
		{ pos = Position(33796, 31391, 6), teleport = Position(33722, 31186, 7), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(33705, 31176, 6),
		to = Position(33736, 31190, 7),
	},
	exit = Position(33799, 31356, 7),
}

local function hasTentacles()
	local spectators = Game.getSpectators(config.boss.position, false, false, 30, 30, 30, 30)

	for _, spec in ipairs(spectators) do
		if spec:isMonster() then
			local name = spec:getName():lower()
			if name:find("tentacle") then
				return true
			end
		end
	end

	return false
end

local function returnBoss()
	local spectators = Game.getSpectators(config.boss.position, false, false, 30, 30, 30, 30)

	for _, spec in ipairs(spectators) do
		if spec:isMonster() and spec:getName():lower():find("tentugly") then
			spec:teleportTo(config.boss.position)
			config.boss.position:sendMagicEffect(CONST_ME_TELEPORT)

			return
		end
	end
end

function checkTentaclesLoop()
	if hasTentacles() then
		addEvent(checkTentaclesLoop, 1000)
	else
		returnBoss()
	end
end

local function cleanRoom()
	for _, line in ipairs({
		{ from = Position(33723, 31180, 7), to = Position(33725, 31180, 7), itemId = 35126 },
		{ from = Position(33723, 31186, 7), to = Position(33723, 31190, 7), itemId = 35112 },
		{ from = Position(33727, 31184, 7), to = Position(33727, 31185, 7), itemId = 35112 },
		{ from = Position(33731, 31180, 7), to = Position(33735, 31180, 7), itemId = 35126 },
		{ from = Position(33718, 31180, 7), to = Position(33718, 31178, 7), itemId = 35112 },
		{ from = Position(33714, 31180, 6), to = Position(33714, 31178, 6), itemId = 35112 },
		{ from = Position(33726, 31182, 6), to = Position(33726, 31178, 6), itemId = 35112 },
		{ from = Position(33718, 31187, 6), to = Position(33718, 31190, 6), itemId = 35112 },
		{ from = Position(33716, 31181, 6), to = Position(33716, 31182, 6), itemId = 35112 },
		{ from = Position(33714, 31185, 6), to = Position(33712, 31185, 6), itemId = 35126 },
	}) do
		if line.from.y == line.to.y then
			local step = line.from.x <= line.to.x and 1 or -1
			for x = line.from.x, line.to.x, step do
				local tile = Tile(Position(x, line.from.y, line.from.z))
				if tile then
					local item = tile:getItemById(line.itemId)
					if item then
						item:remove()
					end
				end
			end
		elseif line.from.x == line.to.x then
			local step = line.from.y <= line.to.y and 1 or -1
			for y = line.from.y, line.to.y, step do
				local tile = Tile(Position(line.from.x, y, line.from.z))
				if tile then
					local item = tile:getItemById(line.itemId)
					if item then
						item:remove()
					end
				end
			end
		end
	end

	for _, t in ipairs({
		{ pos = Position(33726, 31180, 7), from = 35120, to = 35119 },
		{ pos = Position(33723, 31191, 7), from = 35110, to = 35109 },
		{ pos = Position(33727, 31186, 7), from = 35110, to = 35109 },
		{ pos = Position(33736, 31180, 7), from = 35120, to = 35119 },
		{ pos = Position(33718, 31191, 6), from = 35110, to = 35109 },
		{ pos = Position(33716, 31183, 6), from = 35110, to = 35109 },
	}) do
		local tile = Tile(t.pos)
		if tile then
			local item = tile:getItemById(t.to)
			if item then
				item:transform(t.from)
			end
		end
	end

	for _, s in ipairs({
		{ base = Position(33718, 31176, 7), visual = Position(33718, 31177, 7), from = 35107, to = 35510 },
		{ base = Position(33714, 31176, 6), visual = Position(33714, 31177, 6), from = 35107, to = 35510 },
		{ base = Position(33726, 31176, 6), visual = Position(33726, 31177, 6), from = 35107, to = 35510 },
		{ base = Position(33710, 31185, 6), visual = Position(33711, 31185, 6), from = 35122, to = 35511 },
	}) do
		local visualTile = Tile(s.visual)
		if visualTile then
			local item = visualTile:getItemById(s.to)
			if item then
				item:remove()
			end
		end

		Game.createItem(s.from, 1, s.base)
	end

	for x = config.specPos.from.x, config.specPos.to.x do
		for y = config.specPos.from.y, config.specPos.to.y do
			for z = config.specPos.from.z, config.specPos.to.z do
				local tile = Tile(Position(x, y, z))
				if tile then
					local item = tile:getItemById(35136)
					if item then
						item:remove()
					end
					local item = tile:getItemById(6065)
					if item then
						item:remove()
					end
					local item = tile:getItemById(5523)
					if item then
						item:remove()
					end
					local item = tile:getItemById(5530)
					if item then
						item:remove()
					end
					local item = tile:getItemById(5531)
					if item then
						item:remove()
					end
					local item = tile:getItemById(5762)
					if item then
						item:remove()
					end
				end
			end
		end
	end

	local spectators = Game.getSpectators(config.boss.position, false, false, 20, 20, 20, 20)
	for _, spec in ipairs(spectators) do
		if spec:isMonster() and spec:getName():lower():find("tentacle") then
			spec:remove()
		end
	end
end

local lever = BossLever(config)
local originalOnUse = lever.onUse

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	cleanRoom()
	return originalOnUse(player, item, fromPosition, target, toPosition, isHotkey)
end

lever:position(Position(33791, 31391, 6))
lever:register()
