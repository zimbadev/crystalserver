local textPositions = {
	Position(435, 432, 8),
	Position(436, 432, 8),
	Position(437, 432, 8),
}

local rewardRoomText = MoveEvent()

function rewardRoomText.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player or player:getStorageValue(Storage.Quest.U8_0.TheInquisitionQuest.RewardRoomText) == 1 then
		return true
	end

	player:setStorageValue(Storage.Quest.U8_0.TheInquisitionQuest.RewardRoomText, 1)
	player:say("You can choose exactly one of these chests. Choose wisely!", TALKTYPE_MONSTER_SAY)
	return true
end

for _, pos in ipairs(textPositions) do
	rewardRoomText:position(pos)
end

rewardRoomText:register()