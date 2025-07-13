local MONK_QUEST = "the_way_of_the_monk_quest"

local shrineConfig = {
	counterKey = "shrineCounter",
	questlineKey = "questline",
}

local shrines = {
	[7105] = { key = "guidance", order = 1, level = 6, rewardItem = 50267, exp = 300 },
	[7106] = { key = "tranquility", order = 2, level = 20, rewardItem = 50271, exp = 2500 },
	[7107] = { key = "respect", order = 3, level = 30, rewardSpell = "Mystic Repulse", exp = 5000 },
	[7108] = { key = "legacy", order = 4, level = 40, rewardItem = 50269, exp = 10000 },
	[7109] = { key = "empathy", order = 5, level = 50, rewardItem = 50273, exp = 15000 },
	[7110] = { key = "harmony", order = 6, level = 70, rewardItem = 50274, exp = 30000 },
	[7111] = { key = "power", order = 7, level = 100, rewardItem = 50272, exp = 60000 },
	[7112] = { key = "knowledge", order = 8, level = 110, rewardSpell = "Forceful Uppercut", exp = 75000 },
	[7113] = { key = "serenity", order = 9, level = 150, rewardItem = 50268, exp = 150000 },
	[7114] = { key = "eternity", order = 10, level = 275, rewardSpell = "Focus Harmony", exp = 500000 },
}

local orderedShrines = {}
for _, data in pairs(shrines) do
	orderedShrines[data.order] = data.key
end

local shrineAction = Action()

function shrineAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local shrine = shrines[item.actionid]
	if not shrine then
		return true
	end

	local kv = player:questKV(MONK_QUEST)
	if (kv:get(shrineConfig.questlineKey) or 0) < 2 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Initiate your pilgrimage with Enpa-Deia Pema at Blue Valley first.")
		return true
	end

	if kv:scoped("mainShrines"):get(shrine.key) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already honoured this shrine.")
		return true
	end

	if player:getLevel() < shrine.level then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You require level %d to honour this shrine.", shrine.level))
		return true
	end

	if shrine.order > 1 and not kv:scoped("mainShrines"):get(orderedShrines[shrine.order - 1]) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must find and honour the previous shrine first.")
		return true
	end

	kv:scoped("mainShrines"):set(shrine.key, true)
	-- keep storage update for questlog compatibility
	player:setStorageValue(Storage.Quest.U15_00.TheWayOfTheMonk.MainShrines[shrine.key:gsub("^%l", string.upper)], 1)
	if shrine.rewardItem then
		player:addItem(shrine.rewardItem, 1)
	elseif shrine.rewardSpell then
		player:learnSpell(shrine.rewardSpell)
	end
	player:addExperience(shrine.exp)

	local newCount = math.max(1, (kv:get(shrineConfig.counterKey) or 0) + 1)
	kv:set(shrineConfig.counterKey, newCount)

	if newCount == 14 then
		kv:set("boolPointsWheel", true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your pilgrimage is complete. Report to Enpa-Deia Pema for a reward.")
		toPosition:sendMagicEffect(CONST_ME_HOLYAREA)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Honour progress: %d/14 (%d shrines remaining)", newCount, 14 - newCount))
		toPosition:sendMagicEffect(CONST_ME_FIREATTACK)
	end

	item:transform(50244)
	return true
end

for aid in pairs(shrines) do
	shrineAction:aid(aid)
end
shrineAction:register()
