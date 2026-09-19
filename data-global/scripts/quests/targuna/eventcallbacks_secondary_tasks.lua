-- Targuna secondary tasks: completion hooks.
-- Daily Reward: detected when the daily reward "next reward time" storage is written (on claim).
-- Stash an Item / Take from Stash: detected via the playerOnStowItem / playerOnStashWithdraw
-- engine events (added in src/: Player::stowItem and Game::playerStashWithdraw).
local DAILY_REWARD_TASK = Storage.Quest.U15_24.Targuna.SecondaryTasks.DailyReward
local STASH_ITEM_TASK = Storage.Quest.U15_24.Targuna.SecondaryTasks.StashItem
local TAKE_FROM_STASH_TASK = Storage.Quest.U15_24.Targuna.SecondaryTasks.TakeFromStash

-- DailyReward.storages.nextRewardTime (see data/modules/scripts/daily_reward/daily_reward.lua)
local DAILY_REWARD_NEXT_TIME = 14899

local dailyRewardTask = EventCallback("TargunaDailyRewardTask")

function dailyRewardTask.playerOnStorageUpdate(player, key, value, oldValue, currentFrameTime)
	if key ~= DAILY_REWARD_NEXT_TIME then
		return
	end
	if not value or value <= 0 or value == oldValue then
		return
	end
	if player:getStorageValue(DAILY_REWARD_TASK) == 1 then
		player:setStorageValue(DAILY_REWARD_TASK, 2)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest task complete: you claimed your daily reward.")
	end
end

dailyRewardTask:register()

-- Stash an Item
local stashItemTask = EventCallback("TargunaStashItemTask")

function stashItemTask.playerOnStowItem(player, item, count)
	if player:getStorageValue(STASH_ITEM_TASK) == 1 then
		player:setStorageValue(STASH_ITEM_TASK, 2)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest task complete: you stashed an item in your supply stash.")
	end
end

stashItemTask:register()

-- Take an item from your stash
local takeFromStashTask = EventCallback("TargunaTakeFromStashTask")

function takeFromStashTask.playerOnStashWithdraw(player, itemId, count)
	if player:getStorageValue(TAKE_FROM_STASH_TASK) == 1 then
		player:setStorageValue(TAKE_FROM_STASH_TASK, 2)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest task complete: you took an item from your supply stash.")
	end
end

takeFromStashTask:register()
