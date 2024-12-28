local swimmingLogout = CreatureEvent("SwimmingLogout")

function swimmingLogout.onLogout(player)
	if player:getOutfit().lookType == 267 then
		player:sendCancelMessage("You cannot logout while in the pool.")
		return false
	end

	return true
end

swimmingLogout:register()
