--[[
	Task Board - God Commands

	Commands:
		/taskboard help                                     - Show all commands
		/taskboard reset                                    - Reset all task board database tables
		/taskboard resetweekly,<player>                     - Reset weekly tasks (shows difficulty selection)
		/taskboard resetbounty,<player>                     - Reset bounty tasks (shows difficulty selection)

		/taskboard addbountypoints,<player>,<amount>        - Add bounty points
		/taskboard addhuntingtaskpoints,<player>,<amount>   - Add task hunting points
		/taskboard addsoulsealspoints,<player>,<amount>     - Add soulseals points
		/taskboard addrerolltasks,<player>,<amount>         - Add reroll tasks
		/taskboard points[,<player>]                        - Show points for player

		--- Bounty Task Commands ---
		/taskboard bounty,<player>,state,<state>                        - Set bounty state (0-3)
		/taskboard bounty,<player>,difficulty,<difficulty>               - Set bounty difficulty (0-3)
		/taskboard bounty,<player>,generate[,<difficulty>]              - Generate creature list
		/taskboard bounty,<player>,talisman,<path>,<level>              - Set talisman level
		/taskboard bounty,<player>,talismans,<level>                    - Set all talismans to level
		/taskboard bounty,<player>,rerolltokens,<amount>                - Set reroll tokens
		/taskboard bounty,<player>,rerolltimestamp,<seconds>            - Set reroll cooldown (seconds from now)
		/taskboard bounty,<player>,active,<raceId>,<kills>,<curKills>,<exp>,<bp>,<grade>,<diff>  - Set active task
		/taskboard bounty,<player>,creature,<raceId>,<kills>,<curKills>,<exp>,<bp>,<claim>,<grade> - Add creature to list
		/taskboard bounty,<player>,clearcreatures                       - Clear creature list
		/taskboard bounty,<player>,info                                 - Show bounty data
		/taskboard bounty,<player>,send                                 - Force send bounty packet

		--- Weekly Task Commands ---
		/taskboard weekly,<player>,generate,<difficulty>                   - Generate weekly tasks
		/taskboard weekly,<player>,difficulty,<difficulty>                  - Set weekly difficulty (0-3)
		/taskboard weekly,<player>,diffmultiplier,<0-3>                    - Set protocol difficulty multiplier
		/taskboard weekly,<player>,killprogress,<taskIndex>,<kills>        - Set kill task progress
		/taskboard weekly,<player>,deliveryprogress,<taskIndex>,<items>,<delivered> - Set delivery progress
		/taskboard weekly,<player>,deliveryunknowns,<taskIndex>,<u1>,<u2>  - Set delivery task unknown bytes
		/taskboard weekly,<player>,anycreature,<kills>                     - Set "any creature" progress
		/taskboard weekly,<player>,completed,<killCount>,<deliveryCount>   - Set completed task counts
		/taskboard weekly,<player>,finished,<0-1>                          - Set weeklyProgressFinished flag
		/taskboard weekly,<player>,rewards,<htp>,<soulseals>              - Set reward display values
		/taskboard weekly,<player>,rewardexp,<killExp>,<deliveryExp>       - Set reward XP per task
		/taskboard weekly,<player>,info                                    - Show weekly data
		/taskboard weekly,<player>,send                                    - Force send weekly packet

		--- Hunting Task Shop Commands ---
		/taskboard shop,<player>,send                       - Force send hunting task shop packet
]]

local taskBoard = TalkAction("/taskboard")

-- Helper: get online player or send error
local function getTarget(player, split, paramIndex)
	local targetName = split[paramIndex] and split[paramIndex]:trim() or ""
	if targetName == "" then
		return nil, "Missing player name."
	end
	local target = Player(targetName)
	if not target then
		return nil, "Player '" .. targetName .. "' is not online."
	end
	return target, nil
end

-- Helper: get required number from split
local function getRequiredNumber(split, paramIndex, fieldName)
	if not split[paramIndex] then
		return nil, "Missing " .. fieldName .. "."
	end
	local val = tonumber(split[paramIndex]:trim())
	if not val then
		return nil, "'" .. split[paramIndex]:trim() .. "' is not a valid number for " .. fieldName .. "."
	end
	return val, nil
end

-- Helper: get optional number from split with default
local function getOptionalNumber(split, paramIndex, default)
	if not split[paramIndex] then
		return default
	end
	return tonumber(split[paramIndex]:trim()) or default
end

-- Difficulty names
local DIFFICULTY_NAMES = { [0] = "Beginner", [1] = "Adept", [2] = "Expert", [3] = "Master" }
local BOUNTY_STATE_NAMES = { [0] = "NONE", [1] = "SELECTION", [2] = "ACTIVE", [3] = "COMPLETED" }
local TALISMAN_NAMES = { [0] = "Damage", [1] = "LifeLeech", [2] = "Loot", [3] = "Bestiary" }
local GRADE_NAMES = { [0] = "Normal", [1] = "Silver (2x)", [2] = "Gold (4x)" }
local CLAIM_NAMES = { [0] = "Select", [1] = "NoClick", [2] = "Clicked" }

function taskBoard.onSay(player, words, param)
	logCommand(player, words, param)

	local split = param:split(",")
	local command = split[1] or ""
	command = command:trim():lower()

	-- ====================================================================
	-- HELP
	-- ====================================================================
	if command == "" or command == "help" then
		player:sendTextMessage(
			MESSAGE_EVENT_ADVANCE,
			"[TaskBoard] Commands:\n"
				.. "  /taskboard reset\n"
				.. "  /taskboard resetweekly,<player>\n"
				.. "  /taskboard resetbounty,<player>\n"
				.. "  /taskboard addbountypoints,<player>,<amount>\n"
				.. "  /taskboard addhuntingtaskpoints,<player>,<amount>\n"
				.. "  /taskboard addsoulsealspoints,<player>,<amount>\n"
				.. "  /taskboard addrerolltasks,<player>,<amount>\n"
				.. "  /taskboard points[,<player>]\n"
				.. "  /taskboard bounty,<player>,<subcommand>,...\n"
				.. "  /taskboard weekly,<player>,<subcommand>,...\n"
				.. "  /taskboard shop,<player>,send\n"
				.. "Type /taskboard bountyhelp or /taskboard weeklyhelp for details."
		)
		return true
	end

	if command == "bountyhelp" then
		player:sendTextMessage(
			MESSAGE_EVENT_ADVANCE,
			"[TaskBoard] Bounty Commands:\n"
				.. "  bounty,<player>,state,<0-3>\n"
				.. "  bounty,<player>,difficulty,<0-3>\n"
				.. "  bounty,<player>,generate[,<difficulty>]\n"
				.. "  bounty,<player>,talisman,<path 0-3>,<level>\n"
				.. "  bounty,<player>,talismans,<level>\n"
				.. "  bounty,<player>,rerolltokens,<amount>\n"
				.. "  bounty,<player>,rerolltimestamp,<seconds>\n"
				.. "  bounty,<player>,active,<raceId>,<kills>,<curKills>,<exp>,<bp>,<grade>,<diff>\n"
				.. "  bounty,<player>,creature,<raceId>,<kills>,<curKills>,<exp>,<bp>,<claim>,<grade>\n"
				.. "  bounty,<player>,clearcreatures\n"
				.. "  bounty,<player>,info\n"
				.. "  bounty,<player>,send"
		)
		return true
	end

	if command == "weeklyhelp" then
		player:sendTextMessage(
			MESSAGE_EVENT_ADVANCE,
			"[TaskBoard] Weekly Commands:\n"
				.. "  weekly,<player>,generate,<difficulty 0-3>\n"
				.. "  weekly,<player>,difficulty,<0-3>\n"
				.. "  weekly,<player>,diffmultiplier,<0-3>   - Set protocol difficulty multiplier\n"
				.. "  weekly,<player>,killprogress,<taskIndex>,<kills>\n"
				.. "  weekly,<player>,deliveryprogress,<taskIndex>,<items>,<delivered>\n"
				.. "  weekly,<player>,deliveryunknowns,<taskIndex>,<u1>,<u2> - Set delivery unknown bytes\n"
				.. "  weekly,<player>,anycreature,<kills>\n"
				.. "  weekly,<player>,completed,<killCount>,<deliveryCount>\n"
				.. "  weekly,<player>,finished,<0-1>          - Set weeklyProgressFinished\n"
				.. "  weekly,<player>,rewards,<htp>,<soulseals> - Set reward display values\n"
				.. "  weekly,<player>,rewardexp,<killExp>,<deliveryExp> - Set reward XP\n"
				.. "  weekly,<player>,info\n"
				.. "  weekly,<player>,send"
		)
		return true
	end

	-- ====================================================================
	-- RESET
	-- ====================================================================
	if command == "reset" then
		local r1 = db.query("DELETE FROM `player_bounty_tasks`")
		local r2 = db.query("DELETE FROM `player_weekly_tasks`")
		local s1 = r1 and "OK" or "FAILED"
		local s2 = r2 and "OK" or "FAILED"
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Database reset:\n" .. "  player_bounty_tasks: " .. s1 .. "\n" .. "  player_weekly_tasks: " .. s2 .. "\n" .. "Players must relog to get fresh data.")
		return true
	end

	-- ====================================================================
	-- RESET WEEKLY (per player, shows difficulty selection)
	-- ====================================================================
	if command == "resetweekly" then
		local target, err = getTarget(player, split, 2)
		if not target then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err .. "\nUsage: /taskboard resetweekly,<player>")
			return true
		end
		target:resetWeeklyTasks()
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Weekly tasks reset for %s. Finished screen will appear.", target:getName()))
		return true
	end

	-- ====================================================================
	-- RESET BOUNTY (per player, clears all bounty data)
	-- ====================================================================
	if command == "resetbounty" then
		local target, err = getTarget(player, split, 2)
		if not target then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err .. "\nUsage: /taskboard resetbounty,<player>")
			return true
		end
		target:setBountyTaskState(0)
		target:setBountyTaskDifficulty(0)
		target:clearBountyCreatureList()
		target:setBountyActiveTask(0, 0, 0, 0, 0, 0, 0)
		target:setBountyRerollTokens(0)
		target:setBountyRerollTimestamp(0)
		target:sendBountyTaskData()
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Bounty tasks reset for %s.", target:getName()))
		return true
	end

	-- ====================================================================
	-- ADD BOUNTY POINTS
	-- ====================================================================
	if command == "addbountypoints" then
		local target, err = getTarget(player, split, 2)
		if not target then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err .. "\nUsage: /taskboard addbountypoints,<player>,<amount>")
			return true
		end
		local amount, err2 = getRequiredNumber(split, 3, "amount")
		if not amount then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
			return true
		end
		if amount <= 0 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: Amount must be greater than 0.")
			return true
		end
		local before = target:getBountyPoints()
		target:addBountyPoints(amount)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Bounty Points for %s: %d -> %d (+%d)", target:getName(), before, target:getBountyPoints(), amount))
		return true
	end

	-- ====================================================================
	-- ADD TASK HUNTING POINTS
	-- ====================================================================
	if command == "addhuntingtaskpoints" then
		local target, err = getTarget(player, split, 2)
		if not target then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err .. "\nUsage: /taskboard addhuntingtaskpoints,<player>,<amount>")
			return true
		end
		local amount, err2 = getRequiredNumber(split, 3, "amount")
		if not amount then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
			return true
		end
		if amount <= 0 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: Amount must be greater than 0.")
			return true
		end
		local before = target:getTaskHuntingPoints()
		target:addTaskHuntingPoints(amount)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Task Hunting Points for %s: %d -> %d (+%d)", target:getName(), before, target:getTaskHuntingPoints(), amount))
		return true
	end

	-- ====================================================================
	-- ADD SOULSEALS POINTS
	-- ====================================================================
	if command == "addsoulsealspoints" then
		local target, err = getTarget(player, split, 2)
		if not target then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err .. "\nUsage: /taskboard addsoulsealspoints,<player>,<amount>")
			return true
		end
		local amount, err2 = getRequiredNumber(split, 3, "amount")
		if not amount then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
			return true
		end
		if amount <= 0 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: Amount must be greater than 0.")
			return true
		end
		local before = target:getSoulsealsPoints()
		target:addSoulsealsPoints(amount)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Soulseals Points for %s: %d -> %d (+%d)", target:getName(), before, target:getSoulsealsPoints(), amount))
		return true
	end

	-- ====================================================================
	-- ADD REROLL TASKS
	-- ====================================================================
	if command == "addrerolltasks" then
		local target, err = getTarget(player, split, 2)
		if not target then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err .. "\nUsage: /taskboard addrerolltasks,<player>,<amount>")
			return true
		end
		local amount, err2 = getRequiredNumber(split, 3, "amount")
		if not amount then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
			return true
		end
		if amount <= 0 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: Amount must be greater than 0.")
			return true
		end
		local before = target:getRerollTasks()
		target:addRerollTasks(amount)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Reroll Tasks for %s: %d -> %d (+%d)", target:getName(), before, target:getRerollTasks(), amount))
		return true
	end

	-- ====================================================================
	-- SHOW POINTS
	-- ====================================================================
	if command == "points" then
		local targetName = split[2] and split[2]:trim() or ""
		local target
		if targetName ~= "" then
			target = Player(targetName)
			if not target then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: Player '" .. targetName .. "' is not online.")
				return true
			end
		else
			target = player
		end

		local soulseals = target:getSoulsealsPoints()
		local expansion = target:weeklyTaskExpansion() and "Yes" or "No"

		-- Talisman levels
		local talismans = ""
		for i = 0, 3 do
			talismans = talismans .. string.format("\n  Talisman %s: Level %d", TALISMAN_NAMES[i], target:getBountyTalismanLevel(i))
		end

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Points for %s:\n  Bounty Points: %d\n  Task Hunting Points: %d\n  Soulseals Points: %d\n  Reroll Tokens: %d\n  Weekly Task Expansion: %s%s", target:getName(), target:getBountyPoints(), target:getTaskHuntingPoints(), soulseals, target:getRerollTasks(), expansion, talismans))
		return true
	end

	-- ====================================================================
	-- BOUNTY TASK COMMANDS
	-- ====================================================================
	if command == "bounty" then
		local target, err = getTarget(player, split, 2)
		if not target then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err .. "\nUsage: /taskboard bounty,<player>,<subcommand>,...")
			return true
		end

		local sub = split[3] and split[3]:trim():lower() or ""

		-- bounty,<player>,state,<state>
		if sub == "state" then
			local state, err2 = getRequiredNumber(split, 4, "state (0-3)")
			if not state then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			target:setBountyTaskState(state)
			target:sendBountyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Bounty state for %s set to %d (%s)", target:getName(), state, BOUNTY_STATE_NAMES[state] or "?"))
			return true
		end

		-- bounty,<player>,difficulty,<difficulty>
		if sub == "difficulty" then
			local diff, err2 = getRequiredNumber(split, 4, "difficulty (0-3)")
			if not diff then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			target:setBountyTaskDifficulty(diff)
			target:sendBountyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Bounty difficulty for %s set to %d (%s)", target:getName(), diff, DIFFICULTY_NAMES[diff] or "?"))
			return true
		end

		-- bounty,<player>,generate[,<difficulty>]
		if sub == "generate" then
			local diff = getOptionalNumber(split, 4, 0)
			target:generateBountyCreatureList(diff)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Generated bounty creature list for %s (difficulty: %s)", target:getName(), DIFFICULTY_NAMES[diff] or "?"))
			return true
		end

		-- bounty,<player>,talisman,<path>,<level>
		if sub == "talisman" then
			local pathIndex, err2 = getRequiredNumber(split, 4, "pathIndex (0-3)")
			if not pathIndex then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			local level, err3 = getRequiredNumber(split, 5, "level")
			if not level then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err3)
				return true
			end
			local before = target:getBountyTalismanLevel(pathIndex)
			target:setBountyTalismanLevel(pathIndex, level)
			target:sendBountyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Talisman %s for %s: Level %d -> %d", TALISMAN_NAMES[pathIndex] or "?", target:getName(), before, level))
			return true
		end

		-- bounty,<player>,talismans,<level> (set all 4 paths)
		if sub == "talismans" then
			local level, err2 = getRequiredNumber(split, 4, "level")
			if not level then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			for i = 0, 3 do
				target:setBountyTalismanLevel(i, level)
			end
			target:sendBountyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] All talismans for %s set to level %d", target:getName(), level))
			return true
		end

		-- bounty,<player>,rerolltokens,<amount>
		if sub == "rerolltokens" then
			local amount, err2 = getRequiredNumber(split, 4, "amount")
			if not amount then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			target:setBountyRerollTokens(amount)
			target:sendBountyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Reroll tokens for %s set to %d", target:getName(), amount))
			return true
		end

		-- bounty,<player>,rerolltimestamp,<seconds>
		if sub == "rerolltimestamp" then
			local seconds, err2 = getRequiredNumber(split, 4, "seconds from now")
			if not seconds then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			-- Convert seconds to OTSYS_TIME (milliseconds since epoch)
			target:setBountyRerollTimestamp((os.time() * 1000) + (seconds * 1000))
			target:sendBountyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Reroll timestamp for %s set to %d seconds from now", target:getName(), seconds))
			return true
		end

		-- bounty,<player>,active,<raceId>,<kills>,<curKills>,<exp>,<bp>,<grade>,<diff>
		if sub == "active" then
			local raceId, err2 = getRequiredNumber(split, 4, "raceId")
			if not raceId then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			local kills, err3 = getRequiredNumber(split, 5, "requiredKills")
			if not kills then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err3)
				return true
			end
			local curKills = getOptionalNumber(split, 6, 0)
			local exp = getOptionalNumber(split, 7, 0)
			local bp = getOptionalNumber(split, 8, 0)
			local grade = getOptionalNumber(split, 9, 0)
			local diff = getOptionalNumber(split, 10, 0)
			target:setBountyActiveTask(raceId, kills, curKills, exp, bp, grade, diff)
			target:setBountyTaskState(2) -- ACTIVE
			target:sendBountyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Active bounty task for %s: raceId=%d, kills=%d/%d, exp=%d, bp=%d, grade=%s, diff=%s", target:getName(), raceId, curKills, kills, exp, bp, GRADE_NAMES[grade] or "?", DIFFICULTY_NAMES[diff] or "?"))
			return true
		end

		-- bounty,<player>,creature,<raceId>,<kills>,<curKills>,<exp>,<bp>,<claim>,<grade>
		if sub == "creature" then
			local raceId, err2 = getRequiredNumber(split, 4, "raceId")
			if not raceId then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			local kills, err3 = getRequiredNumber(split, 5, "requiredKills")
			if not kills then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err3)
				return true
			end
			local curKills = getOptionalNumber(split, 6, 0)
			local exp = getOptionalNumber(split, 7, 0)
			local bp = getOptionalNumber(split, 8, 0)
			local claim = getOptionalNumber(split, 9, 0)
			local grade = getOptionalNumber(split, 10, 0)
			target:addBountyCreature(raceId, kills, curKills, exp, bp, claim, grade)
			target:sendBountyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Added bounty creature for %s: raceId=%d, kills=%d/%d, exp=%d, bp=%d, claim=%s, grade=%s", target:getName(), raceId, curKills, kills, exp, bp, CLAIM_NAMES[claim] or "?", GRADE_NAMES[grade] or "?"))
			return true
		end

		-- bounty,<player>,clearcreatures
		if sub == "clearcreatures" then
			target:clearBountyCreatureList()
			target:sendBountyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Bounty creature list cleared for %s", target:getName()))
			return true
		end

		-- bounty,<player>,info
		if sub == "info" then
			local msg = string.format("[TaskBoard] Bounty Info for %s:\n  Bounty Points: %d\n  Reroll Tokens: %d", target:getName(), target:getBountyPoints(), target:getRerollTasks())
			for i = 0, 3 do
				msg = msg .. string.format("\n  Talisman %s: Level %d", TALISMAN_NAMES[i], target:getBountyTalismanLevel(i))
			end
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, msg)
			return true
		end

		-- bounty,<player>,send
		if sub == "send" then
			target:sendBountyTaskData()
			target:sendTaskBoardResourceBalance()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Bounty task packet sent to %s", target:getName()))
			return true
		end

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Unknown bounty subcommand: " .. sub .. ". Use /taskboard bountyhelp")
		return true
	end

	-- ====================================================================
	-- WEEKLY TASK COMMANDS
	-- ====================================================================
	if command == "weekly" then
		local target, err = getTarget(player, split, 2)
		if not target then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err .. "\nUsage: /taskboard weekly,<player>,<subcommand>,...")
			return true
		end

		local sub = split[3] and split[3]:trim():lower() or ""

		-- weekly,<player>,generate,<difficulty>
		if sub == "generate" then
			local diff, err2 = getRequiredNumber(split, 4, "difficulty (0-3)")
			if not diff then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			target:generateWeeklyTasks(diff)
			target:sendWeeklyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Generated weekly tasks for %s (difficulty: %s)", target:getName(), DIFFICULTY_NAMES[diff] or "?"))
			return true
		end

		-- weekly,<player>,difficulty,<difficulty>
		if sub == "difficulty" then
			local diff, err2 = getRequiredNumber(split, 4, "difficulty (0-3)")
			if not diff then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			target:setWeeklyDifficulty(diff)
			target:sendWeeklyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Weekly difficulty for %s set to %d (%s)", target:getName(), diff, DIFFICULTY_NAMES[diff] or "?"))
			return true
		end

		-- weekly,<player>,killprogress,<taskIndex>,<kills>
		if sub == "killprogress" then
			local taskIndex, err2 = getRequiredNumber(split, 4, "taskIndex")
			if not taskIndex then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			local kills, err3 = getRequiredNumber(split, 5, "kills")
			if not kills then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err3)
				return true
			end
			target:setWeeklyKillTaskProgress(taskIndex, kills)
			target:sendWeeklyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Weekly kill task %d for %s set to %d kills", taskIndex, target:getName(), kills))
			return true
		end

		-- weekly,<player>,deliveryprogress,<taskIndex>,<items>,<delivered>
		if sub == "deliveryprogress" then
			local taskIndex, err2 = getRequiredNumber(split, 4, "taskIndex")
			if not taskIndex then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			local items, err3 = getRequiredNumber(split, 5, "items")
			if not items then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err3)
				return true
			end
			local delivered = getOptionalNumber(split, 6, 0)
			target:setWeeklyDeliveryTaskProgress(taskIndex, items, delivered)
			target:sendWeeklyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Weekly delivery task %d for %s: items=%d, delivered=%d", taskIndex, target:getName(), items, delivered))
			return true
		end

		-- weekly,<player>,anycreature,<kills>
		if sub == "anycreature" then
			local kills, err2 = getRequiredNumber(split, 4, "kills")
			if not kills then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			target:setWeeklyAnyCreatureProgress(kills)
			target:sendWeeklyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Weekly 'any creature' kills for %s set to %d", target:getName(), kills))
			return true
		end

		-- weekly,<player>,completed,<killCount>,<deliveryCount>
		if sub == "completed" then
			local killCount, err2 = getRequiredNumber(split, 4, "killCount")
			if not killCount then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			local deliveryCount = getOptionalNumber(split, 5, 0)
			target:setWeeklyCompletedTasks(killCount, deliveryCount)
			target:sendWeeklyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Weekly completed tasks for %s: kill=%d, delivery=%d", target:getName(), killCount, deliveryCount))
			return true
		end

		-- weekly,<player>,diffmultiplier,<value>
		if sub == "diffmultiplier" then
			local val, err2 = getRequiredNumber(split, 4, "difficultyMultiplier (0-3)")
			if not val then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			target:setWeeklyDifficultyMultiplier(val)
			target:sendWeeklyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Weekly difficultyMultiplier for %s set to %d", target:getName(), val))
			return true
		end

		-- weekly,<player>,deliveryunknowns,<taskIndex>,<unknown1>,<unknown2>
		if sub == "deliveryunknowns" then
			local taskIndex, err2 = getRequiredNumber(split, 4, "taskIndex")
			if not taskIndex then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			local u1, err3 = getRequiredNumber(split, 5, "unknown1")
			if not u1 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err3)
				return true
			end
			local u2 = getOptionalNumber(split, 6, 0)
			local ok = target:setWeeklyDeliveryUnknowns(taskIndex, u1, u2)
			target:sendWeeklyTaskData()
			if ok then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Delivery task %d for %s: unknown1=%d, unknown2=%d", taskIndex, target:getName(), u1, u2))
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Error: Delivery task index %d out of range for %s", taskIndex, target:getName()))
			end
			return true
		end

		-- weekly,<player>,finished,<value>
		if sub == "finished" then
			local val, err2 = getRequiredNumber(split, 4, "weeklyProgressFinished (0-1)")
			if not val then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			target:setWeeklyProgressFinished(val)
			target:sendWeeklyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Weekly progressFinished for %s set to %d", target:getName(), val))
			return true
		end

		-- weekly,<player>,rewards,<huntingTaskPoints>,<soulseals>
		if sub == "rewards" then
			local htp, err2 = getRequiredNumber(split, 4, "huntingTaskPoints")
			if not htp then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			local soulseals = getOptionalNumber(split, 5, 0)
			target:setWeeklyRewards(htp, soulseals)
			target:sendWeeklyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Weekly rewards for %s: HTP=%d, Soulseals=%d", target:getName(), htp, soulseals))
			return true
		end

		-- weekly,<player>,rewardexp,<killTaskExp>,<deliveryTaskExp>
		if sub == "rewardexp" then
			local killExp, err2 = getRequiredNumber(split, 4, "killTaskRewardExp")
			if not killExp then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err2)
				return true
			end
			local deliveryExp = getOptionalNumber(split, 5, killExp)
			target:setWeeklyRewardExp(killExp, deliveryExp)
			target:sendWeeklyTaskData()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Weekly reward XP for %s: kill=%d, delivery=%d", target:getName(), killExp, deliveryExp))
			return true
		end

		-- weekly,<player>,info
		if sub == "info" then
			local msg = string.format("[TaskBoard] Weekly Info for %s:\n  Task Hunting Points: %d\n  Soulseals: %d", target:getName(), target:getTaskHuntingPoints(), target:getSoulsealsPoints())
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, msg)
			return true
		end

		-- weekly,<player>,send
		if sub == "send" then
			target:sendWeeklyTaskData()
			target:sendTaskBoardResourceBalance()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Weekly task packet sent to %s", target:getName()))
			return true
		end

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Unknown weekly subcommand: " .. sub .. ". Use /taskboard weeklyhelp")
		return true
	end

	-- ====================================================================
	-- HUNTING TASK SHOP COMMANDS
	-- ====================================================================
	if command == "shop" then
		local target, err = getTarget(player, split, 2)
		if not target then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Error: " .. err .. "\nUsage: /taskboard shop,<player>,send")
			return true
		end

		local sub = split[3] and split[3]:trim():lower() or ""

		-- shop,<player>,send
		if sub == "send" then
			target:sendHuntingTaskShopData()
			target:sendTaskBoardResourceBalance()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[TaskBoard] Hunting task shop packet sent to %s", target:getName()))
			return true
		end

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Unknown shop subcommand: " .. sub)
		return true
	end

	-- ====================================================================
	-- UNKNOWN
	-- ====================================================================
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[TaskBoard] Unknown: " .. command .. ". Use /taskboard help")
	return true
end

taskBoard:separator(" ")
taskBoard:groupType("god")
taskBoard:register()
