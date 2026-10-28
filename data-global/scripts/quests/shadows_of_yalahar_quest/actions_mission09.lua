local HEADACHE_DURATION = 60
local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar

-- Folio
local yalahariFolio = Action()
function yalahariFolio.onUse(player, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(ShadowsOfYalahar.Mission09) ~= 1 then
		return true
	end

	local successCount = player:getStorageValue(ShadowsOfYalahar.Mission09BooksSuccess)
	if successCount < 0 then
		successCount = 0
	end

	if successCount >= 8 then
		return true
	end

	local headacheUntil = player:getStorageValue(ShadowsOfYalahar.Mission09HeadacheUntil)
	if headacheUntil > os.time() then
		player:say("You still have a headache and cannot concentrate on reading.", TALKTYPE_MONSTER_SAY)
		return true
	end

	local roll = math.random(1, 100)
	if roll <= 1 then
		player:teleportTo(Position(33324, 32173, 6))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:setStorageValue(ShadowsOfYalahar.Mission09BooksSuccess, 0)
		return true
	elseif roll <= 20 then
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
		player:say("You got a headache from all this reading.", TALKTYPE_MONSTER_SAY)
		player:setStorageValue(ShadowsOfYalahar.Mission09BooksSuccess, 0)
		player:setStorageValue(ShadowsOfYalahar.Mission09HeadacheUntil, os.time() + HEADACHE_DURATION)
		local monsterRoll = math.random(1, 100)
		if monsterRoll <= 5 then
			Game.createMonster("War Golem", player:getPosition(), true, true)
		elseif monsterRoll <= 10 then
			Game.createMonster("Fire Devil", player:getPosition(), true, true)
		elseif monsterRoll <= 20 then
			Game.createMonster("Enraged Bookworm", player:getPosition(), true, true)
		end
		return true
	else
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
		player:say("You learned something about the ritual.", TALKTYPE_MONSTER_SAY)
		player:setStorageValue(ShadowsOfYalahar.Mission09BooksSuccess, successCount + 1)
		return true
	end
end
yalahariFolio:aid(4953)
yalahariFolio:register()

-- Inkwell
local yalahariInkwell = Action()
function yalahariInkwell.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(ShadowsOfYalahar.Mission09) ~= 1 then
		return true
	end

	local successCount = player:getStorageValue(ShadowsOfYalahar.Mission09BooksSuccess)
	if successCount < 8 then
		player:say("You decide not to touch that.", TALKTYPE_MONSTER_SAY)
		return true
	end

	player:say("You have written down the ritual.", TALKTYPE_MONSTER_SAY)
	player:setStorageValue(ShadowsOfYalahar.Mission09, 2)
	player:setStorageValue(ShadowsOfYalahar.Mission09BooksSuccess, -1)
	return true
end
yalahariInkwell:aid(4954)
yalahariInkwell:register()

-- Headache Pill
local headachePill = Action()
function headachePill.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local headacheUntil = player:getStorageValue(ShadowsOfYalahar.Mission09HeadacheUntil)
	if headacheUntil <= os.time() then
		player:sendCancelMessage("You do not have a headache.")
		return true
	end

	player:setStorageValue(ShadowsOfYalahar.Mission09HeadacheUntil, -1)
	player:say("Your headache is gone.", TALKTYPE_MONSTER_SAY)
	item:remove(1)
	return true
end
headachePill:id(9537)
headachePill:register()
