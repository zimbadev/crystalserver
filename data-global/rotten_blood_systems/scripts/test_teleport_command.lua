local RottenBloodMechanics = dofile(DATA_DIRECTORY .. "/scripts/quests/rotten_blood_quest/rotten_blood_boss_mechanics.lua")

local testTeleport = TalkAction("/testteleport")

function testTeleport.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local bossName = param:trim()
	if bossName == "" then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Usage: /testteleport <bossname>")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Available bosses: Vemiath, Chagorz, Murcion, Ichgahal, Bakragore")
		return false
	end

	-- Verificar que el boss existe en la configuración
	local validBosses = { "Vemiath", "Chagorz", "Murcion", "Ichgahal", "Bakragore" }
	local found = false
	for _, boss in ipairs(validBosses) do
		if boss:lower() == bossName:lower() then
			bossName = boss
			found = true
			break
		end
	end

	if not found then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Invalid boss name. Available: Vemiath, Chagorz, Murcion, Ichgahal, Bakragore")
		return false
	end

	-- Crear teleport de prueba
	local config = {
		["Vemiath"] = { centerPos = Position(33043, 32335, 15) },
		["Chagorz"] = { centerPos = Position(33043, 32366, 15) },
		["Murcion"] = { centerPos = Position(33008, 32367, 15) },
		["Ichgahal"] = { centerPos = Position(33008, 32334, 15) },
		["Bakragore"] = { centerPos = Position(33043, 32397, 15) },
	}

	local centerPos = config[bossName].centerPos

	-- Crear teleport
	local teleport = Game.createItem(37000, 1, centerPos)
	if teleport then
		teleport:setActionId(50001) -- Asignar ActionId para el MoveEvent
		centerPos:sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Teleport created for " .. bossName .. " at " .. centerPos.x .. "," .. centerPos.y .. "," .. centerPos.z)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Item ID: " .. teleport.itemid .. ", ActionId: " .. teleport:getActionId())

		-- Programar eliminación después de 15 segundos
		addEvent(function()
			local tile = Tile(centerPos)
			if tile then
				local item = tile:getItemById(37000)
				if item then
					item:remove()
				end
			end
		end, 15000)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Failed to create teleport for " .. bossName)
	end

	return false
end

testTeleport:separator(" ")
testTeleport:groupType("god")
testTeleport:register()
