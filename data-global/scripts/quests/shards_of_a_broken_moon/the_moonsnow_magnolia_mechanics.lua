-- Shards of a Broken Moon - The Moonsnow Magnolia Mechanics

-- 1. Cura com dano de Morte (HealthChange)
local magnoliaHealth = CreatureEvent("MoonsnowMagnoliaHealth")

function magnoliaHealth.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not creature or not creature:isMonster() then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	-- Mecânica: O boss se cura com dano de Morte (Death Damage)
	if primaryType == COMBAT_DEATHDAMAGE and primaryDamage > 0 then
		creature:addHealth(primaryDamage)
		creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		primaryDamage = 0
	end
	if secondaryType == COMBAT_DEATHDAMAGE and secondaryDamage > 0 then
		creature:addHealth(secondaryDamage)
		creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		secondaryDamage = 0
	end

	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

magnoliaHealth:register()

-- 2. Transição da Fase 1 para a Fase 2 (Interceptação de Morte)
local magnoliaPrepareDeath = CreatureEvent("MoonsnowMagnoliaPrepareDeath")

function magnoliaPrepareDeath.onPrepareDeath(creature, killer, realDamage)
	if not creature or not creature:isMonster() then
		return true
	end

	-- Se estiver na Fase 1, bloqueia a morte e transiciona para a Fase 2
	if MoonsnowMagnoliaFight.phase == 1 then
		MoonsnowMagnoliaFight.phase = 2

		-- Restaura a vida inteira
		creature:addHealth(creature:getMaxHealth())
		creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

		-- Fala oficial da armadilha
		creature:say("You have defeated me, come here and take your prize!", TALKTYPE_MONSTER_YELL)

		-- Desativa a necessidade do Bone Fiddle na Fase 2
		if MoonsnowMagnoliaFight.watchdogEvent then
			stopEvent(MoonsnowMagnoliaFight.watchdogEvent)
			MoonsnowMagnoliaFight.watchdogEvent = nil
		end

		-- Explosão massiva de gelo após 1 segundo
		local bossGuid = creature:getId()
		addEvent(function(id)
			local boss = Monster(id)
			if not boss then
				return
			end

			local bossPos = boss:getPosition()
			bossPos:sendMagicEffect(CONST_ME_ICEAREA)

			-- Dano nos jogadores dentro da arena
			local spectators = Game.getSpectators(bossPos, false, true, 25, 25, 20, 20)
			for _, player in ipairs(spectators) do
				player:getPosition():sendMagicEffect(CONST_ME_ICEAREA)
				doTargetCombatHealth(boss:getId(), player, COMBAT_ICEDAMAGE, -4800, -5200, CONST_ME_ICEATTACK)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Moonsnow Magnolia deceived you with a colossal ice blast! Prepare for her true final form!")
			end
		end, 1000, bossGuid)

		-- Retorna false para a engine do servidor cancelar o dano fatal e não matar o monstro
		return false
	end

	-- Se já estiver na Fase 2, permite a morte normal
	return true
end

magnoliaPrepareDeath:register()

-- 3. Morte Definitiva na Fase 2
local magnoliaDeath = CreatureEvent("MoonsnowMagnoliaDeath")

function magnoliaDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
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

	return true
end

magnoliaDeath:register()
