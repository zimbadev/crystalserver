local callback = EventCallback("MonsterOnDropLootTheCorruptor")

function callback.monsterOnDropLoot(monster, corpse)
	if not monster or not corpse then
		return
	end

	if monster:getName():lower() ~= "the corruptor" then
		return
	end

	local player = Player(corpse:getCorpseOwner())
	if not player then
		return
	end

	local commonLoot = {
		{ id = 3031, count = math.random(1, 50) }, -- Gold Coin
		{ id = 3723, count = math.random(0, 3) }, -- White Mushroom
		{ id = 7618, count = math.random(0, 4) }, -- Health Potion
		{ id = 2853, count = 1, chance = 50 }, -- Bag
		{ id = 3338, count = 1, chance = 50 }, -- Bone Sword
	}

	for _, item in ipairs(commonLoot) do
		local addItem = true
		if item.chance then
			addItem = math.random(100) <= item.chance
		end
		if addItem and item.count > 0 then
			corpse:addItem(item.id, item.count)
		end
	end

	if player:getStorageValue(Storage.Quest.U15_12.newhavenNewLootTheCorruptor) < 1 then
		return
	end

	local vocationLoot = {}

	if player:isKnight() then
		vocationLoot = {
			{ id = 3359, count = 1, chance = 100 }, -- Brass Armor
			{ id = 3285, count = 1, chance = 100 }, -- Longsword
			{ id = 3375, count = 1, chance = 100 }, -- Soldier Helmet
		}
	elseif player:isMonk() then
		vocationLoot = {
			{ id = 48847, count = 1, chance = 100 }, -- Harmony Amulet
			{ id = 48845, count = 1, chance = 100 }, -- Simple Jo Staff
		}
	elseif player:isPaladin() then
		vocationLoot = {
			{ id = 10321, count = 1, chance = 100 }, -- Ranger's Cloak
			{ id = 48843, count = 1, chance = 100 }, -- Refined Bow
		}
	elseif player:isDruid() then
		vocationLoot = {
			{ id = 3066, count = 1, chance = 100 }, -- Snakebite Rod
			{ id = 8871, count = 1, chance = 100 }, -- Magician's Robe
		}
	elseif player:isSorcerer() then
		vocationLoot = {
			{ id = 3074, count = 1, chance = 100 }, -- Wand of Vortex
			{ id = 8871, count = 1, chance = 100 }, -- Magician's Robe
		}
	end

	for _, item in ipairs(vocationLoot) do
		local addItem = true
		if item.chance and item.chance < 100 then
			addItem = math.random(100) <= item.chance
		end
		if addItem then
			corpse:addItem(item.id, item.count)
		end
	end

	player:setStorageValue(Storage.Quest.U15_12.newhavenNewLootTheCorruptor, -1)
end

callback:register()
