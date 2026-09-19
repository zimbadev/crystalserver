-- A long lost treasure: final chest (treasure cave on Targuna)
local TREASURE_MISSION = Storage.Quest.U15_24.Targuna.LongLostTreasure.Mission
local TREASURE_CHEST = Storage.Quest.U15_24.Targuna.LongLostTreasure.TreasureChest

local CHEST_POSITION = Position(31944, 31924, 8)

local ADVENTURER_BACKPACK_ID = 53074
local ROPE_ID = 3003

local treasureChest = Action()

function treasureChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(TREASURE_CHEST) == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
		return true
	end

	if player:getStorageValue(TREASURE_MISSION) < 4 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It's locked tight. Sterling must mark the spot on your map before you can claim this treasure.")
		return true
	end

	local backpack = player:addItem(ADVENTURER_BACKPACK_ID, 1)
	if not backpack then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have no room to carry the treasure.")
		return true
	end
	backpack:addItem(ROPE_ID, 1)

	player:setStorageValue(TREASURE_CHEST, 1)
	player:setStorageValue(TREASURE_MISSION, 5)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found an adventurer backpack.")
	fromPosition:sendMagicEffect(CONST_ME_GIFT_WRAPS)
	return true
end

treasureChest:position(CHEST_POSITION)
treasureChest:register()
