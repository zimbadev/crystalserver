local communicates = {
	"Welcome to Crystal Server! Visit the organization to see all our work: https://crystalsever.vercel.app",
	"Did you like it? Help support what we do here with a donation by visiting the link: https://crystalsever.vercel.app/donate",
	"Visit our discord to ask questions or report issues: https://discord.gg/7AYJEHTghQ",
}

local scriptConfig = {
	itemId = 19236,
	registerPositions = {
		{ x = 350, y = 642, z = 6 },
	},
}

local worldBoard = Action()

function worldBoard.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- If the item id is not the one on the worldboard, it will return here
	if item:getId() ~= scriptConfig.itemId then
		return false
	end

	for index, value in pairs(communicates) do
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, value)
	end
	return true
end

-- Usage: action:position(position, itemId)
-- Explanation: The variable "item id" is optional, the id or the name of the item can be added, the item will be created in the map if it does not exist. If it already exists on the map, it will send a warning informing (in the distro) so the id must be removed so that the warning disappears keeping only the position)
for index, value in pairs(scriptConfig.registerPositions) do
	worldBoard:position(value, scriptConfig.itemId)
end

worldBoard:register()
