local ANCIENT_ENEMY_MISSION = Storage.Quest.U15_24.Targuna.AncientEnemy.Mission
local LIZARD_COMMANDER_KILLED = Storage.Quest.U15_24.Targuna.AncientEnemy.LizardCommanderKilled

local lizardCommanderKill = CreatureEvent("TargunaLizardCommanderDeath")

function lizardCommanderKill.onDeath(creature, _corpse, _lastHitKiller, mostDamageKiller)
	onDeathForParty(creature, mostDamageKiller, function(_creature, player)
		if player:getStorageValue(ANCIENT_ENEMY_MISSION) == 2 and player:getStorageValue(LIZARD_COMMANDER_KILLED) ~= 1 then
			player:setStorageValue(LIZARD_COMMANDER_KILLED, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have defeated the Lizard Commander! Report back to Lizzie on Targuna.")
		end
	end)
	return true
end

lizardCommanderKill:register()
