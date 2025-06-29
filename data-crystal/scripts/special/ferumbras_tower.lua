local actions = {
	[30001] = {
		action = "removeStone",
		stonePos = Position(656, 569, 7),
		stoneId = 1791,
	},
	[30002] = {
		action = "removeStone",
		stonePos = Position(655, 569, 7),
		stoneId = 1791,
	},
	[30003] = {
		action = "removeStone",
		stonePos = Position(633, 549, 7),
		stoneId = 1791,
	},
	[30004] = {
		action = "createStairs",
		stairsPos = Position(643, 542, 8),
		stairsId = 1947,
	},
}

local lever = Action()

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local cfg = actions[item.uid]
	if not cfg then
		player:sendCancelMessage("This lever does nothing.")
		return true
	end

	if cfg.action == "removeStone" then
		local tile = Tile(cfg.stonePos)
		if tile then
			local stone = tile:getItemById(cfg.stoneId)
			if stone then
				Position(cfg.stonePos):sendMagicEffect(CONST_ME_EXPLOSIONAREA)
				stone:remove()
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The stone has been removed.")
			else
				player:sendCancelMessage("The stone is already gone.")
			end
		end
	elseif cfg.action == "createStairs" then
		local tile = Tile(cfg.stairsPos)
		if tile and not tile:getItemById(cfg.stairsId) then
			Game.createItem(cfg.stairsId, 1, cfg.stairsPos)
			Position(cfg.stairsPos):sendMagicEffect(CONST_ME_MAGIC_RED)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Stairs have appeared.")
		else
			player:sendCancelMessage("Stairs already exist.")
		end
	end

	item:transform(item.itemid == 2772 and 2773 or 2772)
	return true
end

-- Rejestracja dźwigni
lever:uid(30001)
lever:uid(30002)
lever:uid(30003)
lever:uid(30004)
lever:register()
