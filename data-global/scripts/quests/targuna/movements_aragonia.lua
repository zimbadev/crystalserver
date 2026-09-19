local TREASURE_MISSION = Storage.Quest.U15_24.Targuna.LongLostTreasure.Mission

-- Matilda the turtle (Targuna) -> Aragonia
-- (The hole down to Morla's cave needs no script; it is reached with a shovel.)
local MATILDA_POSITION = Position(31924, 31904, 7)
local ARAGONIA_ARRIVAL = Position(33479, 32734, 7)

local matildaTravel = MoveEvent()

function matildaTravel.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(TREASURE_MISSION) < 1 then
		player:teleportTo(fromPosition)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You should speak to Sterling before riding Matilda to Aragonia.")
		return true
	end

	player:teleportTo(ARAGONIA_ARRIVAL)
	ARAGONIA_ARRIVAL:sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Matilda carries you across the sea to Aragonia. Defeat the pirates and rescue the turtle eggs!")

	if player:getStorageValue(TREASURE_MISSION) == 1 then
		player:setStorageValue(TREASURE_MISSION, 2)
	end
	return true
end

matildaTravel:type("stepin")
matildaTravel:position(MATILDA_POSITION)
matildaTravel:register()

-- Matilda the turtle (Aragonia) -> Targuna
local MATILDA_RETURN_POSITION = Position(33478, 32729, 7)
local TARGUNA_ARRIVAL = Position(31925, 31907, 7)

local matildaReturn = MoveEvent()

function matildaReturn.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(TARGUNA_ARRIVAL)
	TARGUNA_ARRIVAL:sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Matilda carries you back across the sea to Targuna.")
	return true
end

matildaReturn:type("stepin")
matildaReturn:position(MATILDA_RETURN_POSITION)
matildaReturn:register()
