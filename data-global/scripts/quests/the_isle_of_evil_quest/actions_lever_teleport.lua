local isleOfEvilLever = Action()

function isleOfEvilLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 2773 then
		item:transform(2772)
		return true
	end

	if item.itemid == 2772 then
		item:transform(2773)

		player:teleportTo(Position(32755, 31469, 7))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

		player:say("What a cunning and devious death trap! Rapanaio has not warned you about mastermind from nothing!", TALKTYPE_MONSTER_SAY)
	end
	return true
end

isleOfEvilLever:aid(57237)
isleOfEvilLever:register()
