--[[
	Ordinary containers -- 130 containers.

	What is inside a container on the map: quest chests, bookcases, a bag inside a
	chest. The world.otbm no longer stores this, so it is declared here.

	To add one by hand, copy a block and change the numbers:

		{
			itemId = 2472,                                   -- the container
			itemPos = { x = 33000, y = 32000, z = 7 },
			contents = {
				{ itemId = 3031, count = 50 },                -- 50 gold coins
				{ itemId = 3160 },                            -- one crystal coin
				{ itemId = 2824,                              -- book
					text = [==[
				Whatever is written on the page.]==] },
				{ itemId = 2854,                              -- bag
					inside = {
						{ itemId = 3003 },                    -- rope
					},
				},
			},
		},

	itemId and itemPos say which container on the map this is. contents is what goes
	inside it, and every entry there needs an itemId plus, optionally, count, text,
	description or inside. Put the item name in a comment on the itemId line.

	The text of a book sits between long brackets. When the text itself ends in a
	closing bracket, the level grows -- [=[ ... ]=], then [==[ ... ]==] -- so that the
	text cannot close the block early. That is why the example above uses [==[.

	count is the OTBM subtype, not an amount, for anything that does not stack.
	Add nth = 2 when the tile holds a second container with the same itemId.

	Applied by loadMapContainers().
]]

MapContainersMisc = {
	-- bag at 32626,31926,1
	{
		itemId = 2853,
		itemPos = { x = 32626, y = 31926, z = 1 },
		contents = {
			{ itemId = 3603, count = 2 }, -- flour
		},
	},
	-- bag at 32627,31923,1
	{
		itemId = 2853,
		itemPos = { x = 32627, y = 31923, z = 1 },
		contents = {
			{ itemId = 3603, count = 2 }, -- flour
		},
	},
	-- bag at 32627,31926,1
	{
		itemId = 2853,
		itemPos = { x = 32627, y = 31926, z = 1 },
		contents = {
			{ itemId = 3603, count = 3 }, -- flour
		},
	},
	-- bag at 32628,31923,1
	{
		itemId = 2853,
		itemPos = { x = 32628, y = 31923, z = 1 },
		contents = {
			{ itemId = 3603, count = 3 }, -- flour
		},
	},
	-- bag at 32628,31926,1
	{
		itemId = 2853,
		itemPos = { x = 32628, y = 31926, z = 1 },
		contents = {
			{ itemId = 3603, count = 3 }, -- flour
		},
	},
	-- chest at 32604,31908,3
	{
		itemId = 2472,
		itemPos = { x = 32604, y = 31908, z = 3 },
		contents = {
			{ itemId = 3003 }, -- rope
		},
	},
	-- bookcase at 33267,31836,3
	{
		itemId = 2436,
		itemPos = { x = 33267, y = 31836, z = 3 },
		contents = {
			{ itemId = 27372 }, -- piece of parchment
		},
	},
	-- bookcase at 33268,31830,4
	{
		itemId = 2436,
		itemPos = { x = 33268, y = 31830, z = 4 },
		contents = {
			{ itemId = 27371 }, -- piece of parchment
		},
	},
	-- bookcase at 33269,31836,4
	{
		itemId = 2436,
		itemPos = { x = 33269, y = 31836, z = 4 },
		contents = {
			{ itemId = 27443 }, -- piece of parchment
		},
	},
	-- bookcase at 33219,32400,5
	{
		itemId = 2440,
		itemPos = { x = 33219, y = 32400, z = 5 },
		contents = {
			{
				itemId = 2853, -- bag
				inside = {
					{
						itemId = 2819, -- parchment
						text = [[
PAGE 1

Famous inhabitants of Darashia

<You have found this very old book that seems out of place among the other books. As you leaf through the yellowed pages you see the description of a person on each left side and the painted portrait of this person on the right side. One person catches your attention. Not only does he have an inappropriate title, also his appearance is strange - on the one hand, he looks friendly, almost funny - on the other hand, his eyes seem to look directly into your soul. Eye-catching is the amulet he is wearing. You read the following and feel very uncomfortable with the portrait staring at you. You tear out those two pages and take them with you after having made sure nobody is watching you.>]],
					},
					{
						itemId = 2819, -- parchment
						text = [[
PAGE 2

Lord Koshei the Curious
-_-_-_-_-_-_-_-_-_-_-_-

Date of birth: unknown
Age: unknown
Hometown: unknown
Date of death: unknown

There are not many things known about this man. He appeared out of nowhere and lived here for nearly ten years. Even though he was communicative, he never told anything about his profession or what he did for a living. First he lived in Darashia 2, Flat 11 for about two years. During that time he was roaming around, travelling the lands of Darama and often visiting the Bath of Dreams and the minotaur pyramid in the North.
Then it was discovered that he had built a tower south of the mountains. It is unexplained how he managed to do that because no one has been seen to help him. Anyway, the remains of his tower are still there. ...]],
					},
					{
						itemId = 2819, -- parchment
						text = [[
PAGE 3

...He often paid Drefia a visit which was a blooming haven during this time. Rumour has it that he has something to do with it turning into an undead city. These rumours are mainly based on his interest in the pyramid to the north, which is known to have been created by the bonelord race. Needless to say that these creatures are also linked with the appearance of undead creatures.
His interceders say that he was always a man of belief that never had anything evil in mind. He was often seen in the crypta of Darashia to pray to the gods. As quickly as he had come, as quickly he disappeared and was never seen again.]],
					},
				},
			},
		},
	},
	-- bookcase at 32157,32427,6
	{
		itemId = 2435,
		itemPos = { x = 32157, y = 32427, z = 6 },
		contents = {
			{ itemId = 2821 }, -- book
			{ itemId = 2816 }, -- book
		},
	},
	-- bookcase at 32158,32427,6
	{
		itemId = 2436,
		itemPos = { x = 32158, y = 32427, z = 6 },
		contents = {
			{ itemId = 2816 }, -- book
		},
	},
	-- bookcase at 32159,32427,6
	{
		itemId = 2437,
		itemPos = { x = 32159, y = 32427, z = 6 },
		contents = {
			{ itemId = 2821 }, -- book
		},
	},
	-- chest at 32591,31933,6
	{
		itemId = 2472,
		itemPos = { x = 32591, y = 31933, z = 6 },
		contents = {
			{ itemId = 3031, count = 39 }, -- gold coin
			{ itemId = 3147, count = 1 }, -- blank rune
			{ itemId = 3264 }, -- sword
		},
	},
	-- barrel at 32732,31975,6
	{
		itemId = 2523,
		itemPos = { x = 32732, y = 31975, z = 6 },
		contents = {
			{ itemId = 3586, count = 1 }, -- orange
			{ itemId = 3586, count = 1 }, -- orange
		},
	},
	-- barrel at 32732,31976,6
	{
		itemId = 2523,
		itemPos = { x = 32732, y = 31976, z = 6 },
		contents = {
			{ itemId = 3470 }, -- wooden spoon
			{ itemId = 3470 }, -- wooden spoon
			{ itemId = 3470 }, -- wooden spoon
		},
	},
	-- barrel at 32732,31977,6
	{
		itemId = 2523,
		itemPos = { x = 32732, y = 31977, z = 6 },
		contents = {
			{ itemId = 3600, count = 3 }, -- bread
		},
	},
	-- drawers at 32776,32334,6
	{
		itemId = 2434,
		itemPos = { x = 32776, y = 32334, z = 6 },
		contents = {
			{ itemId = 2815 }, -- scroll
			{ itemId = 2815 }, -- scroll
			{ itemId = 2815 }, -- scroll
			{ itemId = 2815 }, -- scroll
			{ itemId = 2815 }, -- scroll
		},
	},
	-- drawers at 32776,32335,6
	{
		itemId = 2434,
		itemPos = { x = 32776, y = 32335, z = 6 },
		contents = {
			{
				itemId = 2854, -- backpack
				inside = {
					{ itemId = 2920 }, -- torch
					{ itemId = 3003 }, -- rope
					{ itemId = 3469 }, -- kitchen knife
				},
			},
			{ itemId = 2853 }, -- bag
			{ itemId = 2853 }, -- bag
			{ itemId = 2906 }, -- watch
		},
	},
	-- drawers at 32776,32336,6
	{
		itemId = 2434,
		itemPos = { x = 32776, y = 32336, z = 6 },
		contents = {
			{ itemId = 2917 }, -- candlestick
			{ itemId = 2917 }, -- candlestick
			{ itemId = 2917 }, -- candlestick
			{ itemId = 2917 }, -- candlestick
			{ itemId = 2917 }, -- candlestick
		},
	},
	-- chest at 32781,32334,6
	{
		itemId = 2472,
		itemPos = { x = 32781, y = 32334, z = 6 },
		contents = {
			{ itemId = 3552 }, -- leather boots
			{ itemId = 3552 }, -- leather boots
			{ itemId = 3559 }, -- leather legs
			{ itemId = 3561 }, -- jacket
			{ itemId = 3562 }, -- coat
		},
	},
	-- chest at 32784,32327,6
	{
		itemId = 2472,
		itemPos = { x = 32784, y = 32327, z = 6 },
		contents = {
			{ itemId = 2874, count = 0 }, -- vial
			{ itemId = 2874, count = 0 }, -- vial
			{ itemId = 2874, count = 0 }, -- vial
			{ itemId = 2874, count = 0 }, -- vial
			{ itemId = 2874, count = 0 }, -- vial
			{ itemId = 2874, count = 0 }, -- vial
			{ itemId = 2874, count = 0 }, -- vial
			{ itemId = 2874, count = 0 }, -- vial
		},
	},
	-- chest at 32785,32327,6
	{
		itemId = 2472,
		itemPos = { x = 32785, y = 32327, z = 6 },
		contents = {
			{ itemId = 2874, count = 0 }, -- vial
			{ itemId = 2874, count = 0 }, -- vial
			{ itemId = 2874, count = 0 }, -- vial
			{ itemId = 2874, count = 0 }, -- vial
			{ itemId = 2874, count = 0 }, -- vial
			{ itemId = 2874, count = 0 }, -- vial
			{ itemId = 2874, count = 0 }, -- vial
		},
	},
	-- barrel at 32065,32201,7
	{
		itemId = 2523,
		itemPos = { x = 32065, y = 32201, z = 7 },
		contents = {
			{ itemId = 3605, count = 5 }, -- bunch of wheat
			{ itemId = 3605, count = 3 }, -- bunch of wheat
		},
	},
	-- barrel at 32068,32201,7
	{
		itemId = 2523,
		itemPos = { x = 32068, y = 32201, z = 7 },
		contents = {
			{ itemId = 3605, count = 4 }, -- bunch of wheat
			{ itemId = 3605, count = 3 }, -- bunch of wheat
		},
	},
	-- barrel at 32068,32202,7
	{
		itemId = 2523,
		itemPos = { x = 32068, y = 32202, z = 7 },
		contents = {
			{ itemId = 3603, count = 8 }, -- flour
		},
	},
	-- barrel at 32068,32206,7
	{
		itemId = 2523,
		itemPos = { x = 32068, y = 32206, z = 7 },
		contents = {
			{ itemId = 3603, count = 4 }, -- flour
		},
	},
	-- box at 32163,32433,7
	{
		itemId = 2473,
		itemPos = { x = 32163, y = 32433, z = 7 },
		contents = {
			{ itemId = 2920 }, -- torch
			{ itemId = 2920 }, -- torch
		},
	},
	-- bookcase at 32180,31934,7
	{
		itemId = 2435,
		itemPos = { x = 32180, y = 31934, z = 7 },
		contents = {
			{
				itemId = 2853, -- bag
				inside = {
					{
						itemId = 2815, -- scroll
						text = [[
I have to hide that key better. One of that greedy adventurers that came here seemingly out of nowhere and refused to tell me how he got here stole it and disturbed the contemplation of the brothers upstairs. Gladly they could defeat him. When will those people learn some respect. How could they think there would be anything valuable? The next intruders will pay a bitter price for such an act of evil!]],
					},
					{ itemId = 2969 }, -- silver key
				},
			},
		},
	},
	-- drawers at 32310,31777,7
	{
		itemId = 2434,
		itemPos = { x = 32310, y = 31777, z = 7 },
		contents = {
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
		},
	},
	-- drawers at 32316,31777,7
	{
		itemId = 2434,
		itemPos = { x = 32316, y = 31777, z = 7 },
		contents = {
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
		},
	},
	-- barrel at 32384,32172,7
	{
		itemId = 2523,
		itemPos = { x = 32384, y = 32172, z = 7 },
		contents = {
			{ itemId = 3605, count = 5 }, -- bunch of wheat
		},
	},
	-- barrel at 32385,32172,7
	{
		itemId = 2523,
		itemPos = { x = 32385, y = 32172, z = 7 },
		contents = {
			{ itemId = 3603, count = 5 }, -- flour
		},
	},
	-- dead human at 32666,32136,7
	{
		itemId = 4240,
		itemPos = { x = 32666, y = 32136, z = 7 },
		contents = {
			{ itemId = 3370 }, -- knight armor
			{ itemId = 3371 }, -- knight legs
			{ itemId = 3416 }, -- dragon shield
			{ itemId = 3280 }, -- fire sword
			{
				itemId = 2854, -- backpack
				inside = {
					{ itemId = 3003 }, -- rope
					{ itemId = 2920 }, -- torch
					{ itemId = 3457 }, -- shovel
				},
			},
		},
	},
	-- drawers at 32794,31166,7
	{
		itemId = 2434,
		itemPos = { x = 32794, y = 31166, z = 7 },
		contents = {
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
		},
	},
	-- slain skeleton at 32794,31572,7
	{
		itemId = 5972,
		itemPos = { x = 32794, y = 31572, z = 7 },
		contents = {
			{ itemId = 2969 }, -- silver key
		},
	},
	-- drawers at 32804,31165,7
	{
		itemId = 2432,
		itemPos = { x = 32804, y = 31165, z = 7 },
		contents = {
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
		},
	},
	-- bookcase at 33171,31762,7
	{
		itemId = 2435,
		itemPos = { x = 33171, y = 31762, z = 7 },
		contents = {
			{ itemId = 2825 }, -- book
			{ itemId = 2825 }, -- book
			{ itemId = 2825 }, -- book
			{ itemId = 2825 }, -- book
		},
	},
	-- bookcase at 33172,31762,7
	{
		itemId = 2436,
		itemPos = { x = 33172, y = 31762, z = 7 },
		contents = {
			{ itemId = 2829 }, -- book
			{ itemId = 2829 }, -- book
			{ itemId = 2829 }, -- book
		},
	},
	-- bookcase at 33173,31762,7
	{
		itemId = 2437,
		itemPos = { x = 33173, y = 31762, z = 7 },
		contents = {
			{ itemId = 2824 }, -- book
			{ itemId = 2824 }, -- book
			{ itemId = 2824 }, -- book
		},
	},
	-- wooden trunk at 31984,32162,8
	{
		itemId = 11810,
		itemPos = { x = 31984, y = 32162, z = 8 },
		contents = {
			{ itemId = 2905 }, -- plate
			{ itemId = 2905 }, -- plate
			{ itemId = 2883, count = 0 }, -- cup
			{ itemId = 2882, count = 0 }, -- jug
		},
	},
	-- crate at 32359,32131,8
	{
		itemId = 2471,
		itemPos = { x = 32359, y = 32131, z = 8 },
		contents = {
			{ itemId = 3582, count = 1 }, -- ham
			{ itemId = 3577, count = 1 }, -- meat
		},
	},
	-- crate at 32359,32132,8
	{
		itemId = 2471,
		itemPos = { x = 32359, y = 32132, z = 8 },
		contents = {
			{ itemId = 3603, count = 10 }, -- flour
		},
	},
	-- drawers at 32386,32180,8
	{
		itemId = 2434,
		itemPos = { x = 32386, y = 32180, z = 8 },
		contents = {
			{
				itemId = 2853, -- bag
				inside = {
					{ itemId = 3533, count = 1 }, -- black token
					{ itemId = 3533, count = 1 }, -- black token
					{ itemId = 3533, count = 1 }, -- black token
					{ itemId = 3533, count = 1 }, -- black token
					{ itemId = 3533, count = 1 }, -- black token
				},
			},
			{
				itemId = 2853, -- bag
				inside = {
					{ itemId = 3533, count = 1 }, -- black token
					{ itemId = 3533, count = 1 }, -- black token
					{ itemId = 3533, count = 1 }, -- black token
					{ itemId = 3533, count = 1 }, -- black token
				},
			},
		},
	},
	-- drawers at 32386,32181,8
	{
		itemId = 2434,
		itemPos = { x = 32386, y = 32181, z = 8 },
		contents = {
			{
				itemId = 2853, -- bag
				inside = {
					{ itemId = 3534, count = 1 }, -- white token
					{ itemId = 3534, count = 1 }, -- white token
					{ itemId = 3534, count = 1 }, -- white token
					{ itemId = 3534, count = 1 }, -- white token
					{ itemId = 3534, count = 1 }, -- white token
				},
			},
			{
				itemId = 2853, -- bag
				inside = {
					{ itemId = 3534, count = 1 }, -- white token
					{ itemId = 3534, count = 1 }, -- white token
					{ itemId = 3534, count = 1 }, -- white token
					{ itemId = 3534, count = 1 }, -- white token
				},
			},
		},
	},
	-- drawers at 32386,32183,8
	{
		itemId = 2434,
		itemPos = { x = 32386, y = 32183, z = 8 },
		contents = {
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
		},
	},
	-- drawers at 32791,31172,8
	{
		itemId = 2434,
		itemPos = { x = 32791, y = 31172, z = 8 },
		contents = {
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
		},
	},
	-- drawers at 32791,31174,8
	{
		itemId = 2434,
		itemPos = { x = 32791, y = 31174, z = 8 },
		contents = {
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
		},
	},
	-- drawers at 33184,31794,8
	{
		itemId = 2434,
		itemPos = { x = 33184, y = 31794, z = 8 },
		contents = {
			{ itemId = 3535 }, -- white pawn
			{ itemId = 3535 }, -- white pawn
			{ itemId = 3535 }, -- white pawn
			{ itemId = 3535 }, -- white pawn
			{ itemId = 3535 }, -- white pawn
			{ itemId = 3535 }, -- white pawn
			{ itemId = 3535 }, -- white pawn
			{ itemId = 3535 }, -- white pawn
		},
	},
	-- drawers at 33184,31795,8
	{
		itemId = 2434,
		itemPos = { x = 33184, y = 31795, z = 8 },
		contents = {
			{ itemId = 3536 }, -- white castle
			{ itemId = 3536 }, -- white castle
			{ itemId = 3537 }, -- white knight
			{ itemId = 3537 }, -- white knight
			{ itemId = 3538 }, -- white bishop
			{ itemId = 3538 }, -- white bishop
			{ itemId = 3539 }, -- the white queen
			{ itemId = 3540 }, -- the white king
		},
	},
	-- drawers at 33184,31803,8
	{
		itemId = 2434,
		itemPos = { x = 33184, y = 31803, z = 8 },
		contents = {
			{ itemId = 3542 }, -- black castle
			{ itemId = 3542 }, -- black castle
			{ itemId = 3543 }, -- black knight
			{ itemId = 3543 }, -- black knight
			{ itemId = 3544 }, -- black bishop
			{ itemId = 3544 }, -- black bishop
			{ itemId = 3545 }, -- the black queen
			{ itemId = 3546 }, -- the black king
		},
	},
	-- drawers at 33184,31804,8
	{
		itemId = 2434,
		itemPos = { x = 33184, y = 31804, z = 8 },
		contents = {
			{ itemId = 3541 }, -- black pawn
			{ itemId = 3541 }, -- black pawn
			{ itemId = 3541 }, -- black pawn
			{ itemId = 3541 }, -- black pawn
			{ itemId = 3541 }, -- black pawn
			{ itemId = 3541 }, -- black pawn
			{ itemId = 3541 }, -- black pawn
			{ itemId = 3541 }, -- black pawn
		},
	},
	-- drawers at 33184,31808,8
	{
		itemId = 2434,
		itemPos = { x = 33184, y = 31808, z = 8 },
		contents = {
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
		},
	},
	-- drawers at 33184,31809,8
	{
		itemId = 2434,
		itemPos = { x = 33184, y = 31809, z = 8 },
		contents = {
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
		},
	},
	-- drawers at 33184,31810,8
	{
		itemId = 2434,
		itemPos = { x = 33184, y = 31810, z = 8 },
		contents = {
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
		},
	},
	-- drawers at 33184,31811,8
	{
		itemId = 2434,
		itemPos = { x = 33184, y = 31811, z = 8 },
		contents = {
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
		},
	},
	-- drawers at 32387,32193,9
	{
		itemId = 2433,
		itemPos = { x = 32387, y = 32193, z = 9 },
		contents = {
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
		},
	},
	-- drawers at 32390,32193,9
	{
		itemId = 2433,
		itemPos = { x = 32390, y = 32193, z = 9 },
		contents = {
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
			{ itemId = 2880, count = 0 }, -- mug
		},
	},
	-- barrel at 32510,32269,9
	{
		itemId = 2523,
		itemPos = { x = 32510, y = 32269, z = 9 },
		contents = {
			{ itemId = 3579, count = 2 }, -- salmon
		},
	},
	-- drawers at 33220,32858,9
	{
		itemId = 2434,
		itemPos = { x = 33220, y = 32858, z = 9 },
		contents = {
			{
				itemId = 2853, -- bag
				inside = {
					{ itemId = 7527 }, -- jewel case
					{
						itemId = 2833, -- parchment
						text = [[
We are not far from revealing the greatest secret in the lands of Darama that was kept by a nomad tribe so far. They call themselves "true sons of the desert" and we managed to obtain their sacred casket by accident. What a great day for us. The right people will pay huge amounts of gold for it.

So far I found out that the strange substance in the casket has something to do with the rotworm species. It is strongly advisable to keep the substance in the casket. I opened it once and minutes later it swarmed with rotworms and carrion worms. Many of my people died in this accident. We presume that we deal with an attractant of a rotworm queen. No one has ever seen one but we are pretty sure that this species is organised by a queen. Maybe it would be possible to lure a queen with this substance but we don't dare to use it again. We need more time to figure out how this all matches and how to use the substance without being overrun by rotworms.]],
					},
				},
			},
		},
	},
	-- bookcase at 33287,31521,9
	{
		itemId = 2436,
		itemPos = { x = 33287, y = 31521, z = 9 },
		contents = {
			{ itemId = 3124, count = 1 }, -- burnt scroll
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33288,31521,9
	{
		itemId = 2436,
		itemPos = { x = 33288, y = 31521, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33288,31524,9
	{
		itemId = 2435,
		itemPos = { x = 33288, y = 31524, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33289,31521,9
	{
		itemId = 2436,
		itemPos = { x = 33289, y = 31521, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3124, count = 1 }, -- burnt scroll
			{ itemId = 3124, count = 1 }, -- burnt scroll
			{ itemId = 3124, count = 1 }, -- burnt scroll
		},
	},
	-- bookcase at 33291,31521,9
	{
		itemId = 2436,
		itemPos = { x = 33291, y = 31521, z = 9 },
		contents = {
			{ itemId = 3124, count = 1 }, -- burnt scroll
			{ itemId = 3124, count = 1 }, -- burnt scroll
		},
	},
	-- bookcase at 33291,31524,9
	{
		itemId = 2437,
		itemPos = { x = 33291, y = 31524, z = 9 },
		contents = {
			{ itemId = 3124, count = 1 }, -- burnt scroll
			{ itemId = 3124, count = 1 }, -- burnt scroll
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33291,31528,9
	{
		itemId = 2437,
		itemPos = { x = 33291, y = 31528, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33292,31521,9
	{
		itemId = 2437,
		itemPos = { x = 33292, y = 31521, z = 9 },
		contents = {
			{ itemId = 3124, count = 1 }, -- burnt scroll
		},
	},
	-- bookcase at 33295,31528,9
	{
		itemId = 2435,
		itemPos = { x = 33295, y = 31528, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3124, count = 1 }, -- burnt scroll
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33296,31524,9
	{
		itemId = 2436,
		itemPos = { x = 33296, y = 31524, z = 9 },
		contents = {
			{ itemId = 3124, count = 1 }, -- burnt scroll
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33297,31528,9
	{
		itemId = 2436,
		itemPos = { x = 33297, y = 31528, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33298,31524,9
	{
		itemId = 2436,
		itemPos = { x = 33298, y = 31524, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3124, count = 1 }, -- burnt scroll
			{ itemId = 3124, count = 1 }, -- burnt scroll
		},
	},
	-- bookcase at 33298,31528,9
	{
		itemId = 2436,
		itemPos = { x = 33298, y = 31528, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33299,31521,9
	{
		itemId = 2436,
		itemPos = { x = 33299, y = 31521, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33299,31524,9
	{
		itemId = 2437,
		itemPos = { x = 33299, y = 31524, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33300,31521,9
	{
		itemId = 2436,
		itemPos = { x = 33300, y = 31521, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3124, count = 1 }, -- burnt scroll
		},
	},
	-- bookcase at 33303,31524,9
	{
		itemId = 2435,
		itemPos = { x = 33303, y = 31524, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3124, count = 1 }, -- burnt scroll
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33303,31528,9
	{
		itemId = 2435,
		itemPos = { x = 33303, y = 31528, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33304,31528,9
	{
		itemId = 2436,
		itemPos = { x = 33304, y = 31528, z = 9 },
		contents = {
			{ itemId = 3124, count = 1 }, -- burnt scroll
			{ itemId = 2824 }, -- book
		},
	},
	-- bookcase at 33305,31524,9
	{
		itemId = 2437,
		itemPos = { x = 33305, y = 31524, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33305,31528,9
	{
		itemId = 2437,
		itemPos = { x = 33305, y = 31528, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33307,31521,9
	{
		itemId = 2435,
		itemPos = { x = 33307, y = 31521, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33308,31521,9
	{
		itemId = 2436,
		itemPos = { x = 33308, y = 31521, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- box at 32080,32121,10
	{
		itemId = 2473,
		itemPos = { x = 32080, y = 32121, z = 10 },
		contents = {
			{ itemId = 3462 }, -- small axe
			{ itemId = 3447, count = 4 }, -- arrow
		},
	},
	-- dead human at 32648,32093,10
	{
		itemId = 4240,
		itemPos = { x = 32648, y = 32093, z = 10 },
		contents = {
			{ itemId = 3552 }, -- leather boots
			{ itemId = 3561 }, -- jacket
			{ itemId = 3559 }, -- leather legs
			{ itemId = 3572 }, -- scarf
			{
				itemId = 2854, -- backpack
				inside = {
					{ itemId = 3003 }, -- rope
					{ itemId = 2920 }, -- torch
					{ itemId = 3457 }, -- shovel
					{
						itemId = 2821, -- book
						text = [[
Expedition diary of Erin Cropwell

Day 1: After visiting my fathers grave, I headed northeast to explore the world behind the great vulcanic mountains.

Day 2: I sneaked through a great cave full of cyclopses. After hours of wandering and climbing I reached the other side.

Day 3: Following the coast to seek signs of life.

Day 4: Found a strange desert. In the middle there seems to be a ruin, I will examine this at night, because it's much too hot now.

Day 5: DAMN!!! I fell into the deep hole and broke both legs and a rib. All I can do is...
climb up spider poison

Tell my wife I lov...]],
					},
				},
			},
		},
	},
	-- chest at 32776,31105,10
	{
		itemId = 2472,
		itemPos = { x = 32776, y = 31105, z = 10 },
		contents = {
			{ itemId = 8453 }, -- blood crystal
		},
	},
	-- bookcase at 32795,32368,10
	{
		itemId = 2438,
		itemPos = { x = 32795, y = 32368, z = 10 },
		contents = {
			{ itemId = 21378 }, -- torn log book
		},
	},
	-- box at 32135,32111,11
	{
		itemId = 2473,
		itemPos = { x = 32135, y = 32111, z = 11 },
		contents = {
			{
				itemId = 2853, -- bag
				inside = {
					{ itemId = 3412 }, -- wooden shield
					{ itemId = 3412 }, -- wooden shield
				},
			},
			{ itemId = 2853 }, -- bag
		},
	},
	-- box at 32136,32111,11
	{
		itemId = 2473,
		itemPos = { x = 32136, y = 32111, z = 11 },
		nth = 1, -- container number 1 with this id on the tile
		contents = {
			{ itemId = 3003 }, -- rope
		},
	},
	-- box at 32136,32111,11
	{
		itemId = 2473,
		itemPos = { x = 32136, y = 32111, z = 11 },
		nth = 2, -- container number 2 with this id on the tile
		contents = {
			{ itemId = 2875, count = 0 }, -- bottle
			{ itemId = 2875, count = 0 }, -- bottle
			{ itemId = 2874, count = 0 }, -- vial
		},
	},
	-- crate at 32141,32098,11
	{
		itemId = 2471,
		itemPos = { x = 32141, y = 32098, z = 11 },
		contents = {
			{ itemId = 3277, count = 6 }, -- spear
			{ itemId = 3277, count = 3 }, -- spear
			{ itemId = 3447, count = 4 }, -- arrow
		},
	},
	-- chest at 32143,32096,11
	{
		itemId = 2472,
		itemPos = { x = 32143, y = 32096, z = 11 },
		contents = {
			{ itemId = 3286 }, -- mace
			{ itemId = 3273 }, -- sabre
			{ itemId = 3276 }, -- hatchet
			{ itemId = 3273 }, -- sabre
		},
	},
	-- box at 32147,32098,11
	{
		itemId = 2473,
		itemPos = { x = 32147, y = 32098, z = 11 },
		nth = 1, -- container number 1 with this id on the tile
		contents = {
			{ itemId = 3412 }, -- wooden shield
			{ itemId = 3412 }, -- wooden shield
			{ itemId = 3352 }, -- chain helmet
		},
	},
	-- box at 32147,32098,11
	{
		itemId = 2473,
		itemPos = { x = 32147, y = 32098, z = 11 },
		nth = 2, -- container number 2 with this id on the tile
		contents = {
			{ itemId = 3361 }, -- leather armor
			{ itemId = 3361 }, -- leather armor
			{ itemId = 3355 }, -- leather helmet
			{ itemId = 3355 }, -- leather helmet
		},
	},
	-- chest at 32147,32106,11
	{
		itemId = 2472,
		itemPos = { x = 32147, y = 32106, z = 11 },
		contents = {
			{ itemId = 2815 }, -- scroll
			{ itemId = 2815 }, -- scroll
			{ itemId = 2873, count = 0 }, -- bucket
			{ itemId = 2875, count = 0 }, -- bottle
		},
	},
	-- drawers at 32616,31981,11
	{
		itemId = 2434,
		itemPos = { x = 32616, y = 31981, z = 11 },
		contents = {
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
		},
	},
	-- drawers at 32616,31982,11
	{
		itemId = 2434,
		itemPos = { x = 32616, y = 31982, z = 11 },
		contents = {
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
			{ itemId = 3533, count = 1 }, -- black token
		},
	},
	-- drawers at 32616,31984,11
	{
		itemId = 2434,
		itemPos = { x = 32616, y = 31984, z = 11 },
		contents = {
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
		},
	},
	-- drawers at 32616,31985,11
	{
		itemId = 2434,
		itemPos = { x = 32616, y = 31985, z = 11 },
		contents = {
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
			{ itemId = 3534, count = 1 }, -- white token
		},
	},
	-- drawers at 32617,31963,11
	{
		itemId = 2433,
		itemPos = { x = 32617, y = 31963, z = 11 },
		contents = {
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
		},
	},
	-- drawers at 32618,31963,11
	{
		itemId = 2433,
		itemPos = { x = 32618, y = 31963, z = 11 },
		contents = {
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
		},
	},
	-- drawers at 32619,31963,11
	{
		itemId = 2433,
		itemPos = { x = 32619, y = 31963, z = 11 },
		contents = {
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
		},
	},
	-- drawers at 32621,31963,11
	{
		itemId = 2433,
		itemPos = { x = 32621, y = 31963, z = 11 },
		contents = {
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
		},
	},
	-- drawers at 32622,31963,11
	{
		itemId = 2433,
		itemPos = { x = 32622, y = 31963, z = 11 },
		contents = {
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
		},
	},
	-- drawers at 32623,31963,11
	{
		itemId = 2433,
		itemPos = { x = 32623, y = 31963, z = 11 },
		contents = {
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
		},
	},
	-- chest at 33081,31658,11
	{
		itemId = 2472,
		itemPos = { x = 33081, y = 31658, z = 11 },
		contents = {
			{ itemId = 3031, count = 100 }, -- gold coin
			{ itemId = 3031, count = 100 }, -- gold coin
			{ itemId = 3031, count = 100 }, -- gold coin
			{ itemId = 3409 }, -- steel shield
			{ itemId = 3557 }, -- plate legs
			{ itemId = 3275 }, -- double axe
			{ itemId = 4315 }, -- skeleton
			{ itemId = 3384 }, -- dark helmet
		},
	},
	-- box at 32128,32066,12
	{
		itemId = 2473,
		itemPos = { x = 32128, y = 32066, z = 12 },
		contents = {
			{ itemId = 3003 }, -- rope
			{ itemId = 3453 }, -- scythe
			{ itemId = 3457 }, -- shovel
		},
	},
	-- box at 32129,32066,12
	{
		itemId = 2473,
		itemPos = { x = 32129, y = 32066, z = 12 },
		contents = {
			{ itemId = 2920 }, -- torch
			{ itemId = 3552 }, -- leather boots
			{ itemId = 3552 }, -- leather boots
			{ itemId = 3552 }, -- leather boots
			{ itemId = 3448, count = 1 }, -- poison arrow
		},
	},
	-- chest at 32130,32055,12
	{
		itemId = 2472,
		itemPos = { x = 32130, y = 32055, z = 12 },
		contents = {
			{ itemId = 3509 }, -- inkwell
			{ itemId = 2815 }, -- scroll
			{ itemId = 2815 }, -- scroll
			{ itemId = 2815 }, -- scroll
			{ itemId = 2815 }, -- scroll
			{ itemId = 2815 }, -- scroll
		},
	},
	-- barrel at 32510,31672,14
	{
		itemId = 2519,
		itemPos = { x = 32510, y = 31672, z = 14 },
		contents = {
			{ itemId = 3459 }, -- wooden hammer
			{ itemId = 3462 }, -- small axe
		},
	},
	-- barrel at 32510,31673,14
	{
		itemId = 2519,
		itemPos = { x = 32510, y = 31673, z = 14 },
		contents = {
			{ itemId = 3509 }, -- inkwell
			{ itemId = 2814 }, -- parchment
		},
	},
	-- chest at 32592,32097,14
	{
		itemId = 2472,
		itemPos = { x = 32592, y = 32097, z = 14 },
		contents = {
			{ itemId = 236, count = 1 }, -- strong health potion
			{ itemId = 236, count = 1 }, -- strong health potion
			{ itemId = 3276 }, -- hatchet
			{ itemId = 3358 }, -- chain armor
			{ itemId = 3352 }, -- chain helmet
		},
	},
	-- drawers at 32402,31627,15
	{
		itemId = 2434,
		itemPos = { x = 32402, y = 31627, z = 15 },
		contents = {
			{ itemId = 3054, charges = 200 }, -- silver amulet
		},
	},
	-- drawers at 32402,31643,15
	{
		itemId = 2434,
		itemPos = { x = 32402, y = 31643, z = 15 },
		contents = {
			{ itemId = 3059 }, -- spellbook
		},
	},
	-- drawers at 32402,31647,15
	{
		itemId = 2434,
		itemPos = { x = 32402, y = 31647, z = 15 },
		contents = {
			{ itemId = 3061, count = 0 }, -- life crystal
		},
	},
	-- barrel at 32411,31644,15
	{
		itemId = 2523,
		itemPos = { x = 32411, y = 31644, z = 15 },
		contents = {
			{ itemId = 3582, count = 5 }, -- ham
		},
	},
	-- drawers at 32411,31646,15
	{
		itemId = 2433,
		itemPos = { x = 32411, y = 31646, z = 15 },
		contents = {
			{ itemId = 3056, charges = 200 }, -- bronze amulet
		},
	},
	-- drawers at 32412,31627,15
	{
		itemId = 2434,
		itemPos = { x = 32412, y = 31627, z = 15 },
		contents = {
			{ itemId = 3046 }, -- magic light wand
		},
	},
	-- drawers at 32414,32139,15
	{
		itemId = 2434,
		itemPos = { x = 32414, y = 32139, z = 15 },
		contents = {
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
			{ itemId = 3548, count = 1 }, -- tic-tac-toe token
		},
	},
	-- drawers at 32414,32140,15
	{
		itemId = 2434,
		itemPos = { x = 32414, y = 32140, z = 15 },
		contents = {
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
			{ itemId = 3547, count = 1 }, -- tic-tac-toe token
		},
	},
	-- drawers at 32418,31626,15
	{
		itemId = 2433,
		itemPos = { x = 32418, y = 31626, z = 15 },
		contents = {
			{ itemId = 3736, count = 1 }, -- star herb
			{ itemId = 3740, count = 1 }, -- shadow herb
		},
	},
	-- bookcase at 32419,32144,15
	{
		itemId = 2436,
		itemPos = { x = 32419, y = 32144, z = 15 },
		contents = {
			{ itemId = 2816 }, -- book
		},
	},
	-- drawers at 32421,31642,15
	{
		itemId = 2433,
		itemPos = { x = 32421, y = 31642, z = 15 },
		contents = {
			{ itemId = 2914 }, -- lamp
			{ itemId = 3723, count = 1 }, -- white mushroom
		},
	},
	-- chest at 32423,31646,15
	{
		itemId = 2472,
		itemPos = { x = 32423, y = 31646, z = 15 },
		contents = {
			{ itemId = 2875, count = 0 }, -- bottle
		},
	},
	-- bookcase at 32487,31612,15
	{
		itemId = 2438,
		itemPos = { x = 32487, y = 31612, z = 15 },
		contents = {
			{ itemId = 3059 }, -- spellbook
		},
	},
	-- bookcase at 32487,31613,15
	{
		itemId = 2439,
		itemPos = { x = 32487, y = 31613, z = 15 },
		contents = {
			{ itemId = 3059 }, -- spellbook
		},
	},
}
