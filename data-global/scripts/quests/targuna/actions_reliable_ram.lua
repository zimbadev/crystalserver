-- Burning Heart (final step): feed the lonely ram on Targuna with the Bunch of Turnips.
-- Reward: Reliable Ram mount + "A reliable Friend" achievement, and the quest completes.
local RELIABLE_RAM_STORAGE = Storage.Quest.U15_24.Targuna.ReliableRam
local BURNING_HEART_MISSION = Storage.Quest.U15_24.Targuna.BurningHeart.Mission
local TURNIPS_REWARD = Storage.Quest.U15_24.Targuna.BurningHeart.TurnipsReward

-- The ram is a map item (not a creature) standing behind the bakery.
local RAM_ITEM_ID = 53439
local RAM_POSITION = Position(31926, 31896, 7)
local ACHIEVEMENT_NAME = "A reliable Friend"

local BUNCH_OF_TURNIPS_ID = 53073 -- items.xml (appearances 53073)
-- Reliable Ram: mounts.xml id=250, clientid/outfit=1934 (identified by rendering appearances.dat).
local RELIABLE_RAM_MOUNT_ID = 250 -- mounts.xml

-- Only registers the action once the mount id is set (avoids a half-given reward).
if BUNCH_OF_TURNIPS_ID > 0 and RELIABLE_RAM_MOUNT_ID > 0 then
	local reliableRam = Action()

	function reliableRam.onUse(player, item, fromPosition, target, toPosition, isHotkey)
		-- The Bunch of Turnips must be used on the ram item.
		if not target or not target:isItem() or target:getId() ~= RAM_ITEM_ID then
			return false
		end

		if target:getPosition():getDistance(RAM_POSITION) > 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This isn't the lonely ram of Targuna.")
			return true
		end

		if player:hasMount(RELIABLE_RAM_MOUNT_ID) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already tamed the Reliable Ram.")
			return true
		end

		-- The turnips only work for the player who actually earned them from Emiliana;
		-- this stops traded/duped items from granting the mount to non-questers.
		if player:getStorageValue(TURNIPS_REWARD) ~= 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The ram doesn't seem to trust you with these turnips.")
			return true
		end

		item:remove(1)
		player:addMount(RELIABLE_RAM_MOUNT_ID)
		player:setStorageValue(RELIABLE_RAM_STORAGE, 1)
		player:addAchievement(ACHIEVEMENT_NAME)

		-- Complete the Burning Heart quest line.
		if player:getStorageValue(BURNING_HEART_MISSION) >= 1 and player:getStorageValue(BURNING_HEART_MISSION) < 5 then
			player:setStorageValue(BURNING_HEART_MISSION, 5)
		end

		target:getPosition():sendMagicEffect(CONST_ME_HEARTS)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The hungry ram enjoyed your gift and is willing to join and assist you on your journey. Take good care of it!")
		return true
	end

	reliableRam:id(BUNCH_OF_TURNIPS_ID)
	reliableRam:register()
end
