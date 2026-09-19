Newhaven = Newhaven or {}

Newhaven.starterItems = {
	[VOCATION.BASE_ID.SORCERER] = {
		items = {
			{ 3355, 1, CONST_SLOT_HEAD }, -- leather helmet
			{ 3561, 1, CONST_SLOT_ARMOR }, -- jacket
			{ 3559, 1, CONST_SLOT_LEGS }, -- leather legs
			{ 3552, 1, CONST_SLOT_FEET }, -- leather boots
			{ 34017, 1, CONST_SLOT_AMMO }, -- lit torch

			{ 21400, 1, CONST_SLOT_RIGHT }, -- spellbook of the novice
			{ 21348, 1, CONST_SLOT_LEFT }, -- the scorcher
		},
		container = {
			{ 268, 10 }, -- mana potion
			{ 266, 2 }, -- health potion
			{ 3031, 50 }, -- gold coins
			{ 3578, 1 }, -- fish
			{ 21351, 1 }, -- light stone shower runes
		},
	},
	[VOCATION.BASE_ID.DRUID] = {
		items = {
			{ 3355, 1, CONST_SLOT_HEAD }, -- leather helmet
			{ 3561, 1, CONST_SLOT_ARMOR }, -- jacket
			{ 3559, 1, CONST_SLOT_LEGS }, -- leather legs
			{ 3552, 1, CONST_SLOT_FEET }, -- leather boots
			{ 34017, 1, CONST_SLOT_AMMO }, -- lit torch

			{ 21400, 1, CONST_SLOT_RIGHT }, -- spellbook of the novice
			{ 21350, 1, CONST_SLOT_LEFT }, -- the chiller
		},
		container = {
			{ 268, 10 }, -- mana potion
			{ 266, 2 }, -- health potion
			{ 3031, 50 }, -- gold coins
			{ 3578, 1 }, -- fish
			{ 21351, 1 }, -- light stone shower runes
		},
	},
	[VOCATION.BASE_ID.PALADIN] = {
		items = {
			{ 3355, 1, CONST_SLOT_HEAD }, -- leather helmet
			{ 3561, 1, CONST_SLOT_ARMOR }, -- jacket
			{ 3559, 1, CONST_SLOT_LEGS }, -- leather legs
			{ 3552, 1, CONST_SLOT_FEET }, -- leather boots
			{ 34017, 1, CONST_SLOT_AMMO }, -- lit torch

			{ 3350, 1, CONST_SLOT_LEFT }, -- bow
			{ 35562, 1, CONST_SLOT_RIGHT }, -- quiver
		},
		container = {
			{ 268, 7 }, -- mana potion
			{ 266, 5 }, -- health potion
			{ 3031, 50 }, -- gold coins
			{ 3578, 1 }, -- fish
		},
	},
	[VOCATION.BASE_ID.KNIGHT] = {
		items = {
			{ 3355, 1, CONST_SLOT_HEAD }, -- leather helmet
			{ 3561, 1, CONST_SLOT_ARMOR }, -- jacket
			{ 3559, 1, CONST_SLOT_LEGS }, -- leather legs
			{ 3552, 1, CONST_SLOT_FEET }, -- leather boots
			{ 34017, 1, CONST_SLOT_AMMO }, -- lit torch

			{ 3272, 1, CONST_SLOT_LEFT }, -- rapier
			{ 3412, 1, CONST_SLOT_RIGHT }, -- wooden shield
		},
		container = {
			{ 268, 2 }, -- mana potion
			{ 266, 10 }, -- health potion
			{ 3031, 50 }, -- gold coins
			{ 3578, 1 }, -- fish
		},
	},
	[VOCATION.BASE_ID.MONK] = {
		items = {
			{ 3355, 1, CONST_SLOT_HEAD }, -- leather helmet
			{ 3561, 1, CONST_SLOT_ARMOR }, -- jacket
			{ 3559, 1, CONST_SLOT_LEGS }, -- leather legs
			{ 3552, 1, CONST_SLOT_FEET }, -- leather boots
			{ 34017, 1, CONST_SLOT_AMMO }, -- lit torch

			{ 50166, 1, CONST_SLOT_LEFT }, -- light jo staff
		},
		container = {
			{ 268, 5 }, -- mana potion
			{ 266, 7 }, -- health potion
			{ 3031, 50 }, -- gold coins
			{ 3578, 1 }, -- fish
		},
	},
}

function Newhaven.giveStarterItems(player)
	if not player or player:getStorageValue(Storage.Quest.U15_12.newhavenStarterItems) > 0 then
		return false
	end

	local vocationId = player:getVocation():getBaseId()
	local starter = Newhaven.starterItems[vocationId]
	if not starter then
		return false
	end

	local quiver = nil
	for i = 1, #starter.items do
		local item = starter.items[i]
		local itemId = item[1]
		local count = item[2]
		local slot = item[3]
		local createdItem
		if slot then
			createdItem = player:addItem(itemId, count, true, 1, slot)
		else
			createdItem = player:addItem(itemId, count)
		end

		if createdItem and itemId == 35562 then
			quiver = createdItem
		end
	end

	if quiver then
		quiver:addItem(3447, 100)
		quiver:addItem(3447, 100)
	end

	local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
	if not backpack then
		backpack = player:addItem(2854, 1, true, 1, CONST_SLOT_BACKPACK)
	end

	if backpack then
		for i = 1, #starter.container do
			backpack:addItem(starter.container[i][1], starter.container[i][2])
		end
	end

	player:setStorageValue(Storage.Quest.U15_12.newhavenStarterItems, 1)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received your starter equipment.")
	return true
end
