local questlog = {
	{
		bossName = "Faceless Bane",
		storageQuestline = Storage.Quest.U12_00.TheDreamCourts.HauntedHouse.Questline,
		storageTimer = Storage.Quest.U12_00.TheDreamCourts.BurriedCatedralGlobal.FacelessTimer,
		maxValue = 4,
	},
	{
		bossName = "Maxxenius",
		storageQuestline = Storage.Quest.U12_00.TheDreamCourts.DreamScar.BossCount,
		storageTimer = Storage.Quest.U12_00.TheDreamCourts.DreamScarGlobal.MaxxeniusTimer,
		maxValue = 5,
	},
	{
		bossName = "Alptramun",
		storageQuestline = Storage.Quest.U12_00.TheDreamCourts.DreamScar.BossCount,
		storageTimer = Storage.Quest.U12_00.TheDreamCourts.DreamScarGlobal.AlptramunTimer,
		maxValue = 5,
	},
	{
		bossName = "Izcandar the Banished",
		storageQuestline = Storage.Quest.U12_00.TheDreamCourts.DreamScar.BossCount,
		storageTimer = Storage.Quest.U12_00.TheDreamCourts.DreamScarGlobal.IzcandarTimer,
		maxValue = 5,
	},
	{
		bossName = "Izcandar Champion of Winter",
		storageQuestline = Storage.Quest.U12_00.TheDreamCourts.DreamScar.BossCount,
		storageTimer = Storage.Quest.U12_00.TheDreamCourts.DreamScarGlobal.IzcandarTimer,
		maxValue = 5,
	},
	{
		bossName = "Izcandar Champion of Summer",
		storageQuestline = Storage.Quest.U12_00.TheDreamCourts.DreamScar.BossCount,
		storageTimer = Storage.Quest.U12_00.TheDreamCourts.DreamScarGlobal.IzcandarTimer,
		maxValue = 5,
	},
	{
		bossName = "Plagueroot",
		storageQuestline = Storage.Quest.U12_00.TheDreamCourts.DreamScar.BossCount,
		storageTimer = Storage.Quest.U12_00.TheDreamCourts.DreamScarGlobal.PlagueRootTimer,
		maxValue = 5,
	},
	{
		bossName = "Malofur Mangrinder",
		storageQuestline = Storage.Quest.U12_00.TheDreamCourts.DreamScar.BossCount,
		storageTimer = Storage.Quest.U12_00.TheDreamCourts.DreamScarGlobal.MalofurTimer,
		maxValue = 5,
	},
	{
		bossName = "The Nightmare Beast",
		storageQuestline = Storage.Quest.U12_00.TheDreamCourts.WardStones.Questline,
		storageTimer = Storage.Quest.U12_00.TheDreamCourts.DreamScar.NightmareTimer,
		maxValue = 2,
	},
}

local alptramunSummons = {
	{ name = "unpleasant dream", minValue = 0, maxValue = 9 },
	{ name = "horrible dream", minValue = 9, maxValue = 18 },
	{ name = "nightmarish dream", minValue = 18, maxValue = 27 },
	{ name = "mind-wrecking dream", minValue = 27, maxValue = 36 },
}

local dreamCourtsDeath = CreatureEvent("dreamCourtsDeath")

function dreamCourtsDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified)
	if not creature:isMonster() or creature:getMaster() then
		return true
	end

	local cName = creature:getName()

	onDeathForDamagingPlayers(creature, function(_, player)
		if cName:lower() == "the nightmare beast" then
			if not player:hasOutfit(1146) or not player:hasOutfit(1147) then
				player:addOutfit(1146)
				player:addOutfit(1147)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You have won a Dream Warrior Outfit.")
			end
		end
	end)

	if cName:lower() == "plant abomination" then
		Game.createMonster("Plant Attendant", creature:getPosition())
	end

	for _, boss in ipairs(questlog) do
		if cName == boss.bossName then
			for pid, _ in pairs(creature:getDamageMap()) do
				local attackerPlayer = Player(pid)
				if attackerPlayer then
					local questlineValue = attackerPlayer:getStorageValue(boss.storageQuestline)
					if questlineValue <= boss.maxValue then
						attackerPlayer:setStorageValue(boss.storageQuestline, questlineValue + 1)
					end
					attackerPlayer:setStorageValue(boss.storageTimer, os.time() + 20 * 60 * 60)
				end
			end

			if cName:lower() == "alptramun" then
				Game.setStorageValue(Storage.Quest.U12_00.TheDreamCourts.DreamScarGlobal.AlptramunSummonsKilled, 0)
			end
		end
	end

	local summonsKilled = Game.getStorageValue(Storage.Quest.U12_00.TheDreamCourts.DreamScarGlobal.AlptramunSummonsKilled)
	for _, summon in ipairs(alptramunSummons) do
		if cName:lower() == summon.name then
			if summonsKilled >= summon.minValue and summonsKilled <= summon.maxValue then
				Game.setStorageValue(Storage.Quest.U12_00.TheDreamCourts.DreamScarGlobal.AlptramunSummonsKilled, summonsKilled + 1)
			end
		end
	end

	return true
end

dreamCourtsDeath:register()
