dofile(DATA_DIRECTORY .. "/lib/core/quests.lua")

if not LastQuestlogUpdate then
	LastQuestlogUpdate = {}
end

local function evaluateText(value, player)
	if type(value) == "function" then
		return tostring(value(player))
	end

	return tostring(value)
end

if not TRACKED_MISSIONS then
	TRACKED_MISSIONS = {}
end

function Player.getSavedMissions(self)
	return TRACKED_MISSIONS[self:getId()] or {}
end

function Player.saveMissions(self, data)
	TRACKED_MISSIONS[self:getId()] = data
end

function Player.hasTrackingQuest(self, missionId)
	local name, questId = self:getQuestDataByMissionId(missionId)
	if not name or not questId then
		return false
	end
	local trackedQuests = Player.getSavedMissions(self)
	if trackedQuests then
		for i = 1, #trackedQuests do
			local mission = trackedQuests[i]
			if mission and mission.missionId == missionId then
				return true
			end
		end
	end
	return false
end

function Player.getQuestDataByMissionId(self, missionId)
	for questId = 1, #Quests do
		local quest = Game.getQuest(questId)
		if quest then
			if quest.missions then
				for i = 1, #quest.missions do
					local mission = quest.missions[i]
					if mission and mission.missionId == missionId then
						return quest.name, questId, i, quest
					end
				end
			end
		end
	end
	return false
end

function Player.resetTrackedMissions(self, receivedMissionsFromClient)
	local maxAllowed = self:getAllowedTrackedQuestCount()
	local currentMissions = {}

	for m = 1, #receivedMissionsFromClient do
		local missionId = receivedMissionsFromClient[m]
		local questName, questId, missionIndex = self:getQuestDataByMissionId(missionId)
		if questName and questId and missionIndex then
			if self:missionIsStarted(questId, missionIndex) then
				local current = {
					questId = questId,
					missionId = missionId,
					questName = questName,
					missionName = self:getMissionName(questId, missionIndex),
					missionDesc = self:getMissionDescription(questId, missionIndex),
				}
				table.insert(currentMissions, current)
				if #currentMissions >= maxAllowed then
					break
				end
			end
		end
	end

	Player.saveMissions(self, currentMissions)
	self:sendTrackedQuests(maxAllowed - #currentMissions, currentMissions)
end

function Player.getAllowedTrackedQuestCount(self)
	return self:isPremium() and 25 or 10
end

function Game.isValidQuest(questId)
	return (Quests and Quests[questId])
end

function Game.isValidMission(questId, missionId)
	return (Game.isValidQuest(questId) and Quests[questId].missions and Quests[questId].missions[missionId])
end

function Game.getQuest(questId)
	if Game.isValidQuest(questId) then
		return Quests[questId]
	end
	return false
end

function Game.getQuestIdByName(name)
	for questId = 1, #Quests do
		local quest = Game.getQuest(questId)
		if quest and quest.name:lower() == name:lower() then
			return questId
		end
	end
	return false
end

function Game.getMission(questId, missionId)
	if Game.isValidMission(questId, missionId) then
		return Quests[questId].missions[missionId]
	end
	return false
end

function Player.getMissionsData(self, storage)
	local missions = {}
	for questId = 1, #Quests do
		local quest = Game.getQuest(questId)
		if quest and quest.missions then
			for missionId = 1, #quest.missions do
				local started = self:missionIsStarted(questId, missionId)
				if started then
					local mission = quest.missions[missionId]
					if mission.storageId == storage then
						local data = {
							questName = quest.name,
							questId = questId,
							missionId = mission.missionId,
							missionName = self:getMissionName(questId, missionId),
							missionDesc = self:getMissionDescription(questId, missionId),
							quest = quest,
						}
						missions[#missions + 1] = data
					end
				end
			end
		end
	end
	return missions
end

function Game.isQuestStorage(key, value, oldValue)
	for questId = 1, #Quests do
		local quest = Game.getQuest(questId)
		if quest then
			if quest.startStorageId == key and quest.startStorageValue == value then
				return true
			end

			if quest.missions then
				for missionId = 1, #quest.missions do
					local mission = Game.getMission(questId, missionId)
					if mission then
						if mission.storageId == key and value >= mission.startValue and value <= mission.endValue then
							return mission.description or oldValue < mission.storageId or oldValue > mission.endValue
						end
					end
				end
			end
		end
	end
	return false
end

function Game.getQuestsCount(player)
	local count = 0
	if Quests then
		for id = 1, #Quests do
			if player:questIsStarted(id) then
				count = count + 1
			end
		end
	end
	return count
end

function Game.getMissionsCount(player, questId)
	local quest = Game.getQuest(questId)
	local count = 0
	if quest then
		local missions = quest.missions
		if missions then
			for missionId = 1, #missions do
				if player:missionIsStarted(questId, missionId) then
					count = count + 1
				end
			end
		end
	end
	return count
end

function Game.addQuest(quest)
	local findQuest = Game.getQuestIdByName(quest.name)
	if findQuest then
		Quests[findQuest] = quest
		return findQuest
	end

	local questId = #Quests + 1
	Quests[questId] = quest
	return questId
end

-- Player functions

function Player.questIsStarted(self, questId)
	local quest = Game.getQuest(questId)
	if quest and self:getStorageValue(quest.startStorageId) ~= -1 or self:getStorageValue(quest.startStorageId) >= quest.startStorageValue then
		return true
	end
	return false
end

function Player.missionIsStarted(self, questId, missionId)
	local mission = Game.getMission(questId, missionId)
	if mission then
		local value = self:getStorageValue(mission.storageId)
		if value == -1 or value < mission.startValue or (not mission.ignoreendvalue and value > mission.endValue) then
			return false
		end

		return true
	end
	return false
end

function Player.questIsCompleted(self, questId)
	local quest = Game.getQuest(questId)
	if quest then
		local missions = quest.missions
		if missions then
			for missionId = 1, #missions do
				if not self:missionIsCompleted(questId, missionId) then
					return false
				end
			end
		end
		return true
	end
	return false
end

function Player.missionIsCompleted(self, questId, missionId)
	local mission = Game.getMission(questId, missionId)
	if mission then
		local value = self:getStorageValue(mission.storageId)
		if value == -1 then
			return false
		end

		if mission.ignoreendvalue then
			return value >= mission.endValue
		end

		return value == mission.endValue
	end
	return false
end

function Player.getMissionName(self, questId, missionId)
	local mission = Game.getMission(questId, missionId)
	if mission then
		if self:missionIsCompleted(questId, missionId) then
			return mission.name .. " (completed)"
		end
		return mission.name
	end
	return ""
end

function Player.getMissionId(self, questId, missionId)
	local mission = Game.getMission(questId, missionId)
	if mission then
		return mission.missionId
	end
	return 0
end

function Player.getMissionDescription(self, questId, missionId)
	local mission = Game.getMission(questId, missionId)
	if mission then
		if mission.description then
			return evaluateText(mission.description, self)
		end

		local value = self:getStorageValue(mission.storageId)
		local state = value
		if mission.ignoreendvalue and value > table.maxn(mission.states) then
			state = table.maxn(mission.states)
		end
		return evaluateText(mission.states[state], self)
	end
	return "An error has occurred, please contact a gamemaster."
end

function Player.sendQuestLog(self)
	local msg = NetworkMessage()
	msg:addByte(0xF0)
	msg:addU16(Game.getQuestsCount(self))
	for questId = 1, #Quests do
		if self:questIsStarted(questId) then
			msg:addU16(questId)
			msg:addString(Quests[questId].name, "Player.sendQuestLog")
			msg:addByte(self:questIsCompleted(questId) and 0x01 or 0x00)
		end
	end
	msg:sendToPlayer(self)
	msg:delete()
end

function Player.sendQuestLine(self, questId)
	local quest = Game.getQuest(questId)
	if quest then
		local missions = quest.missions
		local msg = NetworkMessage()
		msg:addByte(0xF1)
		msg:addU16(questId)
		msg:addByte(Game.getMissionsCount(self, questId))
		if missions then
			for missionIndex in ipairs(missions) do
				if self:missionIsStarted(questId, missionIndex) then
					if self:getClient().version >= 1200 then
						msg:addU16(self:getMissionId(questId, missionIndex))
					end
					msg:addString(self:getMissionName(questId, missionIndex), "Player.sendQuestLine - mission.missionName")
					msg:addString(self:getMissionDescription(questId, missionIndex), "Player.sendQuestLine - mission.missionDesc")
				end
			end
		end

		msg:sendToPlayer(self)
		msg:delete()
	end
end

local function getCharmRune(value, count)
	count = tonumber(count) or 0
	value = value:gsub("^%s*(.-)%s*$", "%1")
	local url = ("/compose_image.php?image=images/icons/%s.png&top=%s&bottom=%s"):format(value, value, count)
	local img = getImage(url, { alt = value, charms = true })
	return "<br>" .. img .. "<br>"
end

local tierIcons = {
	["Momentum"] = { fallbackId = 50188 },
	["Ruse"] = { fallbackId = 50254 },
	["Transcendence"] = { fallbackId = 50146 },
	["Onslaught"] = { fallbackId = 50158 },
}

local function getTierItem(value, count, slot)
	count = tonumber(count) or 0
	local url = "/compose_image.php?image=images/items/%s.gif&top=%s&bottom=%s"
	local current = tierIcons[value]
	local itemId = current.fallbackId

	if slot then
		itemId = slot:getId() or itemId
	end
	url = (url):format(itemId, value, count)

	local img = getImage(url, { alt = value, size = 24, charms = true })
	return "<br>" .. img .. "<br>"
end

local function isTierOrCharmTracker(name)
	local isTierTracker = name:find("Tier")
	local isCharmTracker = name:find("Charm")
	local hasTrackerInName = isTierTracker or isCharmTracker
	return hasTrackerInName, isCharmTracker, isTierTracker
end

local function handleTrackers(questName, mission, player)
	local hasTrackerInName, isCharmTracker = isTierOrCharmTracker(questName)
	mission.missionName = ""
	if hasTrackerInName and mission.quest then
		mission.quest.cachedTracker = mission.quest.cachedTracker or {}
		local playerId = player:getId()
		mission.quest.cachedTracker[playerId] = mission.quest.cachedTracker[playerId] or {}
		local playerCache = mission.quest.cachedTracker[playerId]
		local cacheKey = isCharmTracker and "charm" or "tier"
		playerCache[cacheKey] = playerCache[cacheKey] or { init = false }
		local cache = playerCache[cacheKey]
		local array = isCharmTracker and mission.quest.parsedMissions or mission.quest.parsedTierMissions

		if not cache.init then
			cache.init = true
			for index, v in ipairs(array) do
				local count = v.getCount(player) or 0
				if count > 0 then
					local slot = player:getSlotItem(v.slot or 0)
					cache[index] = isCharmTracker and getCharmRune(v.name, count) or getTierItem(v.name, count, slot)
				end
			end
		else
			if isCharmTracker then
				local charmId = player:getLastCharmTrigger()
				if charmId and charmId >= 0 then
					local index = charmId + 1
					local v = array[index]
					if v then
						local count = v.getCount(player) or 0
						if count > 0 then
							cache[index] = getCharmRune(v.name, count)
						else
							cache[index] = nil
						end
					end
				end
			else
				local slotId = player:getLastItemUpgradeTriggerSlot()
				if slotId and slotId > 0 then
					for index, v in ipairs(array) do
						if v.slot == slotId then
							local count = v.getCount(player) or 0
							if count > 0 then
								cache[index] = getTierItem(v.name, count, player:getSlotItem(v.slot))
							else
								cache[index] = nil
							end
							break
						end
					end
				end
			end
		end

		local hasCount = false
		for index = 1, #array do
			local data = cache[index]
			if data then
				hasCount = true
				mission.missionName = mission.missionName .. data .. "<br>"
			end
		end
		mission.questName = questName
		mission.missionDesc = not hasCount and "No data available." or ""
		return mission
	end

	mission.questName = questName
	return mission
end

function Player.sendTrackedQuests(self, remainingQuests, missions)
	local msg = NetworkMessage()
	msg:addByte(0xD0)
	msg:addByte(0x01)
	msg:addByte(remainingQuests)
	msg:addByte(#missions)

	for m = 1, #missions do
		local mission = missions[m]
		local hasTrackerInName = isTierOrCharmTracker(mission.missionName)
		msg:addU16(mission.missionId)
		msg:addU16(mission.questId)
		msg:addString(mission.questName)
		msg:addString(mission.missionName)
		msg:addString(not hasTrackerInName and mission.missionDesc or "No data available.")
	end
	msg:sendToPlayer(self)
	msg:delete()
end

function Player.sendUpdateTrackedQuest(self, mission)
	local msg = NetworkMessage()
	msg:addByte(0xD0)
	msg:addByte(0x00)

	local questName, questId = mission.questName, mission.questId

	if not questName or not questId then
		questName, questId = self:getQuestDataByMissionId(mission.missionId)
	end

	mission.questName = questName
	mission = handleTrackers(questName, mission, self)
	local hasTrackerInName = isTierOrCharmTracker(mission.missionName)
	msg:addU16(mission.missionId)
	msg:addU16(questId)
	msg:addString(not hasTrackerInName and questName or "")
	msg:addString(mission.missionName)
	msg:addString(mission.missionDesc)
	msg:sendToPlayer(self)
	msg:delete()
end

function Player.updateStorage(self, key, value, oldValue, currentFrameTime)
	local playerId = self:getId()
	if LastQuestlogUpdate[playerId] ~= currentFrameTime and Game.isQuestStorage(key, value, oldValue) then
		LastQuestlogUpdate[playerId] = currentFrameTime
		if value ~= oldValue then
			self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your questlog has been updated.")
		end
	end

	local missions = self:getMissionsData(key)
	for i = 1, #missions do
		local mission = missions[i]
		if self:hasTrackingQuest(mission.missionId) then
			self:sendUpdateTrackedQuest(mission)
		end
	end
end

local function sendPrint(questId, index)
	logger.warn("[sendPrint] - Quest id:[{}]] mission:[{}]", questId, index)
end

for questId = 1, #Quests do
	local quest = Game.getQuest(questId)
	if quest then
		for index, value in ipairs(quest.missions) do
			if index then
				if not value.name then
					logger.error("Quest.load: Wrong mission name found")
					sendPrint(questId, index)
				end
				if not value.storageId then
					logger.error("Quest.load: Wrong mission storage found")
					sendPrint(questId, index)
				end
				if not value.missionId then
					logger.error("Quest.load: Wrong mission id found")
					sendPrint(questId, index)
				end
				if not value.startValue then
					logger.error("Quest.load: Wrong mission start value found")
					sendPrint(questId, index)
				end
				if not value.endValue then
					logger.error("Quest.load: Wrong mission end value found")
					sendPrint(questId, index)
				end
			end
		end
	end
end
