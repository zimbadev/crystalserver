local thornfireCrystal = Action()

local config = {
	chanceToSummon = 10,
	effect = CONST_ME_SMOKE,
	message = "The magical flames have unleashed the flaming wolves!",
	monsterName = "Thornfire Wolf",
	monsterCount = 2,
	validItemIds = {
		232,
		5061,
		5062,
		5063,
		5064,
		5065,
		5066,
		5067,
		6288,
		6289,
		7803,
		19096,
		32021,
	},
	spawnPositions = {
		Position(33091, 32149, 7),
		Position(33079, 32143, 7),
		Position(33104, 32160, 7),
		Position(33095, 32158, 7),
	},
	storageKey = 147251,
	neededCountForAchievement = 500,
}

function thornfireCrystal.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not table.contains(config.validItemIds, target.itemid) then
		return false
	end

	local randomChance = math.random(100)
	target:remove(1)
	item:transform(12819, 0)
	toPosition:sendMagicEffect(config.effect)

	local currentCount = player:getStorageValue(config.storageKey)
	if currentCount == -1 then
		currentCount = 1
	else
		currentCount = currentCount + 1
	end
	player:setStorageValue(config.storageKey, currentCount)

	if randomChance <= config.chanceToSummon then
		player:say(config.message, TALKTYPE_MONSTER_SAY)
		for i = 1, config.monsterCount do
			local spawnPos = config.spawnPositions[math.random(#config.spawnPositions)]
			Game.createMonster(config.monsterName, spawnPos)
			spawnPos:sendMagicEffect(config.effect)
			if currentCount >= config.neededCountForAchievement and not player:hasAchievement("Firefighter") then
				player:addAchievement("Firefighter")
			end
		end
	end

	return true
end

thornfireCrystal:id(12722)
thornfireCrystal:register()

local fillBucket = Action()

function fillBucket.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 12819 and target.itemid == 12721 then
		item:remove(1)
		player:addItem(12722, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You fill the magical bog water into the prepared bucket. You fill the magical bog water into the prepared bucket. The bucket seems to hold the water but for how long?")
		return true
	end
	return false
end

fillBucket:id(12819)
fillBucket:register()
