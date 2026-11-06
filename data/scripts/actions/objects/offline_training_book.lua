local offlineTrainingBook = Action()

function offlineTrainingBook.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local text = item:getAttribute(ITEM_ATTRIBUTE_TEXT)
	if text == "" then
		return false
	end
	player:showTextDialog(item.itemid, text)
	return true
end

offlineTrainingBook:id(11440, 11441, 11442)
offlineTrainingBook:register()
