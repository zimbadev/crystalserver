local TREASURE_MISSION = Storage.Quest.U15_24.Targuna.LongLostTreasure.Mission
local TORTOISE_EGG_COUNT = Storage.Quest.U15_24.Targuna.LongLostTreasure.TortoiseEggCount

local TORTOISE_EGG_ID = 5678
local EGGS_REQUIRED = 10

local eggPositions = {
	{ x = 33485, y = 32695, z = 8 },
	{ x = 33490, y = 32692, z = 8 },
	{ x = 33515, y = 32691, z = 8 },
	{ x = 33518, y = 32690, z = 7 },
	{ x = 33508, y = 32695, z = 8 },
	{ x = 33507, y = 32703, z = 7 },
	{ x = 33522, y = 32695, z = 8 },
	{ x = 33520, y = 32696, z = 7 },
	{ x = 33481, y = 32704, z = 8 },
	{ x = 33482, y = 32711, z = 8 },
	{ x = 33495, y = 32709, z = 7 },
	{ x = 33494, y = 32711, z = 8 },
	{ x = 33494, y = 32717, z = 7 },
	{ x = 33511, y = 32710, z = 8 },
	{ x = 33512, y = 32709, z = 7 },
	{ x = 33513, y = 32710, z = 7 },
	{ x = 33510, y = 32716, z = 7 },
	{ x = 33520, y = 32707, z = 8 },
	{ x = 33528, y = 32707, z = 8 },
	{ x = 33534, y = 32710, z = 7 },
	{ x = 33527, y = 32718, z = 7 },
	{ x = 33534, y = 32718, z = 7 },
	{ x = 33532, y = 32719, z = 8 },
	{ x = 33482, y = 32729, z = 7 },
	{ x = 33481, y = 32732, z = 7 },
	{ x = 33489, y = 32721, z = 7 },
	{ x = 33496, y = 32722, z = 8 },
	{ x = 33495, y = 32727, z = 7 },
	{ x = 33493, y = 32726, z = 8 },
	{ x = 33516, y = 32721, z = 7 },
	{ x = 33512, y = 32734, z = 7 },
	{ x = 33527, y = 32727, z = 8 },
	{ x = 33530, y = 32732, z = 7 },
	{ x = 33532, y = 32735, z = 8 },
	{ x = 33533, y = 32732, z = 8 },
	{ x = 33534, y = 32737, z = 7 },
	{ x = 33521, y = 32741, z = 7 },
	{ x = 33537, y = 32696, z = 8 },
	{ x = 33543, y = 32698, z = 8 },
	{ x = 33550, y = 32710, z = 7 },
	{ x = 33552, y = 32710, z = 7 },
	{ x = 33541, y = 32722, z = 7 },
	{ x = 33543, y = 32727, z = 7 },
	{ x = 33537, y = 32729, z = 8 },
	{ x = 33541, y = 32731, z = 8 },
	{ x = 33547, y = 32731, z = 8 },
}

local tortoiseEgg = Action()

function tortoiseEgg.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getId() ~= TORTOISE_EGG_ID then
		return false
	end

	if player:getStorageValue(TREASURE_MISSION) ~= 2 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Speak to Sterling or Morla before rescuing these eggs.")
		return true
	end

	local count = math.max(player:getStorageValue(TORTOISE_EGG_COUNT), 0)
	if count >= EGGS_REQUIRED then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already rescued enough turtle eggs. Bring them to Morla!")
		return true
	end

	count = count + 1
	player:setStorageValue(TORTOISE_EGG_COUNT, count)
	item:remove(1)
	fromPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You rescued a turtle egg. (%d/%d)", count, EGGS_REQUIRED))
	return true
end

for _, pos in ipairs(eggPositions) do
	tortoiseEgg:position(pos)
end
tortoiseEgg:register()
