--[[
    CreatureScript: Monster AI Death Event
    Limpia el estado del monster cuando muere
    (Desde Mexas - crystalserverRef)
]]

local monsterAiDeath = CreatureEvent("MonsterAI_Death")

function monsterAiDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if not creature or not creature:isMonster() then
		return true
	end

	-- Limpiar estado del monster
	if MonsterAI and MonsterAI.onDeath then
		return MonsterAI.onDeath(creature)
	end
	return true
end

monsterAiDeath:register()
