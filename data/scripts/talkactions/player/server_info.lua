local serverInfo = TalkAction("!serverinfo")

function serverInfo.onSay(player, words, param)
	local useStages = configManager.getBoolean(configKeys.RATE_USE_STAGES)
	local text = "Server Info Rates: \n"

	if useStages then
		local configRateSkill = configManager.getNumber(configKeys.RATE_SKILL)
		local skills = {
			{ name = "Sword Skill Stages", skill = SKILL_SWORD },
			{ name = "Club Skill Stages", skill = SKILL_CLUB },
			{ name = "Axe Skill Stages", skill = SKILL_AXE },
			{ name = "Distance Skill Stages", skill = SKILL_DISTANCE },
			{ name = "Shield Skill Stages", skill = SKILL_SHIELD },
			{ name = "Fist Skill Stages", skill = SKILL_FIST }
		}

		text = text .. "\nExp Stages rate: " .. getRateFromTable(experienceStages, player:getLevel(), expstagesrate) .. "x"

		for _, skillData in ipairs(skills) do
			text = text .. "\n" .. skillData.name .. " rate: "
				.. getRateFromTable(skillsStages, player:getSkillLevel(skillData.skill), configRateSkill) .. "x"
		end

		text = text .. "\nMagic Stages rate: "
			.. getRateFromTable(magicLevelStages, player:getBaseMagicLevel(), configManager.getNumber(configKeys.RATE_MAGIC)) .. "x"
	else
		text = text .. "\nExp rate: " .. configManager.getNumber(configKeys.RATE_EXPERIENCE) .. "x"
			.. "\nSkill rate: " .. configManager.getNumber(configKeys.RATE_SKILL) .. "x"
			.. "\nMagic rate: " .. configManager.getNumber(configKeys.RATE_MAGIC) .. "x"
	end

	text = text .. "\nLoot rate: " .. configManager.getNumber(configKeys.RATE_LOOT) .. "x"
		.. "\nSpawns rate: " .. configManager.getNumber(configKeys.RATE_SPAWN) .. "x"
		.. "\nBestiary rate: " .. configManager.getNumber(configKeys.BESTIARY_KILL_MULTIPLIER) .. "x"
		.. "\nBestiary Charm Shop Price: " .. configManager.getFloat(configKeys.BESTIARY_RATE_CHARM_SHOP_PRICE) .. "x"
		.. "\nBoosted Boss Kill Bonus: " .. configManager.getNumber(configKeys.BOOSTED_BOSS_KILL_BONUS) .. "x"
		.. "\nBoosted Boss Loot Bonus: " .. configManager.getNumber(configKeys.BOOSTED_BOSS_LOOT_BONUS) .. "%"
		.. "\nCritical Chance: " .. configManager.getNumber(configKeys.CRITICALCHANCE) .. "%"
		.. "\nParty Share Range: " .. configManager.getFloat(configKeys.PARTY_SHARE_RANGE_MULTIPLIER) .. "x"
		.. "\nWheel Points per Level: " .. configManager.getNumber(configKeys.WHEEL_POINTS_PER_LEVEL)

	text = text .. "\n\nAnimus Mastery: \n"
		.. "\nMax Monster XP: " .. configManager.getFloat(configKeys.ANIMUS_MASTERY_MAX_MONSTER_XP_MULTIPLIER) .. "x"
		.. "\nMonster XP: " .. configManager.getFloat(configKeys.ANIMUS_MASTERY_MONSTER_XP_MULTIPLIER) .. "x"
		.. "\nMonsters XP: " .. configManager.getFloat(configKeys.ANIMUS_MASTERY_MONSTERS_XP_MULTIPLIER) .. "x"
		.. "\nMonsters to Increase: " .. configManager.getNumber(configKeys.ANIMUS_MASTERY_MONSTERS_TO_INCREASE_XP_MULTIPLIER)

	-- Stamina info
	local staminaTrainer = configManager.getBoolean(configKeys.STAMINA_TRAINER)
	local staminaPz = configManager.getBoolean(configKeys.STAMINA_PZ)

	if staminaTrainer or staminaPz then
		text = text .. "\n\nStamina: \n"

		if staminaTrainer then
			text = text .. "\nTrainer enabled: Yes"
				.. "\nTrainer Delay: " .. configManager.getNumber(configKeys.STAMINA_TRAINER_DELAY) .. " min"
				.. "\nTrainer Gain: " .. configManager.getNumber(configKeys.STAMINA_TRAINER_GAIN) .. " per min"
		end

		if staminaPz then
			text = text .. "\nPZ enabled: Yes"
				.. "\nOrange Delay: " .. configManager.getNumber(configKeys.STAMINA_ORANGE_DELAY) .. " min"
				.. "\nGreen Delay: " .. configManager.getNumber(configKeys.STAMINA_GREEN_DELAY) .. " min"
				.. "\nPZ Gain: " .. configManager.getNumber(configKeys.STAMINA_PZ_GAIN) .. " per min"
		end
	end

	local loseHouseText = configManager.getNumber(configKeys.HOUSE_LOSE_AFTER_INACTIVITY) > 0
		and configManager.getNumber(configKeys.HOUSE_LOSE_AFTER_INACTIVITY) .. " days" or "never"

	text = text .. "\n\nHouse Info: \n"
		.. "\nLevel to buy: " .. configManager.getNumber(configKeys.HOUSE_BUY_LEVEL)
		.. "\nLose after inactivity: " .. loseHouseText
		.. "\nRent rate: " .. configManager.getFloat(configKeys.HOUSE_RENT_RATE) .. "x"
		.. "\nMax per player: " .. configManager.getNumber(configKeys.MAX_HOUSES_LIMIT)
		.. "\nPrice per SQM: " .. configManager.getNumber(configKeys.HOUSE_PRICE_PER_SQM) .. " gp"
		.. "\nDays to close bid: " .. configManager.getNumber(configKeys.DAYS_TO_CLOSE_BID)

	text = text .. "\n\nOther Info: \n"
		.. "\nProtection level: " .. configManager.getNumber(configKeys.PROTECTION_LEVEL)
		.. "\nWorld Type: " .. configManager.getString(configKeys.WORLD_TYPE)
		.. "\nKills/day red skull: " .. configManager.getNumber(configKeys.DAY_KILLS_TO_RED)
		.. "\nKills/week red skull: " .. configManager.getNumber(configKeys.WEEK_KILLS_TO_RED)
		.. "\nKills/month red skull: " .. configManager.getNumber(configKeys.MONTH_KILLS_TO_RED)
		.. "\nMax on Dummy: " .. configManager.getNumber(configKeys.MAX_ALLOWED_ON_A_DUMMY)
		.. "\nServer Save: " .. configManager.getString(configKeys.GLOBAL_SERVER_SAVE_TIME)

	player:showTextDialog(34266, text)
	return true
end

serverInfo:separator(" ")
serverInfo:groupType("normal")
serverInfo:register()
