-- Shards of a Broken Moon - The Moonsnow Magnolia Fight & Teleports
local config = {
	bossName = "The Moonsnow Magnolia",
	bossPos = Position(33929, 32754, 9),

	-- Portais de entrada e saída
	entrancePos = Position(33901, 32718, 9), -- Portal fora (na ante-sala)
	playerSpawnPos = Position(33929, 32763, 9), -- Entrada dentro da arena (2 sqm ao norte do portal de saída)
	exitPortalPos = Position(33929, 32765, 9), -- Portal de saída dentro da arena
	playerExitPos = Position(33901, 32716, 9), -- Posição de saída fora (2 sqm ao norte do portal externo)

	-- Limites da arena
	roomCenter = Position(33929, 32754, 9),
	roomArea = {
		from = Position(33909, 32738, 9),
		to = Position(33950, 32773, 9),
	},
	rangeX = 22,
	rangeY = 20,

	-- Adds iniciais
	jaracals = {
		Position(33926, 32754, 9),
		Position(33932, 32754, 9),
	},

	-- Poças de Moonsilver Drift
	drifts = {
		Position(33922, 32748, 9),
		Position(33936, 32748, 9),
		Position(33921, 32758, 9),
		Position(33937, 32758, 9),
		Position(33929, 32760, 9),
	},

	fightDuration = 10 * 60, -- 10 minutos
	cooldownHours = 20, -- 20 horas
}

-- Estado global da luta ativa
MoonsnowMagnoliaFight = {
	active = false,
	phase = 1,
	lastFiddleTime = 0,
	bossGuid = 0,
	playerId = 0,
	kickEvent = nil,
	watchdogEvent = nil,
}

local function clearRoom()
	local spectators = Game.getSpectators(config.roomCenter, false, false, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, spec in ipairs(spectators) do
		if spec:isMonster() then
			spec:remove()
		end
	end

	-- Remove Moonsilver Drifts residuais
	for _, pos in ipairs(config.drifts) do
		local tile = Tile(pos)
		if tile then
			local item = tile:getItemById(54235)
			if item then
				item:remove()
			end
		end
	end
end

local function kickPlayer(playerId)
	local player = Player(playerId)
	if player then
		player:teleportTo(config.playerExitPos)
		config.playerExitPos:sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your time inside The Moonsnow Magnolia's lair has expired!")
	end
	clearRoom()
	MoonsnowMagnoliaFight.active = false
	MoonsnowMagnoliaFight.phase = 1
	MoonsnowMagnoliaFight.playerId = 0
	if MoonsnowMagnoliaFight.watchdogEvent then
		stopEvent(MoonsnowMagnoliaFight.watchdogEvent)
		MoonsnowMagnoliaFight.watchdogEvent = nil
	end
end

local function fiddleWatchdog()
	if not MoonsnowMagnoliaFight.active then
		return
	end

	-- Se o boss ainda estiver vivo e na fase 1
	if MoonsnowMagnoliaFight.phase == 1 then
		local timeWithoutFiddle = os.time() - MoonsnowMagnoliaFight.lastFiddleTime
		if timeWithoutFiddle >= 70 then
			local boss = Monster(MoonsnowMagnoliaFight.bossGuid)
			if boss and not boss:isDead() then
				boss:say("Come feast, my darlings!", TALKTYPE_MONSTER_YELL)
				-- Invoca 4 Furious Jaracal punitivos
				local spawnPositions = {
					Position(33927, 32752, 9),
					Position(33931, 32752, 9),
					Position(33927, 32756, 9),
					Position(33931, 32756, 9),
				}
				for _, pos in ipairs(spawnPositions) do
					local m = Game.createMonster("Furious Jaracal", pos, true, true)
					if m then
						pos:sendMagicEffect(CONST_ME_TELEPORT)
					end
				end
			end
			-- Reinicia o contador para evitar flood
			MoonsnowMagnoliaFight.lastFiddleTime = os.time()
		end
	end

	-- Repete a verificação a cada 3 segundos
	MoonsnowMagnoliaFight.watchdogEvent = addEvent(fiddleWatchdog, 3000)
end

-- 1. Portal de Entrada (33901, 32718, 9)
local magnoliaEntrance = MoveEvent()

function magnoliaEntrance.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	-- Checagem de cooldown (20 horas)
	local timeLeft = player:getBossCooldown(config.bossName) - os.time()
	if timeLeft > 0 then
		player:teleportTo(fromPosition, true)
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to wait " .. Game.getTimeInWords(timeLeft) .. " to face " .. config.bossName .. " again!")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	-- Checagem se a sala está ocupada por outro jogador
	local spectators = Game.getSpectators(config.roomCenter, false, true, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	if #spectators > 0 then
		player:teleportTo(fromPosition, true)
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is already fighting " .. config.bossName .. ". Please wait.")
		return true
	end

	-- Limpa monstros de lutas anteriores
	clearRoom()

	-- Teleporta o jogador para dentro
	player:teleportTo(config.playerSpawnPos)
	config.playerSpawnPos:sendMagicEffect(CONST_ME_TELEPORT)
	player:setDirection(DIRECTION_NORTH)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have entered The Moonsnow Magnolia's lair! You have 10 minutes.")

	-- Registra cooldown de 20 horas
	player:setBossCooldown(config.bossName, os.time() + config.cooldownHours * 3600)

	-- Spawna o boss
	local boss = Game.createMonster(config.bossName, config.bossPos, true, true)
	if boss then
		config.bossPos:sendMagicEffect(CONST_ME_TELEPORT)
		boss:registerEvent("MoonsnowMagnoliaPrepareDeath")
		boss:registerEvent("MoonsnowMagnoliaDeath")
		boss:registerEvent("MoonsnowMagnoliaHealth")
		MoonsnowMagnoliaFight.bossGuid = boss:getId()
	end

	-- Spawna os 2 Furious Jaracal iniciais
	for _, pos in ipairs(config.jaracals) do
		local jaracal = Game.createMonster("Furious Jaracal", pos, true, true)
		if jaracal then
			pos:sendMagicEffect(CONST_ME_TELEPORT)
		end
	end

	-- Spawna as poças de Moonsilver Drift
	for _, pos in ipairs(config.drifts) do
		Game.createItem(54235, 1, pos)
		pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	end

	-- Configura o estado da luta
	MoonsnowMagnoliaFight.active = true
	MoonsnowMagnoliaFight.phase = 1
	MoonsnowMagnoliaFight.lastFiddleTime = os.time()
	MoonsnowMagnoliaFight.playerId = player:getId()

	-- Inicia o timer de 10 minutos
	if MoonsnowMagnoliaFight.kickEvent then
		stopEvent(MoonsnowMagnoliaFight.kickEvent)
	end
	MoonsnowMagnoliaFight.kickEvent = addEvent(kickPlayer, config.fightDuration * 1000, player:getId())

	-- Inicia o watchdog do Bone Fiddle
	if MoonsnowMagnoliaFight.watchdogEvent then
		stopEvent(MoonsnowMagnoliaFight.watchdogEvent)
	end
	MoonsnowMagnoliaFight.watchdogEvent = addEvent(fiddleWatchdog, 3000)

	return true
end

magnoliaEntrance:type("stepin")
magnoliaEntrance:position(config.entrancePos)
magnoliaEntrance:register()

-- 2. Portal de Saída (33929, 32765, 9)
local magnoliaExit = MoveEvent()

function magnoliaExit.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	player:teleportTo(config.playerExitPos)
	config.playerExitPos:sendMagicEffect(CONST_ME_TELEPORT)
	player:setDirection(DIRECTION_NORTH)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have left the lair.")

	-- Se o jogador ativo saiu da sala, encerra o combate e limpa
	if MoonsnowMagnoliaFight.playerId == player:getId() then
		clearRoom()
		MoonsnowMagnoliaFight.active = false
		MoonsnowMagnoliaFight.phase = 1
		MoonsnowMagnoliaFight.playerId = 0
		if MoonsnowMagnoliaFight.kickEvent then
			stopEvent(MoonsnowMagnoliaFight.kickEvent)
			MoonsnowMagnoliaFight.kickEvent = nil
		end
		if MoonsnowMagnoliaFight.watchdogEvent then
			stopEvent(MoonsnowMagnoliaFight.watchdogEvent)
			MoonsnowMagnoliaFight.watchdogEvent = nil
		end
	end

	return true
end

magnoliaExit:type("stepin")
magnoliaExit:position(config.exitPortalPos)
magnoliaExit:register()
