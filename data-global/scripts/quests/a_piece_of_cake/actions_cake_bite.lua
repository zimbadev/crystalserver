-- A Piece of Cake - Bite the cake at Cake Keep Isle

local cakeBite = Action()

function cakeBite.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if CakeQuest.getStage() ~= 2 then
		player:sendTextMessage(MESSAGE_FAILURE, "The cake isn't ready to be eaten right now.")
		return true
	end

	if not CakeQuest.get(CakeQuest.Keys.EatingWindowActive, false) then
		CakeQuest.openEatingWindow()
	end

	local itemPos = item:getPosition()
	if itemPos.z ~= CakeQuest.Config.EatingFloorZ then
		player:sendTextMessage(MESSAGE_FAILURE, "This part of the cake isn't the one being eaten right now.")
		return true
	end

	local windowStart = CakeQuest.get(CakeQuest.Keys.EatingWindowStartedAt, 0)
	local playerWindowStart = player:getStorageValue(CakeQuest.PlayerStorage.BitesWindowStart)
	if playerWindowStart ~= windowStart then
		player:setStorageValue(CakeQuest.PlayerStorage.BitesWindowStart, windowStart)
		player:setStorageValue(CakeQuest.PlayerStorage.BitesThisWindow, 0)
	end

	local now = os.time()
	local lastBite = player:getStorageValue(CakeQuest.PlayerStorage.LastBiteAt)
	if lastBite > 0 and (now - lastBite) < CakeQuest.Config.BITE_COOLDOWN_SECONDS then
		local wait = CakeQuest.Config.BITE_COOLDOWN_SECONDS - (now - lastBite)
		player:sendTextMessage(MESSAGE_FAILURE, ("You're too full! Wait %d more second(s) before taking another bite."):format(wait))
		return true
	end

	local bitesThisWindow = player:getStorageValue(CakeQuest.PlayerStorage.BitesThisWindow)
	bitesThisWindow = bitesThisWindow > 0 and bitesThisWindow or 0
	if bitesThisWindow >= CakeQuest.Config.MAX_BITES_PER_PLAYER_PER_WINDOW then
		player:sendTextMessage(MESSAGE_FAILURE, "You can't eat any more cake this window - you've had your fill! Wait for the next one.")
		return true
	end

	if not CakeQuest.isCakeEdibleId(item.itemid) then
		return true
	end

	player:setStorageValue(CakeQuest.PlayerStorage.LastBiteAt, now)
	player:setStorageValue(CakeQuest.PlayerStorage.BitesThisWindow, bitesThisWindow + 1)

	local progress = CakeQuest.get(CakeQuest.Keys.LayerProgress, 0) + 1

	CakeQuest.KV:set("removedTile:" .. progress, { x = itemPos.x, y = itemPos.y, z = itemPos.z, id = item.itemid })

	item:remove(1)
	CakeQuest.set(CakeQuest.Keys.LayerProgress, progress)

	player:say("Mmmm!", TALKTYPE_MONSTER_SAY)

	local goal = CakeQuest.Config.BITES_REQUIRED_PER_LAYER
	if progress % 100 == 0 or progress >= goal then
		Game.broadcastMessage(("A Piece of Cake: layer progress %d/%d!"):format(math.min(progress, goal), goal), MESSAGE_EVENT_ADVANCE)
	end

	return true
end

cakeBite:id(CakeQuest.Items.CakeEdibleIds[1], CakeQuest.Items.CakeEdibleIds[2])
cakeBite:register()
