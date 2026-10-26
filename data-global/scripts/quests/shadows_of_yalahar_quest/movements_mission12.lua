-- Teleport Fenrock Mission 12
local teleports = {
	{
		access = Storage.Quest.U8_5.ShadowsOfYalahar.Mission12,
		from = Position(32550, 31274, 9),
		to = Position(32550, 31271, 9),
	},
	{
		access = Storage.Quest.U8_5.ShadowsOfYalahar.Mission12,
		from = Position(32550, 31272, 9),
		to = Position(32550, 31275, 9),
	},
}
local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar

local fenrockTeleport = MoveEvent()
function fenrockTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(ShadowsOfYalahar.Mission12) ~= 1 then
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	local teleportTo = nil
	for _, teleportItem in pairs(teleports) do
		if position:compare(teleportItem.from) then
			teleportTo = teleportItem.to
			break
		end
	end

	if teleportTo then
		player:teleportTo(teleportTo)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end

	return true
end

for _, teleportItem in pairs(teleports) do
	fenrockTeleport:position(teleportItem.from)
end

fenrockTeleport:register()

-- Drunk Tiles
local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar
local DRUNK_DURATION = 20000 -- 60000 ms (20 seconds)

local mission12DrunkFloor = MoveEvent()
function mission12DrunkFloor.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	local condition = Condition(CONDITION_DRUNK)
	condition:setParameter(CONDITION_PARAM_TICKS, DRUNK_DURATION)
	creature:addCondition(condition)
	creature:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)

	return true
end

mission12DrunkFloor:type("stepin")
mission12DrunkFloor:aid(25032)
mission12DrunkFloor:register()
