-- Burning Heart: Crimson Court teleports
local BURNING_HEART_MISSION = Storage.Quest.U15_24.Targuna.BurningHeart.Mission
local HERALD_KILLED = Storage.Quest.U15_24.Targuna.BurningHeart.HeraldKilled

-- Energy portal (Targuna) -> upper level of the Crimson Court (near Emiliana)
local ENERGY_PORTAL = Position(31962, 31897, 5)
local CRIMSON_COURT_ARRIVAL = Position(32414, 32690, 12)

-- Return portal (Crimson Court) -> back to Targuna
local RETURN_PORTAL = Position(32414, 32691, 12)
local TARGUNA_RETURN_ARRIVAL = Position(31962, 31898, 5)

-- Inner teleport -> lever area (blocked once the Herald is defeated: boss is one-time)
local INNER_TP_FROM = Position(32424, 32652, 14)
local INNER_TP_TO = Position(32432, 32656, 15)

-- Lever room teleport -> goes up one floor (exit)
local LEVER_ROOM_TP_FROM = Position(32432, 32652, 15)
local LEVER_ROOM_TP_TO = Position(32426, 32652, 14)

-- Boss room exit tile: before the kill it sends you back to the lever; after the
-- kill it leads up and out of the boss room.
local BOSS_ROOM_EXIT_FROM = Position(32489, 32656, 15)
local BOSS_ROOM_EXIT_DONE = Position(32426, 32652, 14)
local LEVER_ROOM_RETURN = Position(32435, 32655, 15)

local function simpleTeleport(fromPos, toPos)
	local mv = MoveEvent()
	function mv.onStepIn(creature, item, position, fromPosition)
		local player = creature:getPlayer()
		if not player then
			return true
		end
		player:teleportTo(toPos)
		toPos:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end
	mv:type("stepin")
	mv:position(fromPos)
	mv:register()
end

-- Energy portal (mission-gated)
local energyPortal = MoveEvent()
function energyPortal.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(BURNING_HEART_MISSION) < 1 then
		player:teleportTo(fromPosition)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You should speak to Emiliana before stepping through the portal.")
		return true
	end

	player:teleportTo(CRIMSON_COURT_ARRIVAL)
	CRIMSON_COURT_ARRIVAL:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
energyPortal:type("stepin")
energyPortal:position(ENERGY_PORTAL)
energyPortal:register()

-- Inner teleport into the lever area, but only while the Herald is still alive.
local innerTp = MoveEvent()
function innerTp.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(HERALD_KILLED) == 1 then
		player:teleportTo(fromPosition)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You cannot enter the room beyond ... yet.")
		return true
	end

	player:teleportTo(INNER_TP_TO)
	INNER_TP_TO:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
innerTp:type("stepin")
innerTp:position(INNER_TP_FROM)
innerTp:register()

simpleTeleport(LEVER_ROOM_TP_FROM, LEVER_ROOM_TP_TO)

-- Boss room exit: leads out after the kill, otherwise sends you back to the lever.
local bossRoomExit = MoveEvent()
function bossRoomExit.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(HERALD_KILLED) == 1 then
		player:teleportTo(BOSS_ROOM_EXIT_DONE)
		BOSS_ROOM_EXIT_DONE:sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(LEVER_ROOM_RETURN)
		LEVER_ROOM_RETURN:sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end
bossRoomExit:type("stepin")
bossRoomExit:position(BOSS_ROOM_EXIT_FROM)
bossRoomExit:register()

-- Return portal back to Targuna (ungated)
simpleTeleport(RETURN_PORTAL, TARGUNA_RETURN_ARRIVAL)
