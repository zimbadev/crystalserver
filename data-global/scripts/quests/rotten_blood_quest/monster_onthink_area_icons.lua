local partyTaintCache = setmetatable({}, { __mode = "v" })
local processedPlayers = setmetatable({}, { __mode = "k" })
local lastCacheReset = os.time()
local KV_SCOPE = "rotten-blood-area-icons"

local UPPER_LEFT_AREAS = {
	{ x1 = 33800, y1 = 31653, x2 = 33941, y2 = 31771, z = 14 },
	{ x1 = 33800, y1 = 31653, x2 = 33941, y2 = 31771, z = 15 },
}

local LOWER_LEFT_AREAS = {
	{ x1 = 33800, y1 = 31809, x2 = 33937, y2 = 31931, z = 14 },
	{ x1 = 33800, y1 = 31809, x2 = 33937, y2 = 31931, z = 15 },
}

local function isInUpperLeftArea(pos)
	for _, area in ipairs(UPPER_LEFT_AREAS) do
		if pos.x >= area.x1 and pos.x <= area.x2 and pos.y >= area.y1 and pos.y <= area.y2 and pos.z == area.z then
			return true
		end
	end
	return false
end

local function isInLowerLeftArea(pos)
	for _, area in ipairs(LOWER_LEFT_AREAS) do
		if pos.x >= area.x1 and pos.x <= area.x2 and pos.y >= area.y1 and pos.y <= area.y2 and pos.z == area.z then
			return true
		end
	end
	return false
end

local function getPartyMinTaintLevel(player)
	local party = player:getParty()
	if not party then
		local kv = player:kv():scoped("rotten-blood-quest")
		local currentTaintKV = kv:get("taints") or 0
		local currentTaintCondition = 0
		local taintCondition = player:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
		if taintCondition then
			currentTaintCondition = taintCondition:getParameter(CONDITION_PARAM_SUBID) or 0
		end
		return math.max(currentTaintKV, currentTaintCondition)
	end

	local leader = party:getLeader()
	if not leader then
		return 0
	end

	local leaderId = leader:getId()
	local currentTime = os.time()

	if partyTaintCache[leaderId] and currentTime - partyTaintCache[leaderId].timestamp < 10 then
		return partyTaintCache[leaderId].minTaint
	end

	local members = party:getMembers()
	local minTaint = 9999

	local kv = leader:kv():scoped("rotten-blood-quest")
	local leaderTaint = kv:get("taints") or 0
	local taintCondition = leader:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
	if taintCondition then
		leaderTaint = math.max(leaderTaint, taintCondition:getParameter(CONDITION_PARAM_SUBID) or 0)
	end
	minTaint = math.min(minTaint, leaderTaint)

	for _, member in ipairs(members) do
		if member and member:isPlayer() then
			local memberKv = member:kv():scoped("rotten-blood-quest")
			local memberTaint = memberKv:get("taints") or 0
			local memberCondition = member:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
			if memberCondition then
				memberTaint = math.max(memberTaint, memberCondition:getParameter(CONDITION_PARAM_SUBID) or 0)
			end
			minTaint = math.min(minTaint, memberTaint)
		end
	end

	if minTaint == 9999 then
		minTaint = 0
	end

	partyTaintCache[leaderId] = {
		minTaint = minTaint,
		timestamp = currentTime,
	}

	return minTaint
end

local function updateHazardIcon(player)
	local taintLevel = getPartyMinTaintLevel(player)

	if taintLevel > 0 then
		local iconLevel = 0
		if taintLevel >= 1 and taintLevel <= 4 then
			iconLevel = taintLevel
		elseif taintLevel == 5 then
			iconLevel = 0
		elseif taintLevel >= 6 and taintLevel <= 9 then
			iconLevel = taintLevel - 5
		end

		if iconLevel > 0 then
			player:setIcon("rotten-hazard", CreatureIconCategory_Quests, CreatureIconQuests_Hazard, iconLevel)
		else
			player:removeIcon("rotten-hazard")
		end
	else
		player:removeIcon("rotten-hazard")
	end
end

local function handleUpperLeftIcon(player)
	local currentTime = os.time()
	local kv = player:kv():scoped(KV_SCOPE)
	local lastUpdate = kv:get("lastUpperLeftUpdate") or 0

	if currentTime - lastUpdate >= 30 then
		local currentIcon = player:getIcon("rotten-area")
		if not currentIcon or currentIcon.category ~= CreatureIconCategory_Quests or currentIcon.icon ~= CreatureIconQuests_ArrowUp then
			player:setIcon("rotten-area", CreatureIconCategory_Quests, CreatureIconQuests_ArrowUp, 1)
		else
			local newCount = math.min(currentIcon.count + 1, 100)
			player:setIcon("rotten-area", CreatureIconCategory_Quests, CreatureIconQuests_ArrowUp, newCount)
		end
		kv:set("lastUpperLeftUpdate", currentTime)
	end
end

local function handleLowerLeftIcon(player)
	local currentTime = os.time()
	local kv = player:kv():scoped(KV_SCOPE)
	local lastUpdate = kv:get("lastLowerLeftUpdate") or 0

	if currentTime - lastUpdate >= 1 then
		local currentIcon = player:getIcon("white-cross")
		if not currentIcon or currentIcon.category ~= CreatureIconCategory_Quests or currentIcon.icon ~= CreatureIconQuests_RedCross then
			player:setIcon("white-cross", CreatureIconCategory_Quests, CreatureIconQuests_RedCross, 1)
		else
			local newCount = math.min(currentIcon.count + 1, 111)
			player:setIcon("white-cross", CreatureIconCategory_Quests, CreatureIconQuests_RedCross, newCount)

			if newCount >= 111 then
				local damage = math.random(1300, 1500)
				player:setIcon("white-cross", CreatureIconCategory_Quests, CreatureIconQuests_RedCross, 0)

				if player:getHealth() > 0 then
					doTargetCombatHealth(0, player, COMBAT_ENERGYDAMAGE, -damage, -damage, CONST_ME_ENERGYHIT)
				end
			end
		end
		kv:set("lastLowerLeftUpdate", currentTime)
	end
end

local function processPlayer(player)
	if processedPlayers[player] then
		return
	end

	processedPlayers[player] = true

	local playerPos = player:getPosition()
	local currentTime = os.time()
	local kv = player:kv():scoped(KV_SCOPE)

	local lastHazardUpdate = kv:get("lastHazardUpdate") or 0
	if currentTime - lastHazardUpdate >= 8 then
		updateHazardIcon(player)
		kv:set("lastHazardUpdate", currentTime)
	end

	if isInUpperLeftArea(playerPos) then
		handleUpperLeftIcon(player)
	end

	if isInLowerLeftArea(playerPos) then
		handleLowerLeftIcon(player)
	end
end

function onRottenMonsterThink(monster, interval)
	if not monster or not monster:isMonster() then
		return true
	end

	local currentTime = os.time()
	if currentTime - lastCacheReset >= 1 then
		processedPlayers = setmetatable({}, { __mode = "k" })
		lastCacheReset = currentTime
	end

	local monsterPos = monster:getPosition()
	local spectators = Game.getSpectators(monsterPos, false, true, 15, 15, 15, 15)

	for _, player in ipairs(spectators) do
		if player:isPlayer() then
			processPlayer(player)
		end
	end

	return true
end

function onPlayerLeaveRottenArea(player)
	if not player or not player:isPlayer() then
		return
	end

	player:removeIcon("rotten-hazard")
	player:removeIcon("rotten-area")
	player:removeIcon("white-cross")

	local kv = player:kv():scoped(KV_SCOPE)
	kv:remove("lastUpperLeftUpdate")
	kv:remove("lastLowerLeftUpdate")
	kv:remove("lastHazardUpdate")
end

_G.onRottenMonsterThink = onRottenMonsterThink
_G.onPlayerLeaveRottenArea = onPlayerLeaveRottenArea
