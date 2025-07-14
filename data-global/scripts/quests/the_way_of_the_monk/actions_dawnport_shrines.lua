local MONK_QUEST = "the_way_of_the_monk_quest"

local shrineConfig = {
	counterKey = "shrineCounter",
}
local shrines = {
	[7101] = { key = "firstShrine", messageIndex = 1 },
	[7102] = { key = "secondShrine", messageIndex = 2 },
	[7103] = { key = "thirdShrine", messageIndex = 3 },
	[7104] = { key = "fourthShrine", messageIndex = 4 },
}
local shrineAction = Action()
function shrineAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local shrine = shrines[item.actionid]
	if not shrine then
		player:sendCancelMessage("Sorry, not possible.")
		return true
	end
	local kv = player:questKV(MONK_QUEST)
	if (kv:get("questline") or 0) < 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ambassador Manop at the Adventurer's Outpost may be able to tell you more about this mysterious shrine.")
		return true
	end
	if not kv:scoped("shrines"):get(shrine.key) then
		kv:scoped("shrines"):set(shrine.key, true)
		player:setStorageValue(Storage.Quest.U15_00.TheWayOfTheMonk.Shrines[shrine.key:gsub("^%l", string.upper)], 1)
		local currentCount = math.max(0, (kv:get(shrineConfig.counterKey) or 0))
		kv:set(shrineConfig.counterKey, currentCount + 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You honor the ways of the Merudri at the shrine of Darkness.")
		toPosition:sendMagicEffect(CONST_ME_FIREATTACK)
		item:transform(50244)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already honor this shrine.")
	end
	return true
end
for aid, _ in pairs(shrines) do
	shrineAction:aid(aid)
end
shrineAction:register()
