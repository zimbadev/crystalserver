local lordRetroDeath = CreatureEvent("LordRetroMonsterDeath")

function lordRetroDeath.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(_, player)
		local hasMaleFormal = player:hasOutfit(1460)
		local hasFemaleFormal = player:hasOutfit(1461)

		if not hasMaleFormal then
			player:addOutfit(1460)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked the Formal Dress outfit.")
		end

		if not hasFemaleFormal then
			player:addOutfit(1461)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked the Formal Dress outfit.")
		end
	end)
	return true
end

lordRetroDeath:register()
