-- The Order of the Stag - boat, mines, corpses and Marie-Denise's wall (Isle of Ada)
--
-- Barco (W): "Go to the shore south of the castle, and click on the rope inside a small fishing
--   boat. You are transferred to the Isle of Ada." V: "behind this building use the rope on the
--   boat to get teleported." The way back: NOT CONFIRMED (we use the rope on the island pier).
-- Minas (W): "By exploring the mines, your quest log should update when reaching this area."
-- Corpos (W): "There are three corpses, 'use' each one to progress in this part. The corpses are
--   nearby burning piles and they face to the right." Eldoran (W): "Set fire to this piles of shame".
-- Parede (W): "Speak to Captain Marie-Denise Banner and say hi, wall, and you will be granted access
--   to the teleport by clicking on the wall. The teleport will take you to the lever room."
--   V: "Now you can go through the wall into the teleport that takes you to the lever room."
--
-- All system texts below are NOT CONFIRMED (the Wiki has no transcript).

local pos = OrderOfTheStag.Positions
local stage = OrderOfTheStag.Stage

local function travel(player, destination)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(destination)
	destination:sendMagicEffect(CONST_ME_WATERSPLASH)
end

-- rope of the small boat in Bounac -> island
local boatToAda = Action()

function boatToAda.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if OrderOfTheStag.getStage(player) < stage.TO_ADA then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This small fishing boat is tied up firmly. You have no reason to set sail.")
		return true
	end

	travel(player, pos.adaArrival)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "After a rough journey, you reach the shore of the Isle of Ada.")
	return true
end

boatToAda:position(pos.boatRope)
boatToAda:register()

-- rope on the island pier -> Bounac (no requirement, so nobody gets stuck on the island)
local boatToBounac = Action()

function boatToBounac.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	travel(player, pos.mainlandArrival)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You row back to the shore of Bounac.")
	return true
end

boatToBounac:position(pos.adaRope)
boatToBounac:register()

-- mines: the quest log updates when reaching the area marked on the Wiki
local mines = MoveEvent()

function mines.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player or OrderOfTheStag.getStage(player) ~= stage.DEMERON then
		return true
	end

	OrderOfTheStag.setStage(player, stage.MINES)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your questlog has been updated. You have found your way through the mines.")
	return true
end

-- The trigger covers the whole area around the ramp (33873,32192,7) on floor 7 and its top on
-- floor 6 (a single tile south of the ramp is inside the rock). The 2 ramps are left out (they
-- are floor changes handled by the engine).
local RAMPS = { ["33872:32192"] = true, ["33873:32192"] = true }
for z = 6, 7 do
	for x = 33866, 33877 do
		for y = 32186, 32195 do
			if not (z == 7 and RAMPS[x .. ":" .. y]) then
				mines:position(Position(x, y, z))
			end
		end
	end
end
mines:register()

-- the 3 corpses: bits 1, 2, 4 in the Corpses storage
local corpses = Action()

function corpses.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if OrderOfTheStag.getStage(player) ~= stage.CORPSES then
		return false
	end

	local bit = 0
	for i, corpsePos in ipairs(pos.corpses) do
		if corpsePos == toPosition then
			bit = 2 ^ (i - 1)
			break
		end
	end
	if bit == 0 then
		return false
	end

	local done = OrderOfTheStag.getCount(player, "Corpses")
	if math.floor(done / bit) % 2 == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already set fire to this corpse.")
		return true
	end

	done = done + bit
	OrderOfTheStag.setCount(player, "Corpses", done)
	toPosition:sendMagicEffect(CONST_ME_FIREAREA)

	local burned = 0
	for i = 1, #pos.corpses do
		if math.floor(done / 2 ^ (i - 1)) % 2 == 1 then
			burned = burned + 1
		end
	end

	if burned >= #pos.corpses then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have set fire to all three corpses. Return to Eldoran the Ambitious.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You set fire to the corpse. (%d/%d)", burned, #pos.corpses))
	end
	return true
end

for _, corpsePos in ipairs(pos.corpses) do
	corpses:position(corpsePos)
end
corpses:register()

-- Marie-Denise's wall (52735, usable in the client) -> places you between the wall and the teleport
local markWall = Action()

function markWall.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if OrderOfTheStag.getStage(player) < stage.WALL then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The wall does not move. There must be a way to open it.")
		return true
	end

	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:teleportTo(pos.markWallInside)
	pos.markWallInside:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

markWall:position(pos.markWall)
markWall:register()

-- both forcefields have destination 0,0,0 on the map: west tower -> lever room and back.
-- They are TELEPORT type items (1949 and 37001): the engine hands the creature to the item and
-- ignores any MoveEvent on that tile, so a position MoveEvent never fires. The destination is set
-- on the item itself at startup. The requirement is on the wall (only the WALL stage gets through).
local FORCEFIELDS = {
	{ position = pos.wallTeleport, itemId = 1949, destination = pos.leverRoomArrival, label = "west tower -> lever room" },
	{ position = pos.leverRoomTeleport, itemId = 37001, destination = pos.leverRoomExit, label = "lever room -> west tower" },
}

local forcefieldStartup = GlobalEvent("OrderOfTheStagForcefields")

function forcefieldStartup.onStartup()
	for _, entry in ipairs(FORCEFIELDS) do
		local tile = Tile(entry.position)
		local item = tile and tile:getItemById(entry.itemId)
		local teleport = item and Teleport(item:getUniqueId())
		if teleport then
			teleport:setDestination(entry.destination)
		else
			logger.warn("[Order of the Stag] forcefield {} not found at {}", entry.label, entry.position:toString())
		end
	end
	return true
end

forcefieldStartup:register()
