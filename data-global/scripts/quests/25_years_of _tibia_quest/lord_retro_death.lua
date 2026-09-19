local lordRetroDeath = CreatureEvent("LordRetroMonsterDeath")

function lordRetroDeath.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(_, player)
		local hasOutfit = player:hasOutfit(1460) and player:hasOutfit(1461)

		if not hasOutfit then
			player:addOutfit(1460)
			player:addOutfit(1461)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked the Formal Dress outfit.")
		end
	end)
	return true
end

lordRetroDeath:register()
