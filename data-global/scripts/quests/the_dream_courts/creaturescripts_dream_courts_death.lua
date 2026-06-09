local bossStorages = {
	["plagueroot"] = {
		storage = Storage.Quest.U12_00.TheDreamCourts.PlaguerootKilled,
		timer = Storage.Quest.U12_00.TheDreamCourts.ArenaTimer,
	},
	["malofur mangrinder"] = {
		storage = Storage.Quest.U12_00.TheDreamCourts.MalofurKilled,
		timer = Storage.Quest.U12_00.TheDreamCourts.ArenaTimer,
	},
	["maxxenius"] = {
		storage = Storage.Quest.U12_00.TheDreamCourts.MaxxeniusKilled,
		timer = Storage.Quest.U12_00.TheDreamCourts.ArenaTimer,
	},
	["alptramun"] = {
		storage = Storage.Quest.U12_00.TheDreamCourts.AlptramunKilled,
		timer = Storage.Quest.U12_00.TheDreamCourts.ArenaTimer,
	},
	["izcandar the banished"] = {
		storage = Storage.Quest.U12_00.TheDreamCourts.IzcandarKilled,
		timer = Storage.Quest.U12_00.TheDreamCourts.ArenaTimer,
	},
	["the nightmare beast"] = {
		storage = Storage.Quest.U12_00.TheDreamCourts.NightmareBeastKilled,
		timer = Storage.Quest.U12_00.TheDreamCourts.NightmareBeastTimer,
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

	local cName = creature:getName():lower()

	onDeathForDamagingPlayers(creature, function(_, player)
		if cName == "the nightmare beast" then
			if not player:hasOutfit(1146) or not player:hasOutfit(1147) then
				player:addOutfit(1146)
				player:addOutfit(1147)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You have won a Dream Warrior Outfit.")
			end
		end
	end)

	if cName == "plant abomination" then
		Game.createMonster("Plant Attendant", creature:getPosition())
	end

	local bossConfig = bossStorages[cName]
	if bossConfig then
		onDeathForDamagingPlayers(creature, function(_, player)
			if bossConfig.storage then
				player:setStorageValue(bossConfig.storage, 1)
			end
			if bossConfig.timer then
				player:setStorageValue(bossConfig.timer, os.time() + 20 * 60 * 60)
			end
		end)

		if cName == "alptramun" then
			Game.setStorageValue(Storage.Quest.U12_00.TheDreamCourts.DreamScarGlobal.AlptramunSummonsKilled, 0)
		end
	end

	local summonsKilled = Game.getStorageValue(Storage.Quest.U12_00.TheDreamCourts.DreamScarGlobal.AlptramunSummonsKilled)
	for _, summon in ipairs(alptramunSummons) do
		if cName == summon.name then
			if summonsKilled >= summon.minValue and summonsKilled <= summon.maxValue then
				Game.setStorageValue(Storage.Quest.U12_00.TheDreamCourts.DreamScarGlobal.AlptramunSummonsKilled, summonsKilled + 1)
			end
		end
	end

	return true
end

dreamCourtsDeath:register()
