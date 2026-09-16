-- Look README.md for see the reserved action/unique numbers

-- Action id 100: the unmovable/untrade/unusable convention. register_actions.lua tests
-- `target.actionid == 100`, so all of these items need that same number, and a table key
-- only fits once. The entry is therefore a list: one block per item.
--
-- Adding a new one: copy a line and put the real item id in it, never `false`. An item
-- another table already stamps does not belong here: that entry wins anyway, and this
-- one would only pretend the item is unmovable.

ItemUnmovableAction = {
	[100] = {
		{ itemId = 3003, itemPos = { { x = 31948, y = 31925, z = 8 } } }, -- rope
		{ itemId = 7741, itemPos = { { x = 32011, y = 31709, z = 7 } } }, -- ice cube
		{ itemId = 3501, itemPos = { { x = 32013, y = 31562, z = 4 } } }, -- mailbox
		{ itemId = 3471, itemPos = { { x = 32054, y = 31887, z = 5 } } }, -- cleaver
		{ itemId = 21427, itemPos = { { x = 32054, y = 31889, z = 5 } } }, -- paladin's bow
		{ itemId = 11792, itemPos = { { x = 32055, y = 31887, z = 5 } } }, -- antlers
		{ itemId = 21428, itemPos = { { x = 32056, y = 31889, z = 5 } } }, -- ununsed simple arrow
		{ itemId = 35567, itemPos = { { x = 32056, y = 31889, z = 5 } } }, -- not named in items.xml
		{ itemId = 21433, itemPos = { { x = 32063, y = 31880, z = 5 } } }, -- chiller
		{ itemId = 21434, itemPos = { { x = 32063, y = 31882, z = 5 } } }, -- light stone shower rune
		{ itemId = 21431, itemPos = { { x = 32063, y = 31899, z = 5 } } }, -- scorcher
		{ itemId = 21432, itemPos = { { x = 32063, y = 31901, z = 5 } } }, -- lightest missile rune
		{ itemId = 2831, itemPos = { { x = 32073, y = 31887, z = 5 } } }, -- book
		{ itemId = 21429, itemPos = { { x = 32073, y = 31889, z = 5 } } }, -- broken wooden shield
		{ itemId = 21430, itemPos = { { x = 32075, y = 31889, z = 5 } } }, -- simple dagger
		{ itemId = 2469, itemPos = { { x = 32265, y = 32811, z = 11 } } }, -- box
		{ itemId = 6258, itemPos = { { x = 32288, y = 32292, z = 7 } } }, -- closed door
		{ itemId = 3392, itemPos = { { x = 32306, y = 32186, z = 6 } } }, -- royal helmet
		{ itemId = 8023, itemPos = { { x = 32314, y = 32244, z = 9 } } }, -- royal crossbow
		{ itemId = 8026, itemPos = { { x = 32316, y = 32244, z = 9 } } }, -- warsinger bow
		{ itemId = 8090, itemPos = { { x = 32318, y = 32244, z = 9 } } }, -- spellbook of dark mysteries
		{ itemId = 8102, itemPos = { { x = 32320, y = 32244, z = 9 } } }, -- emerald sword
		{ itemId = 8096, itemPos = { { x = 32322, y = 32244, z = 9 } } }, -- hellforged axe
		{ itemId = 8100, itemPos = { { x = 32324, y = 32244, z = 9 } } }, -- obsidian truncheon
		{ itemId = 8060, itemPos = { { x = 32326, y = 32244, z = 9 } } }, -- master archer's armor
		{ itemId = 8053, itemPos = { { x = 32328, y = 32244, z = 9 } } }, -- fireborn giant armor
		{ itemId = 8062, itemPos = { { x = 32330, y = 32244, z = 9 } } }, -- robe of the underworld
		{ itemId = 50261, itemPos = { { x = 32332, y = 32244, z = 9 } } }, -- merudri nanbando
		{ itemId = 3634, itemPos = { { x = 32366, y = 32542, z = 8 } } }, -- dead tree
		{ itemId = 5785, itemPos = { { x = 32383, y = 32199, z = 9 } } }, -- medal of honour
		{ itemId = 8737, itemPos = { { x = 32383, y = 32206, z = 9 } } }, -- CM token
		{ itemId = 9614, itemPos = { { x = 32391, y = 32208, z = 9 } } }, -- famous golden bug
		{ itemId = 8148, itemPos = { { x = 32399, y = 32199, z = 9 } } }, -- golden falcon
		{ itemId = 9802, itemPos = { { x = 32399, y = 32208, z = 9 } } }, -- friendship amulet
		{ itemId = 8149, itemPos = { { x = 32403, y = 32195, z = 9 } } }, -- Tibiacity Encyclopedia
		{ itemId = 8150, itemPos = { { x = 32406, y = 32190, z = 9 } } }, -- key of numerous locks
		{ itemId = 9538, itemPos = { { x = 32407, y = 32208, z = 9 } } }, -- pigeon trophy
		{ itemId = 9189, itemPos = { { x = 32411, y = 32204, z = 9 } } }, -- hand puppets
		{ itemId = 8151, itemPos = { { x = 32414, y = 32190, z = 9 } } }, -- TibiaHispano Emblem
		{ itemId = 9144, itemPos = { { x = 32414, y = 32200, z = 9 } } }, -- Epaminondas doll
		{ itemId = 8152, itemPos = { { x = 32422, y = 32190, z = 9 } } }, -- mexcalibur
		{ itemId = 8156, itemPos = { { x = 32422, y = 32200, z = 9 } } }, -- abacus
		{ itemId = 10706, itemPos = { { x = 32424, y = 32500, z = 10 } } }, -- sulphur puddle
		{ itemId = 8153, itemPos = { { x = 32430, y = 32190, z = 9 } } }, -- golden newspaper
		{ itemId = 8155, itemPos = { { x = 32430, y = 32200, z = 9 } } }, -- heavily bound book
		{ itemId = 8154, itemPos = { { x = 32434, y = 32197, z = 9 } } }, -- norseman doll
		{ itemId = 18343, itemPos = { { x = 32438, y = 32190, z = 9 } } }, -- bookworm doll
		{ itemId = 3997, itemPos = { { x = 32440, y = 32190, z = 10 } } }, -- Tibiora's box
		{ itemId = 10477, itemPos = { { x = 32440, y = 32200, z = 10 } } }, -- dragon goblet
		{ itemId = 10817, itemPos = { { x = 32448, y = 32190, z = 10 } } }, -- bag of oriental spices
		{ itemId = 10476, itemPos = { { x = 32448, y = 32200, z = 10 } } }, -- lucky clover amulet
		{ itemId = 10800, itemPos = { { x = 32456, y = 32190, z = 10 } } }, -- orc's jaw shredder
		{ itemId = 10798, itemPos = { { x = 32456, y = 32200, z = 10 } } }, -- ferumbras doll
		{ itemId = 12904, itemPos = { { x = 32468, y = 32190, z = 10 } } }, -- dread doll
		{ itemId = 12041, itemPos = { { x = 32468, y = 32200, z = 10 } } }, -- frozen heart
		{ itemId = 12809, itemPos = { { x = 32476, y = 32190, z = 10 } } }, -- epic wisdom
		{ itemId = 12043, itemPos = { { x = 32476, y = 32200, z = 10 } } }, -- draken doll
		{ itemId = 12813, itemPos = { { x = 32484, y = 32190, z = 10 } } }, -- old radio
		{ itemId = 12045, itemPos = { { x = 32484, y = 32200, z = 10 } } }, -- music box
		{ itemId = 12811, itemPos = { { x = 32488, y = 32197, z = 10 } } }, -- imortus
		{ itemId = 14760, itemPos = { { x = 32496, y = 32190, z = 10 } } }, -- mathmaster shield
		{ itemId = 14764, itemPos = { { x = 32496, y = 32200, z = 10 } } }, -- Durin The Almighty
		{ itemId = 3067, itemPos = { { x = 32497, y = 31641, z = 13 } } }, -- hailstorm rod
		{ itemId = 3297, itemPos = { { x = 32498, y = 31640, z = 13 } } }, -- serpent sword
		{ itemId = 3388, itemPos = { { x = 32498, y = 31640, z = 13 } } }, -- demon armor
		{ itemId = 3011, itemPos = { { x = 32498, y = 31641, z = 13 } } }, -- crown
		{ itemId = 3422, itemPos = { { x = 32498, y = 31641, z = 13 } } }, -- great shield
		{ itemId = 3320, itemPos = { { x = 32499, y = 31640, z = 13 } } }, -- fire axe
		{ itemId = 3060, itemPos = { { x = 32499, y = 31641, z = 13 } } }, -- orb
		{ itemId = 3364, itemPos = { { x = 32499, y = 31641, z = 13 } } }, -- golden legs
		{ itemId = 14762, itemPos = { { x = 32504, y = 32190, z = 10 } } }, -- medusa skull
		{ itemId = 14766, itemPos = { { x = 32504, y = 32200, z = 10 } } }, -- majestic shield
		{ itemId = 16275, itemPos = { { x = 32512, y = 32190, z = 10 } } }, -- noble sword
		{ itemId = 16262, itemPos = { { x = 32512, y = 32200, z = 10 } } }, -- dragon eye
		{ itemId = 19397, itemPos = { { x = 32516, y = 32197, z = 10 } } }, -- memory box
		{ itemId = 20342, itemPos = { { x = 32524, y = 32200, z = 10 } } }, -- jade amulet
		{ itemId = 946, itemPos = { { x = 32583, y = 31409, z = 15 } } }, -- eternal flames
		{ itemId = 227, itemPos = { { x = 32583, y = 31410, z = 15 } } }, -- fine vase
		{ itemId = 8049, itemPos = { { x = 32584, y = 31405, z = 15 } } }, -- lavos armor
		{ itemId = 3365, itemPos = { { x = 32584, y = 31406, z = 15 } } }, -- golden helmet
		{ itemId = 8057, itemPos = { { x = 32584, y = 31407, z = 15 } } }, -- divine plate
		{ itemId = 3024, itemPos = { { x = 32584, y = 31408, z = 15 } } }, -- holy falcon
		{ itemId = 406, itemPos = { { x = 32584, y = 31411, z = 15 } } }, -- family signet ring
		{ itemId = 3368, itemPos = { { x = 32585, y = 31405, z = 15 } } }, -- winged helmet
		{ itemId = 3365, itemPos = { { x = 32585, y = 31408, z = 15 } } }, -- golden helmet
		{ itemId = 3402, itemPos = { { x = 32585, y = 31409, z = 15 } } }, -- native armor
		{ itemId = 3023, itemPos = { { x = 32585, y = 31411, z = 15 } } }, -- holy scarab
		{ itemId = 8097, itemPos = { { x = 32586, y = 31406, z = 15 } } }, -- solar axe
		{ itemId = 7450, itemPos = { { x = 32586, y = 31408, z = 15 } } }, -- hammer of prophecy
		{ itemId = 3363, itemPos = { { x = 32586, y = 31409, z = 15 } } }, -- dragon scale legs
		{ itemId = 36811, itemPos = { { x = 32609, y = 32489, z = 12 } } }, -- megasylvan sapling
		{ itemId = 36811, itemPos = { { x = 32609, y = 32504, z = 12 } } }, -- megasylvan sapling
		{ itemId = 36811, itemPos = { { x = 32628, y = 32488, z = 12 } } }, -- megasylvan sapling
		{ itemId = 36811, itemPos = { { x = 32629, y = 32506, z = 12 } } }, -- megasylvan sapling
		{ itemId = 3364, itemPos = { { x = 32634, y = 31927, z = 3 } } }, -- golden legs
		{ itemId = 3363, itemPos = { { x = 32637, y = 31925, z = 3 } } }, -- dragon scale legs
		{ itemId = 3422, itemPos = { { x = 32637, y = 31927, z = 3 } } }, -- great shield
		{ itemId = 3365, itemPos = { { x = 32638, y = 31926, z = 3 } } }, -- golden helmet
		{ itemId = 3011, itemPos = { { x = 32688, y = 31608, z = 13 } } }, -- crown
		{ itemId = 3068, itemPos = { { x = 32688, y = 31609, z = 13 } } }, -- crystal wand
		{ itemId = 3423, itemPos = { { x = 32688, y = 31609, z = 13 } } }, -- blessed shield
		{ itemId = 3373, itemPos = { { x = 32691, y = 31608, z = 13 } } }, -- strange helmet
		{ itemId = 3284, itemPos = { { x = 32691, y = 31609, z = 13 } } }, -- ice rapier
		{ itemId = 3386, itemPos = { { x = 32691, y = 31609, z = 13 } } }, -- dragon scale mail
		{ itemId = 3365, itemPos = { { x = 32694, y = 31609, z = 13 } } }, -- golden helmet
		{ itemId = 3275, itemPos = { { x = 32694, y = 31610, z = 13 } } }, -- double axe
		{ itemId = 3360, itemPos = { { x = 32694, y = 31610, z = 13 } } }, -- golden armor
		{ itemId = 3425, itemPos = { { x = 32694, y = 31610, z = 13 } } }, -- dwarven shield
		{ itemId = 52339, itemPos = { { x = 32716, y = 31553, z = 15 } } }, -- charred skull
		{ itemId = 52340, itemPos = { { x = 32747, y = 31606, z = 15 } } }, -- molten throne
		{ itemId = 596, itemPos = { { x = 32776, y = 31062, z = 7 } } }, -- strange carving
		{ itemId = 5287, itemPos = { { x = 32802, y = 31314, z = 7 } } }, -- closed door
		{ itemId = 10200, itemPos = { { x = 32816, y = 32425, z = 7 } } }, -- crystal boots
		{ itemId = 8054, itemPos = { { x = 32819, y = 32424, z = 7 } } }, -- earthborn titan armor
		{ itemId = 3365, itemPos = { { x = 32820, y = 32424, z = 7 } } }, -- golden helmet
		{ itemId = 52342, itemPos = { { x = 32825, y = 31568, z = 15 } } }, -- gilded wig
		{ itemId = 52341, itemPos = { { x = 32848, y = 31450, z = 15 } } }, -- draconic rattle
		{ itemId = 3423, itemPos = { { x = 32850, y = 32251, z = 12 } } }, -- blessed shield
		{ itemId = 842, itemPos = { { x = 32884, y = 31248, z = 8 } } }, -- mysterious machine
		{ itemId = 3390, itemPos = { { x = 32884, y = 31921, z = 8 } } }, -- horned helmet
		{ itemId = 843, itemPos = { { x = 32885, y = 31248, z = 8 } } }, -- mysterious machine
		{ itemId = 3555, itemPos = { { x = 32885, y = 31920, z = 8 } } }, -- golden boots
		{ itemId = 3024, itemPos = { { x = 32891, y = 31921, z = 8 } } }, -- holy falcon
		{ itemId = 3400, itemPos = { { x = 32892, y = 31921, z = 8 } } }, -- dragon scale helmet
		{ itemId = 231, itemPos = { { x = 33027, y = 32869, z = 7 } } }, -- sand
		{ itemId = 231, itemPos = { { x = 33040, y = 32484, z = 7 } } }, -- sand
		{ itemId = 231, itemPos = { { x = 33133, y = 32568, z = 7 } } }, -- sand
		{ itemId = 231, itemPos = { { x = 33133, y = 32640, z = 7 } } }, -- sand
		{ itemId = 3278, itemPos = { { x = 33158, y = 32691, z = 14 } } }, -- magic longsword
		{ itemId = 3302, itemPos = { { x = 33158, y = 32691, z = 14 } } }, -- dragon lance
		{ itemId = 3387, itemPos = { { x = 33158, y = 32691, z = 14 } } }, -- demon helmet
		{ itemId = 3309, itemPos = { { x = 33158, y = 32695, z = 14 } } }, -- thunder hammer
		{ itemId = 3386, itemPos = { { x = 33158, y = 32695, z = 14 } } }, -- dragon scale mail
		{ itemId = 3296, itemPos = { { x = 33158, y = 32696, z = 14 } } }, -- warlord sword
		{ itemId = 3314, itemPos = { { x = 33158, y = 32696, z = 14 } } }, -- naginata
		{ itemId = 3422, itemPos = { { x = 33159, y = 32695, z = 14 } } }, -- great shield
		{ itemId = 3369, itemPos = { { x = 33161, y = 32688, z = 14 } } }, -- warrior helmet
		{ itemId = 3388, itemPos = { { x = 33161, y = 32688, z = 14 } } }, -- demon armor
		{ itemId = 3364, itemPos = { { x = 33161, y = 32701, z = 14 } } }, -- golden legs
		{ itemId = 3392, itemPos = { { x = 33161, y = 32701, z = 14 } } }, -- royal helmet
		{ itemId = 3297, itemPos = { { x = 33162, y = 32701, z = 14 } } }, -- serpent sword
		{ itemId = 3328, itemPos = { { x = 33162, y = 32701, z = 14 } } }, -- daramian waraxe
		{ itemId = 3390, itemPos = { { x = 33163, y = 32701, z = 14 } } }, -- horned helmet
		{ itemId = 3414, itemPos = { { x = 33163, y = 32701, z = 14 } } }, -- mastermind shield
		{ itemId = 2932, itemPos = { { x = 33164, y = 32175, z = 8 } } }, -- oil lamp
		{ itemId = 3058, itemPos = { { x = 33164, y = 32701, z = 14 } } }, -- strange symbol
		{ itemId = 3342, itemPos = { { x = 33164, y = 32701, z = 14 } } }, -- war axe
		{ itemId = 3442, itemPos = { { x = 33164, y = 32701, z = 14 } } }, -- tempest shield
		{ itemId = 3368, itemPos = { { x = 33165, y = 32688, z = 14 } } }, -- winged helmet
		{ itemId = 3288, itemPos = { { x = 33165, y = 32701, z = 14 } } }, -- magic sword
		{ itemId = 3318, itemPos = { { x = 33165, y = 32701, z = 14 } } }, -- knight axe
		{ itemId = 3394, itemPos = { { x = 33165, y = 32701, z = 14 } } }, -- amazon armor
		{ itemId = 3440, itemPos = { { x = 33166, y = 32701, z = 14 } } }, -- scarab shield
		{ itemId = 3366, itemPos = { { x = 33167, y = 32688, z = 14 } } }, -- magic plate armor
		{ itemId = 3313, itemPos = { { x = 33167, y = 32701, z = 14 } } }, -- obsidian lance
		{ itemId = 3331, itemPos = { { x = 33167, y = 32701, z = 14 } } }, -- ravager's axe
		{ itemId = 3397, itemPos = { { x = 33167, y = 32701, z = 14 } } }, -- dwarven armor
		{ itemId = 3365, itemPos = { { x = 33168, y = 32688, z = 14 } } }, -- golden helmet
		{ itemId = 3396, itemPos = { { x = 33168, y = 32701, z = 14 } } }, -- dwarven helmet
		{ itemId = 3438, itemPos = { { x = 33168, y = 32701, z = 14 } } }, -- eagle shield
		{ itemId = 3332, itemPos = { { x = 33169, y = 32701, z = 14 } } }, -- hammer of wrath
		{ itemId = 3398, itemPos = { { x = 33169, y = 32701, z = 14 } } }, -- dwarven legs
		{ itemId = 3391, itemPos = { { x = 33171, y = 32701, z = 14 } } }, -- crusader helmet
		{ itemId = 3423, itemPos = { { x = 33171, y = 32701, z = 14 } } }, -- blessed shield
		{ itemId = 231, itemPos = { { x = 33208, y = 32591, z = 7 } } }, -- sand
		{ itemId = 231, itemPos = { { x = 33214, y = 32552, z = 7 } } }, -- sand
		{ itemId = 231, itemPos = { { x = 33233, y = 32704, z = 7 } } }, -- sand
		{ itemId = 3434, itemPos = { { x = 33254, y = 32468, z = 6 } } }, -- vampire shield
		{ itemId = 3387, itemPos = { { x = 33254, y = 32469, z = 6 } } }, -- demon helmet
		{ itemId = 3284, itemPos = { { x = 33254, y = 32470, z = 6 } } }, -- ice rapier
		{ itemId = 3297, itemPos = { { x = 33254, y = 32470, z = 6 } } }, -- serpent sword
		{ itemId = 231, itemPos = { { x = 33255, y = 32833, z = 7 } } }, -- sand
		{ itemId = 3040, itemPos = { { x = 33264, y = 32440, z = 12 } } }, -- gold nugget
		{ itemId = 3043, itemPos = { { x = 33264, y = 32441, z = 12 } } }, -- crystal coin
		{ itemId = 3010, itemPos = { { x = 33265, y = 32438, z = 12 } } }, -- emerald bangle
		{ itemId = 3440, itemPos = { { x = 33265, y = 32439, z = 12 } } }, -- scarab shield
		{ itemId = 2903, itemPos = { { x = 33265, y = 32443, z = 12 } } }, -- golden mug
		{ itemId = 3025, itemPos = { { x = 33266, y = 32439, z = 12 } } }, -- ancient amulet
		{ itemId = 3031, itemPos = { { x = 33266, y = 32439, z = 12 } } }, -- gold coin
		{ itemId = 3445, itemPos = { { x = 33277, y = 32443, z = 12 } } }, -- salamander shield
		{ itemId = 3017, itemPos = { { x = 33278, y = 32438, z = 12 } } }, -- silver brooch
		{ itemId = 3021, itemPos = { { x = 33278, y = 32439, z = 12 } } }, -- sapphire amulet
		{ itemId = 3555, itemPos = { { x = 33278, y = 32441, z = 12 } } }, -- golden boots
		{ itemId = 3013, itemPos = { { x = 33278, y = 32442, z = 12 } } }, -- golden amulet
		{ itemId = 231, itemPos = { { x = 33282, y = 32743, z = 7 } } }, -- sand
		{ itemId = 231, itemPos = { { x = 33290, y = 32603, z = 7 } } }, -- sand
		{ itemId = 22502, itemPos = { { x = 33447, y = 32787, z = 10 } } }, -- gate of expertise
		{ itemId = 22502, itemPos = { { x = 33447, y = 32793, z = 10 } } }, -- gate of expertise
		{ itemId = 22502, itemPos = { { x = 33447, y = 32796, z = 10 } } }, -- gate of expertise
		{ itemId = 22502, itemPos = { { x = 33447, y = 32801, z = 10 } } }, -- gate of expertise
		{ itemId = 22502, itemPos = { { x = 33447, y = 32805, z = 10 } } }, -- gate of expertise
		{ itemId = 22502, itemPos = { { x = 33449, y = 32787, z = 10 } } }, -- gate of expertise
		{ itemId = 22502, itemPos = { { x = 33449, y = 32801, z = 10 } } }, -- gate of expertise
		{ itemId = 22504, itemPos = { { x = 33450, y = 32786, z = 10 } } }, -- gate of expertise
		{ itemId = 22504, itemPos = { { x = 33451, y = 32786, z = 10 } } }, -- gate of expertise
		{ itemId = 22502, itemPos = { { x = 33453, y = 32798, z = 10 } } }, -- gate of expertise
		{ itemId = 22502, itemPos = { { x = 33460, y = 32792, z = 11 } } }, -- gate of expertise
		{ itemId = 22502, itemPos = { { x = 33460, y = 32805, z = 11 } } }, -- gate of expertise
		{ itemId = 22504, itemPos = { { x = 33461, y = 32805, z = 11 } } }, -- gate of expertise
		{ itemId = 22502, itemPos = { { x = 33479, y = 32792, z = 11 } } }, -- gate of expertise
		{ itemId = 22504, itemPos = { { x = 33479, y = 32805, z = 11 } } }, -- gate of expertise
		{ itemId = 20446, itemPos = { { x = 33655, y = 31947, z = 7 } } }, -- closed door
		{ itemId = 641, itemPos = { { x = 33909, y = 31196, z = 11 } } }, -- piece of paper
		{ itemId = 641, itemPos = { { x = 33933, y = 31189, z = 11 } } }, -- piece of paper
		{ itemId = 641, itemPos = { { x = 33953, y = 31213, z = 11 } } }, -- piece of paper
	},
}
