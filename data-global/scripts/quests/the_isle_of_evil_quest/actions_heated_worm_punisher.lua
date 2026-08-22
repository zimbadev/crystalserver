local MISSION04_STORAGE = Storage.Quest.U8_5.TheIsleOfEvil.Mission04

local KV_SCOPE = "the-isle-of-evil"
local WORM_COUNT_KV = "mission04-wormcount"
local MUST_PAY_KV = "mission04-mustpay"
local WORMS_REQUIRED = 6

local CARRION_WORM_ID = 9197
local DRILLING_WORM_ID = 9196

local heatedWormPunisher = Action()

function heatedWormPunisher.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(MISSION04_STORAGE) ~= 2 then
		return true
	end

	if not target then
		return true
	end

	local targetId = target.itemid
	local kv = player:kv():scoped(KV_SCOPE)

	if targetId == CARRION_WORM_ID then
		if kv:get(MUST_PAY_KV) then
			player:say("You should go talk to Scutty before continuing.", TALKTYPE_MONSTER_SAY)
			return true
		end

		toPosition:sendMagicEffect(CONST_ME_STUN)

		local count = (kv:get(WORM_COUNT_KV) or 0) + 1
		kv:set(WORM_COUNT_KV, count)

		if count < WORMS_REQUIRED then
			player:say("You've got gim! That will tech the beast a lesson!", TALKTYPE_MONSTER_SAY)
		else
			player:say("You've got him! That was the last one you had to scare off. Report to Scutty about the worms.", TALKTYPE_MONSTER_SAY)

			if not player:hasAchievement("Worm Whacker") then
				player:addAchievement("Worm Whacker")
			end

			player:setStorageValue(MISSION04_STORAGE, 3)
			kv:set(WORM_COUNT_KV, 0)
		end

		return true
	end

	if targetId == DRILLING_WORM_ID then
		toPosition:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
		player:say("Oh no! You have hit one of Scutty's precious drilling worms!", TALKTYPE_MONSTER_SAY)
		kv:set(WORM_COUNT_KV, 0)
		kv:set(MUST_PAY_KV, true)

		return true
	end

	return true
end

heatedWormPunisher:id(9201)
heatedWormPunisher:register()
