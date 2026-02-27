local entrances = {
	-- Murcion
	{ pos = Position(34092, 31978, 14), dest = Position(33842, 31651, 13), setIcon = true }, -- enter Murcion area
	{ pos = Position(33842, 31650, 13), dest = Position(34092, 31979, 14), removeIcon = true }, -- leave Murcion area
	{ pos = Position(33905, 31693, 15), dest = Position(32971, 32368, 15), requiresShields = true }, -- Murcion lever room

	-- Chagorz
	{ pos = Position(34093, 32009, 14), dest = Position(33809, 31815, 13), setIcon = true }, -- enter Chagorz area
	{ pos = Position(33809, 31814, 13), dest = Position(34092, 32009, 14), removeIcon = true }, -- leave Chagorz area
	{ pos = Position(33902, 31881, 15), dest = Position(33071, 32370, 15), requiresShields = true }, -- Chagorz lever room

	-- Ichgahal
	{ pos = Position(34120, 31978, 14), dest = Position(34101, 31678, 13), setIcon = true }, -- enter Ichgahal area
	{ pos = Position(34101, 31677, 13), dest = Position(34119, 31979, 14), removeIcon = true }, -- leave Ichgahal area
	{ pos = Position(34065, 31716, 15), dest = Position(32971, 32336, 15), requiresShields = true }, -- Ichgahal lever room

	-- Vemiath
	{ pos = Position(34117, 32010, 15), dest = Position(34119, 31876, 14), setIcon = true }, -- enter Vemiath area
	{ pos = Position(34119, 31875, 14), dest = Position(34118, 32010, 15), removeIcon = true }, -- leave Vemiath area
	{ pos = Position(34002, 31820, 15), dest = Position(33071, 32336, 15), requiresShields = true }, -- Vemiath lever room

	-- Bakragore leave room (sin icon logic)
	{ pos = Position(33069, 32405, 15), dest = Position(34106, 32052, 13) },

	{ pos = Position(33848, 31994, 10), dest = Position(33848, 31994, 10), setIcon = false }, -- rootkracken 1
}

local teleportEvent = Action()

function teleportEvent.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return false
	end

	local access = player:kv():scoped("rotten-blood-quest"):get("access") or 0
	if access < 5 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You should pay respect to the Bloodshade guarding this realm before entering.")
		player:teleportTo(fromPosition, true)
		return false
	end

	for _, ent in pairs(entrances) do
		if ent.pos == item:getPosition() then
			-- Shield-point check if needed
			if ent.requiresShields then
				local icon = player:getIcon("rotten-area")
				if not icon or icon.count < 100 then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need 100 Rotten Points to enter this room.")
					player:teleportTo(fromPosition, true)
					return false
				end
			end

			-- Teleporta
			player:teleportTo(ent.dest)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

			-- Icon logic
			if ent.setIcon then
				-- pone ArrowUp con count 0
				player:setIcon("rotten-area", CreatureIconCategory_Quests, CreatureIconQuests_ArrowUp, 0)
			elseif ent.removeIcon then
				-- quita cualquier ArrowUp
				player:removeIcon("rotten-area")
				local currentIcon = player:getIcon("white-cross")
				if currentIcon then
					player:removeIcon("white-cross")
				end
				local currentIconRed = player:getIcon("red-cross")
				if currentIconRed then
					player:removeIcon("red-cross")
				end
			end

			break
		end
	end

	return true
end

-- registra todos los portales
for _, ent in pairs(entrances) do
	teleportEvent:position(ent.pos)
end
teleportEvent:register()

----------- Bakragore Entrance Check -----------
local entrance = {
	position = Position(34106, 32054, 13),
	destinationLowTaint = Position(33008, 32395, 15), -- Área sin acceso directo (< 5 taints)
	destinationHighTaint = Position(33071, 32404, 15), -- Bakragore lever room (>= 5 taints)
}

local bakragoreEntrance = Action()

function bakragoreEntrance.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return true
	end

	local kv = player:kv():scoped("rotten-blood-quest")
	local taints = kv:get("taints") or 0
	local level = player:getLevel()

	-- Verificación de nivel
	if level < 250 then
		player:sendCancelMessage("You need to be at least level 250 to enter Bakragore's lair.")
		player:teleportTo(fromPosition, true)
		return true
	end

	-- Verificación de mini bosses (solo la primera vez como quest)
	local miniBosses = { "murcion", "chagorz", "ichgahal", "vemiath" }
	local allDefeated = true

	for _, mini in ipairs(miniBosses) do
		local defeated = kv:scoped(mini):get("defeated")
		if not defeated then
			allDefeated = false
			break
		end
	end

	-- Primera vez: Necesita haber matado los 4 minibosses
	if not allDefeated then
		local missing = {}
		for _, mini in ipairs(miniBosses) do
			local defeated = kv:scoped(mini):get("defeated")
			if not defeated then
				table.insert(missing, mini:sub(1, 1):upper() .. mini:sub(2))
			end
		end
		player:sendCancelMessage("First time entry requires defeating all mini bosses: " .. table.concat(missing, ", "))
		player:teleportTo(fromPosition, true)
		return true
	end

	-- Después de la primera vez: Destino depende de taints
	local destination
	if taints < 5 then
		destination = entrance.destinationLowTaint
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need the Final Taint (5+) to access Bakragore's chamber. You are sent to the preparation area.")
	else
		destination = entrance.destinationHighTaint
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have the Final Taint! You step into Bakragore's lair...")
	end

	player:teleportTo(destination)
	return true
end

bakragoreEntrance:position(entrance.position)
bakragoreEntrance:register()

local cooldownSeconds = 2 * 60 -- 2 minutos

-- Lista de pilares/crystals que al usarlos se transforman (rotten crystal -> broken rotten crystal)
local pillarsID = {
	{ id = 43792, transformid = 43793 },
	{ id = 43794, transformid = 43795 },
	{ id = 43796, transformid = 43797 },
	{ id = 43798, transformid = 43799 },
	{ id = 43800, transformid = 43801 },
}

-- Lista de mushrooms (solo cooldown, sin transformación)
local mushroomsID = {
	43744, -- rotten mushroom
	43786, -- rotten mushroom
	43787, -- rotten mushroom
	43788, -- rotten mushroom
	43789, -- rotten mushroom
	43790, -- rotten mushroom
}

-- Convierte una posición a clave única para el KV
local function formatPosKey(pos)
	return string.format("%d_%d_%d", pos.x, pos.y, pos.z)
end

-- Suma 15 al contador (hasta 100) en el icono ArrowUp
local function ticksIconsRotten(player)
	local currentIcon = player:getIcon("rotten-area")
	local currentCount = 0

	-- Si el jugador NO tiene el ícono arrowUP, se le coloca con 15
	if not currentIcon or currentIcon.category ~= CreatureIconCategory_Quests or currentIcon.icon ~= CreatureIconQuests_ArrowUp then
		currentCount = 15
		player:setIcon("rotten-area", CreatureIconCategory_Quests, CreatureIconQuests_ArrowUp, currentCount)
		return currentCount
	end

	-- Si ya tiene el ícono arrowUP, se le suman 15 más
	currentCount = math.min(currentIcon.count + 15, 100)
	player:setIcon("rotten-area", CreatureIconCategory_Quests, CreatureIconQuests_ArrowUp, currentCount)
	return currentCount
end

-- Acción de uso del ítem (Pilares y Mushrooms)
local itemActionUse = Action()

function itemActionUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local itemId = item.itemid
	local isPillar = false
	local isMushroom = false
	local conf = nil

	-- 1) Verificamos si es un pilar (con transformación)
	for _, v in ipairs(pillarsID) do
		if v.id == itemId then
			conf = v
			isPillar = true
			break
		end
	end

	-- 2) Verificamos si es un mushroom (sin transformación)
	if not isPillar then
		for _, mushroomId in ipairs(mushroomsID) do
			if mushroomId == itemId then
				isMushroom = true
				break
			end
		end
	end

	-- Si no es ni pilar ni mushroom, no hacer nada
	if not isPillar and not isMushroom then
		return false
	end

	-- 3) Generamos la clave según la posición del ítem
	local posKey = formatPosKey(item:getPosition())
	local kvRoot = player:kv():scoped("itemCooldowns")
	local now = os.time()
	local cd = kvRoot:get(posKey) or 0

	-- 4) Chequeamos cooldown
	if cd > now then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You must wait %d seconds before using this again.", cd - now))
		return false
	end

	-- 5) Aplicamos nuevo cooldown
	kvRoot:set(posKey, now + cooldownSeconds)

	-- 6) Damos íconos y efecto visual
	ticksIconsRotten(player)
	player:getPosition():sendMagicEffect(CONST_ME_PURPLESMOKE)

	-- 7) Solo los pilares se transforman y tienen decay
	if isPillar and conf then
		item:transform(conf.transformid)
		item:decay()
	end
	-- Los mushrooms no se transforman, solo quedan inutilizables por el cooldown

	return true
end

-- Registramos la acción para cada ID de ítem (pillares y mushrooms)
for _, v in ipairs(pillarsID) do
	itemActionUse:id(v.id)
end
for _, mushroomId in ipairs(mushroomsID) do
	itemActionUse:id(mushroomId)
end
itemActionUse:register()
