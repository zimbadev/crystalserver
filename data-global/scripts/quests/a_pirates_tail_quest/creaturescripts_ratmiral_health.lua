local ratmiralHealth = CreatureEvent("ratmiralHealth")

local hasRetreated = false

function ratmiralHealth.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not creature or not creature:getMonster() then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	if creature:getHealth() > 110000 then
		hasRetreated = false
	end

	local currentHealth = creature:getHealth() + primaryDamage

	if not hasRetreated and currentHealth <= 110000 then
		hasRetreated = true

		local ratticusSearchPos = Position(33917, 31350, 13)
		local catkillerSearchPos = Position(33891, 31352, 13)
		local ratticusChangePos = Position(33905, 31351, 14)
		local catkillerChangePos = Position(33903, 31350, 14)
		local rateyePos = Position(33905, 31350, 14)

		creature:say("JOIN ME, MY CREW!", TALKTYPE_MONSTER_SAY)

		addEvent(function()
			local ratticus = nil
			local catkiller = nil

			for _, mob in ipairs(Game.getSpectators(ratticusSearchPos, false, false, 10, 10, 10, 10)) do
				if mob:getMonster() and mob:getName():lower() == "1st mate ratticus" then
					ratticus = mob
					break
				end
			end

			for _, mob in ipairs(Game.getSpectators(catkillerSearchPos, false, false, 10, 10, 10, 10)) do
				if mob:getMonster() and mob:getName():lower() == "mister catkiller" then
					catkiller = mob
					break
				end
			end

			if ratticus then
				ratticus:setMoveLocked(false)
				ratticus:teleportTo(ratticusChangePos)
				ratticus:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end

			if catkiller then
				catkiller:setMoveLocked(false)
				catkiller:teleportTo(catkillerChangePos)
				catkiller:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end

			Game.createMonster("Rateye Ric", rateyePos, true, true)
		end, 500)
	end

	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

ratmiralHealth:register()
