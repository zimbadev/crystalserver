-- ============================================================================
-- Echo Warden Trigger - onDeath for every common/uncommon monster
-- (a) 0.05% chance to spawn echo warden portal (item 54133) at corpse tile,
--     appearing PORTAL_DELAY_MS (30s) AFTER the kill (not instantly).
-- (b) on tagged Echo Warden death -> first-kill charm reward per damager
-- Echo-raid-spawned creatures (STORAGE_IS_SPAWNED == 1) never re-trigger.
-- Registered to all 1-2 star monsters via GlobalEvent onStartup.
-- ============================================================================

local echoWardenTrigger = CreatureEvent("EchoWardenTrigger")

-- summon-aware list of players who damaged the creature
local function damagersOf(creature)
	local players, seen = {}, {}
	local dmap = creature:getDamageMap()
	if not dmap then
		return players
	end
	for cid, _ in pairs(dmap) do
		if cid and cid > 0 then
			local d = Creature(cid)
			if d then
				local pl
				if d:isPlayer() then
					pl = d:getPlayer()
				else
					local master = d:getMaster()
					if master and master:isPlayer() then
						pl = master:getPlayer()
					end
				end
				if pl and not seen[pl:getId()] then
					seen[pl:getId()] = true
					players[#players + 1] = pl
				end
			end
		end
	end
	return players
end

function echoWardenTrigger.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if not creature or not creature:isMonster() then
		return true
	end

	-- (b) tagged Echo Warden -> first-kill reward per damager, then stop.
	if creature:getStorageValue(EchoWarden.STORAGE_IS_WARDEN) == 1 then
		local baseKind = EchoWarden.activeWardens[creature:getId()] or creature:getName()
		EchoWarden.activeWardens[creature:getId()] = nil
		for _, player in ipairs(damagersOf(creature)) do
			EchoWarden.grantReward(player, baseKind)
		end
		return true
	end

	-- echo-raid-spawned creatures (warden + minions) never re-trigger.
	if creature:getStorageValue(EchoWarden.STORAGE_IS_SPAWNED) == 1 then
		return true
	end

	local mType = creature:getType()
	if not mType then
		return true
	end

	-- Guards: never spawn from summon / reward boss / bosstiary boss / forge / out-of-range stars.
	if creature:getMaster() ~= nil or mType:isRewardBoss() then
		return true
	end
	local br = mType.bossRace and mType:bossRace()
	if br and br ~= "" then
		return true
	end
	if creature.getForgeStack and creature:getForgeStack() > 0 then
		return true
	end
	local stars = mType:BestiaryStars() or 0
	if stars < 1 or stars > 2 then -- SOLO common/uncommon (1-2 estrellas) disparan Echo Raids (como Tibia RL)
		return true
	end

	-- (a) portal spawn roll
	if math.random(1, EchoWarden.SPAWN_CHANCE_DEN) > EchoWarden.SPAWN_CHANCE_NUM then
		return true
	end

	local kindName = creature:getName()
	local pos = creature:getPosition()
	addEvent(EchoWarden.spawnPortal, EchoWarden.PORTAL_DELAY_MS, pos.x, pos.y, pos.z, kindName)

	return true
end

echoWardenTrigger:register()

-- Register the death event to ALL common/uncommon monsters at boot.
local echoWardenStartup = GlobalEvent("EchoWardenTriggerStartup")

function echoWardenStartup.onStartup()
	local count = 0
	for stars = 1, 2 do -- SOLO common/uncommon (1-2 estrellas), como Tibia RL
		local monsters = Game.getMonstersByBestiaryStars(stars)
		if monsters then
			for _, mType in ipairs(monsters) do
				if mType:name() then
					mType:registerEvent("EchoWardenTrigger")
					count = count + 1
				end
			end
		end
	end
	logger.info("[EchoWarden] Registered death trigger to {} monsters (common/uncommon 1-2)", count)
	return true
end

echoWardenStartup:register()
