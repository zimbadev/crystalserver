--[[
	A Piece of Cake - Extraction Spots. 
	It's the SAME physical tile	used for two different things, depending on who steps on it:
		1) A Cake Golem (monster) steps here during stage 1: it gets
		   extracted (removed from the game) and counts toward the 200
		   golems-lured goal. The player needs to make the golem
		   (hostile, chases the player) walk here - no need to kill it.
		2) A player steps here during the Brutus reward errand, ONLY
		   while the quest is in stage 3: counts as "visited this
		   city's machine", if they already stepped on the isle's Cake
		   Base before (errand.stepIsleArmed).
]]

local extractionSpot = MoveEvent()

local function cityFromActionId(aid)
	for city, cityAid in pairs(CakeQuest.ActionIds.ExtractionSpot) do
		if cityAid == aid then
			return city
		end
	end
	return nil
end

local function handleGolemLure(creature, city)
	if CakeQuest.getStage() ~= 1 then
		return true
	end

	local total = CakeQuest.get(CakeQuest.Keys.GolemsLured, 0)
	if total >= CakeQuest.Config.GOLEM_LURE_GOAL then
		return true
	end

	total = total + 1
	CakeQuest.set(CakeQuest.Keys.GolemsLured, total)

	creature:say("CRUNSH!", TALKTYPE_MONSTER_SAY)
	creature:getPosition():sendMagicEffect(CONST_ME_STUN)
	creature:remove()

	if total % 20 == 0 or total >= CakeQuest.Config.GOLEM_LURE_GOAL then
		Game.broadcastMessage(("A Piece of Cake: %d/%d Cake Golems extracted!"):format(total, CakeQuest.Config.GOLEM_LURE_GOAL), MESSAGE_EVENT_ADVANCE)
	end

	CakeQuest.checkStage1Complete()

	return true
end

local function handleBrutusVisit(player, city)
	local errand = CakeQuest.getBrutusErrand(player)
	if #errand.visitedCities >= 5 then
		return true
	end
	if not errand.stepIsleArmed then
		player:sendTextMessage(MESSAGE_FAILURE, "Go step on the Cake Base at the isle first.")
		return true
	end

	for _, visitedCity in ipairs(errand.visitedCities) do
		if visitedCity == city then
			player:sendTextMessage(MESSAGE_FAILURE, "You already visited this machine for Brutus' errand.")
			return true
		end
	end

	table.insert(errand.visitedCities, city)
	errand.stepIsleArmed = false
	CakeQuest.setBrutusErrand(player, errand)

	player:say("SWOOSH!", TALKTYPE_MONSTER_SAY)
	player:getPosition():sendMagicEffect(CONST_ME_CAKE)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, (city .. " machine visited. Head back to the Cake Base isle."))
	return true
end

function extractionSpot.onStepIn(creature, item, position, fromPosition)
	local city = cityFromActionId(item.actionid)
	if not city then
		return true
	end

	local monster = creature:getMonster()
	if monster and creature:getName() == CakeQuest.MonsterName then
		return handleGolemLure(creature, city)
	end

	local player = creature:getPlayer()
	if player and CakeQuest.getStage() == 3 then
		return handleBrutusVisit(player, city)
	end

	return true
end

extractionSpot:type("stepin")
for _, aid in pairs(CakeQuest.ActionIds.ExtractionSpot) do
	extractionSpot:aid(aid)
end
extractionSpot:register()
