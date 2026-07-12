local config = {
	thais = {
		from = Position(32429, 32164, 8),
		to = Position(32431, 32166, 8),
		destination = Position(33453, 31030, 8),
	},
	temporalTides = {
		from = Position(33452, 31027, 8),
		to = Position(33454, 31029, 8),
		destination = Position(32430, 32167, 8),
	},
}

local function isInArea(position, fromPosition, toPosition)
	return position.x >= fromPosition.x and position.x <= toPosition.x and position.y >= fromPosition.y and position.y <= toPosition.y and position.z == fromPosition.z
end

local function teleportPlayer(player, destination)
	player:teleportTo(destination)
	player:getPosition():sendMagicEffect(CONST_ME_ENERGYHIT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The mechanism takes you back in time.")
end

local timeMachine = Action()

function timeMachine.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if isInArea(fromPosition, config.thais.from, config.thais.to) then
		teleportPlayer(player, config.thais.destination)
		return true
	end

	if isInArea(fromPosition, config.temporalTides.from, config.temporalTides.to) then
		teleportPlayer(player, config.temporalTides.destination)
		return true
	end

	return false
end

local function registerArea(action, fromPosition, toPosition)
	for x = fromPosition.x, toPosition.x do
		for y = fromPosition.y, toPosition.y do
			action:position(Position(x, y, fromPosition.z))
		end
	end
end

registerArea(timeMachine, config.thais.from, config.thais.to)
registerArea(timeMachine, config.temporalTides.from, config.temporalTides.to)
timeMachine:register()
