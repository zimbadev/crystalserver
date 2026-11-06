local autohealing = TalkAction("!autohealing")
local HEALING_STORAGE = 65003
local HEALING_THRESHOLD_STORAGE = 65004

function autohealing.onSay(player, words, param)
	if not player then
		return true
	end

	-- vocation gate: base id 0 = no vocation (rookgaard)
	if player:getVocation():getBaseId() == 0 then
		player:sendCancelMessage("Only characters with a vocation can use auto-healing.")
		return true
	end

	param = param:lower()

	if param == "" then
		local currentThreshold = player:getStorageValue(HEALING_THRESHOLD_STORAGE)
		local thresholdText = (currentThreshold > 0) and (currentThreshold .. "%") or "20% (default)"
		local status = (player:getStorageValue(HEALING_STORAGE) == 1) and "ENABLED" or "DISABLED"
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Auto Healing: " .. status .. ". Casting spells at: " .. thresholdText .. " health.")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Usage: !autohealing on/off [number]. Example: '!autohealing on 20' (casts at 20%)")
		return true
	end

	local params = param:split(" ")
	local action = params[1]
	local thresholdParam = params[2]

	if thresholdParam and tonumber(thresholdParam) == nil then
		player:sendCancelMessage("Invalid number '" .. thresholdParam .. "'. Please use a number from 1 to 99.")
		return true
	end

	local threshold = tonumber(thresholdParam)

	if action == "on" then
		if threshold then
			if threshold >= 1 and threshold <= 99 then
				player:setStorageValue(HEALING_THRESHOLD_STORAGE, threshold)
			else
				player:sendCancelMessage("Invalid number. Choose a number from 1 to 99. Example: '!autohealing on 20'")
				return true
			end
		end

		player:setStorageValue(HEALING_STORAGE, 1)
		player:registerEvent("AutoHealHealthChange")
		player:registerEvent("AutoHealLogout")

		local currentThreshold = player:getStorageValue(HEALING_THRESHOLD_STORAGE)
		local thresholdText = (currentThreshold > 0) and (currentThreshold .. "%") or "20% (default)"
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Auto Healing ENABLED. Casting spells at " .. thresholdText .. " health.")
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	elseif action == "off" then
		player:setStorageValue(HEALING_STORAGE, 0)
		player:unregisterEvent("AutoHealHealthChange")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Auto Healing DISABLED.")
		player:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
	else
		player:sendCancelMessage("Invalid parameter. Usage: !autohealing on/off [number]. Example: '!autohealing on 20'")
	end

	return true
end

autohealing:separator(" ")
autohealing:groupType("normal")
autohealing:register()
