local config = {
	[39511] = {
		fromPosition = Position(484, 240, 14),
		toPosition = Position(484, 239, 14),
	},
	[39512] = {
		teleportPlayer = true,
		fromPosition = Position(484, 240, 14),
		toPosition = Position(457, 240, 13),
	},
}

local pitsOfInfernoBlackMirror = Action()
function pitsOfInfernoBlackMirror.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local useItem = config[item.actionid]
	if not useItem then
		return true
	end

	if useItem.teleportPlayer then
		player:teleportTo(Position(485, 240, 13))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("Beauty has to be rewarded! Muahahaha!", TALKTYPE_MONSTER_SAY)
	end

	local tapestry = Tile(useItem.fromPosition):getItemById(6433)
	if tapestry then
		tapestry:moveTo(useItem.toPosition)
	end
	return true
end

pitsOfInfernoBlackMirror:aid(39511, 39512)
pitsOfInfernoBlackMirror:register()
