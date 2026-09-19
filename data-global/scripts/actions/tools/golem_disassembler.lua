local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar

local energyCondition = Condition(CONDITION_ENERGY)
energyCondition:setParameter(CONDITION_PARAM_DELAYED, true)
energyCondition:addDamage(5, 2000, -25)

local outcomes = {
	{
		chance = 50,
		message = "You have ruined the golem remains!",
		action = function(player, target) end,
	},
	{
		chance = 5,
		message = "There was something stuck in the golem!",
		action = function(player, target)
			Game.createMonster("Rat", target:getPosition(), true, true)
		end,
	},
	{
		chance = 10,
		message = "You have salvaged some scrap metal!",
		action = function(player, target)
			player:addItem(953, 1) -- nail
		end,
	},
	{
		chance = 5,
		message = "What an electrifying experience!",
		action = function(player, target)
			player:addCondition(energyCondition)
		end,
	},
	{
		chance = 30,
		message = "You have salvaged a golem part.",
		action = function(player, target)
			player:addItem(9233, 1) -- golem part
		end,
	},
}

local function rollOutcome()
	local roll = math.random(1, 100)
	local accumulated = 0
	for _, outcome in ipairs(outcomes) do
		accumulated = accumulated + outcome.chance
		if roll <= accumulated then
			return outcome
		end
	end
	return outcomes[#outcomes]
end

local golemDisassembler = Action()
function golemDisassembler.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- Mission 04 Shadows of Yalahar Quest
	if target.itemid == 8888 then
		if player:getStorageValue(ShadowsOfYalahar.Mission04) ~= 1 then
			return true
		end

		target:transform(8889)

		local outcome = rollOutcome()
		player:say(outcome.message, TALKTYPE_MONSTER_SAY)
		outcome.action(player, target)

		return true
	end
end

golemDisassembler:id(9235)
golemDisassembler:register()
