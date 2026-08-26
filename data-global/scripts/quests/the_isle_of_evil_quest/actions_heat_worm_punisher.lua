local MISSION04_STORAGE = Storage.Quest.U8_5.TheIsleOfEvil.Mission04

local HEATED_CRUCIBLE_ID = 9242
local HEATED_WORM_PUNISHER_ID = 9201

local heatWormPunisher = Action()

function heatWormPunisher.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(MISSION04_STORAGE) ~= 2 then
		return true
	end

	if not target or target.itemid ~= HEATED_CRUCIBLE_ID then
		return true
	end

	item:transform(HEATED_WORM_PUNISHER_ID)
	toPosition:sendMagicEffect(CONST_ME_FIREATTACK)
	player:say("You've heated up the hammer for a short while.", TALKTYPE_MONSTER_SAY)

	return true
end

heatWormPunisher:id(9234)
heatWormPunisher:register()
