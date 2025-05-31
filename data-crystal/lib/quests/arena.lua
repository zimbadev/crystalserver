local firstPit = {
	fromPos = { x = 340, y = 225, z = 7 },
	toPos = { x = 349, y = 234, z = 7 },
	center = { x = 345, y = 229, z = 7 },
	pillar = { x = 339, y = 229, z = 7 },
	tp = { x = 339, y = 229, z = 7 },
	summon = { x = 345, y = 231, z = 7 },
}

local function generatePits()
	local offsets = {
		{ 0, 0 },
		{ -14, 0 },
		{ -28, 0 },
		{ -42, 0 },
		{ -35, -14 },
		{ -21, -14 },
		{ -7, -14 },
		{ -14, -28 },
		{ -28, -28 },
		{ -21, -42 },
	}
	local pits = {}
	for i, offset in ipairs(offsets) do
		pits[i] = {
			fromPos = { x = firstPit.fromPos.x + offset[1], y = firstPit.fromPos.y + offset[2], z = firstPit.fromPos.z },
			toPos = { x = firstPit.toPos.x + offset[1], y = firstPit.toPos.y + offset[2], z = firstPit.toPos.z },
			center = { x = firstPit.center.x + offset[1], y = firstPit.center.y + offset[2], z = firstPit.center.z },
			pillar = { x = firstPit.pillar.x + offset[1], y = firstPit.pillar.y + offset[2], z = firstPit.pillar.z },
			tp = { x = firstPit.tp.x + offset[1], y = firstPit.tp.y + offset[2], z = firstPit.tp.z },
			summon = { x = firstPit.summon.x + offset[1], y = firstPit.summon.y + offset[2], z = firstPit.summon.z },
		}
	end
	return pits
end

SvargrondArena = {
	-- Settings
	kickTime = 600,
	kickPosition = Position({ x = 386, y = 229, z = 6 }),
	rewardPosition = Position({ x = 357, y = 211, z = 6 }),

	kickEvents = {},
	timerEvents = {},
	effectPositionCache = {},

	itemTimer = 21464,
	itemPillar = 1841,
	itemTeleport = 5022,
	itemsNotErasable = { 21464, 1841, 2181, 2182, 2183 },

	pits = generatePits(),

	arenas = {
		[1] = {
			name = "Greenhorn",
			price = 1000,
			questLog = Storage.CrystalServer.IceCity.BarbarianArena.QuestLogGreenhorn,
			achievement = "Greenhorn",
			creatures = {
				"frostfur",
				"bloodpaw",
				"bovinus",
				"achad",
				"colerian the barbarian",
				"the hairy one",
				"axeitus headbanger",
				"rocky",
				"cursed gladiator",
				"orcus the cruel",
			},
		},
		[2] = {
			name = "Scrapper",
			price = 5000,
			questLog = Storage.CrystalServer.IceCity.BarbarianArena.QuestLogScrapper,
			achievement = "Scrapper",
			creatures = {
				"avalanche",
				"kreebosh the exile",
				"the dark dancer",
				"the hag",
				"slim",
				"grimgor guteater",
				"drasilla",
				"spirit of earth",
				"spirit of water",
				"spirit of fire",
			},
		},
		[3] = {
			name = "Warlord",
			price = 10000,
			questLog = Storage.CrystalServer.IceCity.BarbarianArena.QuestLogWarlord,
			achievement = "Warlord of Svargrond",
			creatures = {
				"webster",
				"darakan the executioner",
				"norgle glacierbeard",
				"the pit lord",
				"svoren the mad",
				"the masked marauder",
				"gnorre chyllson",
				"fallen mooh'tah master ghar",
				"deathbringer",
				"the obliverator",
			},
		},
	},

	trophies = {
		[3264] = {
			trophy = 5807,
			trophyStorage = Storage.CrystalServer.IceCity.BarbarianArena.TrophyGreenhorn,
			desc = "It is given to the courageous victor of the barbarian arena in greenhorn difficulty. Awarded to %s",
		},
		[3265] = {
			trophy = 5806,
			trophyStorage = Storage.CrystalServer.IceCity.BarbarianArena.TrophyScrapper,
			desc = "It is given to the courageous victor of the barbarian arena in scrapper difficulty. Awarded to %s.",
		},
		[3266] = {
			trophy = 5805,
			trophyStorage = Storage.CrystalServer.IceCity.BarbarianArena.TrophyWarlord,
			desc = "It is given to the courageous victor of the barbarian arena in warlord difficulty. Awarded to %s.",
		},
	},
}

-- ===== ARENA METHODS =====

function SvargrondArena.getPitCreatures(pitId)
	local pit = SvargrondArena.pits[pitId]
	if not pit then
		return {}
	end
	local specs = Game.getSpectators(pit.center, false, false, 5, 5, 5, 5)
	return specs or {}
end

function SvargrondArena.resetPit(pitId)
	local pit = SvargrondArena.pits[pitId]
	if not pit then
		return
	end
	for x = pit.fromPos.x, pit.toPos.x do
		for y = pit.fromPos.y, pit.toPos.y do
			for z = pit.fromPos.z, pit.toPos.z do
				local tile = Tile({ x = x, y = y, z = z })
				if tile then
					local movableItem = tile:getThing(255)
					if movableItem and movableItem:isItem() then
						local itemType = ItemType(movableItem:getId())
						if itemType and itemType:isMovable() and not table.contains(SvargrondArena.itemsNotErasable, movableItem:getId()) then
							movableItem:remove()
						end
					end
					local creature = tile:getTopCreature()
					if creature and creature:isMonster() then
						creature:remove()
					end
				end
			end
		end
	end
	local pillarTile = Tile(pit.pillar)
	if pillarTile then
		local teleportItem = pillarTile:getItemById(SvargrondArena.itemTeleport)
		if teleportItem then
			teleportItem:remove()
		end
		local pillarItem = pillarTile:getItemById(SvargrondArena.itemPillar)
		if not pillarItem then
			Game.createItem(SvargrondArena.itemPillar, 1, pit.pillar)
		end
	end
end

function SvargrondArena.getPitOccupant(pitId, ignorePlayer)
	for _, creature in ipairs(SvargrondArena.getPitCreatures(pitId)) do
		if creature:isPlayer() and (not ignorePlayer or creature:getId() ~= ignorePlayer:getId()) then
			return creature
		end
	end
	return nil
end

function SvargrondArena.kickPlayer(cid, hideMessage)
	SvargrondArena.cancelEvents(cid)
	local player = Player(cid)
	if not player then
		return
	end
	if player:getStorageValue(Storage.CrystalServer.IceCity.BarbarianArena.PitDoor) > 0 then
		player:teleportTo(SvargrondArena.kickPosition)
		SvargrondArena.kickPosition:sendMagicEffect(CONST_ME_TELEPORT)
		player:setStorageValue(Storage.CrystalServer.IceCity.BarbarianArena.PitDoor, 0)
		if not hideMessage then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your time ran out!")
		end
	end
end

function SvargrondArena.cancelEvents(cid)
	local kickEvent = SvargrondArena.kickEvents[cid]
	if kickEvent then
		SvargrondArena.removeTimer(kickEvent.pitId)
		stopEvent(kickEvent.eventId)
	end
	SvargrondArena.kickEvents[cid] = nil
end

function SvargrondArena.scheduleKickPlayer(cid, pitId)
	SvargrondArena.cancelEvents(cid)
	SvargrondArena.startTimer(pitId)
	local eventId = addEvent(SvargrondArena.kickPlayer, SvargrondArena.kickTime * 1000, cid)
	if eventId then
		SvargrondArena.kickEvents[cid] = { eventId = eventId, pitId = pitId }
	end
end

function SvargrondArena.startTimer(pitId)
	local pit = SvargrondArena.pits[pitId]
	if not pit then
		return
	end
	local tile = Tile(pit.fromPos)
	if not tile then
		return
	end
	local timerItem = tile:getItemById(SvargrondArena.itemTimer)
	if timerItem then
		timerItem:remove()
	end
	timerItem = Game.createItem(SvargrondArena.itemTimer, 1, pit.fromPos)
	if timerItem then
		timerItem:decay()
	end
	if SvargrondArena.timerEvents[pitId] then
		stopEvent(SvargrondArena.timerEvents[pitId])
	end
	SvargrondArena.timerEvents[pitId] = addEvent(SvargrondArena.removeTimer, SvargrondArena.kickTime * 1000, pitId)
end

function SvargrondArena.removeTimer(pitId)
	local pit = SvargrondArena.pits[pitId]
	if not pit then
		return
	end
	local tile = Tile(pit.fromPos)
	if not tile then
		return
	end
	local timerItem = tile:getItemById(SvargrondArena.itemTimer)
	if timerItem then
		timerItem:remove()
	end
	SvargrondArena.timerEvents[pitId] = nil
end

function SvargrondArena.sendPillarEffect(pitId)
	local positions = SvargrondArena.effectPositionCache[pitId]
	if not positions then
		local p = SvargrondArena.pits[pitId].pillar
		positions = {
			Position(p.x - 1, p.y, p.z),
			Position(p.x + 1, p.y, p.z),
			Position(p.x + 1, p.y - 1, p.z),
			Position(p.x + 1, p.y + 1, p.z),
			Position(p.x, p.y, p.z),
		}
		SvargrondArena.effectPositionCache[pitId] = positions
	end
	for _, pos in ipairs(positions) do
		pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	end
end
