-- Mission 12 - Golem Servant Itens Mechanic
local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar

local KV_SCOPE = "shadows-of-yalahar"
local ACTIVE_KEY = "golem-servant-active"
local CURRENT_ITEM_KEY = "golem-servant-current-item"
local HAS_ITEM_KEY = "golem-servant-has-item"

local function createGolemContainerAction(itemKey)
	local containerData = GolemServantItems[itemKey]
	local action = Action()

	function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
		if player:getStorageValue(ShadowsOfYalahar.Mission12) ~= 1 then
			return true
		end

		local kv = player:kv():scoped(KV_SCOPE)

		local active = kv:get(ACTIVE_KEY)
		if active ~= true then
			player:sendCancelMessage("You have no use for this right now.")
			return true
		end

		local currentItem = kv:get(CURRENT_ITEM_KEY)
		if currentItem ~= itemKey then
			player:sendCancelMessage("You have no use for this right now.")
			return true
		end

		local hasItem = kv:get(HAS_ITEM_KEY)
		if hasItem == true then
			player:sendCancelMessage("You already have this item.")
			return true
		end

		player:addItem(containerData.itemId, 1)
		kv:set(HAS_ITEM_KEY, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You take the " .. containerData.displayName .. ".")

		return true
	end

	action:aid(containerData.containerActionId)
	action:register()

	return action
end

for _, itemKey in ipairs(GolemServantItemKeys) do
	createGolemContainerAction(itemKey)
end

-- Mission 12 - Elevator (Fenrock)
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
			teleportPlayer(pair.a, pair.b)
			return true
		end

		if isInArea(playerPosition, pair.b) then
			teleportPlayer(pair.b, pair.a)
			return true
		end
	end

	player:sendCancelMessage("You cannot use this here.")
	return true
end

elevatorFenrock:aid(4968)
elevatorFenrock:register()
