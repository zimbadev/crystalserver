local function createWooden(position, removeId, createId, actionId)
	local woodPosition = Position(position)
	local woodenPlanks = Tile(woodPosition):getItemById(removeId)
	if woodenPlanks then
		woodenPlanks:remove()
		local woods = Game.createItem(createId, 1, position)
		if woods then
			woods:setActionId(actionId)
		end
	end
	return true
end

local settingTable = {
	[42501] = { position = Position(32647, 32216, 7), removeItem = 12183, createItem = 6474 },
	[42502] = { position = Position(32660, 32213, 7), removeItem = 12183, createItem = 6474 },
	[42503] = { position = Position(32644, 32183, 6), removeItem = 12185, createItem = 6473 },
	[42504] = { position = Position(32660, 32201, 7), removeItem = 12184, createItem = 6473 },
	[42505] = { position = Position(32652, 32200, 5), removeItem = 12185, createItem = 6473 },
	[42506] = { position = Position(32679, 32210, 6), removeItem = 12185, createItem = 6473 },
}

local function getWallCount(player)
	local ok, value = pcall(function()
		return player:kv():get("rottinwood-wallcount")
	end)
	return ok and (tonumber(value) or 0) or 0
end

local hammer = Action()

function hammer.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target or type(target) ~= "userdata" or not target:isItem() then
		return false
	end

	local targetActionId = target:getActionId()

	-- Lay down the wood
	local position = Position(32571, 31508, 9)
	local tile = Tile(position)
	if targetActionId == 40021 and tile:getItemById(4597) then
		if player:getItemCount(5901) >= 3 and player:getItemCount(953) >= 3 then
			player:removeItem(5901, 3)
			player:removeItem(953, 3)
			player:say("KLING KLONG!", TALKTYPE_MONSTER_SAY)
			tile:getItemById(295):remove()
			tile:getItemById(291):remove()
			Game.createItem(5770, 1, position):setActionId(40021)
		end
		return true
		-- Lay down the rails
	elseif targetActionId == 40021 and tile:getItemById(5770) then
		if player:getItemCount(9114) >= 1 and player:getItemCount(9115) >= 2 and player:getItemCount(953) >= 3 then
			player:removeItem(9114, 1)
			player:removeItem(9115, 2)
			player:removeItem(953, 3)
			player:say("KLING KLONG!", TALKTYPE_MONSTER_SAY)
			Game.createItem(7122, 1, position)
		end
		return true
	end

	-- Rottin wood and married men quest
	local setting = settingTable[targetActionId]
	if setting then
		local S = Storage.Quest.U8_7.RottinWoodAndTheMarriedMen

		local currentCount = math.max(0, getWallCount(player))
		if currentCount >= 6 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already fixed many broken walls today.")
			return true
		end

		local woodenItem = Tile(setting.position):getItemById(setting.removeItem)
		if woodenItem then
			woodenItem:remove()
			local repairedWall = Game.createItem(setting.createItem, 1, setting.position)
			if repairedWall then
				repairedWall:setActionId(targetActionId)
			end

			addEvent(createWooden, 2 * 60 * 1000, setting.position, setting.createItem, setting.removeItem, targetActionId)

			player:kv():set("rottinwood-wallcount", currentCount + 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You fixed this broken wall.")

			local mission02Value = player:getStorageValue(S.Mission02)
			player:updateStorage(S.Mission02, mission02Value, mission02Value, os.time())

			local task02Value = player:getStorageValue(S.Task02)
			player:updateStorage(S.Task02, task02Value, task02Value, os.time())
		end
		return true
	end

	return false
end

hammer:id(3460)
hammer:register()
