-- Resets the elemental basin riddle (Mazoran) for one player.
-- Takes a player id so it can be used with addEvent. With a token (the Active
-- value set by a gem) it only resets when that attempt is still the current one.
function FerumbrasAscensionRevertElements(playerId, token)
	local player = Player(playerId)
	if not player then
		return
	end

	local elements = Storage.Quest.U10_90.FerumbrasAscension.Elements
	if token ~= nil and player:getStorageValue(elements.Active) ~= token then
		return
	end

	player:setStorageValue(elements.Active, 0)
	player:setStorageValue(elements.First, 0)
	player:setStorageValue(elements.Second, 0)
	player:setStorageValue(elements.Third, 0)
	player:setStorageValue(elements.Four, 0)
	player:setStorageValue(elements.Done, 0)
end
