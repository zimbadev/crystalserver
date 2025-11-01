local etcher = Action()

function etcher.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target or type(target) ~= "userdata" or not target:isItem() then
		return false
	end

	player:onClearAllImbuementsOnEtcher(target)
	return true
end

etcher:id(51443)
etcher:register()
