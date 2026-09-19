-- A Piece of Cake - Eating Window

local cakeEatingWindow = GlobalEvent("CakeQuestEatingWindow")

local function restoreEatingFloor(bitCount)
	for i = 1, bitCount do
		local key = "removedTile:" .. i
		local tile = CakeQuest.KV:get(key)
		if tile then
			Game.createItem(tile.id, 1, Position(tile.x, tile.y, tile.z))
		end
	end
end

local function finishGroundFloor()
	CakeQuest.set(CakeQuest.Keys.EatingWindowActive, false)
	CakeQuest.setStage(3)
	CakeQuest.set(CakeQuest.Keys.PendingBrutusBonus, true)
end

local LAYER_EATEN_MESSAGES = {
	[1] = "One layer of the cake tower has been eaten!",
	[2] = "Two layer of the cake tower has been eaten!",
	[3] = "Three layer of the cake tower has been eaten!",
	[4] = "All layers of the cake tower have been eaten!",
}

function cakeEatingWindow.onThink(interval)
	if CakeQuest.getStage() ~= 2 then
		return true
	end

	local active = CakeQuest.get(CakeQuest.Keys.EatingWindowActive, false)
	if not active then
		return true
	end

	local layer = CakeQuest.get(CakeQuest.Keys.CurrentLayer, 1)
	if layer < 1 then
		layer = 1
	end

	local progress = CakeQuest.get(CakeQuest.Keys.LayerProgress, 0)
	local goalReached = progress >= CakeQuest.Config.BITES_REQUIRED_PER_LAYER
	local timeUp = os.time() >= CakeQuest.get(CakeQuest.Keys.EatingWindowEndsAt, 0)

	if not goalReached and not timeUp then
		return true
	end

	CakeQuest.set(CakeQuest.Keys.EatingWindowActive, false)

	if not goalReached then
		restoreEatingFloor(progress)
		Game.broadcastMessage(("Time's up! Only %d/%d bites were taken. The cake pieces grow back on the ground floor - try again!"):format(progress, CakeQuest.Config.BITES_REQUIRED_PER_LAYER), MESSAGE_EVENT_ADVANCE)
		return true
	end

	local floorToRemove = CakeQuest.Config.LayerFloors[layer]
	local isFinalRound = (floorToRemove == CakeQuest.Config.EatingFloorZ)

	if isFinalRound then
		Game.broadcastMessage(LAYER_EATEN_MESSAGES[layer] .. " You can now step where the cake was and start extracting your mark at each city's machine.", MESSAGE_EVENT_ADVANCE)
		finishGroundFloor()
		return true
	end

	Game.broadcastMessage(LAYER_EATEN_MESSAGES[layer], MESSAGE_EVENT_ADVANCE)
	CakeQuest.removeFloorBulk(floorToRemove)
	restoreEatingFloor(progress)
	CakeQuest.set(CakeQuest.Keys.CurrentLayer, layer + 1)

	return true
end

cakeEatingWindow:interval(60 * 1000) -- 1 min check
cakeEatingWindow:register()
