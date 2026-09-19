local SHRINE_ITEM_ID = 50242
local SHRINE_POS = Position(31931, 31866, 7)

local actions_three_fold_path_shrine_targuna = Action()

function actions_three_fold_path_shrine_targuna.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getId() ~= SHRINE_ITEM_ID or item:getPosition() ~= SHRINE_POS then
		return false
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Three-Fold Path dictates the order of the shrines to visit and when to do this. This is either not the time for this shrine or you are not yet experienced enough to prepare yourself for the gifts of the Merudri.")
	return true
end

actions_three_fold_path_shrine_targuna:position({ x = 31931, y = 31866, z = 7 })
actions_three_fold_path_shrine_targuna:register()
