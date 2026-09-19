local config = {
	sorcerer = {
		id = 1367,
		name = "Bladespark",
	},
	druid = {
		id = 1364,
		name = "Mossmasher",
	},
	paladin = {
		id = 1366,
		name = "Sandscourge",
	},
	knight = {
		id = 1365,
		name = "Snowbash",
	},
	monk = {
		id = 1819,
		name = "Moonhunter",
	},
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local vocation = config[player:getVocation():getBase():getName():lower()]
	if not vocation then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have not vocation.")
		return true
	end

	if player:hasFamiliar(vocation.id) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already have the " .. vocation.name .. " familiar.")
		return false
	end

	player:addFamiliar(vocation.id)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You obtained the " .. vocation.name .. " familiar.")
	return true
end

action:aid(35508)
action:register()

local entryToTargetPositions = {
	cheesyEntry = {
		from = Position(33927, 31368, 7),
		to = Position(33927, 31366, 7),
	},
}

local portalCheesy = MoveEvent()
function portalCheesy.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	local player = creature:getPlayer()
	if not player then
		return true
	end

	for name, data in pairs(entryToTargetPositions) do
		if position == data.from then
			data.from:sendMagicEffect(214)
			player:teleportTo(data.to, true)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Chedar is spicy, mould is blue, you took like a donkey and smell like a one too.")
			return true
		end
	end

	return true
end
portalCheesy:aid(47501)
portalCheesy:register()

local entryToTargetPositionsCheesy = {
	cheesyExit = {
		from = Position(33924, 31365, 7),
		to = Position(33919, 31366, 7),
	},
}

local portalCheesyChess = MoveEvent()
function portalCheesyChess.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	local player = creature:getPlayer()
	if not player then
		return true
	end

	for name, data in pairs(entryToTargetPositionsCheesy) do
		if position == data.from then
			data.from:sendMagicEffect(168)
			player:teleportTo(data.to, true)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The quicksand pulls you down.")
			return true
		end
	end

	return true
end
portalCheesyChess:aid(47502)
portalCheesyChess:register()

local exitCheesy = Action()
function exitCheesy.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return false
	end

	player:teleportTo(Position(33799, 31321, 7))
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You set sail and leave. But on your way you back you hit a reef and the boat springs a leak. You only just reach the coasts.")
end
exitCheesy:position(Position(33925, 31355, 7))
exitCheesy:register()

local storages = {
	{ storage = Storage.Quest.U12_60.APiratesTail.TentuglyKilled, bossName = "Tentugly's Head" },
	{ storage = Storage.Quest.U12_60.APiratesTail.RatmiralKilled, bossName = "Ratmiral Blackwhiskers" },
}

local positions = {
	{ position = Position(33734, 31273, 7), destination = Position(33922, 31370, 7) },
}

local familiarChess = MoveEvent()

function familiarChess.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		creature:teleportTo(fromPosition, true)
		return false
	end

	for _, value in ipairs(storages) do
		if player:getStorageValue(value.storage) ~= 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are not allowed to use this yet.")
			player:teleportTo(fromPosition, true)
			return false
		end
	end

	for _, value in ipairs(positions) do
		if position == value.position then
			player:teleportTo(value.destination)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end
	end

	return false
end

for _, value in ipairs(positions) do
	familiarChess:position(value.position)
end

familiarChess:register()
