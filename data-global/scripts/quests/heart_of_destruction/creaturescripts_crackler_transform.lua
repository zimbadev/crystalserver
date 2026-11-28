local cracklerTransformEvent = CreatureEvent("CracklerTransform")
function cracklerTransformEvent.onThink(creature)
	if not creature or not creature:isMonster() then
		return true
	end

	if cracklerTransform == true then
		local monster = Game.createMonster("depolarized crackler", creature:getPosition(), false, true)
		if monster then
			monster:addHealth(-monster:getHealth() + creature:getHealth(), COMBAT_PHYSICALDAMAGE)
			creature:remove()
		end
	end

	return true
end

cracklerTransformEvent:register()
