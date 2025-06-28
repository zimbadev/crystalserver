local setting = {
	[2080] = {
		storage = Storage.Quest.U7_8.ThePitsOfInferno.ThroneInfernatil,
		text = "You have touched Infernatil's throne and absorbed some of his spirit.",
		effect = CONST_ME_FIREAREA,
		toPosition = Position(654, 55, 15),
	},
	[2081] = {
		storage = Storage.Quest.U7_8.ThePitsOfInferno.ThroneTafariel,
		text = "You have touched Tafariel's throne and absorbed some of his spirit.",
		effect = CONST_ME_MORTAREA,
		toPosition = Position(502, 91, 15),
	},
	[2082] = {
		storage = Storage.Quest.U7_8.ThePitsOfInferno.ThroneVerminor,
		text = "You have touched Verminor's throne and absorbed some of his spirit.",
		effect = CONST_ME_POISONAREA,
		toPosition = Position(585, 172, 15),
	},
	[2083] = {
		storage = Storage.Quest.U7_8.ThePitsOfInferno.ThroneApocalypse,
		text = "You have touched Apocalypse's throne and absorbed some of his spirit.",
		effect = CONST_ME_EXPLOSIONAREA,
		toPosition = Position(620, 112, 15),
	},
	[2084] = {
		storage = Storage.Quest.U7_8.ThePitsOfInferno.ThroneBazir,
		text = "You have touched Bazir's throne and absorbed some of his spirit.",
		effect = CONST_ME_MAGIC_GREEN,
		toPosition = Position(462, 229, 13),
	},
	[2085] = {
		storage = Storage.Quest.U7_8.ThePitsOfInferno.ThroneAshfalor,
		text = "You have touched Ashfalor's throne and absorbed some of his spirit.",
		effect = CONST_ME_FIREAREA,
		toPosition = Position(584, 153, 15),
	},
	[2086] = {
		storage = Storage.Quest.U7_8.ThePitsOfInferno.ThronePumin,
		text = "You have touched Pumin's throne and absorbed some of his spirit.",
		effect = CONST_ME_MORTAREA,
		toPosition = Position(530, 123, 15),
	},
}

local throne = MoveEvent()

function throne.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local throne = setting[item.uid]
	if not throne then
		return true
	end

	if player:getStorageValue(throne.storage) ~= 1 then
		player:setStorageValue(throne.storage, 1)
		player:setStorageValue(Storage.Quest.U7_8.ThePitsOfInferno.ShortcutHubDoor, 1)
		player:getPosition():sendMagicEffect(throne.effect)
		player:say(throne.text, TALKTYPE_MONSTER_SAY)
	else
		player:teleportTo(throne.toPosition)
		player:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
		player:say("Begone!", TALKTYPE_MONSTER_SAY)
	end
	return true
end

throne:type("stepin")

for index, value in pairs(setting) do
	throne:uid(index)
end

throne:register()
