--[[
	A Piece of Cake - command to test and control the quest without waiting for the real event dates or the raid/check intervals.
	Usage:
		/cakequest status                -> shows current state
		/cakequest start                  -> forces the start (stage 1) + fires one raid right away
		/cakequest raid                   -> manually fires a raid (only while in stage 1)
		/cakequest stage <0-3>            -> jumps straight to a stage (2 builds the bridge; 3 makes the "mark" errand available, but does NOT spawn Brutus - use /cakequest brutus for that)
		/cakequest brutus                  -> manually activates Brutus + the world bonus (normally happens automatically at the next server save after stage 3 begins)
		/cakequest endevent                -> manually runs the end-of-event cleanup (removes bridge + Brutus, as if Feb 26 had passed)
		/cakequest addsubstance <n>       -> adds "n" delivered substances
		/cakequest addgolem <n>           -> adds "n" lured golems
		/cakequest addbite <n>            -> adds "n" bites to the current round
		/cakequest reset                  -> wipes everything (stage 0, removes bridge/bakers/Brutus)
]]

local cakeQuestCommand = TalkAction("/cakequest")

local function stageName(stage)
	local names = {
		[0] = "inactive",
		[1] = "stage 1 (raids/substances)",
		[2] = "stage 2 (eating the cake)",
		[3] = "stage 3 (mark errand available; Brutus/bonus may still be pending until next server save)",
	}
	return names[stage] or "unknown"
end

function cakeQuestCommand.onSay(player, words, param)
	logCommand(player, words, param)

	local args = param:split(" ")
	local sub = args[1] and args[1]:lower() or ""

	if sub == "status" or sub == "" then
		local stage = CakeQuest.getStage()
		local substances = CakeQuest.get(CakeQuest.Keys.SubstancesDelivered, 0)
		local golems = CakeQuest.get(CakeQuest.Keys.GolemsLured, 0)
		local layer = CakeQuest.get(CakeQuest.Keys.CurrentLayer, 0)
		local progress = CakeQuest.get(CakeQuest.Keys.LayerProgress, 0)
		local windowActive = CakeQuest.get(CakeQuest.Keys.EatingWindowActive, false)
		local pendingBrutus = CakeQuest.get(CakeQuest.Keys.PendingBrutusBonus, false)
		local brutusActive = CakeQuest.get(CakeQuest.Keys.BrutusAndBonusActive, false)
		local bonusUntil = CakeQuest.get(CakeQuest.Keys.WorldBonusUntil, 0)
		local bonusInfo = bonusUntil > os.time() and (" | World bonus until: " .. os.date("%d/%m/%Y %H:%M", bonusUntil)) or ""
		player:sendTextMessage(
			MESSAGE_EVENT_ADVANCE,
			("[A Piece of Cake] Stage: %s | Substances: %d/%d | Golems: %d/%d | Layer: %d/%d | Window open: %s | Bites: %d/%d | Pending Brutus/bonus: %s | Brutus/bonus active: %s%s"):format(
				stageName(stage),
				substances,
				CakeQuest.Config.SUBSTANCE_GOAL,
				golems,
				CakeQuest.Config.GOLEM_LURE_GOAL,
				layer,
				CakeQuest.Config.LAYERS,
				tostring(windowActive),
				progress,
				CakeQuest.Config.BITES_REQUIRED_PER_LAYER,
				tostring(pendingBrutus),
				tostring(brutusActive),
				bonusInfo
			)
		)
	elseif sub == "start" then
		CakeQuest.startFreshOccurrence()
		CakeQuest.runRaid()
		Game.broadcastMessage("A Piece of Cake was force-started by " .. player:getName() .. ").", MESSAGE_EVENT_ADVANCE)
	elseif sub == "raid" then
		if CakeQuest.getStage() ~= 1 then
			player:sendCancelMessage("You can only force a manual raid during stage 1 (use /cakequest stage 1 or start first).")
			return true
		end
		CakeQuest.runRaid()
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Raid triggered manually.")
	elseif sub == "brutus" then
		if CakeQuest.getStage() ~= 3 then
			player:sendCancelMessage("Brutus/bonus can only be activated during stage 3 (use /cakequest stage 3 first).")
			return true
		end
		CakeQuest.activateBrutusAndBonus()
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Brutus and the world bonus were activated manually.")
	elseif sub == "endevent" then
		CakeQuest.endOfEventCleanup()
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "End-of-event cleanup executed manually (bridge + Brutus removed, if present).")
	elseif sub == "stage" then
		local value = tonumber(args[2])
		if not value or value < 0 or value > 3 then
			player:sendCancelMessage("Usage: /cakequest stage <0-3>")
			return true
		end
		if value == 2 then
			CakeQuest.enterStage2()
		else
			CakeQuest.setStage(value)
			if value == 3 then
				CakeQuest.set(CakeQuest.Keys.PendingBrutusBonus, true)
			end
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Stage set to " .. value .. " (" .. stageName(value) .. ").")
	elseif sub == "addsubstance" then
		local value = tonumber(args[2]) or 1
		local total = CakeQuest.get(CakeQuest.Keys.SubstancesDelivered, 0) + value
		CakeQuest.set(CakeQuest.Keys.SubstancesDelivered, total)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Substances delivered now: " .. total)
		CakeQuest.checkStage1Complete()
	elseif sub == "addgolem" then
		local value = tonumber(args[2]) or 1
		local total = CakeQuest.get(CakeQuest.Keys.GolemsLured, 0) + value
		CakeQuest.set(CakeQuest.Keys.GolemsLured, total)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Golems lured now: " .. total)
		CakeQuest.checkStage1Complete()
	elseif sub == "addbite" then
		local value = tonumber(args[2]) or 1
		local total = CakeQuest.get(CakeQuest.Keys.LayerProgress, 0) + value
		CakeQuest.set(CakeQuest.Keys.LayerProgress, total)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Current round's progress now: " .. total)
	elseif sub == "reset" then
		CakeQuest.set(CakeQuest.Keys.Stage, 0)
		CakeQuest.set(CakeQuest.Keys.SubstancesDelivered, 0)
		CakeQuest.set(CakeQuest.Keys.GolemsLured, 0)
		CakeQuest.set(CakeQuest.Keys.CurrentLayer, 0)
		CakeQuest.set(CakeQuest.Keys.LayerProgress, 0)
		CakeQuest.set(CakeQuest.Keys.EatingWindowActive, false)
		CakeQuest.set(CakeQuest.Keys.PendingBrutusBonus, false)
		CakeQuest.set(CakeQuest.Keys.BrutusAndBonusActive, false)
		CakeQuest.set(CakeQuest.Keys.EventEndCleanedUp, false)
		CakeQuest.set(CakeQuest.Keys.WorldBonusUntil, 0)
		CakeQuest.removeBridge()
		CakeQuest.removeBakers()
		CakeQuest.removeBrutus()
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A Piece of Cake was reset (bridge, bakers and Brutus removed).")
	else
		player:sendCancelMessage("Usage: /cakequest status|start|raid|stage <n>|brutus|endevent|addsubstance <n>|addgolem <n>|addbite <n>|reset")
	end

	return true
end

cakeQuestCommand:separator(" ")
cakeQuestCommand:groupType("god")
cakeQuestCommand:register()
