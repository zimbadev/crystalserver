local energyPositions = {
	Position(33268, 31786, 11),
	Position(33269, 31786, 11),
	Position(33268, 31787, 11),
	Position(33269, 31787, 11),
	Position(33268, 31788, 11),
	Position(33269, 31788, 11),
	Position(33268, 31789, 11),
	Position(33269, 31789, 11),
}

local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar
local KV_SCOPE = "shadows-of-yalahar"
local KV_KEY = "mission12-lever"

local energyLever = Action()
function energyLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(ShadowsOfYalahar.Questline) ~= 22 then
		return true
	end

	local kv = player:kv():scoped(KV_SCOPE)
	if kv:get(KV_KEY) then
		player:sendCancelMessage("You have already used this lever.")
		return true
	end

	if item.itemid == 2772 then
		item:transform(2773)
		return true
	end

	for _, position in ipairs(energyPositions) do
		position:sendMagicEffect(CONST_ME_ENERGYHIT)
	end

	kv:set(KV_KEY, true)
	item:transform(2772)

	return true
end

energyLever:aid(57236)
energyLever:register()
