local createItem = TalkAction("/i")

local ITEMS_LIMIT = 14400 -- lasting exercise weapon

function createItem.onSay(player, words, param)
	-- create log
	logCommand(player, words, param)

	local split = param:split(",")

	local itemType = ItemType(split[1])
	if itemType:getId() == 0 then
		itemType = ItemType(tonumber(split[1]))
		if not tonumber(split[1]) or itemType:getId() == 0 then
			player:sendCancelMessage("There is no item with that id or name.")
			return true
		end
	end

	if itemType:getId() < 100 then
		return true
	end

	local charges = itemType:getCharges()
	local count = tonumber(split[2] or 1)
	if not count then
		count = 1
	end

	if count > ITEMS_LIMIT then
		player:sendCancelMessage(string.format("You can only create up to %d items at once.", ITEMS_LIMIT))
		return true
	end

	if itemType:isStackable() then
		local mainContainer = player:getSlotItem(CONST_SLOT_BACKPACK)
		if not mainContainer then
			player:addItemEx(Game.createItem(2854), CONST_SLOT_BACKPACK)
			mainContainer = player:getSlotItem(CONST_SLOT_BACKPACK)
		end

		local remainingCount = count
		local stackSize = itemType:getStackSize()

		while remainingCount > 0 do
			local freeSlots = mainContainer and (mainContainer:getCapacity() - mainContainer:getSize()) or 0
			if freeSlots <= 1 and mainContainer:getSize() ~= 0 then
				mainContainer = Game.createItem(2854)
				player:addItemEx(mainContainer)
			end

			local countToAdd = math.min(remainingCount, stackSize)
			local tmpItem = mainContainer:addItem(itemType:getId(), countToAdd)
			if tmpItem then
				remainingCount = remainingCount - countToAdd
			else
				logger.warn("Failed to add item: {}, to container", itemType:getName())
				break
			end
		end

		if not player:isInGhostMode() then
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		end
		return true
	end

	if not itemType:isFluidContainer() then
		if charges > 0 then
			count = math.min(charges, math.max(1, count))
		else
			count = 1
		end
	else
		count = math.max(0, count)
	end

	local result
	local tier = tonumber(split[3])

	if tier then
		result = player:addItem(itemType:getId(), count, true, 0, CONST_SLOT_WHEREEVER, tier)
	else
		if itemType:getCharges() > 0 then
			result = player:addItem(itemType:getId(), charges)
		else
			result = player:addItem(itemType:getId(), count)
		end
	end

	if result then
		if not itemType:isStackable() then
			if type(result) == "table" then
				for _, item in ipairs(result) do
					item:decay()
				end
			else
				result:decay()
			end
		end

		if not player:isInGhostMode() then
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		end
	end
	return true
end

createItem:separator(" ")
createItem:groupType("god")
createItem:register()
