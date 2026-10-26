-- No Rest for the Wicked - portal from the arena to the Doomforge (34041,32330,14, aid 9915)
-- W: "Once the fight is over, players can use the orange teleport in the room to access the Doomforge. In case
-- The Forgemaster died during the bossfight, Arbaziloth will not heal himself, and the Doomforge will not be
-- accessible." Uses the result of the LAST fight (arbaziloth_fight.lua -> state.result).
-- Refusal texts NOT CONFIRMED (the first two came with the community script).
local PORTAL_AID = 9915
local PORTAL_POSITION = Position(34041, 32330, 14)

local forgeMasterPortal = MoveEvent()

function forgeMasterPortal.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player or item:getActionId() ~= PORTAL_AID or position ~= PORTAL_POSITION then
		return true
	end

	local fight = ArbazilothFight and ArbazilothFight.state
	local message
	if fight and fight.bossId and Monster(fight.bossId) then
		message = "The power surging to Arbaziloth prevents you from entering!"
	elseif fight and fight.result == "easy" then
		message = "The Forgemaster has been defeated, the lack of power prevents you from entering!"
	elseif not fight or fight.result ~= "hard" then
		message = "The forge lies cold. There is no way through right now."
	end

	if message then
		-- the item is a teleport: the engine already moved the player, so send them back
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
		return true
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You enter the forge!")
	return true
end

forgeMasterPortal:type("stepin")
forgeMasterPortal:id(37000)
forgeMasterPortal:register()
