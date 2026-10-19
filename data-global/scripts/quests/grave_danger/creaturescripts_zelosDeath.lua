-- Killing King Zelos no longer gives the outfit or the achievement (TibiaWiki dialogue: Jack Springer gives them).
-- The death sets KingZelosKilled (actions_bosses_killed.lua) and the mission goes to 4; the player goes back to Jack Springer,
-- says {report} and he hands out the Hand of the Inquisition Outfit + "Inquisition's Hand" (npc/jack_springer.lua).
local config = {
	centerPosition = Position(33443, 31545, 13),
	rangeX = 11,
	rangeY = 11,
}

local KingzelosDeath = CreatureEvent("zelosDeath")

function KingzelosDeath.onPrepareDeath(creature)
	local spectators = Game.getSpectators(config.centerPosition, false, true, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
	for _, player in pairs(spectators) do
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "King Zelos has been defeated! Report back to Jack Springer.")
	end
	return true
end

KingzelosDeath:register()
