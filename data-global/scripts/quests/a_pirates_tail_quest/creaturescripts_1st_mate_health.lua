local mateRatticusHealth = CreatureEvent("mateRatticusHealth")

local hasRetreated = false

function mateRatticusHealth.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not creature or not creature:getMonster() then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	if creature:getHealth() > 25000 then
		hasRetreated = false
	end

	local currentHealth = creature:getHealth() + primaryDamage

	if not hasRetreated and currentHealth <= 25000 then
		hasRetreated = true

		local ratticusChangePos = Position(33917, 31350, 13)
		local ratmiralChangePos = Position(33904, 31349, 14)
		local ratmiralSpawnPos = Position(33917, 31350, 13)
		local creatureId = creature:getId()

		creature:say("RATREAT!", TALKTYPE_MONSTER_SAY)

		addEvent(function()
			local ratticus = Creature(creatureId)
			if ratticus then
				ratticus:teleportTo(ratticusChangePos)
				ratticus:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				ratticus:setMoveLocked(true)
			end

			local ratmiral = nil
			for _, mob in ipairs(Game.getSpectators(ratmiralSpawnPos, false, false, 5, 5, 5, 5)) do
				if mob:getMonster() and mob:getName():lower() == "ratmiral blackwhiskers" then
					ratmiral = mob
					break
				end
			end

			if ratmiral then
				ratmiral:setMoveLocked(false)
				ratmiral:teleportTo(ratmiralChangePos)
				ratmiral:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		end, 500)
	end

	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

mateRatticusHealth:register()
