local debugSpawn = TalkAction("/debugspawn")

function debugSpawn.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local centerPos = Position(33043, 32397, 15)

	-- Verificar GlobalStorage values
	local teleportPaused = Game.getStorageValue("BakragoreTeleportPaused")
	local spawnPaused = Game.getStorageValue("BakragoreElderBloodjawSpawnPaused")

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "=== BAKRAGORE SPAWN DEBUG ===")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "BakragoreTeleportPaused: " .. tostring(teleportPaused))
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "BakragoreElderBloodjawSpawnPaused: " .. tostring(spawnPaused))

	-- Verificar condición de spawn
	local shouldSpawn = (spawnPaused ~= 1)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Should spawn Elder Bloodjaw: " .. tostring(shouldSpawn))

	-- Verificar Elder Bloodjaw existentes
	local spectators = Game.getSpectators(centerPos, false, false, 20, 20, 20, 20)
	local elderBloodjawCount = 0
	local bakragoreAlive = false

	for _, creature in ipairs(spectators) do
		if creature:isMonster() then
			if creature:getName():lower() == "elder bloodjaw" then
				elderBloodjawCount = elderBloodjawCount + 1
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Elder Bloodjaw found at: " .. creature:getPosition():toString())
			elseif creature:getName() == "Bakragore" then
				bakragoreAlive = true
			end
		end
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Elder Bloodjaw count: " .. elderBloodjawCount)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bakragore alive: " .. tostring(bakragoreAlive))

	-- Simular cálculo de taint
	local maxTaint = 0
	local playerSpectators = Game.getSpectators(centerPos, false, true, 15, 15, 15, 15)

	for _, spectator in ipairs(playerSpectators) do
		if spectator:isPlayer() then
			local kv = spectator:kv():scoped("rotten-blood-quest")
			local currentTaintKV = kv:get("taints") or 0
			local currentTaintCondition = 0
			local taintCondition = spectator:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
			if taintCondition then
				currentTaintCondition = taintCondition:getParameter(CONDITION_PARAM_SUBID) or 0
			end
			local taintLevel = math.max(currentTaintKV, currentTaintCondition)
			if taintLevel > maxTaint then
				maxTaint = taintLevel
			end
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Player " .. spectator:getName() .. " taint: " .. taintLevel)
		end
	end

	local baseBloojaws = 2
	local extraBloodjaws = 0
	if maxTaint >= 5 then
		extraBloodjaws = extraBloodjaws + 1
	end
	if maxTaint >= 8 then
		extraBloodjaws = extraBloodjaws + 1
	end
	if maxTaint >= 9 then
		extraBloodjaws = extraBloodjaws + 1
	end
	local targetCount = math.min(baseBloojaws + extraBloodjaws, 5)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Max taint: " .. maxTaint)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Target Elder Bloodjaw count: " .. targetCount)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Should spawn: " .. math.max(0, targetCount - elderBloodjawCount) .. " more")

	return false
end

debugSpawn:separator(" ")
debugSpawn:groupType("god")
debugSpawn:register()
