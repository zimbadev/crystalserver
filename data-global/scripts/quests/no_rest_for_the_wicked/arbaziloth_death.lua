local arbazilothOnDeath = CreatureEvent("azzilonCastleArbazilothOnDeath")

function arbazilothOnDeath.onDeath(creature)
	local bossName = creature:getName():lower()
	if bossName ~= "arbaziloth" and bossName ~= "weakened arbaziloth" then
		return false
	end
	Game.setStorageValue("globalArbazilothHeal", 0)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.ForgemasterDoor.Questline) >= 2 then
			return false
		end
		local currentStorage = player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.KillArbaziloth.Questline)
		if currentStorage == 1 then
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.KillArbaziloth.Questline, 2)
			if not player:hasOutfit(1809) or not player:hasOutfit(1808) then
				player:addOutfit(1809)
				player:addOutfit(1808)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have defeated Arbaziloth for the first time. You have won the Fiend Slayer Outfit")
			end
		elseif currentStorage >= 2 and currentStorage < 9 then
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.KillArbaziloth.Questline, currentStorage + 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have defeated Arbaziloth " .. (currentStorage + 1) .. " times.")
		elseif currentStorage == 9 then
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.KillArbaziloth.Questline, 10)
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.ForgemasterDoor.Questline, 2)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You have defeated Arbaziloth 10 times. Ask for a KEY to The Forgemaster.")
		end
	end)

	return true
end

arbazilothOnDeath:register()
