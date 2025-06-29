local holeId = { 294, 369, 370, 385, 394, 411, 412, 413, 432, 433, 435, 482, 483, 594, 595, 609, 610, 615, 868, 874, 1156, 4824, 7515, 7516, 7517, 7518, 7519, 7520, 7521, 7522, 7737, 7755, 7762, 7767, 7768, 8144, 8690, 8709, 12203, 12961, 17239, 19220, 23364 } -- usable rope holes, for rope spots see global.lua
local wildGrowth = { 2130, 3635, 30224 } -- wild growth destroyable by machete
local jungleGrass = { -- grass destroyable by machete
	[3696] = 3695,
	[3702] = 3701,
	[17153] = 17151,
}
local groundIds = { 354, 355 } -- pick usable grounds
local sandIds = { 231 } -- desert sand
local fruits = { 3584, 3585, 3586, 3587, 3588, 3589, 3590, 3591, 3592, 3593, 3595, 3596, 5096, 8011, 8012, 8013 } -- fruits to make decorated cake with knife
local holes = { 593, 606, 608, 867, 21341 } -- holes opened by shovel
local ropeSpots = { 386, 421, 12935, 12936, 14238, 17238, 21501, 21965, 21966, 21967, 21968, 23363 }
local lava = {
	Position(550, 185, 11),
	Position(550, 186, 11),
	Position(550, 187, 11),
	Position(551, 187, 11),
	Position(551, 186, 11),
	Position(551, 185, 11),
	Position(552, 186, 11),
	Position(552, 185, 11),
	Position(552, 184, 11),
	Position(552, 183, 11),
	Position(552, 182, 11),
	Position(553, 182, 11),
	Position(553, 183, 11),
	Position(553, 184, 11),
	Position(553, 185, 11),
	Position(553, 186, 11),
	Position(554, 186, 11),
	Position(554, 185, 11),
	Position(554, 184, 11),
	Position(554, 183, 11),
	Position(554, 182, 11),
	Position(554, 181, 11),
	Position(555, 181, 11),
	Position(555, 182, 11),
	Position(555, 183, 11),
	Position(555, 184, 11),
	Position(555, 185, 11),
	Position(555, 186, 11),
	Position(555, 187, 11),
	Position(556, 186, 11),
	Position(556, 185, 11),
	Position(556, 184, 11),
	Position(556, 183, 11),
	Position(556, 182, 11),
	Position(556, 181, 11),
	Position(557, 181, 11),
	Position(557, 182, 11),
	Position(557, 183, 11),
	Position(558, 183, 11),
	Position(558, 182, 11),
	Position(558, 181, 11),
	Position(559, 181, 11),
	Position(559, 182, 11),
	Position(559, 183, 11),
	Position(554, 187, 11),
}
local cutItems = {
	[2291] = 3146,
	[2292] = 3146,
	[2293] = 3145,
	[2294] = 3145,
	[2295] = 3145,
	[2296] = 3145,
	[2314] = 3136,
	[2315] = 3136,
	[2316] = 3136,
	[2319] = 3136,
	[2358] = 3138,
	[2359] = 3138,
	[2360] = 3138,
	[2361] = 3138,
	[2366] = 3137,
	[2367] = 3137,
	[2368] = 3137,
	[2369] = 3137,
	[2374] = 3137,
	[2375] = 3137,
	[2376] = 3137,
	[2377] = 3137,
	[2378] = 3137,
	[2379] = 3137,
	[2380] = 3137,
	[2381] = 3137,
	[2382] = 3138,
	[2384] = 3137,
	[2385] = 3138,
	[2431] = 3136,
	[2432] = 3136,
	[2433] = 3136,
	[2441] = 3137,
	[2442] = 3137,
	[2443] = 3137,
	[2444] = 3137,
	[2445] = 3139,
	[2446] = 3139,
	[2447] = 3139,
	[2448] = 3139,
	[2449] = 3139,
	[2450] = 3139,
	[2452] = 3139,
	[2524] = 3135,
	[2904] = 3137,
	[4995] = 4996,
	[2997] = 3139,
	[2998] = 3139,
	[2999] = 3139,
	[3000] = 3139,
	[6123] = 3139,
	[2959] = 3139,
	[2960] = 3139,
	[2961] = 3139,
	[2962] = 3139,
	[2963] = 3139,
	[2964] = 3139,
	[2974] = 3135,
	[2975] = 3135,
	[2976] = 3135,
	[2979] = 3135,
	[2980] = 3135,
	[2982] = 3135,
	[2987] = 3135,
	[2986] = 3135,
	[3465] = 3142,
	[3484] = 3143,
	[3485] = 3143,
	[3486] = 3143,
	[2346] = 6266,
	[2347] = 6266,
	[2348] = 3137,
	[2349] = 3137,
	[2350] = 3137,
	[2351] = 3137,
	[2352] = 3140,
	[2353] = 6266,
	[2418] = 3137,
	[2419] = 3137,
	[2420] = 3137,
	[2421] = 3137,
	[2422] = 3137,
	[2423] = 3137,
	[2424] = 3137,
	[2425] = 3137,
	[2426] = 3140,
	[2465] = 3140,
	[2466] = 3140,
	[2467] = 3140,
	[2468] = 3140,
	[6355] = 3142,
	[6356] = 3142,
	[6357] = 3142,
	[6358] = 3142,
	[6359] = 3142,
	[6360] = 3142,
	[6362] = 3142,
	[6367] = 3135,
	[6368] = 3135,
	[6369] = 3135,
	[6370] = 3135,
	[2469] = 3135,
	[2471] = 3136,
	[2472] = 3135,
	[2473] = 3140,
	[2480] = 3135,
	[2481] = 3135,
	[2482] = 2483,
	[2483] = 3139,
	[2484] = 3139,
	[2485] = 3139,
	[2486] = 3139,
	[2519] = 3136,
	[2523] = 3135,
	[6085] = 3139,
	[116] = 3136,
	[117] = 3136,
	[118] = 3136,
	[119] = 3135,
	[404] = 3136,
	[405] = 3136,
	[6109] = 3139,
	[6110] = 3139,
	[6111] = 3139,
	[6112] = 3139,
	[182] = 188,
	[183] = 189,
	[233] = 234,
	[25798] = 0,
	[25800] = 0,
}

function destroyItem(player, item, fromPosition, target, toPosition, isHotkey)
	if type(target) ~= "userdata" or not target:isItem() then
		return false
	end

	if target:hasAttribute(ITEM_ATTRIBUTE_UNIQUEID) or target:hasAttribute(ITEM_ATTRIBUTE_ACTIONID) then
		return false
	end

	if toPosition.x == CONTAINER_POSITION then
		player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return true
	end

	local destroyId = ItemType(target.itemid):getDestroyId()
	if destroyId == 0 then
		return false
	end

	if math.random(7) == 1 then
		local item = Game.createItem(destroyId, 1, toPosition)
		if item then
			item:decay()
		end

		-- Move items outside the container
		if target:isContainer() then
			for i = target:getSize() - 1, 0, -1 do
				local containerItem = target:getItem(i)
				if containerItem then
					containerItem:moveTo(toPosition)
				end
			end
		end
		target:remove(1)
	end
	toPosition:sendMagicEffect(CONST_ME_POFF)
	return true
end

function onUseMachete(player, item, fromPosition, target, toPosition, isHotkey)
	local targetId = target.itemid
	if not targetId then
		return true
	end

	if table.contains(wildGrowth, targetId) then
		toPosition:sendMagicEffect(CONST_ME_POFF)
		target:remove()
		return true
	end

	local grass = jungleGrass[targetId]
	if grass then
		target:transform(grass)
		target:decay()
		player:addAchievementProgress("Nothing Can Stop Me", 100)
		return true
	end
	return destroyItem(player, item, fromPosition, target, toPosition, isHotkey)
end

function onUsePick(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 1791 then
		-- The Pits of Inferno Quest
		if toPosition == Position(553, 182, 11) then
			for i = 1, #lava do
				local lavaTile = Tile(lava[i]):getItemById(21477)
				if lavaTile then
					lavaTile:transform(5815)
				end
			end
			target:transform(3141)
			toPosition:sendMagicEffect(CONST_ME_SMOKE)
		elseif target.actionid == 40031 then
			-- This elseif was previously missing an 'end' before the next 'if' statement
		end -- This 'end' was added to close the 'if target.itemid == 1791 then' block
	end

	if target.itemid == 10310 then -- shiny stone refining
		local chance = math.random(1, 100)
		if chance == 1 then
			player:addItem(ITEM_CRYSTAL_COIN) -- 1% chance of getting crystal coin
		elseif chance <= 6 then
			player:addItem(ITEM_GOLD_COIN) -- 5% chance of getting gold coin
		elseif chance <= 51 then
			player:addItem(ITEM_PLATINUM_COIN) -- 45% chance of getting platinum coin
		else
			player:addItem(3028) -- 49% chance of getting small diamond
		end
		player:addAchievementProgress("Petrologist", 100)
		target:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
		target:remove(1)
		return true
	end

	local tile = Tile(toPosition)
	if not tile then
		return false
	end

	local ground = tile:getGround()
	if not ground then
		return false
	end

	if table.contains(groundIds, ground.itemid) and (ground:hasAttribute(ITEM_ATTRIBUTE_UNIQUEID) or ground:hasAttribute(ITEM_ATTRIBUTE_ACTIONID)) then
		ground:transform(394)
		ground:decay()
		toPosition:sendMagicEffect(CONST_ME_POFF)

		toPosition.z = toPosition.z + 1
		tile:relocateTo(toPosition)
		return true
	end

	-- Ice fishing hole
	if ground.itemid == 7200 then
		ground:transform(7236)
		ground:decay()
		toPosition:sendMagicEffect(CONST_ME_HITAREA)
		return true
	end
	return false
end

function onUseRope(player, item, fromPosition, target, toPosition, isHotkey)
	local tile = Tile(toPosition)
	if not tile then
		return false
	end

	local ground = tile:getGround()
	if ground and table.contains(ropeSpots, ground:getId()) or tile:getItemById(12935) then
		if Tile(toPosition:moveUpstairs()):hasFlag(TILESTATE_PROTECTIONZONE) and player:isPzLocked() then
			player:sendCancelMessage(RETURNVALUE_PLAYERISPZLOCKED)
			return true
		end
		player:teleportTo(toPosition, false)
		return true
	elseif table.contains(holeId, target.itemid) then
		toPosition.z = toPosition.z + 1
		tile = Tile(toPosition)
		if tile then
			local thing = tile:getTopVisibleThing()
			if thing:isPlayer() then
				if Tile(toPosition:moveUpstairs()):hasFlag(TILESTATE_PROTECTIONZONE) and thing:isPzLocked() then
					return false
				end
				return thing:teleportTo(toPosition, false)
			end
			if thing:isItem() and thing:getType():isMovable() then
				return thing:moveTo(toPosition:moveUpstairs())
			end
		end
		player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return true
	end
	return false
end

function onUseShovel(player, item, fromPosition, target, toPosition, isHotkey)
	local tile = Tile(toPosition)
	if not tile then
		return false
	end

	local ground = tile:getGround()
	if not ground then
		return false
	end

	local groundId = ground:getId()
	if table.contains(holes, groundId) then
		ground:transform(groundId + 1)
		ground:decay()
		toPosition:moveDownstairs()
		toPosition.y = toPosition.y - 1
		if Tile(toPosition):hasFlag(TILESTATE_PROTECTIONZONE) and player:isPzLocked() then
			player:sendCancelMessage(RETURNVALUE_PLAYERISPZLOCKED)
			return true
		end
		player:teleportTo(toPosition, false)
		toPosition.z = toPosition.z + 1
		tile:relocateTo(toPosition)
		player:addAchievementProgress("The Undertaker", 500)
	elseif target.itemid == 867 then -- large hole
		target:transform(868)
		target:decay()
		player:addAchievementProgress("The Undertaker", 500)
	elseif target.itemid == 17950 then -- swamp digging
		if not player:hasExhaustion("swamp-digging") then
			local chance = math.random(1, 100)
			if chance <= 42 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You dug up a dead snake.")
				player:addItem(4259)
			elseif chance >= 43 and chance <= 79 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You dug up a small diamond.")
				player:addItem(3028)
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You dug up a leech.")
				player:addItem(17858)
			end

			player:setExhaustion("swamp-digging", 7 * 24 * 60 * 60)
			player:getPosition():sendMagicEffect(CONST_ME_GREEN_RINGS)
		end
	elseif table.contains(sandIds, groundId) then
		local randomValue = math.random(1, 100)
		if target.actionid == 100 and randomValue <= 20 then
			ground:transform(615)
			ground:decay()
		elseif randomValue == 1 then
			Game.createItem(3042, 1, toPosition) -- Scarab Coin
			player:addAchievementProgress("Gold Digger", 100)
		elseif randomValue > 95 then
			Game.createMonster("Scarab", toPosition)
		end
		toPosition:sendMagicEffect(CONST_ME_POFF)
	else
		return false
	end
	return true
end

function onUseScythe(player, item, fromPosition, target, toPosition, isHotkey)
	if not table.contains({ 3453, 9596 }, item.itemid) then
		return false
	end

	if target.itemid == 3653 then -- wheat
		target:transform(3651)
		target:decay()
		Game.createItem(3605, 1, toPosition) -- bunch of wheat
		player:addAchievementProgress("Happy Farmer", 200)
		return true
	end
	return destroyItem(player, item, fromPosition, target, toPosition, isHotkey)
end

function onUseSickle(player, item, fromPosition, target, toPosition, isHotkey)
	if not table.contains({ 3293, 3306 }, item.itemid) then
		return false
	end

	if target.itemid == 5464 then -- burning sugar cane
		target:transform(5463)
		target:decay()
		Game.createItem(5466, 1, toPosition) -- bunch of sugar cane
		player:addAchievementProgress("Natural Sweetener", 50)
		return true
	end
	return destroyItem(player, item, fromPosition, target, toPosition, isHotkey)
end

function onUseCrowbar(player, item, fromPosition, target, toPosition, isHotkey)
	if not table.contains({ 3304, 9598 }, item.itemid) then
		return false
	end
	return destroyItem(player, item, fromPosition, target, toPosition, isHotkey)
end

function onUseKitchenKnife(player, item, fromPosition, target, toPosition, isHotkey)
	if not table.contains({ 3469, 9594, 9598 }, item.itemid) then
		return false
	end

	if table.contains(fruits, target.itemid) and player:removeItem(6277, 1) then
		target:remove(1)
		player:addItem(6278, 1)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		return true
	end
	return false
end

function onUseSpoon(player, item, fromPosition, target, toPosition, isHotkey)
	if not table.contains({ 3468, 3470 }, item.itemid) then
		return false
	end
	return false
end
