if not _G.TrainingStaminaGiven then
	_G.TrainingStaminaGiven = {}
end

local trainingStamina = CreatureEvent("TrainingStamina")

function trainingStamina.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not attacker or not attacker:isPlayer() then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	if creature:getName() ~= staminaBonus.target then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	if not configManager.getBoolean(configKeys.STAMINA_TRAINER) then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	local player = attacker
	local playerId = player:getId()

	if _G.TrainingStaminaGiven[playerId] then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	local currentStamina = player:getStamina()

	if currentStamina < 2520 then
		player:setStamina(currentStamina + staminaBonus.bonus)
		player:sendTextMessage(MESSAGE_FAILURE, string.format("%i of stamina has been refilled.", staminaBonus.bonus))
		_G.TrainingStaminaGiven[playerId] = true
	end

	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

trainingStamina:register()
