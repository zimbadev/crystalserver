-- Rotten Blood Hazard Icon System - Login Event
-- Cleans up all rotten blood icons on login

local rottenTaintGain = CreatureEvent("RottenTaintGain")

function rottenTaintGain.onLogin(player)
	if not player or not player:isPlayer() then
		return true
	end

	-- Clean up all rotten blood related icons on login
	player:removeIcon("rotten-hazard")
	player:removeIcon("rotten-area")
	player:removeIcon("white-cross")

	logger.debug("Player Login: Cleaned up all rotten blood icons from player {}", player:getName())

	-- Update hazard icon after a delay if player is in rotten area
	addEvent(function()
		if player and player:isPlayer() then
			if updateRottenHazardIcon then
				updateRottenHazardIcon(player)
			end
		end
	end, 2000) -- 2 seconds delay to ensure cleanup is processed first

	return true
end

rottenTaintGain:register()
