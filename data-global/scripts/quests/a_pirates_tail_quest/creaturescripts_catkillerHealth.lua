local catkillerHealth = CreatureEvent("catkillerHealth")

local hasRetreated = false

function catkillerHealth.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not creature or not creature:getMonster() then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	if creature:getHealth() > 25000 then
		hasRetreated = false
	end

	local currentHealth = creature:getHealth() + primaryDamage

	if not hasRetreated and currentHealth <= 25000 then
		hasRetreated = true

		local retreatPos = Position(33891, 31352, 13)

		creature:say("RATREAT!", TALKTYPE_MONSTER_SAY)

		addEvent(function()
			creature:teleportTo(retreatPos)
			creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			creature:setMoveLocked(true)

			local ladderPos = Position(33902, 31347, 15)
			Game.createItem(5542, 1, ladderPos)

			local ladderSpectators = Game.getSpectators(ladderPos, false, true, 10, 10, 10, 10)
			for _, player in ipairs(ladderSpectators) do
				player:say("A rope ladder has been dropped!", TALKTYPE_MONSTER_SAY, false, player, ladderPos)
			end
		end, 500)
	end

	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

catkillerHealth:register()
