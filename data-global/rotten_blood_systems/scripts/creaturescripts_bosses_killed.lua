local rottenZones = Zone("kill.monsters.rottenareas")

-- murcion
rottenZones:addArea({ x = 33800, y = 31653, z = 14 }, { x = 33941, y = 31771, z = 14 })
rottenZones:addArea({ x = 33800, y = 31653, z = 15 }, { x = 33911, y = 31714, z = 15 })
-- chagorz
rottenZones:addArea({ x = 33800, y = 31809, z = 14 }, { x = 33937, y = 31931, z = 14 })
rottenZones:addArea({ x = 33800, y = 31809, z = 15 }, { x = 33937, y = 31931, z = 15 })
-- ichgahal
rottenZones:addArea({ x = 34000, y = 31657, z = 14 }, { x = 34126, y = 31768, z = 14 })
rottenZones:addArea({ x = 34000, y = 31657, z = 15 }, { x = 34126, y = 31768, z = 15 })
-- Vemiath
rottenZones:addArea({ x = 33985, y = 31807, z = 14 }, { x = 34137, y = 31932, z = 14 })
rottenZones:addArea({ x = 33985, y = 31807, z = 15 }, { x = 34137, y = 31932, z = 15 })
-- Boss rooms (piso 15) - zona general que cubre todas las salas de bosses
rottenZones:addArea({ x = 32966, y = 32324, z = 15 }, { x = 33088, y = 32410, z = 15 })

-- Function to get player's rotten blood taint level
local function getRottenBloodTaintLevel(player)
	local kv = player:kv():scoped("rotten-blood-quest")
	local currentTaintKV = kv:get("taints") or 0

	-- Also check condition-based taint (for Bakragore mechanics)
	local currentTaintCondition = 0
	local taintCondition = player:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
	if taintCondition then
		currentTaintCondition = taintCondition:getParameter(CONDITION_PARAM_SUBID) or 0
	end

	-- Return the higher of the two taint levels
	return math.max(currentTaintKV, currentTaintCondition)
end

-- Function to get minimum taint level from party
local function getPartyMinTaintLevel(player)
	local party = player:getParty()
	if not party then
		-- Solo player - return their own taint level
		return getRottenBloodTaintLevel(player)
	end

	-- Player is in party - find minimum taint level
	local minTaintLevel = 999
	local partyMembers = party:getMembers()

	-- Check leader's taint level
	local leader = party:getLeader()
	if leader then
		local leaderTaint = getRottenBloodTaintLevel(leader)
		minTaintLevel = math.min(minTaintLevel, leaderTaint)
	end

	-- Check all members' taint levels
	for _, member in ipairs(partyMembers) do
		if member and member:isPlayer() then
			local memberTaint = getRottenBloodTaintLevel(member)
			minTaintLevel = math.min(minTaintLevel, memberTaint)
		end
	end

	return minTaintLevel == 999 and 0 or minTaintLevel
end

-- Function to update Hazard icon based on party minimum taint level and area
function updateRottenHazardIcon(player)
	local taintLevel = getPartyMinTaintLevel(player)
	local isInRottenArea = rottenZones:isInZone(player:getPosition())
	local party = player:getParty()

	if isInRottenArea and taintLevel > 0 then
		-- Convert taint level to icon level (1-4 visual icons only)
		local iconLevel = 0
		if taintLevel >= 1 and taintLevel <= 4 then
			iconLevel = taintLevel -- Taints 1-4 = Icons 1-4
		elseif taintLevel == 5 then
			iconLevel = 0 -- Taint 5 (Final Taint) = NO ICON (no penalties)
		elseif taintLevel >= 6 and taintLevel <= 9 then
			iconLevel = taintLevel - 5 -- Taint 6-9 = Icons 1-4 again
		end

		if iconLevel > 0 then
			-- Show Hazard icon with calculated icon level
			player:setIcon("rotten-hazard", CreatureIconCategory_Quests, CreatureIconQuests_Hazard, iconLevel)

			-- Debug log
			if party then
				logger.debug("Party Hazard Update: Player {} taint {} -> icon level {} (party minimum)", player:getName(), taintLevel, iconLevel)
			else
				logger.debug("Solo Hazard Update: Player {} taint {} -> icon level {}", player:getName(), taintLevel, iconLevel)
			end
		else
			-- Taint 5 (Final Taint) - No icon, no penalties
			player:removeIcon("rotten-hazard")
			logger.debug("Final Taint: Player {} has taint 5 (no icon, no penalties)", player:getName())
		end
	else
		-- Player is not in rotten area or has no hazard level - remove Hazard icon
		player:removeIcon("rotten-hazard")
		logger.debug("Hazard Removed: Player {} removed hazard icon (not in area or no taint)", player:getName())
	end
end

-- Function to remove Hazard icon (for cleanup)
function removeRottenHazardIcon(player)
	player:removeIcon("rotten-hazard")
end

-- Function to get hazard level from icon (for use in combat systems)
function getPlayerHazardLevel(player)
	local hazardIcon = player:getIcon("rotten-hazard")
	if hazardIcon and hazardIcon.category == CreatureIconCategory_Quests and hazardIcon.icon == CreatureIconQuests_Hazard then
		return hazardIcon.count or 0
	end
	return 0
end

-- Function to check if player is in upper left area
local function isInUpperLeftArea(player)
	local pos = player:getPosition()
	-- Area superior izquierda: (33800, 31653) a (33941, 31771) en ambos pisos
	return (pos.x >= 33800 and pos.x <= 33941 and pos.y >= 31653 and pos.y <= 31771 and (pos.z == 14 or pos.z == 15))
end

-- Function to check if player is in lower left area
local function isInLowerLeftArea(player)
	local pos = player:getPosition()
	-- Area inferior izquierda: (33800, 31809) a (33937, 31931) en ambos pisos
	return (pos.x >= 33800 and pos.x <= 33937 and pos.y >= 31809 and pos.y <= 31931 and (pos.z == 14 or pos.z == 15))
end

-- Function to increment rotten area icon for upper left area
local function incrementRottenAreaIcon(player)
	local currentIcon = player:getIcon("rotten-area")
	if not currentIcon or currentIcon.category ~= CreatureIconCategory_Quests or currentIcon.icon ~= CreatureIconQuests_ArrowUp then
		player:setIcon("rotten-area", CreatureIconCategory_Quests, CreatureIconQuests_ArrowUp, 1)
	else
		local newCount = currentIcon.count + 1
		player:setIcon("rotten-area", CreatureIconCategory_Quests, CreatureIconQuests_ArrowUp, newCount)
		logger.debug("Upper Left Area: Player {} rotten area icon incremented to {}", player:getName(), newCount)
	end
end

-- Function to manage whitecross icon for lower left area
local function manageWhiteCrossIcon(player)
	local currentIcon = player:getIcon("white-cross")
	if not currentIcon or currentIcon.category ~= CreatureIconCategory_Quests or currentIcon.icon ~= CreatureIconQuests_RedCross then
		player:setIcon("white-cross", CreatureIconCategory_Quests, CreatureIconQuests_RedCross, 1)
	else
		local newCount = currentIcon.count + 1
		player:setIcon("white-cross", CreatureIconCategory_Quests, CreatureIconQuests_RedCross, newCount)
		logger.debug("Lower Left Area: Player {} white cross icon incremented to {}", player:getName(), newCount)

		-- Check if reached 111 icons
		if newCount >= 111 then
			-- Apply energy damage over 5 seconds
			local damage = math.random(1200, 1300)
			logger.debug("Lower Left Area: Player {} reached 111 white cross icons, applying {} energy damage", player:getName(), damage)

			-- Apply damage over 5 seconds (every second)
			for i = 1, 5 do
				addEvent(function(playerId)
					local eventPlayer = Player(playerId)
					if eventPlayer and eventPlayer:isPlayer() then
						doTargetCombatHealth(nil, eventPlayer, COMBAT_ENERGYDAMAGE, -damage, -damage, CONST_ME_ENERGYHIT)
					end
				end, i * 1000, player:getId()) -- 1, 2, 3, 4, 5 seconds
			end

			-- Reset white cross icon to 0
			player:setIcon("white-cross", CreatureIconCategory_Quests, CreatureIconQuests_RedCross, 0)
		end
	end
end

-- Function to remove whitecross icon when leaving lower left area
local function removeWhiteCrossIcon(player)
	player:removeIcon("white-cross")
	logger.debug("Lower Left Area: Player {} removed white cross icon", player:getName())
end

-- Funciones addIconsRotten y ticksIconsRotten eliminadas
-- Ya no se usan porque el sistema de matar monsters para íconos ArrowUp fue eliminado

-- Sistema de matar monsters para íconos ArrowUp eliminado
-- Ahora el ícono ArrowUp se incrementa automáticamente cada 10 segundos en el área superior izquierda

-- Event: Player death - remove all rotten blood icons
local playerDeathEvent = CreatureEvent("RottenBloodPlayerDeath")

function playerDeathEvent.onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if not player or not player:isPlayer() then
		return true
	end

	-- Remove all rotten blood related icons
	player:removeIcon("rotten-hazard")
	player:removeIcon("rotten-area")
	player:removeIcon("white-cross")

	logger.debug("Player Death: Removed all rotten blood icons from player {}", player:getName())

	return true
end

playerDeathEvent:register()

-- Event: Player login handled in rotten_area_login.lua

local bossesRottenBlood = CreatureEvent("RottenBloodBossDeath")

function bossesRottenBlood.onDeath(creature)
	local bossName = creature:getName():lower()

	local validBosses = { "murcion", "chagorz", "ichgahal", "vemiath", "bakragore" }
	if not table.contains(validBosses, bossName) then
		return false
	end

	-- Obtener todos los jugadores que hicieron daño
	local damagingPlayers = {}
	onDeathForDamagingPlayers(creature, function(_, player)
		table.insert(damagingPlayers, player)
	end)

	-- Determinar el nivel mínimo de taint del grupo
	local minTaintLevel = 9999
	for _, player in ipairs(damagingPlayers) do
		local kv = player:kv():scoped("rotten-blood-quest")
		local currentTaintKV = kv:get("taints") or 0
		local currentTaintCondition = 0
		local taintCondition = player:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
		if taintCondition then
			currentTaintCondition = taintCondition:getParameter(CONDITION_PARAM_SUBID) or 0
		end
		local currentTaint = math.max(currentTaintKV, currentTaintCondition)
		minTaintLevel = math.min(minTaintLevel, currentTaint)
	end

	-- Si no hay jugadores, salir
	if #damagingPlayers == 0 then
		return false
	end

	-- Procesar cada jugador individualmente
	for _, player in ipairs(damagingPlayers) do
		local now = os.time()
		local kv = player:kv():scoped("rotten-blood-quest")

		-- Leer taint desde KV y desde Condition, tomar el mayor
		local currentTaintKV = kv:get("taints") or 0
		local currentTaintCondition = 0
		local taintCondition = player:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
		if taintCondition then
			currentTaintCondition = taintCondition:getParameter(CONDITION_PARAM_SUBID) or 0
		end
		local currentTaint = math.max(currentTaintKV, currentTaintCondition)

		-- Solo puede obtener taint si tiene al menos el nivel mínimo del grupo
		if currentTaint < minTaintLevel then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need at least " .. minTaintLevel .. " taints to gain corruption from this boss.")
			goto continue
		end

		local nextTaint = nil
		local cooldownPeriod = 20 * 60 * 60 -- 20 horas

		if bossName ~= "bakragore" then
			-- Guardar flag de miniboss derrotado
			kv:scoped(bossName):set("defeated", true)

			-- Minis:
			if currentTaint >= 0 and currentTaint <= 3 then
				nextTaint = currentTaint + 1
			elseif currentTaint == 5 then
				nextTaint = 6
			elseif currentTaint >= 6 and currentTaint <= 8 then
				nextTaint = currentTaint + 1
			end

			-- Sistema de dropeo de esencias (solo con taint 5+)
			if currentTaint >= 5 and corpse then
				-- Determinar chance de esencia según taint level
				local essenceChance = 0
				if currentTaint == 5 then
					essenceChance = 30 -- 30% con taint 5
				elseif currentTaint == 6 then
					essenceChance = 40 -- 40% con taint 6
				elseif currentTaint == 7 then
					essenceChance = 50 -- 50% con taint 7
				elseif currentTaint == 8 then
					essenceChance = 60 -- 60% con taint 8
				elseif currentTaint >= 9 then
					essenceChance = 70 -- 70% con taint 9
				end

				local roll = math.random(100)
				if roll <= essenceChance then
					-- Dropear la esencia correspondiente al boss
					local essenceIds = {
						murcion = 43501, -- the essence of Murcion
						ichgahal = 43502, -- the essence of Ichgahal
						chagorz = 43504, -- the essence of Chagorz
						vemiath = 43503, -- the essence of Vemiath
					}

					local essenceId = essenceIds[bossName]
					if essenceId then
						corpse:addItem(essenceId, 1)
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your Final Taint (taint " .. currentTaint .. ") allowed you to obtain the essence! (chance: " .. essenceChance .. "%)")
						logger.debug("Player {} with taint {} obtained essence from {} (chance: {}%, roll: {})", player:getName(), currentTaint, bossName, essenceChance, roll)
					end
				else
					logger.debug("Player {} with taint {} did not get essence from {} (chance: {}%, roll: {})", player:getName(), currentTaint, bossName, essenceChance, roll)
				end
			end
		else
			-- Bakragore
			if currentTaint == 4 then
				nextTaint = 5
			end

			-- Taint 9: Bakragore puede dropear hasta 3 bags especiales
			if currentTaint == 9 then
				local extraBags = math.random(1, 3)
				for i = 1, extraBags do
					local bagType = math.random(1, 2)
					local bagId = bagType == 1 and 43895 or 43860 -- bag you covet normal o grand sanguine
					if corpse then
						corpse:addItem(bagId, 1)
					end
				end
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Your maximum taint level grants you %d extra bags!", extraBags))
				logger.info("Player {} with taint 9 received {} extra bags from Bakragore", player:getName(), extraBags)
			end

			-- Al morir Bakragore limpiar flags de minibosses
			for _, mini in ipairs({ "murcion", "chagorz", "ichgahal", "vemiath" }) do
				kv:scoped(mini):remove("defeated")
			end
		end

		local bossCooldown = kv:scoped(bossName):get("cooldown") or 0
		if bossCooldown <= now and nextTaint then
			kv:scoped(bossName):set("cooldown", now + cooldownPeriod)
			kv:set("taints", nextTaint)

			-- Remover cualquier condición de bakragore existente
			if taintCondition then
				player:removeCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
			end

			-- Crear nueva condición con el nivel de taint correcto
			local condition = Condition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
			condition:setParameter(CONDITION_PARAM_SUBID, nextTaint)
			condition:setParameter(CONDITION_PARAM_TICKS, 7 * 24 * 60 * 60 * 1000)
			player:addCondition(condition)

			-- Actualizar icono de hazard inmediatamente después de cambiar el taint (como en Mexas)
			if updateRottenHazardIcon then
				updateRottenHazardIcon(player)

				-- Si el jugador está en party, actualizar todos los miembros
				local party = player:getParty()
				if party then
					local partyMembers = party:getMembers()
					local leader = party:getLeader()

					if leader and leader:isPlayer() then
						updateRottenHazardIcon(leader)
					end

					for _, member in ipairs(partyMembers) do
						if member and member:isPlayer() then
							updateRottenHazardIcon(member)
						end
					end
				end
			end

			-- Forzar actualización visual del cliente con un pequeño delay (backup, como en Mexas)
			addEvent(function(playerId)
				local eventPlayer = Player(playerId)
				if eventPlayer and updateRottenHazardIcon then
					updateRottenHazardIcon(eventPlayer)

					local party = eventPlayer:getParty()
					if party then
						local partyMembers = party:getMembers()
						local leader = party:getLeader()

						if leader and leader:isPlayer() then
							updateRottenHazardIcon(leader)
						end

						for _, member in ipairs(partyMembers) do
							if member and member:isPlayer() then
								updateRottenHazardIcon(member)
							end
						end
					end
				end
			end, 100, player:getId())

			if bossName == "bakragore" and nextTaint == 5 then
				if not player:hasOutfit("1663") or not player:hasOutfit("1662") then
					player:addOutfitAddon("1663", 1)
					player:addOutfitAddon("1662", 1)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You have won a Decaying Defender Outfit.")
				end
			end

			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Your Bakragore taint has increased to level %d!", nextTaint))
			logger.info("Player {} taint increased to: {}", player:getName(), nextTaint)
		else
			if bossCooldown > now then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This boss is still on cooldown for you.")
			elseif not nextTaint then
				if bossName == "bakragore" then
					if currentTaint < 4 then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to defeat all four mini-bosses before facing Bakragore.")
					elseif currentTaint >= 5 then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already defeated Bakragore and obtained its taint.")
					end
				else
					if currentTaint == 4 then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must defeat Bakragore to advance to the next taint level.")
					elseif currentTaint == 9 then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have reached the maximum taint level.")
					end
				end
			end
		end

		::continue::
	end

	return true
end
bossesRottenBlood:register()
