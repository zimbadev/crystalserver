-- =====================================================================
-- ROTTEN BLOOD LOGIN - ULTRA SIMPLIFIED
-- =====================================================================
-- PURPOSE: Apply taint CONDITION on login (for server tracking)
-- NOTE: Icon updates are handled by rotten_area_timer.lua (every 8s)
--       when player is INSIDE Rotten Blood zones
-- =====================================================================

local rottenBloodLogin = CreatureEvent("RottenBloodLogin")

function rottenBloodLogin.onLogin(player)
	-- Get taint level from KV storage (set by boss deaths)
	local kv = player:kv():scoped("rotten-blood-quest")
	local taintLevel = kv:get("taints") or 0

	-- Only process if player has taint (1-9)
	if taintLevel > 0 and taintLevel <= 9 then
		local currentCondition = player:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)

		-- Check if player already has correct condition
		if currentCondition then
			local currentSubId = currentCondition:getParameter(CONDITION_PARAM_SUBID) or 0
			if currentSubId == taintLevel then
				-- Condition is correct, nothing to do
				return true
			end
			-- Wrong taint level, remove and re-apply
			player:removeCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
		end

		-- Apply taint condition (icons will be shown by rotten_area_timer.lua when in zone)
		local condition = Condition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
		condition:setParameter(CONDITION_PARAM_SUBID, taintLevel)
		condition:setParameter(CONDITION_PARAM_TICKS, 7 * 24 * 60 * 60 * 1000) -- 7 days duration
		player:addCondition(condition)

		logger.debug("Rotten Blood Login: Applied taint {} condition to player {}", taintLevel, player:getName())
	end

	return true
end

rottenBloodLogin:register()
