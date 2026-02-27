-- Sistema de pérdida de taints al morir en la sala de Bakragore

-- Zona de Bakragore
local bakragoreZone = {
	from = Position(33034, 32389, 15),
	to = Position(33053, 32410, 15),
}

-- Función para verificar si el player está en la zona de Bakragore
local function isInBakragoreZone(player)
	local pos = player:getPosition()
	return pos.x >= bakragoreZone.from.x and pos.x <= bakragoreZone.to.x and pos.y >= bakragoreZone.from.y and pos.y <= bakragoreZone.to.y and pos.z == bakragoreZone.from.z
end

-- Función para obtener el nivel de taint de un jugador
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

-- Función para establecer el nivel de taint (mismo sistema que el NPC)
local function setPlayerTaintLevel(player, newTaintLevel)
	local kv = player:kv():scoped("rotten-blood-quest")
	kv:set("taints", newTaintLevel)

	-- SIEMPRE eliminar TODAS las condiciones de Bakragore primero
	for i = 0, 10 do
		player:removeCondition(CONDITION_BAKRAGORE, i)
	end

	-- Si el nuevo nivel no es 0, crear la nueva condición con el nivel específico
	if newTaintLevel > 0 then
		local condition = Condition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT, 0, true)
		condition:setParameter(CONDITION_PARAM_SUBID, newTaintLevel)
		condition:setParameter(CONDITION_PARAM_TICKS, -1)
		player:addCondition(condition)
	end

	-- Actualizar iconos
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

	-- Verificar si el player murió en la zona de Bakragore
	if not isInBakragoreZone(player) then
		return true
	end

	-- Obtener taint actual del jugador
	local currentTaint = getPlayerTaintLevel(player)

	if currentTaint == 0 then
		return true -- No tiene taints, no hacer nada
	end

	-- Determinar cuántos taints puede perder (máximo 2)
	local taintsToLose = math.min(2, currentTaint)
	local newTaintLevel = math.max(0, currentTaint - taintsToLose)

	-- Aplicar la pérdida de taints
	setPlayerTaintLevel(player, newTaintLevel)

	-- Mensaje al jugador
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You died in Bakragore's lair and lost " .. taintsToLose .. " taint level" .. (taintsToLose == 1 and "" or "s") .. "! Current taint: " .. newTaintLevel)

	logger.debug("Player {} died in Bakragore zone: Lost {} taints ({} -> {})", player:getName(), taintsToLose, currentTaint, newTaintLevel)

	return true
end

bakragorePlayerDeath:register()
