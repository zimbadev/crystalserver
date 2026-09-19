local rottenBloodLogin = CreatureEvent("RottenBloodLogin")

function rottenBloodLogin.onLogin(player)
	local kv = player:kv():scoped("rotten-blood-quest")
	local taintLevel = kv:get("taints") or 0

	if taintLevel > 0 and taintLevel <= 9 then
		local currentCondition = player:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)

		if currentCondition then
			local currentSubId = currentCondition:getParameter(CONDITION_PARAM_SUBID) or 0
			if currentSubId == taintLevel then
				return true
			end
			player:removeCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
		end

		local condition = Condition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
		condition:setParameter(CONDITION_PARAM_SUBID, taintLevel)
		condition:setParameter(CONDITION_PARAM_TICKS, 7 * 24 * 60 * 60 * 1000)
		player:addCondition(condition)

		logger.debug("Rotten Blood Login: Applied taint {} condition to player {}", taintLevel, player:getName())
	end

	return true
end

rottenBloodLogin:register()
