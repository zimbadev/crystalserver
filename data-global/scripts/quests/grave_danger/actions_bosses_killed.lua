local bosses = {
	["sir baeloc"] = { storage = Storage.Quest.U12_20.GraveDanger.Bosses.BaelocNictrosKilled },
	["count vlarkorth"] = { storage = Storage.Quest.U12_20.GraveDanger.Bosses.CountVlarkorthKilled },
	["duke krule"] = { storage = Storage.Quest.U12_20.GraveDanger.Bosses.DukeKruleKilled },
	["earl osam"] = { storage = Storage.Quest.U12_20.GraveDanger.Bosses.EarlOsamKilled },
	["lord azaram"] = { storage = Storage.Quest.U12_20.GraveDanger.Bosses.LordAzaramKilled },
	["king zelos"] = { storage = Storage.Quest.U12_20.GraveDanger.Bosses.KingZelosKilled },
}

local bossesGraveDanger = CreatureEvent("GraveDangerBossDeath")
function bossesGraveDanger.onDeath(creature)
	local bossConfig = bosses[creature:getName():lower()]
	if not bossConfig then
		return true
	end
	onDeathForDamagingPlayers(creature, function(creature, player)
		if bossConfig.storage then
			player:setStorageValue(bossConfig.storage, 1)
		end
		-- each boss marks its grave in the quest log; with all 5 the mission goes to 2 and Jack Springer
		-- opens King Zelos' door (grave_danger_access.lua). The door is no longer given here.
		if GraveDangerGraves then
			GraveDangerGraves.refresh(player)
		end
	end)
	return true
end

bossesGraveDanger:register()
