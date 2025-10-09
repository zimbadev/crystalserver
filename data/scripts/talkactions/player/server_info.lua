local serverInfo = TalkAction("!serverinfo")

function serverInfo.onSay(player, words, param)
	local useStages = configManager.getBoolean(configKeys.RATE_USE_STAGES)
	local text = useStages and "Server Info Stages Rates: \n" or "Server Info Rates: \n"

	if useStages then
		local configRateSkill = configManager.getNumber(configKeys.RATE_SKILL)
		local skills = {
			{ name = "Sword Skill Stages",    skill = SKILL_SWORD },
			{ name = "Club Skill Stages",     skill = SKILL_CLUB },
			{ name = "Axe Skill Stages",      skill = SKILL_AXE },
			{ name = "Distance Skill Stages", skill = SKILL_DISTANCE },
			{ name = "Shield Skill Stages",   skill = SKILL_SHIELD },
			{ name = "Fist Skill Stages",     skill = SKILL_FIST }
		}

		text = text ..
		"\nExp Stages rate: " .. getRateFromTable(experienceStages, player:getLevel(), expstagesrate) .. "x"

		for _, skillData in ipairs(skills) do
			text = text .. "\n" .. skillData.name .. " rate: "
				.. getRateFromTable(skillsStages, player:getSkillLevel(skillData.skill), configRateSkill) .. "x"
		end

		text = text .. "\nMagic Stages rate: "
			.. getRateFromTable(magicLevelStages, player:getBaseMagicLevel(),
				configManager.getNumber(configKeys.RATE_MAGIC)) .. "x"
	else
		text = text .. "\nExp rate: " .. configManager.getNumber(configKeys.RATE_EXPERIENCE) .. "x"
			.. "\nSkill rate: " .. configManager.getNumber(configKeys.RATE_SKILL) .. "x"
			.. "\nMagic rate: " .. configManager.getNumber(configKeys.RATE_MAGIC) .. "x"
	end

	-- Informações comuns
	text = text .. "\nLoot rate: " .. configManager.getNumber(configKeys.RATE_LOOT) .. "x"
		.. "\nSpawns rate: " .. configManager.getNumber(configKeys.RATE_SPAWN) .. "x"
		.. "\nBestiary rate: " .. configManager.getNumber(configKeys.BESTIARY_KILL_MULTIPLIER) .. "x"

	-- Informações adicionais
	local loseHouseText = configManager.getNumber(configKeys.HOUSE_LOSE_AFTER_INACTIVITY) > 0
		and configManager.getNumber(configKeys.HOUSE_LOSE_AFTER_INACTIVITY) .. " days" or "never"

	text = text .. "\n\nMore Server Info: \n"
		.. "\nLevel to buy house: " .. configManager.getNumber(configKeys.HOUSE_BUY_LEVEL)
		.. "\nLose house after inactivity: " .. loseHouseText
		.. "\nProtection level: " .. configManager.getNumber(configKeys.PROTECTION_LEVEL)
		.. "\nWorldType: " .. configManager.getString(configKeys.WORLD_TYPE)
		.. "\nKills/day to red skull: " .. configManager.getNumber(configKeys.DAY_KILLS_TO_RED)
		.. "\nKills/week to red skull: " .. configManager.getNumber(configKeys.WEEK_KILLS_TO_RED)
		.. "\nKills/month to red skull: " .. configManager.getNumber(configKeys.MONTH_KILLS_TO_RED)
		.. "\nServer Save: " .. configManager.getString(configKeys.GLOBAL_SERVER_SAVE_TIME)

	player:showTextDialog(34266, text)
	return true
end

serverInfo:separator(" ")
serverInfo:groupType("normal")
serverInfo:register()
