local entrances = {
	{ position = Position(34092, 31978, 14), destination = Position(33842, 31651, 13) }, -- Murcion hunt area
	{ position = Position(33842, 31650, 13), destination = Position(34092, 31979, 14) }, -- leave Murcion hunt area
	{ position = Position(33905, 31693, 15), destination = Position(32971, 32368, 15) }, -- Murcion lever room

	{ position = Position(34093, 32009, 14), destination = Position(33809, 31815, 13) }, -- Chagorz hunt area
	{ position = Position(33809, 31814, 13), destination = Position(34092, 32009, 14) }, -- leave Chagorz hunt area
	{ position = Position(33902, 31881, 15), destination = Position(33071, 32370, 15) }, -- Chagorz lever room

	{ position = Position(34120, 31978, 14), destination = Position(34101, 31678, 13) }, -- Ichgahal hunt area
	{ position = Position(34101, 31677, 13), destination = Position(34119, 31979, 14) }, -- leave Ichgahal hunt area
	{ position = Position(34065, 31716, 15), destination = Position(32971, 32336, 15) }, -- Ichgahal lever room

	{ position = Position(34117, 32010, 15), destination = Position(34119, 31876, 14) }, -- Vemiath hunt area
	{ position = Position(34119, 31875, 14), destination = Position(34118, 32010, 15) }, -- leave Vemiath hunt area
	{ position = Position(34002, 31820, 15), destination = Position(33071, 32336, 15) }, -- Vemiath lever room

	{ position = Position(33069, 32405, 15), destination = Position(34106, 32052, 13) }, -- Bakragore leave room
}

local teleportEvent = Action()

function teleportEvent.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return false
	end

	local access = player:kv():scoped("rotten-blood-quest"):get("access") or 0
	if access < 5 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You should pay respect to the Bloodshade guarding this realm before entering.")
		player:teleportTo(fromPosition, true)
		return false
	end

	for _, entrance in pairs(entrances) do
		if toPosition == entrance.position then
			player:teleportTo(entrance.destination)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end
	end

	return false
end

for _, entrance in pairs(entrances) do
	teleportEvent:position(entrance.position)
end
teleportEvent:register()

----------- Bakragore Entrance Check -----------
local entrance = {
	position = Position(34106, 32054, 13),
	destination = Position(33071, 32403, 15), -- Bakragore lever room
}

local bakragoreEntrance = Action()

function bakragoreEntrance.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return false
	end

	if player:getLevel() < 250 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need at least level 250 to enter.")
		player:teleportTo(fromPosition, true)
		return false
	end

	local now, text = os.time(), ""
	for _, bossName in pairs({ "murcion", "chagorz", "ichgahal", "vemiath" }) do
		local cooldown = player:kv():scoped("rotten-blood-quest"):scoped(bossName):get("cooldown") or 0
		if cooldown <= now then
			text = text .. "\n" .. bossName:titleCase()
		end
	end

	if text ~= "" then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You still need to defeat: " .. text)
		player:teleportTo(fromPosition, true)
		return false
	end

	local taints = player:kv():scoped("rotten-blood-quest"):get("taints") or 0
	if taints < 4 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have %i taints.", taints))
		player:teleportTo(fromPosition, true)
		return false
	end

	if toPosition == entrance.position then
		player:teleportTo(entrance.destination)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	return false
end

bakragoreEntrance:position(entrance.position)
bakragoreEntrance:register()
