local questChests = {
	-- Behe Quest
	[5010] = { itemId = 3360, count = 1, message = "You have found a Golden Armor." },
	[5011] = { itemId = 3420, count = 1, message = "You have found a Demon Shield." },
	[5012] = { itemId = 3315, count = 1, message = "You have found a Guardian Halberd." },
	[5013] = { itemId = 3055, count = 1, message = "You have found a platinum amulet." },
	-- DH Quest
	[5049] = { itemId = 3387, count = 1, message = "You have found a Demon Helmet." },
	[5050] = { itemId = 3554, count = 1, message = "You have found a Steel Boots." },
	[5051] = { itemId = 3420, count = 1, message = "You have found a Demon Shield." },
	-- Karmia City Simples
	[5014] = { itemId = 3295, count = 1, message = "You have found a Bright Sword." },
	[5069] = { itemId = 3372, count = 1, message = "You have found a Brass Legs." },
	[5019] = { itemId = 3297, count = 1, message = "You have found a Serpent Sword." },
	[5021] = { itemId = 3269, count = 1, message = "You have found a Halberd." },
	[5022] = { itemId = 3437, count = 1, message = "You have found an Amazon Shield." },
	[5023] = { itemId = 3301, count = 1, message = "You have found a Broad Sword." },
	[5025] = { itemId = 3380, count = 1, message = "You have found a Noble Armor." },
	[5026] = { itemId = 3428, count = 1, message = "You have found a Tower Shield." },
	[5029] = { itemId = 3066, count = 1, message = "You have found a Snakebite Rod." },
	[5030] = { itemId = 3074, count = 1, message = "You have found a Wand of Vortex." },
	[5031] = { itemId = 3035, count = 1, message = "You have found a 200 Gps." },
	[5067] = { itemId = 2969, count = 1, message = "You have found a Key.\n Key bk quest!" },
	[5068] = { itemId = 3357, count = 1, message = "You have found a Plate armor." },
	-- Desert City
	[5032] = { itemId = 3567, count = 1, message = "You have found a Blue Robe." },
	[5033] = { itemId = 3436, count = 1, message = "You have found a Medusa Shield." },
	[5034] = { itemId = 3333, count = 1, message = "You have found a Crystal Mace." },
	[5035] = { itemId = 3302, count = 1, message = "You have found a Dragon Lance." },
	[5036] = { itemId = 3371, count = 1, message = "You have found a Knight Legs." },
	[5037] = { itemId = 3035, count = 100, message = "You have found a 100 platinum coins." },
	[5038] = { itemId = 3098, count = 1, message = "You have found a Ring of Healing." },
	[5039] = { itemId = 2339, count = 1, message = "You have found a Piece of Ancient Helmet." },
	[5040] = { itemId = 2337, count = 1, message = "You have found a Piece of Ancient Helmet." },
	[5041] = { itemId = 2336, count = 1, message = "You have found a Piece of Ancient Helmet." },
	[5073] = { itemId = 2340, count = 1, message = "You have found a Piece of Ancient Helmet." },
	[5074] = { itemId = 2341, count = 1, message = "You have found a Piece of Ancient Helmet." },
	[5042] = { itemId = 2335, count = 1, message = "You have found a Piece of Ancient Helmet." },
	[5043] = { itemId = 3394, count = 1, message = "You have found a Amazon Armor." },
	[5044] = { itemId = 3395, count = 1, message = "You have found a Amazon Helmet." },
	-- Lost City
	[5015] = { itemId = 3370, count = 1, message = "You have found a Knight Armor." },
	[5016] = { itemId = 3280, count = 1, message = "You have found a Fire Sword." },
	[5017] = { itemId = 3418, count = 1, message = "You have found a Bonelord Shield." },
	[5018] = { itemId = 3369, count = 1, message = "You have found a Warrior Helmet." },
	-- Premmy City
	[5045] = { itemId = 3318, count = 1, message = "You have found a knight Axe." },
	[5046] = { itemId = 3320, count = 1, message = "You have found a Fire Axe." },
	[5047] = { itemId = 3434, count = 1, message = "You have found a Vampire Shield." },
	[5048] = { itemId = 3302, count = 1, message = "You have found a Dragon Lance." },
	[5058] = { itemId = 2338, count = 1, message = "You have found a Piece of Ancient Helmet." },
	[5059] = { itemId = 3429, count = 1, message = "You have found a Black Shield." },
	[5060] = { itemId = 3368, count = 1, message = "You have found a Winged Helmet." },
	[5088] = { itemId = 3309, count = 1, message = "You have found a Thunder Hammer." },
	-- Tiquanda
	[5052] = { itemId = 3323, count = 1, message = "You have found a Dwarven Axe." },
	[5053] = { itemId = 3079, count = 1, message = "You have found a Boots of Haste." },
	[5054] = { itemId = 3392, count = 1, message = "You have found a Royal Helmet." },
	[5055] = { itemId = 3317, count = 1, message = "You have found a Barbarian Axe." },
	[5056] = { itemId = 3576, count = 1, message = "You have found a Post Officers Hat." },
	[5057] = { itemId = 3417, count = 1, message = "You have found a Shield of Honor." },
	[5066] = { -- Kontener
		containerId = 2853,
		inside = {
			{ itemId = 3071, count = 1 },
			{ itemId = 3043, count = 1 },
		},
		message = "You have found a bag.",
	},
	-- RookGuard
	[5061] = { itemId = 3271, count = 1, message = "You have found a Spike Sword." },
	[5062] = { itemId = 3411, count = 1, message = "You have found a Brass Shield." },
	-- Venore
	[5076] = { itemId = 3381, count = 1, message = "You have found a Crown Armor." },
	[5077] = { itemId = 3382, count = 1, message = "You have found a Crown Legs." },
	[5063] = { itemId = 3322, count = 1, message = "You have found a Dragon Hammer." },
	[5064] = { itemId = 3567, count = 1, message = "You have found a Blue Robe." },
	[5065] = { itemId = 3281, count = 1, message = "You have found a Giant Sword." },
	[5080] = { itemId = 6579, count = 1, message = "You have found a Random Addon Doll." },
	-- Folda (też torba!)
	[5081] = {
		containerId = 2853,
		inside = {
			{ itemId = 3031, count = 42 },
			{ itemId = 3483, count = 1 },
		},
		message = "You have found a bag.",
	},
	[5082] = { itemId = 401, count = 1, message = "You have found a Book." },
	[5083] = { itemId = 3379, count = 1, message = "You have found a Crusader helmet." },
	-- Libera Bay
	[5084] = { itemId = 3421, count = 1, message = "You have found a Dark Shield." },
	[5086] = { itemId = 44621, count = 1, message = "You have found a Dragon Scale Armor." },
	[5087] = { itemId = 6131, count = 1, message = "You have found a Tortoise Shield." },
}

for uid, data in pairs(questChests) do
	local action = Action()
	action:uid(uid)
	function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
		local storage = uid
		if player:getStorageValue(storage) ~= 1 then
			if data.containerId then
				local container = player:addItem(data.containerId, 1)
				if container and data.inside then
					for _, entry in ipairs(data.inside) do
						container:addItem(entry.itemId, entry.count or 1)
					end
				end
			else
				player:addItem(data.itemId, data.count or 1)
			end
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, data.message)
			player:setStorageValue(storage, 1)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is empty.")
		end
		return true
	end
	action:register()
end
