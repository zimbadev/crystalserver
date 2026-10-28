local TOP_LEFT_CORNER = { x = 32651, y = 32178, z = 7 }
local BOTTOM_RIGHT_CORNER = { x = 32668, y = 32190, z = 7 }

function removeMonster()
	-- Iterate over the area defined by TOP_LEFT_CORNER and BOTTOM_RIGHT_CORNER
	for Py = TOP_LEFT_CORNER.y, BOTTOM_RIGHT_CORNER.y do
		for Px = TOP_LEFT_CORNER.x, BOTTOM_RIGHT_CORNER.x do
			local tile = Tile(Position({ x = Px, y = Py, z = 7 }))
			if tile then
				local monster = tile:getTopCreature()
				-- Check if there is a "Travelling Merchant" monster on this tile
				if monster and monster:isMonster() and monster:getName() == "Travelling Merchant" then
					-- Apply visual effect
					monster:getPosition():sendMagicEffect(CONST_ME_STONES)

					-- Remove the monster
					monster:remove()
				end
			end
		end
	end
	return true
end

function removeTree()
	local treePosition = { x = 32662, y = 32190, z = 7 }
	local tree = getTileItemById(treePosition, 3682)
	if tree and tree.uid > 0 then
		Position(treePosition):sendMagicEffect(CONST_ME_SMALLPLANTS)
		doRemoveItem(tree.uid, 1)
	end
	return true
end

function removeTrap()
	-- Iterate over the area defined by TOP_LEFT_CORNER and BOTTOM_RIGHT_CORNER
	for Py = TOP_LEFT_CORNER.y, BOTTOM_RIGHT_CORNER.y do
		for Px = TOP_LEFT_CORNER.x, BOTTOM_RIGHT_CORNER.x do
			local trap = getTileItemById({ x = Px, y = Py, z = 7 }, 12187)
			if trap and trap.uid > 0 then
				-- Remove the trap
				doRemoveItem(trap.uid, 1)

				-- Create item 12189 at the position where the trap was removed
				Game.createItem(12189, 1, { x = Px, y = Py, z = 7 })
			end
		end
	end

	-- Schedule the removal of items 12189 after a set time (e.g., 5 minutes)
	addEvent(removeItems, 5 * 60 * 1000)
	return true
end

function removeItems()
	-- Iterate over the area defined by TOP_LEFT_CORNER and BOTTOM_RIGHT_CORNER
	for Py = TOP_LEFT_CORNER.y, BOTTOM_RIGHT_CORNER.y do
		for Px = TOP_LEFT_CORNER.x, BOTTOM_RIGHT_CORNER.x do
			local item = getTileItemById({ x = Px, y = Py, z = 7 }, 12189)
			if item and item.uid > 0 then
				-- Remove item 12189
				doRemoveItem(item.uid, 1)
			end
		end
	end
	return true
end

local rottinWoodtrap = Action()
function rottinWoodtrap.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if item.itemid ~= 12186 or itemEx.itemid ~= 10480 then
		return false
	end

	local S = Storage.Quest.U8_7.RottinWoodAndTheMarriedMen
	if player:getStorageValue(S.Mission03) ~= 1 then
		return false
	end

	local trapCount = player:kv():get("rottinwood-trap-count") or 0

	if trapCount < 4 then
		-- Place one of the first 4 traps normally
		player:say("You place the trap carefully on the ground. Between twigs and leaves it is almost invisible.", TALKTYPE_MONSTER_SAY)

		item:remove(1)
		Game.createItem(12187, 1, toPosition)

		player:kv():set("rottinwood-trap-count", trapCount + 1)
	elseif trapCount == 4 then
		-- 5th and final trap: seals the area and summons the merchants
		player:say("It looks like the merchants are about to arrive, better hide somewhere where you can see what's going on in the area.", TALKTYPE_MONSTER_SAY)

		item:remove(1)
		Game.createItem(12187, 1, toPosition)
		player:kv():set("rottinwood-trap-count", trapCount + 1)

		-- Teleport the player to a hiding spot and create a visual effect
		player:teleportTo({ x = 32660, y = 32193, z = 7 })
		player:getPosition():sendMagicEffect(CONST_ME_STONES)

		-- Place a small fir tree at the specified location
		Game.createItem(3682, 1, { x = 32662, y = 32190, z = 7 }) -- small fir tree

		-- Summon the Travelling Merchant monsters in specified locations
		Game.createMonster("Travelling Merchant", { x = 32656, y = 32182, z = 7 })
		Game.createMonster("Travelling Merchant", { x = 32660, y = 32181, z = 7 })
		Game.createMonster("Travelling Merchant", { x = 32661, y = 32184, z = 7 })
		Game.createMonster("Travelling Merchant", { x = 32662, y = 32181, z = 7 })
		Game.createMonster("Travelling Merchant", { x = 32657, y = 32185, z = 7 })
		Game.createMonster("Travelling Merchant", { x = 32658, y = 32183, z = 7 })
		Game.createMonster("Travelling Merchant", { x = 32663, y = 32186, z = 7 })

		-- Schedule the removal of the tree, monsters and traps after 5 minutes
		addEvent(removeTree, 5 * 60 * 1000)
		addEvent(removeMonster, 5 * 60 * 1000)
		addEvent(removeTrap, 5 * 60 * 1000)
	end
	return true
end

rottinWoodtrap:id(12186)
rottinWoodtrap:register()
