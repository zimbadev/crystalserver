local destinations = {
	[28810] = Position(583, 152, 9),
	[28811] = Position(585, 168, 9),
	[28812] = Position(589, 158, 9),
	[28813] = Position(592, 155, 9),
	[28814] = Position(601, 154, 9),
	[28815] = Position(572, 156, 9),
	[28816] = Position(585, 165, 9),
	[28817] = Position(600, 144, 9),
	[28818] = Position(602, 155, 9),
	[28819] = Position(601, 137, 9),
	[28820] = Position(588, 161, 9),
	[28821] = Position(606, 168, 9),
	[28822] = Position(586, 171, 9),
	[28823] = Position(621, 137, 9),
	[28824] = Position(599, 171, 9),
	[28825] = Position(600, 152, 9),
	[28826] = Position(586, 171, 9),
	[28827] = Position(589, 155, 9),
	[28828] = Position(572, 162, 9),
	[28829] = Position(603, 144, 9),
	[28830] = Position(606, 149, 9),
	[28831] = Position(600, 169, 9),
	[28832] = Position(600, 168, 9),
	[28833] = Position(600, 166, 9),
	[28834] = Position(600, 167, 9),
}

local tileTeleport = MoveEvent()

function tileTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(destinations[item.actionid])
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

tileTeleport:type("stepin")

for index, value in pairs(destinations) do
	tileTeleport:aid(index)
end

tileTeleport:register()
