local TheIsleOfEvil = Storage.Quest.U8_5.TheIsleOfEvil
local KV_SCOPE = "the-isle-of-evil"

local corpses = {
	[9402] = {
		kv = "doctor-perhaps-reward",
		rewards = { 9399, 9383, 9372, 9373 },
	},

	[9403] = {
		kv = "dirtbeard-reward",
		rewards = { 9374, 9401, 9375, 9382 },
	},

	[9404] = {
		kv = "evil-mastermind-reward",
		rewards = { 9391 },
	},

	[9405] = {
		kv = "monstor-reward",
		rewards = { 9381, 9386, 9380, 9396 },
	},

	[9406] = {
		kv = "mephiles-reward",
		rewards = { 9376, 9387, 9400, 9377 },
	},

	[9407] = {
		kv = "boogey-reward",
		rewards = { 9379, 9385, 9384, 9378 },
	},
}

local function hasCollectedAllCorpses(kv)
	for _, corpse in pairs(corpses) do
		if not kv:get(corpse.kv) then
			return false
		end
	end
	return true
end

local isleOfEvilCorpse = Action()

function isleOfEvilCorpse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local corpse = corpses[item.itemid]

	if not corpse then
		return true
	end

	if player:getStorageValue(TheIsleOfEvil.Mission07) ~= 1 then
		return true
	end

	local kv = player:kv():scoped(KV_SCOPE)
	if kv:get(corpse.kv) then
		return true
	end

	local rewardId = corpse.rewards[math.random(#corpse.rewards)]

	player:addItem(rewardId, 1)
	kv:set(corpse.kv, true)

	if hasCollectedAllCorpses(kv) then
		player:setStorageValue(TheIsleOfEvil.Mission07, 2)
	end
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:say("You reap some magnificent loot from this servant of evil!", TALKTYPE_MONSTER_SAY)

	return true
end

for corpseId in pairs(corpses) do
	isleOfEvilCorpse:id(corpseId)
end

isleOfEvilCorpse:register()
