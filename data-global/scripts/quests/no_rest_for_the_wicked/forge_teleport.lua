local forgeMasterPortal = MoveEvent()

local areaTopLeft = Position(34026, 32322, 14)
local areaBottomRight = Position(34042, 32341, 14)

local function countCreatures(fromPos, toPos, creatureName)
	local count = 0
	for x = fromPos.x, toPos.x do
		for y = fromPos.y, toPos.y do
			local tile = Tile(Position(x, y, fromPos.z))
			if tile then
				local creatures = tile:getCreatures()
				for _, creature in ipairs(creatures) do
					if creature:isMonster() and creature:getName():lower() == creatureName then
						count = count + 1
					end
				end
			end
		end
	end
	return count
end

function forgeMasterPortal.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	local portalActionID = 9915
	local portalPos = Position(34041, 32330, 14)

	if item:getActionId() == portalActionID and position == portalPos then
		local fightArbaziloth = countCreatures(areaTopLeft, areaBottomRight, "arbaziloth") >= 1
		local deadForgemaster = countCreatures(areaTopLeft, areaBottomRight, "the forgemaster") == 0

		if fightArbaziloth then
			creature:teleportTo(fromPosition)
			creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The power surging to Arbaziloth prevents you from entering!")
		elseif deadForgemaster then
			creature:teleportTo(fromPosition)
			creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Forgemaster has been defeated the lack of power prevents you from entering!")
		else
			creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You enter the forge!")
		end
	end

	return true
end

forgeMasterPortal:type("stepin")
forgeMasterPortal:id(37000)
forgeMasterPortal:register()
