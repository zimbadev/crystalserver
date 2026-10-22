-- The Order of the Stag - Etzel Writ (Bounac cathedral)
--
-- W: "You need to open the hole using a Frozen Starlight, by placing it on the stand.
--     The writ is inside a frozen chest. Bring the writ to Kesar."
-- V: "Place the Frozen Starlight on the Trophy Stand, which then allows you to use a pick on this
--     tile. Click on it to go down and encounter the Ancient Lion Warlock. Open the chest to receive
--     a Certificate. Then click on the wall to get out." Message when it opens (V): "Hitting the ideal
--     weak spot, the stone floor gives in and opens a narrow passage." Empty chest (V): "The frozen
--     chest is empty." Video note: in a team everyone sees it open; the Frozen Starlight can
--     be taken back from the stand.
--
-- How long the hole stays open: NOT CONFIRMED (5 minutes).

local pos = OrderOfTheStag.Positions
local items = OrderOfTheStag.Items
local stage = OrderOfTheStag.Stage

local HOLE_OPEN_SECONDS = 5 * 60
local USABLE_EXIT_WALL = 52656 -- same wall as 1507, but usable in the official client
local MAP_EXIT_WALL = 1507
local WARLOCK_NAME = "Ancient Lion Warlock"
local ROOM_FROM = Position(32399, 32466, 5)
local ROOM_TO = Position(32404, 32471, 5)

local HOLE_ID = 52654 -- the hole (M)
local CLOSED_FLOOR_ID = 417 -- tiled floor, the same floor as its neighbours (M). The hole only shows up
-- after the pick, as in the video; the map had the hole always visible.

local holeOpenUntil = 0
local holeCloseEvent = nil

local function setHole(open)
	local tile = Tile(pos.holeTile)
	local ground = tile and tile:getGround()
	if not ground then
		return
	end
	local want = open and HOLE_ID or CLOSED_FLOOR_ID
	if ground:getId() ~= want then
		ground:transform(want)
	end
end

local function starlightOnStand()
	local tile = Tile(pos.stand)
	return tile and tile:getItemById(items.FROZEN_STARLIGHT) ~= nil
end

local function warlockInRoom()
	for x = ROOM_FROM.x, ROOM_TO.x do
		for y = ROOM_FROM.y, ROOM_TO.y do
			local tile = Tile(Position(x, y, ROOM_FROM.z))
			if tile then
				for _, creature in ipairs(tile:getCreatures() or {}) do
					if creature:isMonster() and creature:getName():lower() == WARLOCK_NAME:lower() then
						return true
					end
				end
			end
		end
	end
	return false
end

-- called by onUsePick (scripts/lib/register_actions.lua); true = the pick was used here
function OrderOfTheStag.onPick(player, target, toPosition)
	if toPosition ~= pos.holeTile then
		return false
	end

	if not starlightOnStand() then
		-- NOT CONFIRMED: global text when the Frozen Starlight is missing
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The floor does not give in. Something seems to be missing on the stand nearby.")
		toPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	end

	holeOpenUntil = os.time() + HOLE_OPEN_SECONDS
	setHole(true)
	if holeCloseEvent then
		stopEvent(holeCloseEvent)
	end
	holeCloseEvent = addEvent(function()
		holeCloseEvent = nil
		setHole(false)
	end, HOLE_OPEN_SECONDS * 1000)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Hitting the ideal weak spot, the stone floor gives in and opens a narrow passage.")
	toPosition:sendMagicEffect(CONST_ME_GROUNDSHAKER)
	return true
end

local function descend(player)
	if not warlockInRoom() then
		Game.createMonster(WARLOCK_NAME, pos.warlockSpawn, false, true)
	end

	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:teleportTo(pos.holeArrival)
	pos.holeArrival:sendMagicEffect(CONST_ME_ICEAREA)
end

-- clicking the hole (V: "Click on it to go down")
local hole = Action()

function hole.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if os.time() > holeOpenUntil then
		-- NOT CONFIRMED: global text while the floor is closed
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The stone floor seems brittle here, but it holds.")
		return true
	end
	descend(player)
	return true
end

hole:position(pos.holeTile)
hole:register()

-- Stepping on the open hole also takes you down. While closed, nothing happens.
local holeStep = MoveEvent()

function holeStep.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if player and os.time() <= holeOpenUntil then
		descend(player)
	end
	return true
end

holeStep:position(pos.holeTile)
holeStep:register()

local chest = Action()

function chest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if OrderOfTheStag.getStage(player) ~= stage.WRIT then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The frozen chest is empty.")
		return true
	end

	local certificate = player:addItem(items.CERTIFICATE, 1)
	if not certificate then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have no room to take what is inside the frozen chest.")
		return true
	end

	OrderOfTheStag.setStage(player, stage.CERTIFICATE)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found an ice-covered certificate of ancestry.")
	toPosition:sendMagicEffect(CONST_ME_ICEATTACK)
	return true
end

chest:position(pos.chest)
chest:register()

local exitWall = Action()

function exitWall.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:teleportTo(pos.exitArrival)
	pos.exitArrival:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

exitWall:position(pos.exitWall)
exitWall:register()

-- The map has the plain wall (1507); the client only offers "Use" on the usable version (52656).
local exitWallStartup = GlobalEvent("OrderOfTheStagExitWall")

function exitWallStartup.onStartup()
	setHole(false) -- starts closed
	local tile = Tile(pos.exitWall)
	local wall = tile and tile:getItemById(MAP_EXIT_WALL)
	if wall then
		wall:transform(USABLE_EXIT_WALL)
	elseif not (tile and tile:getItemById(USABLE_EXIT_WALL)) then
		logger.warn("[Order of the Stag] cathedral exit wall not found at {}", pos.exitWall:toString())
	end
	return true
end

exitWallStartup:register()
