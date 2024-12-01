local regenerateStamina = CreatureEvent("RegenerateStamina")

function regenerateStamina.onLogin(player)
	if not configManager.getBoolean(configKeys.STAMINA_SYSTEM) then
		return true
	end

	local staminaRegained = 0
	local lastLogout = player:getLastLogout()
	local offlineTime = (lastLogout ~= 0) and math.min(os.time() - lastLogout, 86400 * 21) or 0
	offlineTime = offlineTime - 600

	if offlineTime < 180 then
		return true
	end

	local staminaMinutes = player:getStamina()
	local initialStamina = staminaMinutes
	local maxNormalStaminaRegen = 2340 - math.min(2340, staminaMinutes)
	local regainStaminaMinutes = offlineTime / configManager.getNumber(configKeys.STAMINA_REGEN_MINUTE)

	if regainStaminaMinutes > maxNormalStaminaRegen then
		local happyHourStaminaRegen = (offlineTime - (maxNormalStaminaRegen * 180)) / configManager.getNumber(configKeys.STAMINA_REGEN_PREMIUM)
		staminaMinutes = math.min(2520, math.max(2340, staminaMinutes) + happyHourStaminaRegen)
	else
		staminaMinutes = staminaMinutes + regainStaminaMinutes
	end

	player:setStamina(staminaMinutes)

	staminaRegained = math.floor(staminaMinutes - initialStamina)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have regenerated " .. staminaRegained .. " stamina minutes while you were offline.")

	return true
end

regenerateStamina:register()
