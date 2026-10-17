local theApeMiss9 = Action()

local GLOBAL_AMPHORAS_OPEN = 101026
local GLOBAL_AMPHORAS_BROKEN = 101027
local cooldownTime = 5 * 60

local amphoraUids = { 40092, 40093, 40094, 40095 }
local amphoraSet = {}
for _, uid in ipairs(amphoraUids) do
	amphoraSet[uid] = true
end

local brokenAmphoras = {}

local function countBroken()
	local n = 0
	for _ in pairs(brokenAmphoras) do
		n = n + 1
	end
	return n
end

function theApeMiss9.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local uid = target:getUniqueId()
	local itemId = target.itemid

	if amphoraSet[uid] and itemId == 4995 then
		if player:getStorageValue(Storage.Quest.U7_6.TheApeCity.Questline) < 17 then
			return false
		end

		target:transform(4996)
		toPosition:sendMagicEffect(CONST_ME_POFF)

		brokenAmphoras[uid] = true
		if countBroken() >= #amphoraUids then
			Game.setStorageValue(GLOBAL_AMPHORAS_OPEN, os.time() + cooldownTime)
			brokenAmphoras = {}
		end
		return true
	end

	local specificPosition = Position(32858, 32526, 11)
	if itemId == 4850 and toPosition == specificPosition then
		if player:getStorageValue(Storage.Quest.U7_6.TheApeCity.Questline) ~= 17 then
			return false
		end

		if player:getStorageValue(Storage.Quest.U7_6.TheApeCity.SnakeDestroyer) == 1 then
			return false
		end

		player:setStorageValue(Storage.Quest.U7_6.TheApeCity.SnakeDestroyer, 1)
		item:remove()
		target:transform(4851)
		target:decay()
		toPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	end

	return false
end

theApeMiss9:id(4835)
theApeMiss9:register()
