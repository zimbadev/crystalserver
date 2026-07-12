local ratmiralCheeseClick = Action()

local cheeseConfig = {
	position = Position(33903, 31345, 14),
	specArea = {
		from = Position(33898, 31344, 14),
		to = Position(33914, 31358, 14),
	},
	maxTicks = 6,
	storageKey = Storage.Quest.U12_60.APiratesTail.WaterIcon,
}

function ratmiralCheeseClick.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:getPosition():isInRange(cheeseConfig.specArea.from, cheeseConfig.specArea.to) then
		return false
	end

	if toPosition.x ~= cheeseConfig.position.x or toPosition.y ~= cheeseConfig.position.y or toPosition.z ~= cheeseConfig.position.z then
		return false
	end

	local currentTicks = player:getStorageValue(cheeseConfig.storageKey)
	if currentTicks < 0 then
		currentTicks = 0
	end

	if currentTicks > 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must use your water supply before taking more.")
		return true
	end

	player:setStorageValue(cheeseConfig.storageKey, cheeseConfig.maxTicks)
	player:setIcon("blue-shield", CreatureIconCategory_Quests, CreatureIconQuests_BlueShield, cheeseConfig.maxTicks)

	player:sendMagicEffect(CONST_ME_LOSEENERGY)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A high rankning crewmember is nearby and won't let you!")

	return true
end

ratmiralCheeseClick:id(26100)
ratmiralCheeseClick:register()

local ratmiralCheeseLogin = CreatureEvent("RatmiralCheeseLogin")
function ratmiralCheeseLogin.onLogin(player)
	if player:getPosition():isInRange(cheeseConfig.specArea.from, cheeseConfig.specArea.to) then
		local ticks = player:getStorageValue(cheeseConfig.storageKey)
		if ticks > 0 then
			player:setIcon("blue-shield", CreatureIconCategory_Quests, CreatureIconQuests_BlueShield, ticks)
		end
	end
	return true
end
ratmiralCheeseLogin:register()

local ratmiralCheeseZoneCheck = GlobalEvent("RatmiralCheeseZoneCheck")
function ratmiralCheeseZoneCheck.onThink(interval)
	local players = Game.getPlayers()
	for _, player in ipairs(players) do
		if not player:getPosition():isInRange(cheeseConfig.specArea.from, cheeseConfig.specArea.to) then
			player:removeIcon("blue-shield")
			player:setStorageValue(cheeseConfig.storageKey, 0)
		else
			local ticks = player:getStorageValue(cheeseConfig.storageKey)
			if ticks > 0 then
				player:setIcon("blue-shield", CreatureIconCategory_Quests, CreatureIconQuests_BlueShield, ticks)
			end
		end
	end
	return true
end
ratmiralCheeseZoneCheck:interval(500)
ratmiralCheeseZoneCheck:register()

local ratmiralCheeseLogout = CreatureEvent("RatmiralCheeseLogout")
function ratmiralCheeseLogout.onLogout(player)
	player:setStorageValue(cheeseConfig.storageKey, 0)
	player:removeIcon("blue-shield")
	return true
end

ratmiralCheeseLogout:register()
