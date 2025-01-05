local skillMap = {
	club = SKILL_CLUB,
	sword = SKILL_SWORD,
	axe = SKILL_AXE,
	dist = SKILL_DISTANCE,
	shield = SKILL_SHIELD,
	fish = SKILL_FISHING,
}

local function getSkillId(skillName)
	return skillMap[skillName:match("^%a+")] or SKILL_FIST
end

local skill = TalkAction("/skill")

function skill.onSay(player, words, param)
	-- Create log
	logCommand(player, words, param)

	if param == "" then
		player:sendCancelMessage("Command param required.")
		return true
	end

	local split = param:split(",")
	if #split < 2 then
		player:sendCancelMessage("Usage: /skill <playername>, <skill or 'level'/'magic'>, [amount], [add/remove]")
		return true
	end

	local targetPlayerName = split[1]:trim()
	local targetPlayer = Player(targetPlayerName)

	if not targetPlayer then
		player:sendCancelMessage("Player not found.")
		return true
	end

	local skillParam = split[2]:trim()
	local skillIncreaseAmount = tonumber(split[3]) or 1
	local action = split[4] and split[4]:trim():lower() or "add" -- Default to 'add' if no action is specified
	local skillPrefix = skillParam:sub(1, 1)

	if action ~= "add" and action ~= "remove" then
		player:sendCancelMessage("Invalid action. Use 'add' or 'remove'.")
		return true
	end

	if skillPrefix == "l" then
		local levelText = (skillIncreaseAmount > 1) and "levels" or "level"
		local targetCurrentLevel = targetPlayer:getLevel()
		local targetNewLevel = targetCurrentLevel + (action == "add" and skillIncreaseAmount or -skillIncreaseAmount)

		if targetNewLevel < 1 then
			targetNewLevel = 1
		end -- Prevent dropping below level 1

		local targetCurrentExp = targetPlayer:getExperience()
		local targetNewExp = Game.getExperienceForLevel(targetNewLevel)
		local experienceDiff = targetCurrentExp - targetNewExp

		if experienceDiff < 0 then
			experienceDiff = 0
		end

		if action == "add" then
			local experienceToAdd = targetNewExp - targetCurrentExp
			if experienceToAdd > 0 then
				targetPlayer:addExperience(experienceToAdd, false)
			end
		else
			targetPlayer:removeExperience(experienceDiff, false)
		end
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s has %s %d %s to you.", player:getName(), action, skillIncreaseAmount, levelText))
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have successfully %s %d %s to player %s.", action, skillIncreaseAmount, levelText, targetPlayer:getName()))
	elseif skillPrefix == "m" then
		local magicText = (skillIncreaseAmount > 1) and "magic levels" or "magic level"
		for _ = 1, skillIncreaseAmount do
			local requiredManaSpent = targetPlayer:getVocation():getRequiredManaSpent(targetPlayer:getBaseMagicLevel() + 1)
			if action == "add" then
				targetPlayer:addManaSpent(requiredManaSpent - targetPlayer:getManaSpent(), true)
			else
				-- For removal, we need to subtract mana
				targetPlayer:addManaSpent(-(targetPlayer:getManaSpent() - requiredManaSpent), true)
			end
		end

		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s has %s %d %s to you.", player:getName(), action, skillIncreaseAmount, magicText))
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have successfully %s %d %s to player %s.", action, skillIncreaseAmount, magicText, targetPlayer:getName()))
	else
		local skillId = getSkillId(skillParam)
		local skillText = (skillIncreaseAmount > 1) and "skill levels" or "skill level"
		for _ = 1, skillIncreaseAmount do
			local requiredSkillTries = targetPlayer:getVocation():getRequiredSkillTries(skillId, targetPlayer:getSkillLevel(skillId) + 1)
			if action == "add" then
				targetPlayer:addSkillTries(skillId, requiredSkillTries - targetPlayer:getSkillTries(skillId), true)
			else
				-- For removal, we need to subtract skill tries
				targetPlayer:addSkillTries(skillId, -(targetPlayer:getSkillTries(skillId) - requiredSkillTries), true)
			end
		end

		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s has %s %d %s %s to you.", player:getName(), action, skillIncreaseAmount, skillParam, skillText))
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have successfully %s %d %s %s to player %s.", action, skillIncreaseAmount, skillParam, skillText, targetPlayer:getName()))
	end
	return true
end

skill:separator(" ")
skill:groupType("god")
skill:register()
