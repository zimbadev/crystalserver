--	A Piece of Cake - Stage Check

local cakeStageCheck = GlobalEvent("CakeQuestStageCheck")

function cakeStageCheck.onThink(interval)
	if CakeQuest.getStage() ~= 1 then
		return true
	end

	if CakeQuest.checkStage1Complete() then
		return true
	end

	local substances = CakeQuest.get(CakeQuest.Keys.SubstancesDelivered, 0)
	local golems = CakeQuest.get(CakeQuest.Keys.GolemsLured, 0)
	Game.broadcastMessage(("A Piece of Cake progress: %d/%d substances, %d/%d golems lured."):format(substances, CakeQuest.Config.SUBSTANCE_GOAL, golems, CakeQuest.Config.GOLEM_LURE_GOAL), MESSAGE_EVENT_ADVANCE)

	return true
end

cakeStageCheck:interval(CakeQuest.Config.CHECK_INTERVAL_MINUTES * 60 * 1000)
cakeStageCheck:register()
