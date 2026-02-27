local debugBakragore = TalkAction("/debugbakragore")

function debugBakragore.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local centerPos = Position(33043, 32397, 15)

	-- Verificar GlobalStorage values
	local teleportPaused = Game.getStorageValue("BakragoreTeleportPaused")
	local spawnPaused = Game.getStorageValue("BakragoreElderBloodjawSpawnPaused")

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "=== BAKRAGORE DEBUG STATUS ===")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "BakragoreTeleportPaused: " .. tostring(teleportPaused))
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "BakragoreElderBloodjawSpawnPaused: " .. tostring(spawnPaused))

	-- Verificar Elder Bloodjaw en la sala
	local spectators = Game.getSpectators(centerPos, false, false, 15, 15, 15, 15)
	local elderBloodjawCount = 0
	local bakragoreAlive = false

	for _, creature in ipairs(spectators) do
		if creature:isMonster() then
			if creature:getName():lower() == "elder bloodjaw" then
				elderBloodjawCount = elderBloodjawCount + 1
			elseif creature:getName() == "Bakragore" then
				bakragoreAlive = true
			end
		end
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Elder Bloodjaw count: " .. elderBloodjawCount)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bakragore alive: " .. tostring(bakragoreAlive))

	-- Verificar teleport
	local tile = Tile(centerPos)
	if tile then
		local teleport = tile:getItemById(37000)
		if teleport then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Teleport exists with ActionId: " .. tostring(teleport:getActionId()))
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "No teleport found at center")
		end
	end

	return false
end

debugBakragore:separator(" ")
debugBakragore:groupType("god")
debugBakragore:register()
