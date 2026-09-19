local rottenTaintGain = CreatureEvent("RottenTaintGain")

function rottenTaintGain.onLogin(player)
	if not player or not player:isPlayer() then
		return true
	end

	player:removeIcon("rotten-hazard")
	player:removeIcon("rotten-area")
	player:removeIcon("white-cross")

	logger.debug("Player Login: Cleaned up all rotten blood icons from player {}", player:getName())

	addEvent(function()
		if player and player:isPlayer() then
			if updateRottenHazardIcon then
				updateRottenHazardIcon(player)
			end
		end
	end, 2000)

	return true
end

rottenTaintGain:register()
