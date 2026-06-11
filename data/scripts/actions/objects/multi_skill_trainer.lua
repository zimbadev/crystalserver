local multiSkillTrainer = Action()

function multiSkillTrainer.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not configManager.getBoolean(configKeys.ENABLE_OFFLINE_TRAINING) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Offline training is currently disabled.")
		return true
	end

	if not player:isPremium() then
		player:sendCancelMessage(RETURNVALUE_YOUNEEDPREMIUMACCOUNT)
		return true
	end

	if player:isPzLocked() then
		return false
	end

	player:sendMultiOfflineTrainingDialog()
	return true
end

multiSkillTrainer:id(52963)
multiSkillTrainer:register()
