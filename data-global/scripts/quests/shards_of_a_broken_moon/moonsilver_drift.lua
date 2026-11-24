-- Shards of a Broken Moon - Moonsilver Drift Hazard (ID 54235)

local asuraNames = {
	["true frost flower asura"] = true,
	["true midnight asura"] = true,
	["frost flower asura"] = true,
	["midnight asura"] = true,
}

local driftStep = MoveEvent()

function driftStep.onStepIn(creature, item, position, fromPosition)
	if creature:isPlayer() then
		-- Dano de morte de 350 a 400
		doTargetCombatHealth(0, creature, COMBAT_DEATHDAMAGE, -350, -400, CONST_ME_MORTAREA)
		return true
	end

	if creature:isMonster() then
		local name = creature:getName():lower()
		if asuraNames[name] then
			-- A Asura absorve a energia da poça e se transforma em True Frostnight Asura
			creature:remove()
			item:remove()
			local newAsura = Game.createMonster("True Frostnight Asura", position, true, true)
			if newAsura then
				position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
				newAsura:say("The moonsilver empowers me!", TALKTYPE_MONSTER_SAY)
			end
			return true
		end
	end

	return true
end

driftStep:type("stepin")
driftStep:id(54235)
driftStep:register()
