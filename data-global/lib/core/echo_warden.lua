-- ============================================================================
-- Echo Raids / Echo Wardens - shared library (pure Lua)
-- IMPORTANT: lives in data/libs/functions/ (NOT data/global/lib/, which does
-- not exist in this fork). Registered from data/libs/functions/load.lua so it
-- loads before every revscriptsys data/scripts file at boot.
--
-- Verified APIs only:
--   Monster:setForgeStack/getForgeStack (C++; applyStacks buffs HP, icon "forge")
--   Creature:setMaxHealth/setHealth/getMaxHealth/setIcon (C++)
--   Monster:setStorageValue/getStorageValue (Lua fallback in monster.lua;
--       getStorageValue returns -1 when unset, so compare with == 1)
--   MonsterType:BestiaryStars/raceId/name/isRewardBoss/bossRace
--   Player:addMinorCharmEchoes/sendLeaderMonsterKilledBanner/kv():scoped() (boolean round-trips)
--   Game.createMonster(name,pos,extended,force,master,spawnEffect) (returns nil on fail)
--   Game.getSpectators(pos, multifloor, onlyPlayer, minX,maxX,minY,maxY)
--   addEvent, Tile:hasFlag/getGround, Position:sendMagicEffect
-- ============================================================================

EchoWarden = EchoWarden or {}

-- ----------------------------- TUNABLES -------------------------------------
EchoWarden.PORTAL_ITEM_ID = 54133
EchoWarden.PORTAL_ATTR_KIND = "echoKind" -- item:setCustomAttribute key
EchoWarden.PORTAL_TTL_MS = 120000 -- portal self-removes after 2 min (counted from when it appears)
EchoWarden.PORTAL_DELAY_MS = 30000 -- portal appears 30s AFTER the kill (not instantly)

EchoWarden.SPAWN_CHANCE_NUM = 100 -- 100 / 200000 = 0.05%
EchoWarden.SPAWN_CHANCE_DEN = 200000

EchoWarden.WARDEN_ADDS_MIN, EchoWarden.WARDEN_ADDS_MAX = 7, 12 -- cantidad de minions por raid

EchoWarden.WARDEN_HP_MULT = 4.0
EchoWarden.WARDEN_ATK_MULT = 1.5 -- only used if optional C++ applied
EchoWarden.USE_CPP_ATK = true -- set true only if applyEchoWarden compiled

EchoWarden.AURA_RANGE = 5
EchoWarden.AURA_MS = 2000

EchoWarden.SCATTER_RADIUS = 3 -- (unused now: spawns land on the portal tile)
EchoWarden.SPAWN_EFFECT = CONST_ME_NONE -- monsters are born silently (no teleport flash)
EchoWarden.SPAWN_STEP_MS = 400 -- delay between each monster (born one after another)

EchoWarden.STORAGE_IS_WARDEN = 54133 -- 1 = this monster is THE echo warden
EchoWarden.STORAGE_IS_SPAWNED = 54134 -- 1 = spawned by an echo raid (never re-triggers)
EchoWarden.KV_SCOPE = "echo_warden" -- player:kv():scoped(...) for first-kill

-- first-kill reward (MINOR CHARM ECHOES) by bestiary difficulty (stars). 0-star fall back to [0].
EchoWarden.ECHOES_BY_STARS = { [0] = 1, [1] = 10, [2] = 15, [3] = 20, [4] = 25, [5] = 30 }

-- runtime map: wardenCreatureId -> baseKindName (aura loop + reward lookup)
EchoWarden.activeWardens = EchoWarden.activeWardens or {}
EchoWarden.activeMinions = EchoWarden.activeMinions or {}
EchoWarden.GLOW_REFRESH_MS = 400
EchoWarden._glowLoop = false

function EchoWarden.pickTile(center, radius)
	radius = radius or EchoWarden.SCATTER_RADIUS
	for _ = 1, 12 do
		local dx = math.random(-radius, radius)
		local dy = math.random(-radius, radius)
		local p = Position(center.x + dx, center.y + dy, center.z)
		local tile = Tile(p)
		if tile and tile:getGround() and not tile:hasFlag(TILESTATE_BLOCKSOLID) and not tile:hasFlag(TILESTATE_PROTECTIONZONE) and not tile:hasFlag(TILESTATE_FLOORCHANGE) and not tile:hasFlag(TILESTATE_TELEPORT) then
			return p
		end
	end
	return center
end

function EchoWarden.markSpawned(m)
	if m and m.setStorageValue then
		m:setStorageValue(EchoWarden.STORAGE_IS_SPAWNED, 1)
	end
end

EchoWarden.STORAGE_IS_MINION = 54135
EchoWarden.MINION_HP_MULT = 1.5
function EchoWarden.makeMinion(m)
	if not m then
		return
	end
	if m:getStorageValue(EchoWarden.STORAGE_IS_MINION) ~= 1 then
		m:setStorageValue(EchoWarden.STORAGE_IS_MINION, 1)
		m:setMaxHealth(math.floor(m:getMaxHealth() * EchoWarden.MINION_HP_MULT))
		m:setHealth(m:getMaxHealth())
		EchoWarden.markSpawned(m) -- nunca re-dispara un portal
	end
	EchoWarden.activeMinions[m:getId()] = true
	EchoWarden.sendCreatureGlow(m, EchoWarden.STATE_MINION) -- glow nativo de MINION (state 1)
	EchoWarden.ensureGlowLoop() -- re-envío continuo (persiste al moverse)
end

EchoWarden.STATE_LEADER = 0
EchoWarden.STATE_MINION = 1
EchoWarden.GLOW_RANGE = 11 -- tiles a la redonda para mandar el glow a los spectators

---@param creature Creature
---@param state number 0=leader, 1=minion
function EchoWarden.sendCreatureGlow(creature, state)
	if not creature then
		return
	end
	local cid = creature:getId()
	local pos = creature:getPosition()
	if not pos then
		return
	end
	local r = EchoWarden.GLOW_RANGE
	for _, spec in ipairs(Game.getSpectators(pos, false, true, r, r, r, r)) do
		local msg = NetworkMessage()
		msg:addByte(0x8B)
		msg:addU32(cid)
		msg:addByte(0x0f)
		msg:addByte(1)
		msg:addByte(state) -- 0=leader, 1=minion
		msg:sendToPlayer(spec)
	end
end

function EchoWarden.glowRefresh()
	local any = false
	for id in pairs(EchoWarden.activeWardens) do
		local w = Monster(id)
		if w and not w:isRemoved() and w:getHealth() > 0 then
			EchoWarden.sendCreatureGlow(w, EchoWarden.STATE_LEADER)
			any = true
		else
			EchoWarden.activeWardens[id] = nil
		end
	end
	for id in pairs(EchoWarden.activeMinions) do
		local m = Monster(id)
		if m and not m:isRemoved() and m:getHealth() > 0 then
			EchoWarden.sendCreatureGlow(m, EchoWarden.STATE_MINION)
			any = true
		else
			EchoWarden.activeMinions[id] = nil
		end
	end
	if any then
		addEvent(EchoWarden.glowRefresh, EchoWarden.GLOW_REFRESH_MS)
	else
		EchoWarden._glowLoop = false
	end
end

function EchoWarden.ensureGlowLoop()
	if not EchoWarden._glowLoop then
		EchoWarden._glowLoop = true
		EchoWarden.glowRefresh()
	end
end

function EchoWarden.makeWarden(w, kindName)
	if not w then
		return
	end
	if EchoWarden.USE_CPP_ATK and w.applyEchoWarden then
		w:applyEchoWarden(EchoWarden.WARDEN_HP_MULT, EchoWarden.WARDEN_ATK_MULT)
		w:removeIcon("warden")
	else
		w:setMaxHealth(math.floor(w:getMaxHealth() * EchoWarden.WARDEN_HP_MULT))
		w:setHealth(w:getMaxHealth())
	end
	w:setStorageValue(EchoWarden.STORAGE_IS_WARDEN, 1)
	w:setStorageValue(EchoWarden.STORAGE_IS_SPAWNED, 1)
	EchoWarden.activeWardens[w:getId()] = kindName
	EchoWarden.sendCreatureGlow(w, EchoWarden.STATE_LEADER)
	EchoWarden.ensureGlowLoop()
end

function EchoWarden.aura(wardenId, kindName)
	local w = Monster(wardenId)
	if not w or w:isRemoved() or w:getHealth() <= 0 then
		EchoWarden.activeWardens[wardenId] = nil
		return
	end
	local p = w:getPosition()
	local r = EchoWarden.AURA_RANGE
	for _, c in ipairs(Game.getSpectators(p, false, false, r, r, r, r)) do
		local m = c:getMonster()
		if m and m:getId() ~= wardenId and m:getName() == kindName and m:getStorageValue(EchoWarden.STORAGE_IS_WARDEN) ~= 1 then
			EchoWarden.makeMinion(m)
		end
	end
	addEvent(EchoWarden.aura, EchoWarden.AURA_MS, wardenId, kindName)
end

function EchoWarden.trickleSpawn(kindName, cx, cy, cz, remaining, stepMs)
	if remaining <= 0 then
		return
	end
	local m = Game.createMonster(kindName, Position(cx, cy, cz), false, true, nil, EchoWarden.SPAWN_EFFECT)
	if m then
		EchoWarden.makeMinion(m)
	end
	addEvent(EchoWarden.trickleSpawn, stepMs, kindName, cx, cy, cz, remaining - 1, stepMs)
end

function EchoWarden.spawnPortal(px, py, pz, kindName)
	local pos = Position(px, py, pz)
	local tile = Tile(pos)
	if not tile or not tile:getGround() then
		return
	end
	local portal = Game.createItem(EchoWarden.PORTAL_ITEM_ID, 1, pos)
	if not portal then
		return
	end
	portal:setCustomAttribute(EchoWarden.PORTAL_ATTR_KIND, kindName)
	pos:sendMagicEffect(CONST_ME_TELEPORT)
	-- failsafe cleanup if nobody steps on it
	addEvent(function(qx, qy, qz)
		local t = Tile(Position(qx, qy, qz))
		if t then
			local it = t:getItemById(EchoWarden.PORTAL_ITEM_ID)
			if it then
				it:remove()
			end
		end
	end, EchoWarden.PORTAL_TTL_MS, px, py, pz)
end

function EchoWarden.runRaid(kindName, center)
	if not kindName or kindName == "" then
		return
	end
	local cx, cy, cz = center.x, center.y, center.z
	local step = EchoWarden.SPAWN_STEP_MS

	local w = Game.createMonster(kindName, Position(cx, cy, cz), false, true, nil, EchoWarden.SPAWN_EFFECT)
	if w then
		EchoWarden.makeWarden(w, kindName)
		addEvent(EchoWarden.aura, EchoWarden.AURA_MS, w:getId(), kindName)
	end

	local adds = math.random(EchoWarden.WARDEN_ADDS_MIN, EchoWarden.WARDEN_ADDS_MAX)
	EchoWarden.trickleSpawn(kindName, cx, cy, cz, adds, step)
end

function EchoWarden.grantReward(player, baseKind)
	if not player or not baseKind or baseKind == "" then
		return false
	end
	local kv = player:kv():scoped(EchoWarden.KV_SCOPE)
	if kv:get(baseKind) then
		return false
	end

	local mt = MonsterType(baseKind)
	local stars = (mt and mt:BestiaryStars()) or 0
	local amount = EchoWarden.ECHOES_BY_STARS[stars] or EchoWarden.ECHOES_BY_STARS[0]
	player:addMinorCharmEchoes(amount)
	kv:set(baseKind, true)

	local raceId = (mt and mt:raceId()) or 0
	if raceId > 0 then
		player:sendLeaderMonsterKilledBanner(raceId, amount)
	end
	return true
end
