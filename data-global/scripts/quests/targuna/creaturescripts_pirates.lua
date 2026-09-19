-- A long lost treasure: Aragonia pirate kill counter (any of the 5 types counts)
local TREASURE_MISSION = Storage.Quest.U15_24.Targuna.LongLostTreasure.Mission
local PIRATE_KILL_COUNT = Storage.Quest.U15_24.Targuna.LongLostTreasure.PirateKillCount

local PIRATES_REQUIRED = 20

local pirateKill = CreatureEvent("TargunaPirateDeath")

function pirateKill.onDeath(creature, _corpse, _lastHitKiller, mostDamageKiller)
	onDeathForParty(creature, mostDamageKiller, function(_creature, player)
		if player:getStorageValue(TREASURE_MISSION) ~= 2 then
			return
		end

		local count = math.max(player:getStorageValue(PIRATE_KILL_COUNT), 0)
		if count >= PIRATES_REQUIRED then
			return
		end

		count = count + 1
		player:setStorageValue(PIRATE_KILL_COUNT, count)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Pirate slain. (%d/%d)", count, PIRATES_REQUIRED))
	end)
	return true
end

pirateKill:register()
