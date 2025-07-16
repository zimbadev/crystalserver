local transformItems = {
	[23485] = 23486, -- explosive barrel
	[23486] = 23485, -- barrel
}

local function bombTimer(seconds, pos)
	local spectators = Game.getSpectators(pos, false, true, 11, 11, 9, 9)
	if #spectators > 0 then
		for i = 1, #spectators do
			spectators[i]:say(seconds, TALKTYPE_MONSTER_SAY, false, spectators[i], pos)
		end
	end
end

local function explodeBomb(position, itemId)
	local tile = Tile(position)
	if tile then
		local item = tile:getItemById(itemId)
		if item then
			item:remove()
		end
	end

	local spectators = Game.getSpectators(position, false, true, 11, 11, 9, 9)
	local minDamage = -800
	local maxDamage = -1100

	for _, spectator in ipairs(spectators) do
		if spectator:isPlayer() or (spectator:getMaster() and spectator:getMaster():isPlayer()) then
			local damage = math.random(minDamage, maxDamage)
			spectator:addHealth(damage)
		end
	end
end

local explosiveBarrel = Action()
function explosiveBarrel.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local itemId = item:getId()
	local newItemId = transformItems[itemId]

	if newItemId then
		item:transform(newItemId)
		item:decay()

		if newItemId == 23486 then
			local position = item:getPosition()
			addEvent(explodeBomb, 3000, position, newItemId)
			bombTimer(3, position)
			addEvent(bombTimer, 1000, 2, position)
			addEvent(bombTimer, 2000, 1, position)
		end
	end

	return true
end

for index in pairs(transformItems) do
	explosiveBarrel:id(index)
end
explosiveBarrel:register()
