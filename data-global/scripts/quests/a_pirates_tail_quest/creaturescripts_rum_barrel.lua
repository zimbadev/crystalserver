local RumBarrelExplotes = CreatureEvent("RumBarrelExplotes")

function RumBarrelExplotes.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	if not creature or not creature:getMonster() then
		return true
	end

	local centerPos = creature:getPosition()
	local damage = math.random(66666, 88888)

	creature:say("The barrel explodes violently!", TALKTYPE_MONSTER_SAY)

	for x = -1, 1 do
		for y = -1, 1 do
			local checkPos = Position(centerPos.x + x, centerPos.y + y, centerPos.z)
			local tile = Tile(checkPos)

			if tile then
				checkPos:sendMagicEffect(CONST_ME_HITBYFIRE)

				local topCreature = tile:getTopCreature()
				if topCreature and topCreature:isMonster() then
					if topCreature:getName():lower() == "weak spot" then
						doTargetCombatHealth(0, topCreature, COMBAT_LIFEDRAIN, -damage, -damage, CONST_ME_NONE)
					end
				end
			end
		end
	end

	return true
end

RumBarrelExplotes:register()
