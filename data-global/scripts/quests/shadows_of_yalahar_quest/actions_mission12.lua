-- Mission 12 - Golem Servant Items Mechanic
local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar

local function createGolemContainerAction(itemKey, itemIndex)
	local containerData = GolemServantItems[itemKey]
	local action = Action()
	function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
		if player:getStorageValue(ShadowsOfYalahar.Mission12) ~= 1 then
			return true
		end

		if player:getStorageValue(ShadowsOfYalahar.Mission12RepairActive) ~= 1 then
			player:sendCancelMessage("You have no use for this right now.")
			return true
		end

		local currentItemIndex = player:getStorageValue(ShadowsOfYalahar.Mission12RepairItem)
		if currentItemIndex ~= itemIndex then
			player:sendCancelMessage("You have no use for this right now.")
			return true
		end

		if player:getStorageValue(ShadowsOfYalahar.Mission12RepairHasItem) == 1 then
			player:sendCancelMessage("You already have this item.")
			return true
		end

		player:addItem(containerData.itemId, 1)
		player:setStorageValue(ShadowsOfYalahar.Mission12RepairHasItem, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You take the " .. containerData.displayName .. ".")
		return true
	end
	action:aid(containerData.containerActionId)
	action:register()
	return action
end

for index, itemKey in ipairs(GolemServantItemKeys) do
	createGolemContainerAction(itemKey, index)
end

-- Mission 12 - Elevator (Fenrock)
local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar

local ELEVATOR_FLOORS = {
	{ a = Position(32549, 31249, 9), b = Position(32549, 31249, 11) },
}
local AREA_SIZE = 2

local function isInArea(position, areaPosition)
	return position.z == areaPosition.z and position.x >= areaPosition.x and position.x < areaPosition.x + AREA_SIZE and position.y >= areaPosition.y and position.y < areaPosition.y + AREA_SIZE
end

local function sendAreaEffect(areaPosition, effect)
	for x = 0, AREA_SIZE - 1 do
		for y = 0, AREA_SIZE - 1 do
			Position(areaPosition.x + x, areaPosition.y + y, areaPosition.z):sendMagicEffect(effect)
		end
	end
end

local function teleportPlayer(fromPosition, toPosition)
	sendAreaEffect(fromPosition, CONST_ME_POFF)
	for x = 0, AREA_SIZE - 1 do
		for y = 0, AREA_SIZE - 1 do
			local originalPosition = Position(fromPosition.x + x, fromPosition.y + y, fromPosition.z)
			local tile = Tile(originalPosition)
			if tile then
				local creatures = tile:getCreatures()
				if creatures then
					for _, creature in ipairs(creatures) do
						if creature:isPlayer() then
							local targetPosition = Position(toPosition.x + x, toPosition.y + y, toPosition.z)
							originalPosition:sendMagicEffect(CONST_ME_TELEPORT)
							if creature:teleportTo(targetPosition) then
								targetPosition:sendMagicEffect(CONST_ME_TELEPORT)
							else
								creature:sendCancelMessage("Something is wrong with the elevator.")
							end
						end
					end
				end
			end
		end
	end
	sendAreaEffect(toPosition, CONST_ME_POFF)
end

local elevatorFenrock = Action()
function elevatorFenrock.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local playerPosition = player:getPosition()

	for _, pair in ipairs(ELEVATOR_FLOORS) do
		if isInArea(playerPosition, pair.a) then
			if player:getStorageValue(ShadowsOfYalahar.Mission12LiftUnlocked) ~= 1 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The lift is damaged and does not respond.")
				return true
			end
			teleportPlayer(pair.a, pair.b)
			return true
		end
		if isInArea(playerPosition, pair.b) then
			teleportPlayer(pair.b, pair.a)
			return true
		end
	end

	player:sendCancelMessage("Step in the elevator area.")
	return true
end
elevatorFenrock:aid(4968)
elevatorFenrock:register()
