local MONK_QUEST = "the_way_of_the_monk_quest"
local ShrineStorage = Storage.Quest.U15_00.TheWayOfTheMonk.Shrines

local shrineConfig = {
	counterKey = "shrineCounter", -- kv counter
	expReward = 50,
	transformedItemId = 50244,
}

local shrines = {
	[7101] = { key = "firstShrine", storage = ShrineStorage.FirstShrine },
	[7102] = { key = "secondShrine", storage = ShrineStorage.SecondShrine },
	[7103] = { key = "thirdShrine", storage = ShrineStorage.ThirdShrine },
	[7104] = { key = "fourthShrine", storage = ShrineStorage.FourthShrine },
}

local shrineAction = Action()
function shrineAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local shrine = shrines[item.actionid]
	if not shrine then
		player:sendCancelMessage("Sorry, not possible.")
		return true
	end

	local kv = player:questKV(MONK_QUEST)
	if (kv:get("questline") or 0) < 1 and not kv:get("gotIntroHint") then
		kv:set("gotIntroHint", true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ambassador Manop at the Adventurer's Outpost may be able to tell you more about this mysterious shrine.")
	end

	if not kv:scoped("shrines"):get(shrine.key) then
		kv:scoped("shrines"):set(shrine.key, true)
		player:setStorageValue(shrine.storage, 1)

		local currentCount = math.max(0, (kv:get(shrineConfig.counterKey) or 0))
		kv:set(shrineConfig.counterKey, currentCount + 1)

		player:addExperience(shrineConfig.expReward, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You honor the ways of the Merudri at this shrine. You gained " .. shrineConfig.expReward .. " experience points.")
		toPosition:sendMagicEffect(CONST_ME_FIREATTACK)
		item:transform(shrineConfig.transformedItemId)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already honored this shrine.")
	end

	return true
end

for aid, _ in pairs(shrines) do
	shrineAction:aid(aid)
end
shrineAction:register()
