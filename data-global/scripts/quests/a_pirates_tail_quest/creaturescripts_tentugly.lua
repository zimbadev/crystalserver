local tentuglysHeadPhase = CreatureEvent("tentuglysHeadPhase")

local config = {
	threshold = 0.80,

	teleport = {
		position = Position(33723, 31166, 7),
	},

	tentacleLines = {
		{
			from = Position(33723, 31180, 7),
			to = Position(33725, 31180, 7),
			itemId = 35126,
		},
		{
			from = Position(33723, 31186, 7),
			to = Position(33723, 31190, 7),
			itemId = 35112,
		},
		{
			from = Position(33727, 31184, 7),
			to = Position(33727, 31185, 7),
			itemId = 35112,
		},
		{
			from = Position(33731, 31180, 7),
			to = Position(33735, 31180, 7),
			itemId = 35126,
		},
		{
			from = Position(33736, 31180, 7),
			to = Position(33736, 31180, 7),
			itemId = 35119,
		},
		{
			from = Position(33718, 31180, 7),
			to = Position(33718, 31178, 7),
			itemId = 35112,
		},
		{
			from = Position(33714, 31180, 6),
			to = Position(33714, 31178, 6),
			itemId = 35112,
		},
		{
			from = Position(33726, 31182, 6),
			to = Position(33726, 31178, 6),
			itemId = 35112,
		},
		{
			from = Position(33718, 31187, 6),
			to = Position(33718, 31190, 6),
			itemId = 35112,
		},
		{
			from = Position(33716, 31181, 6),
			to = Position(33716, 31182, 6),
			itemId = 35112,
		},
		{
			from = Position(33714, 31185, 6),
			to = Position(33712, 31185, 6),
			itemId = 35126,
		},
	},

	transformTiles = {
		{
			position = Position(33726, 31180, 7),
			fromId = 35120,
			toId = 35119,
		},
		{
			position = Position(33723, 31191, 7),
			fromId = 35110,
			toId = 35109,
		},
		{
			position = Position(33727, 31186, 7),
			fromId = 35110,
			toId = 35109,
		},
		{
			position = Position(33736, 31180, 7),
			fromId = 35120,
			toId = 35119,
		},
		{
			special = true,
			basePos = Position(33718, 31176, 7),
			visualPos = Position(33718, 31177, 7),
			fromId = 35107,
			toId = 35510,
		},
		{
			special = true,
			basePos = Position(33714, 31176, 6),
			visualPos = Position(33714, 31177, 6),
			fromId = 35107,
			toId = 35510,
		},
		{
			special = true,
			basePos = Position(33726, 31176, 6),
			visualPos = Position(33726, 31177, 6),
			fromId = 35107,
			toId = 35510,
		},
		{
			position = Position(33718, 31191, 6),
			fromId = 35110,
			toId = 35109,
		},
		{
			position = Position(33716, 31183, 6),
			fromId = 35110,
			toId = 35109,
		},
		{
			special = true,
			basePos = Position(33710, 31185, 6),
			visualPos = Position(33711, 31185, 6),
			fromId = 35122,
			toId = 35511,
		},
	},

	spawnMonsters = {
		{
			name = "Tentacle",
			position = Position(33722, 31180, 7),
		},
		{
			name = "Tentacle2",
			position = Position(33723, 31185, 7),
		},
		{
			name = "Tentacle3",
			position = Position(33727, 31183, 7),
		},
		{
			name = "Tentacle4",
			position = Position(33730, 31180, 7),
		},
		{
			name = "Tentacle5",
			position = Position(33718, 31181, 7),
		},
		{
			name = "Tentacle6",
			position = Position(33714, 31181, 6),
		},
		{
			name = "Tentacle7",
			position = Position(33726, 31183, 6),
		},
		{
			name = "Tentacle8",
			position = Position(33718, 31186, 6),
		},
		{
			name = "Tentacle9",
			position = Position(33715, 31185, 6),
		},
		{
			name = "Tentacle10",
			position = Position(33716, 31180, 6),
		},
	},
}

local function createTentacleLines()
	for _, line in ipairs(config.tentacleLines) do
		if line.from.y == line.to.y then
			local step = line.from.x <= line.to.x and 1 or -1
			for x = line.from.x, line.to.x, step do
				Game.createItem(line.itemId, 1, Position(x, line.from.y, line.from.z))
			end
		elseif line.from.x == line.to.x then
			local step = line.from.y <= line.to.y and 1 or -1
			for y = line.from.y, line.to.y, step do
				Game.createItem(line.itemId, 1, Position(line.from.x, y, line.from.z))
			end
		end
	end
end

local function transformTiles()
	for _, t in ipairs(config.transformTiles) do
		if t.special then
			local baseTile = Tile(t.basePos)
			if baseTile then
				for _, item in ipairs(baseTile:getItems() or {}) do
					if item:getId() == t.fromId then
						item:remove()
					end
				end
			end

			local visualTile = Tile(t.visualPos)
			if visualTile then
				for _, item in ipairs(visualTile:getItems() or {}) do
					if item:getId() == t.fromId then
						item:remove()
					end
				end
			end

			local positionsToCheck = {
				t.basePos,
				t.visualPos,
				Position(t.visualPos.x, t.visualPos.y - 1, t.visualPos.z),
				Position(t.visualPos.x, t.visualPos.y + 1, t.visualPos.z),
				Position(t.visualPos.x - 1, t.visualPos.y, t.visualPos.z),
				Position(t.visualPos.x + 1, t.visualPos.y, t.visualPos.z),
			}

			for _, pos in ipairs(positionsToCheck) do
				local tile = Tile(pos)
				if tile then
					for _, item in ipairs(tile:getItems() or {}) do
						if item:getId() == t.fromId then
							item:remove()
						end
					end
				end
			end

			Game.createItem(t.toId, 1, t.visualPos)
		else
			local tile = Tile(t.position)
			if tile then
				local item = tile:getItemById(t.fromId)
				if item then
					item:transform(t.toId)
				end
			end
		end
	end
end

local function spawnTentacles()
	for _, m in ipairs(config.spawnMonsters) do
		local monster = Game.createMonster(m.name, m.position, true, true)
		if monster then
			m.position:sendMagicEffect(CONST_ME_ENERGYHIT)
		end
	end
end

function tentuglysHeadPhase.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not creature then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	local maxHealth = creature:getMaxHealth()
	local currentHealth = creature:getHealth()

	local totalDamage = math.max(0, primaryDamage) + math.max(0, secondaryDamage)
	local newHealth = currentHealth - totalDamage

	if creature:getStorageValue(1) ~= 1 and newHealth <= (maxHealth * config.threshold) then
		creature:setStorageValue(1, 1)

		local cid = creature:getId()

		addEvent(function()
			local c = Creature(cid)
			if not c then
				return
			end

			local tpPos = config.teleport.position

			c:teleportTo(tpPos, true)
			tpPos:sendMagicEffect(CONST_ME_TELEPORT)

			createTentacleLines()
			transformTiles()
			spawnTentacles()
			addEvent(checkTentaclesLoop, 1000)
		end, 100)
	end

	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

tentuglysHeadPhase:register()
