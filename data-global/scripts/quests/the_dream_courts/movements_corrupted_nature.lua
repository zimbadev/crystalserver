local corruptedNature = MoveEvent()

function corruptedNature.onStepIn(creature, item, position, fromPosition)
	if not creature or not creature:isMonster() then
		return true
	end

	local healAmount = math.random(7000, 10000)
	local cName = creature:getName():lower()
	local cPos = creature:getPosition()

	if cName == "plant attendant" then
		creature:remove()

		local abomination = Game.createMonster("Plant Abomination", cPos)
		if abomination then
			abomination:registerEvent("dreamCourtsDeath")
			abomination:say("The vile energy changes the attendant horribly!", TALKTYPE_MONSTER_SAY)
		end
	elseif cName == "plagueroot" then
		creature:addHealth(healAmount)
	end

	return true
end

corruptedNature:id(28951)
corruptedNature:register()
