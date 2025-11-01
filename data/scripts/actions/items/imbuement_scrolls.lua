local imbuementScrolls = Action()

function imbuementScrolls.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target or type(target) ~= "userdata" or not target:isItem() then
		return false
	end

	player:applyImbuementScrollToItem(item.itemid, target)
	return true
end

imbuementScrolls:id(51444, 51445, 51446, 51447, 51448, 51449, 51450, 51451, 51452, 51453, 51454, 51455, 51456, 51457, 51458, 51459, 51460, 51461, 51462, 51463, 51464, 51465, 51466, 51467, 51724, 51725, 51726, 51727, 51728, 51729, 51730, 51731, 51732, 51733, 51734, 51735, 51736, 51737, 51738, 51739, 51740, 51741, 51742, 51743, 51744, 51745, 51746, 51747)
imbuementScrolls:register()
