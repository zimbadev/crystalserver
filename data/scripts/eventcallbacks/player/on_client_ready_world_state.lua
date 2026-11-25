-- What a client needs every time it attaches to its character: on login and when it
-- reattaches to a headless body (that path runs no onLogin).

local clientReady = EventCallback("PlayerOnClientReadyWorldState")

function clientReady.playerOnClientReady(player)
	-- CipSoft: stash/market/depot search only while on a depot switch (a client that
	-- attaches on one gets them; anywhere else they stay off until the player steps on one).
	local atDepot = player:isAtDepotSwitch()
	player:setSpecialContainersAvailable(atDepot, atDepot, atDepot)
end

clientReady:register()
