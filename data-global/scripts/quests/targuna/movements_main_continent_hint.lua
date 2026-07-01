-- Welcome to the Main Continent (tutorial hint id 7) when stepping off the ferry from Newhaven.
-- Also starts the Targuna Quest and shows its secondary tasks in the quest log.
local TARGUNA_QUEST = Storage.Quest.U15_24.Targuna
local MAIN_CONTINENT_HINT = TARGUNA_QUEST.MainContinentHint

local ARRIVAL_TILES = {
	Position(31936, 31927, 7),
	Position(31936, 31926, 7),
	Position(31937, 31926, 7),
	Position(31938, 31926, 7),
	Position(31939, 31926, 7),
	Position(31940, 31926, 7),
	Position(31940, 31927, 7),
	Position(31940, 31928, 7),
	Position(31940, 31929, 7),
}

local mainContinentHint = MoveEvent()

function mainContinentHint.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(MAIN_CONTINENT_HINT) == 1 then
		return true
	end

	player:sendTutorial(13)
	player:setStorageValue(MAIN_CONTINENT_HINT, 1)

	-- Starts the Targuna Quest and shows its secondary tasks in the quest log.
	if player:getStorageValue(TARGUNA_QUEST.Questline) < 1 then
		player:setStorageValue(TARGUNA_QUEST.Questline, 1)
	end
	local tasks = TARGUNA_QUEST.SecondaryTasks
	for _, taskStorage in ipairs({ tasks.DailyReward, tasks.DepositGold, tasks.StashItem, tasks.TakeFromStash, tasks.WithdrawGold }) do
		if player:getStorageValue(taskStorage) < 1 then
			player:setStorageValue(taskStorage, 1)
		end
	end

	-- An Ancient Enemy starts here too: the player is informed of the lizard threat and told to find Lizzie.
	if player:getStorageValue(TARGUNA_QUEST.AncientEnemy.Mission) < 1 then
		player:setStorageValue(TARGUNA_QUEST.AncientEnemy.Mission, 1)
	end

	return true
end

mainContinentHint:type("stepin")
for _, tile in ipairs(ARRIVAL_TILES) do
	mainContinentHint:position(tile)
end
mainContinentHint:register()
