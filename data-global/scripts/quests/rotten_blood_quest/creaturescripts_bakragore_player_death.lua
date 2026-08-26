local bakragoreZone = {
	from = Position(33034, 32389, 15),
	to = Position(33053, 32410, 15),
}

local function isInBakragoreZone(player)
	local pos = player:getPosition()
	return pos.x >= bakragoreZone.from.x and pos.x <= bakragoreZone.to.x and pos.y >= bakragoreZone.from.y and pos.y <= bakragoreZone.to.y and pos.z == bakragoreZone.from.z
end

local function getPlayerTaintLevel(player)
	local kv = player:kv():scoped("rotten-blood-quest")
	local currentTaintKV = kv:get("taints") or 0
	local currentTaintCondition = 0
	local taintCondition = player:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
	if taintCondition then
		currentTaintCondition = taintCondition:getParameter(CONDITION_PARAM_SUBID) or 0
	end
	return math.max(currentTaintKV, currentTaintCondition)
end

local function setPlayerTaintLevel(player, newTaintLevel)
	local kv = player:kv():scoped("rotten-blood-quest")
	kv:set("taints", newTaintLevel)

	for i = 0, 10 do
		player:removeCondition(CONDITION_BAKRAGORE, i)
	end

	if newTaintLevel > 0 then
		local condition = Condition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT, 0, true)
		condition:setParameter(CONDITION_PARAM_SUBID, newTaintLevel)
		condition:setParameter(CONDITION_PARAM_TICKS, -1)
		player:addCondition(condition)
	end

	if player.removeIconBakragore then
		player:removeIconBakragore()
	end
	updateRottenHazardIcon(player)
end

local bakragorePlayerDeath = CreatureEvent("BakragorePlayerDeath")

function bakragorePlayerDeath.onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if not player or not player:isPlayer() then
		return true
	end

	if not isInBakragoreZone(player) then
		return true
	end

	local currentTaint = getPlayerTaintLevel(player)

	if currentTaint == 0 then
		return true
	end

	local taintsToLose = math.min(2, currentTaint)
	local newTaintLevel = math.max(0, currentTaint - taintsToLose)

	setPlayerTaintLevel(player, newTaintLevel)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You died in Bakragore's lair and lost " .. taintsToLose .. " taint level" .. (taintsToLose == 1 and "" or "s") .. "! Current taint: " .. newTaintLevel)

	logger.debug("Player {} died in Bakragore zone: Lost {} taints ({} -> {})", player:getName(), taintsToLose, currentTaint, newTaintLevel)

	return true
end

bakragorePlayerDeath:register()
