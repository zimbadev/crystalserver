local transformWolf = MoveEvent()

function transformWolf.onStepIn(creature, item, position, fromPosition)
	if not creature:isMonster() then
		return true
	end

	if creature:getName() == "Thornfire Wolf" then
		creature:remove()
		position:sendMagicEffect(CONST_ME_ICEATTACK)
		Game.createMonster("Crystal Wolf", position, false, true)
	end
	return true
end

transformWolf:type("stepin")
transformWolf:id(12721)
transformWolf:register()
