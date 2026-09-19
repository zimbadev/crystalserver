local rottinWoodCorpse = Action()

local function getCorpseCount(player)
	local ok, value = pcall(function()
		return player:kv():get("rottinwood-corpsecount")
	end)
	return ok and (tonumber(value) or 0) or 0
end

function rottinWoodCorpse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid ~= 12189 then
		return false
	end

	local S = Storage.Quest.U8_7.RottinWoodAndTheMarriedMen
	if player:getStorageValue(S.Mission03) ~= 1 then
		return true
	end

	local corpseCount = getCorpseCount(player)
	if corpseCount < 5 then
		player:say("You take no more gold than you actually need and release the merchant who makes away the very second you remove the ropes.", TALKTYPE_MONSTER_SAY)
		player:kv():set("rottinwood-corpsecount", corpseCount + 1)
		player:addMoney(100)
		fromPosition:sendMagicEffect(CONST_ME_SMALLPLANTS)
		item:remove(1)

		local missionValue = player:getStorageValue(S.Mission03)
		player:updateStorage(S.Mission03, missionValue, missionValue, os.time())
	end

	return true
end

rottinWoodCorpse:id(12189)
rottinWoodCorpse:register()
