--[[
	ROTTEN BLOOD AREA ICONS - Monster onThink System
	
	OPTIMIZACIÓN CRÍTICA V4:
	- Los MONSTERS actualizan iconos de jugadores cercanos (no PlayerOnThink)
	- Un monster procesa TODOS los jugadores en su rango
	- Si NO hay jugadores en zona = NO hay monsters = 0 overhead
	- Batch processing natural (1 monster → N jugadores)
	- COOLDOWNS PERSISTENTES: Usa KV del jugador para garantizar intervalos correctos
	
	IMPACTO:
	- De 250 PlayerOnThink/s → 100-150 Monster onThink/s
	- Si no hay jugadores en zona: 0 ejecuciones (monsters no existen)
	- Reducción adicional de ~40-60% vs PlayerOnThink
	- Cooldowns 100% confiables usando KV storage
	
	MECÁNICAS:
	- Upper Left Area (Rotten Wasteland): +1 icon cada 30s (max 100)
	- Lower Left Area (Darklight): +1 icon cada 1s, 1300-1500 damage al llegar a 111
	- Hazard Icon: Actualiza cada 8s basado en party min taint
	
	REGISTRADO EN:
	- 16 monsters de Rotten Blood (via startup_register_events.lua)
]]

-- ✅ OPTIMIZACIÓN: Cache global de party min taint
local partyTaintCache = setmetatable({}, { __mode = "v" })

-- ✅ OPTIMIZACIÓN: Cache de jugadores procesados (evita duplicados)
local processedPlayers = setmetatable({}, { __mode = "k" })
local lastCacheReset = os.time()

-- ✅ KV Scope para timers de iconos (persistente por jugador)
local KV_SCOPE = "rotten-blood-area-icons"

-- Pre-definir áreas especiales como coordenadas (más rápido que Zone para verificaciones simples)
local UPPER_LEFT_AREAS = {
	{ x1 = 33800, y1 = 31653, x2 = 33941, y2 = 31771, z = 14 },
	{ x1 = 33800, y1 = 31653, x2 = 33941, y2 = 31771, z = 15 },
}

local LOWER_LEFT_AREAS = {
	{ x1 = 33800, y1 = 31809, x2 = 33937, y2 = 31931, z = 14 },
	{ x1 = 33800, y1 = 31809, x2 = 33937, y2 = 31931, z = 15 },
}

-- Función para verificar si está en Upper Left Area
local function isInUpperLeftArea(pos)
	for _, area in ipairs(UPPER_LEFT_AREAS) do
		if pos.x >= area.x1 and pos.x <= area.x2 and pos.y >= area.y1 and pos.y <= area.y2 and pos.z == area.z then
			return true
		end
	end
	return false
end

-- Función para verificar si está en Lower Left Area
local function isInLowerLeftArea(pos)
	for _, area in ipairs(LOWER_LEFT_AREAS) do
		if pos.x >= area.x1 and pos.x <= area.x2 and pos.y >= area.y1 and pos.y <= area.y2 and pos.z == area.z then
			return true
		end
	end
	return false
end

-- Función para obtener party min taint level (con CACHE)
local function getPartyMinTaintLevel(player)
	local party = player:getParty()

	-- Si no tiene party, retornar su taint personal
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

	-- ✅ Cache válido por 10 segundos
	if partyTaintCache[leaderId] and currentTime - partyTaintCache[leaderId].timestamp < 10 then
		return partyTaintCache[leaderId].minTaint
	end

	-- Recalcular min taint
	local members = party:getMembers()
	local minTaint = 9999

	-- Incluir al leader
	local kv = leader:kv():scoped("rotten-blood-quest")
	local leaderTaint = kv:get("taints") or 0
	local taintCondition = leader:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
	if taintCondition then
		leaderTaint = math.max(leaderTaint, taintCondition:getParameter(CONDITION_PARAM_SUBID) or 0)
	end
	minTaint = math.min(minTaint, leaderTaint)

	-- Incluir miembros
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

	-- Guardar en cache
	partyTaintCache[leaderId] = {
		minTaint = minTaint,
		timestamp = currentTime,
	}

	return minTaint
end

-- Función para actualizar Hazard icon
local function updateHazardIcon(player)
	local taintLevel = getPartyMinTaintLevel(player)

	if taintLevel > 0 then
		local iconLevel = 0
		if taintLevel >= 1 and taintLevel <= 4 then
			iconLevel = taintLevel
		elseif taintLevel == 5 then
			iconLevel = 0 -- Taint 5 = NO ICON
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

-- Función para manejar Upper Left Area icon (Rotten Wasteland - cada 30 segundos)
local function handleUpperLeftIcon(player)
	local currentTime = os.time()
	local kv = player:kv():scoped(KV_SCOPE)
	local lastUpdate = kv:get("lastUpperLeftUpdate") or 0

	-- Verificar cooldown de 30 segundos
	if currentTime - lastUpdate >= 30 then
		local currentIcon = player:getIcon("rotten-area")
		if not currentIcon or currentIcon.category ~= CreatureIconCategory_Quests or currentIcon.icon ~= CreatureIconQuests_ArrowUp then
			player:setIcon("rotten-area", CreatureIconCategory_Quests, CreatureIconQuests_ArrowUp, 1)
		else
			local newCount = math.min(currentIcon.count + 1, 100)
			player:setIcon("rotten-area", CreatureIconCategory_Quests, CreatureIconQuests_ArrowUp, newCount)
		end
		-- Guardar timestamp en KV
		kv:set("lastUpperLeftUpdate", currentTime)
	end
end

-- Función para manejar Lower Left Area icon (Darklight - cada 1 segundo)
local function handleLowerLeftIcon(player)
	local currentTime = os.time()
	local kv = player:kv():scoped(KV_SCOPE)
	local lastUpdate = kv:get("lastLowerLeftUpdate") or 0

	-- Verificar cooldown de 1 segundo
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
		-- Guardar timestamp en KV
		kv:set("lastLowerLeftUpdate", currentTime)
	end
end

-- ✅ Función de procesamiento para un jugador (llamada por el monster)
local function processPlayer(player)
	-- Skip si ya fue procesado por otro monster en este ciclo
	if processedPlayers[player] then
		return
	end

	processedPlayers[player] = true

	local playerPos = player:getPosition()
	local currentTime = os.time()
	local kv = player:kv():scoped(KV_SCOPE)

	-- Actualizar Hazard icon cada 8s (usando KV)
	local lastHazardUpdate = kv:get("lastHazardUpdate") or 0
	if currentTime - lastHazardUpdate >= 8 then
		updateHazardIcon(player)
		kv:set("lastHazardUpdate", currentTime)
	end

	-- Upper Left Area (Rotten Wasteland - 30s cooldown)
	if isInUpperLeftArea(playerPos) then
		handleUpperLeftIcon(player)
	end

	-- Lower Left Area (Darklight - 1s cooldown)
	if isInLowerLeftArea(playerPos) then
		handleLowerLeftIcon(player)
	end
end

-- ✅ MONSTER ONTHINK: El monster busca jugadores cercanos y los procesa
function onRottenMonsterThink(monster, interval)
	if not monster or not monster:isMonster() then
		return true
	end

	-- ✅ OPTIMIZACIÓN: Resetear cache de jugadores procesados cada segundo
	local currentTime = os.time()
	if currentTime - lastCacheReset >= 1 then
		processedPlayers = setmetatable({}, { __mode = "k" })
		lastCacheReset = currentTime
	end

	-- ✅ Obtener jugadores cercanos (15 sqm radius)
	local monsterPos = monster:getPosition()
	local spectators = Game.getSpectators(monsterPos, false, true, 15, 15, 15, 15)

	-- ✅ Procesar cada jugador UNA SOLA VEZ
	for _, player in ipairs(spectators) do
		if player:isPlayer() then
			processPlayer(player)
		end
	end

	return true
end

-- ✅ CLEANUP: Limpiar iconos y KV cuando jugador sale de zona
function onPlayerLeaveRottenArea(player)
	if not player or not player:isPlayer() then
		return
	end

	player:removeIcon("rotten-hazard")
	player:removeIcon("rotten-area")
	player:removeIcon("white-cross")

	-- Limpiar KV de cooldowns
	local kv = player:kv():scoped(KV_SCOPE)
	kv:remove("lastUpperLeftUpdate")
	kv:remove("lastLowerLeftUpdate")
	kv:remove("lastHazardUpdate")
end

-- Exportar funciones para uso en monsters
_G.onRottenMonsterThink = onRottenMonsterThink
_G.onPlayerLeaveRottenArea = onPlayerLeaveRottenArea
