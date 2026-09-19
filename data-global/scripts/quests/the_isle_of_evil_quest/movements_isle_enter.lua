local KV_SCOPE = "the-isle-of-evil"
local TheIsleOfEvil = Storage.Quest.U8_5.TheIsleOfEvil

local isleEnterPositions = {
	Position(32671, 31454, 6),
	Position(32671, 31455, 6),
}

local isleEnter = MoveEvent()

function isleEnter.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	local player = Player(creature)

	if player:getStorageValue(TheIsleOfEvil.Mission07) >= 1 or player:kv():scoped(KV_SCOPE):get("rapanaio-travel") then
		player:say("You hear evil laughter from afar.", TALKTYPE_MONSTER_SAY)
		return true
	end

	player:teleportTo(fromPosition)
	player:say("You better talk to Rapanaio before leave the safety of the ship!", TALKTYPE_MONSTER_SAY)

	return true
end

isleEnter:type("stepin")

for _, position in ipairs(isleEnterPositions) do
	isleEnter:position(position)
end

isleEnter:register()
