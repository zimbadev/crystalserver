local autoheal = TalkAction("!autopotion")
local STORAGE = 65000
local STORAGE_THRESHOLD = 65001

function autoheal.onSay(player, words, param)
	if not player then
		return true
	end

	-- vocation gate: base id 0 = no vocation (rookgaard)
	if player:getVocation():getBaseId() == 0 then
		player:sendCancelMessage("Only characters with a vocation can use auto-potion.")
		return true
	end

	param = param:lower()

	if param == "" then
		local currentThreshold = player:getStorageValue(STORAGE_THRESHOLD)
		local thresholdText = (currentThreshold > 0) and (currentThreshold .. "%") or "40% (default)"
		local status = (player:getStorageValue(STORAGE) == 1) and "ENABLED" or "DISABLED"
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Auto Potion: " .. status .. ". Drinking potions at: " .. thresholdText .. " health/mana.")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Usage: !autopotion on/off [number]. Example: '!autopotion on 40' (enabled at 40%)")
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
				player:setStorageValue(STORAGE_THRESHOLD, threshold)
			else
				player:sendCancelMessage("Invalid number. Choose a number from 1 to 99. Example: '!autopotion on 40'")
				return true
			end
		end

		player:setStorageValue(STORAGE, 1)
		player:registerEvent("AutoPotionHealthChange")
		player:registerEvent("AutoPotionManaChange")
		player:registerEvent("AutoPotionLogout")

		local currentThreshold = player:getStorageValue(STORAGE_THRESHOLD)
		local thresholdText = (currentThreshold > 0) and (currentThreshold .. "%") or "40% (default)"
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Auto-Potion ENABLED. Drinking potions at " .. thresholdText .. " health/mana.")
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	elseif action == "off" then
		player:setStorageValue(STORAGE, 0)
		player:unregisterEvent("AutoPotionHealthChange")
		player:unregisterEvent("AutoPotionManaChange")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Auto-Potion DISABLED.")
		player:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
	else
		player:sendCancelMessage("Invalid parameter. Usage: !autopotion on/off [number]. Example: '!autopotion on 40'")
	end

	return true
end

autoheal:separator(" ")
autoheal:groupType("normal")
autoheal:register()
