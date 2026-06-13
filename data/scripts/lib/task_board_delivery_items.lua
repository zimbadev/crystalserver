--[[
	Weekly Task - Delivery Items List

	This file defines all items available for weekly delivery tasks.
	Items are loaded by the server at startup from this Lua table,
	so you can add, remove, or modify items without recompilation.

	Source: https://tibiopedia.pl/items/others/delivery

	Fields:
		itemId (number) required - The item ID from items.xml
		count (number) required - The fixed amount of items to deliver (1-50)

	Missing items not yet in items.xml (Winter Update 2025):
		Basalt Crumbs, Bloated Maggot, Broken Mitmah Necklace,
		Bulltaur Armor Scrap, Bulltaur Hoof, Bulltaur Horn,
		Crystal of the Mitmah, Encrypted Notes, Idol of the Forge,
		Pressed Flower, Ritual Tooth, Rotten Feather, Staff Piece,
		Strange Substance, Yapunac Dagger
]]

WEEKLY_DELIVERY_ITEMS = {
	{ itemId = 811, count = 20 }, -- Terra Mantle
	{ itemId = 813, count = 20 }, -- Terra Boots
	{ itemId = 818, count = 20 }, -- Magma Boots
	{ itemId = 819, count = 20 }, -- Glacier Shoes
	{ itemId = 820, count = 20 }, -- Lightning Boots
	{ itemId = 821, count = 20 }, -- Magma Legs
	{ itemId = 824, count = 20 }, -- Glacier Robe
	{ itemId = 825, count = 20 }, -- Lightning Robe
	{ itemId = 826, count = 20 }, -- Magma Coat
	{ itemId = 827, count = 20 }, -- Magma Monocle
	{ itemId = 828, count = 20 }, -- Lightning Headband
	{ itemId = 829, count = 20 }, -- Glacier Mask
	{ itemId = 830, count = 20 }, -- Terra Hood
	{ itemId = 3234, count = 50 }, -- Cookbook
	{ itemId = 3269, count = 20 }, -- Halberd
	{ itemId = 3275, count = 20 }, -- Double Axe
	{ itemId = 3291, count = 50 }, -- Knife
	{ itemId = 3292, count = 50 }, -- Combat Knife
	{ itemId = 3301, count = 20 }, -- Broadsword
	{ itemId = 3306, count = 20 }, -- Golden Sickle
	{ itemId = 3307, count = 20 }, -- Scimitar
	{ itemId = 3316, count = 20 }, -- Orcish Axe
	{ itemId = 3318, count = 20 }, -- Knight Axe
	{ itemId = 3320, count = 20 }, -- Fire Axe
	{ itemId = 3322, count = 20 }, -- Dragon Hammer
	{ itemId = 3330, count = 20 }, -- Heavy Machete
	{ itemId = 3333, count = 20 }, -- Crystal Mace
	{ itemId = 3337, count = 50 }, -- Bone Club
	{ itemId = 3342, count = 20 }, -- War Axe
	{ itemId = 3346, count = 20 }, -- Ripper Lance
	{ itemId = 3364, count = 10 }, -- Golden Legs
	{ itemId = 3371, count = 20 }, -- Knight Legs
	{ itemId = 3373, count = 20 }, -- Strange Helmet
	{ itemId = 3413, count = 20 }, -- Battle Shield
	{ itemId = 3415, count = 20 }, -- Guardian Shield
	{ itemId = 3421, count = 20 }, -- Dark Shield
	{ itemId = 3429, count = 20 }, -- Black Shield
	{ itemId = 3509, count = 50 }, -- Inkwell
	{ itemId = 3557, count = 20 }, -- Plate Legs
	{ itemId = 3575, count = 20 }, -- Wood Cape
	{ itemId = 5479, count = 50 }, -- Cat's Paw
	{ itemId = 5800, count = 50 }, -- Grappling Hook
	{ itemId = 5888, count = 50 }, -- Piece of Hell Steel
	{ itemId = 5889, count = 50 }, -- Piece of Draconian Steel
	{ itemId = 6558, count = 50 }, -- Flask of Demonic Blood
	{ itemId = 7381, count = 20 }, -- Mammoth Whopper
	{ itemId = 7383, count = 20 }, -- Relic Sword
	{ itemId = 7386, count = 20 }, -- Mercenary Sword
	{ itemId = 7387, count = 20 }, -- Diamond Sceptre
	{ itemId = 7388, count = 20 }, -- Vile Axe
	{ itemId = 7402, count = 10 }, -- Dragon Slayer
	{ itemId = 7413, count = 20 }, -- Titan Axe
	{ itemId = 7425, count = 20 }, -- Taurus Mace
	{ itemId = 7427, count = 20 }, -- Chaos Mace
	{ itemId = 7428, count = 20 }, -- Bonebreaker
	{ itemId = 7436, count = 20 }, -- Angelic Axe
	{ itemId = 7449, count = 20 }, -- Crystal Sword
	{ itemId = 7454, count = 10 }, -- Glorious Axe
	{ itemId = 8043, count = 20 }, -- Focus Cape
	{ itemId = 8045, count = 20 }, -- Hibiscus Dress
	{ itemId = 8050, count = 10 }, -- Crystalline Armor
	{ itemId = 8061, count = 10 }, -- Skullcracker Armor
	{ itemId = 8074, count = 10 }, -- Spellbook of Mind Control
	{ itemId = 9054, count = 50 }, -- Glob of Acid Slime
	{ itemId = 9055, count = 50 }, -- Glob of Tar
	{ itemId = 9631, count = 50 }, -- Scarab Pincers
	{ itemId = 9632, count = 50 }, -- Ancient Stone
	{ itemId = 9637, count = 50 }, -- Hellhound Slobber
	{ itemId = 9643, count = 50 }, -- Thorn
	{ itemId = 9649, count = 50 }, -- Gauze Bandage
	{ itemId = 9652, count = 50 }, -- Witch Broom
	{ itemId = 9656, count = 50 }, -- Broken Gladiator Shield
	{ itemId = 9659, count = 50 }, -- Half-Eaten Brain
	{ itemId = 9662, count = 50 }, -- Mutated Bat Ear
	{ itemId = 9667, count = 50 }, -- Boggy Dreads
	{ itemId = 9668, count = 50 }, -- Mutated Rat Tail
	{ itemId = 9688, count = 50 }, -- Bundle of Cursed Straw
	{ itemId = 10276, count = 50 }, -- Elder Bonelord Tentacle
	{ itemId = 10277, count = 50 }, -- Bony Tail
	{ itemId = 10278, count = 50 }, -- Stone Wing
	{ itemId = 10282, count = 50 }, -- Hydra Head
	{ itemId = 10291, count = 50 }, -- Rotten Piece of Cloth
	{ itemId = 10293, count = 50 }, -- Striped Fur
	{ itemId = 10301, count = 50 }, -- Centipede Leg
	{ itemId = 10303, count = 50 }, -- Dark Rosary
	{ itemId = 10305, count = 50 }, -- Lump of Earth
	{ itemId = 10306, count = 50 }, -- Essence of a Bad Dream
	{ itemId = 10308, count = 50 }, -- Mutated Flesh
	{ itemId = 10310, count = 50 }, -- Shiny Stone
	{ itemId = 10312, count = 50 }, -- Scythe Leg
	{ itemId = 10313, count = 50 }, -- Winged Tail
	{ itemId = 10315, count = 50 }, -- Sulphurous Stone
	{ itemId = 10316, count = 50 }, -- Unholy Bone
	{ itemId = 10317, count = 50 }, -- Werewolf Fur
	{ itemId = 10320, count = 50 }, -- Book of Necromantic Rituals
	{ itemId = 10321, count = 50 }, -- Mammoth Tusk
	{ itemId = 10384, count = 20 }, -- Zaoan Armor
	{ itemId = 10386, count = 20 }, -- Zaoan Shoes
	{ itemId = 10397, count = 50 }, -- Weaver's Wandtip
	{ itemId = 10404, count = 50 }, -- Bone Shoulderplate
	{ itemId = 10407, count = 50 }, -- Shaggy Tail
	{ itemId = 10408, count = 50 }, -- Spiked Iron Ball
	{ itemId = 10410, count = 50 }, -- Cursed Shoulder Spikes
	{ itemId = 10411, count = 50 }, -- Widow's Mandibles
	{ itemId = 10413, count = 50 }, -- Zaogun Flag
	{ itemId = 10414, count = 50 }, -- Zaogun Shoulderplates
	{ itemId = 10415, count = 50 }, -- High Guard Flag
	{ itemId = 10416, count = 50 }, -- High Guard Shoulderplates
	{ itemId = 10418, count = 50 }, -- Broken Halberd
	{ itemId = 10438, count = 20 }, -- Spellweaver's Robe
	{ itemId = 10439, count = 20 }, -- Zaoan Robe
	{ itemId = 10444, count = 50 }, -- Dragon Priest's Wandtip
	{ itemId = 10449, count = 50 }, -- Ghastly Dragon Head
	{ itemId = 10454, count = 50 }, -- Terramite Legs
	{ itemId = 10455, count = 50 }, -- Lancer Beetle Shell
	{ itemId = 10456, count = 50 }, -- Sandcrawler Shell
	{ itemId = 11443, count = 50 }, -- Girlish Hair Decoration
	{ itemId = 11449, count = 50 }, -- Blood Preservation
	{ itemId = 11450, count = 50 }, -- Small Notebook
	{ itemId = 11454, count = 50 }, -- Luminous Orb
	{ itemId = 11456, count = 50 }, -- Dirty Turban
	{ itemId = 11457, count = 50 }, -- Dragon's Tail
	{ itemId = 11465, count = 50 }, -- Elven Astral Observer
	{ itemId = 11471, count = 50 }, -- Kongra's Shoulderpad
	{ itemId = 11477, count = 50 }, -- Orcish Gear
	{ itemId = 11482, count = 50 }, -- Piece of Warrior Armor
	{ itemId = 11487, count = 50 }, -- Quara Tentacle
	{ itemId = 11488, count = 50 }, -- Quara Eye
	{ itemId = 11490, count = 50 }, -- Quara Pincers
	{ itemId = 11491, count = 50 }, -- Quara Bone
	{ itemId = 11510, count = 50 }, -- Scroll of Heroic Deeds
	{ itemId = 11511, count = 50 }, -- Banana Sash
	{ itemId = 11512, count = 50 }, -- Small Flask of Eyedrops
	{ itemId = 11514, count = 50 }, -- Colourful Feather
	{ itemId = 11659, count = 50 }, -- Draken Wristbands
	{ itemId = 11660, count = 50 }, -- Broken Draken Mail
	{ itemId = 11661, count = 50 }, -- Broken Slicer
	{ itemId = 11671, count = 50 }, -- Eye of Corruption
	{ itemId = 11672, count = 50 }, -- Tail of Corruption
	{ itemId = 11673, count = 50 }, -- Scale of Corruption
	{ itemId = 12313, count = 50 }, -- Stampor Talons
	{ itemId = 12683, count = 20 }, -- Heavy Trident
	{ itemId = 12730, count = 50 }, -- Eye of a Deepling
	{ itemId = 14008, count = 50 }, -- Spellsinger's Seal
	{ itemId = 14009, count = 50 }, -- Key to the Drowned Library
	{ itemId = 14010, count = 50 }, -- Deepling Guard Belt Buckle
	{ itemId = 14011, count = 50 }, -- Deepling Breaktime Snack
	{ itemId = 14013, count = 50 }, -- Deeptags
	{ itemId = 14017, count = 50 }, -- Deepling Scales
	{ itemId = 14041, count = 50 }, -- Deepling Ridge
	{ itemId = 14044, count = 50 }, -- Deepling Claw
	{ itemId = 14076, count = 50 }, -- Swarmer Antenna
	{ itemId = 14078, count = 50 }, -- Spitter Nose
	{ itemId = 14080, count = 50 }, -- Waspoid Claw
	{ itemId = 14083, count = 50 }, -- Compound Eye
	{ itemId = 14225, count = 50 }, -- Dung Ball
	{ itemId = 14247, count = 20 }, -- Ornate Crossbow
	{ itemId = 16130, count = 50 }, -- Magma Clump
	{ itemId = 16132, count = 50 }, -- Eye of a Weeper
	{ itemId = 16133, count = 50 }, -- Pulverized Ore
	{ itemId = 16135, count = 50 }, -- Vein of Ore
	{ itemId = 16138, count = 50 }, -- Crystalline Spikes
	{ itemId = 16139, count = 50 }, -- Humongous Chunk
	{ itemId = 16140, count = 50 }, -- Hideous Chunk
	{ itemId = 16160, count = 20 }, -- Crystalline Sword
	{ itemId = 16163, count = 20 }, -- Crystal Crossbow
	{ itemId = 17463, count = 50 }, -- Damselfly Eye
	{ itemId = 17809, count = 50 }, -- Bola
	{ itemId = 17812, count = 50 }, -- Ratana
	{ itemId = 17817, count = 50 }, -- Cheese Cutter
	{ itemId = 17818, count = 50 }, -- Cheesy Figurine
	{ itemId = 17819, count = 50 }, -- Earflap
	{ itemId = 17824, count = 50 }, -- Swampling Club
	{ itemId = 17826, count = 50 }, -- Lost Basher's Spike
	{ itemId = 17829, count = 50 }, -- Buckle
	{ itemId = 17830, count = 50 }, -- Bonecarving Knife
	{ itemId = 17831, count = 50 }, -- Bone Fetish
	{ itemId = 17847, count = 50 }, -- Wimp Tooth Chain
	{ itemId = 17850, count = 50 }, -- Holy Ash
	{ itemId = 17851, count = 50 }, -- Broken Throwing Axe
	{ itemId = 17853, count = 50 }, -- Lost Bracers
	{ itemId = 17854, count = 50 }, -- Mad Froth
	{ itemId = 17855, count = 50 }, -- Red Hair Dye
	{ itemId = 17856, count = 50 }, -- Basalt Fetish
	{ itemId = 17857, count = 50 }, -- Basalt Figurine
	{ itemId = 17859, count = 50 }, -- Spiky Club
	{ itemId = 18924, count = 50 }, -- Tooth File
	{ itemId = 18925, count = 50 }, -- Lancet
	{ itemId = 18926, count = 50 }, -- Horoscope
	{ itemId = 18927, count = 50 }, -- Vampire's Cape Chain
	{ itemId = 18928, count = 50 }, -- Blood Tincture in a Vial
	{ itemId = 18995, count = 50 }, -- Venison
	{ itemId = 19110, count = 50 }, -- Dowser
	{ itemId = 19111, count = 50 }, -- Fir Cone
	{ itemId = 20198, count = 50 }, -- Frazzle Tongue
	{ itemId = 20201, count = 50 }, -- Silencer Resonating Chamber
	{ itemId = 20202, count = 50 }, -- Dead Weight
	{ itemId = 20203, count = 50 }, -- Trapped Bad Dream Monster
	{ itemId = 20204, count = 50 }, -- Bowl of Terror Sweat
	{ itemId = 20206, count = 50 }, -- Hemp Rope
	{ itemId = 20207, count = 50 }, -- Pool of Chitinous Glue
	{ itemId = 21103, count = 50 }, -- Glooth Injection Tube
	{ itemId = 21164, count = 20 }, -- Glooth Cape
	{ itemId = 21165, count = 20 }, -- Rubber Cap
	{ itemId = 21168, count = 20 }, -- Alloy Legs
	{ itemId = 21169, count = 20 }, -- Metal Spats
	{ itemId = 21171, count = 20 }, -- Metal Bat
	{ itemId = 21174, count = 20 }, -- Mino Lance
	{ itemId = 21175, count = 20 }, -- Mino Shield
	{ itemId = 21178, count = 20 }, -- Glooth Club
	{ itemId = 21179, count = 20 }, -- Glooth Blade
	{ itemId = 21180, count = 20 }, -- Glooth Axe
	{ itemId = 21182, count = 50 }, -- Glob of Glooth
	{ itemId = 21193, count = 50 }, -- Metal Jaw
	{ itemId = 21195, count = 50 }, -- Poisoned Fang
	{ itemId = 21196, count = 50 }, -- Necromantic Rust
	{ itemId = 21197, count = 50 }, -- Slimy Leaf Tentacle
	{ itemId = 21199, count = 50 }, -- Giant Pacifier
	{ itemId = 21201, count = 50 }, -- Execowtioner Mask
	{ itemId = 21204, count = 50 }, -- Cowbell
	{ itemId = 21974, count = 50 }, -- Golden Lotus Brooch
	{ itemId = 22051, count = 50 }, -- Werebadger Claws
	{ itemId = 22054, count = 50 }, -- Wereboar Tusks
	{ itemId = 22055, count = 50 }, -- Werebadger Skull
	{ itemId = 22056, count = 50 }, -- Werebear Skull
	{ itemId = 22057, count = 50 }, -- Werebear Fur
	{ itemId = 22085, count = 20 }, -- Fur Armor
	{ itemId = 22086, count = 20 }, -- Badger Boots
	{ itemId = 22087, count = 20 }, -- Wereboar Loincloth
	{ itemId = 22184, count = 50 }, -- Shamanic Talisman
	{ itemId = 22186, count = 50 }, -- Raw Meat
	{ itemId = 22188, count = 50 }, -- Ogre Ear Stud
	{ itemId = 22191, count = 50 }, -- Skull Fetish
	{ itemId = 22729, count = 50 }, -- Pair of Hellflayer Horns
	{ itemId = 23502, count = 50 }, -- Sparkion Claw
	{ itemId = 23503, count = 50 }, -- Sparkion Tail
	{ itemId = 23504, count = 50 }, -- Sparkion Legs
	{ itemId = 23505, count = 50 }, -- Sparkion Stings
	{ itemId = 23506, count = 50 }, -- Plasma Pearls
	{ itemId = 23510, count = 50 }, -- Odd Organ
	{ itemId = 23511, count = 50 }, -- Curious Matter
	{ itemId = 23514, count = 50 }, -- Volatile Proto Matter
	{ itemId = 23515, count = 50 }, -- Dangerous Proto Matter
	{ itemId = 23516, count = 50 }, -- Instable Proto Matter
	{ itemId = 23518, count = 50 }, -- Spark Sphere
	{ itemId = 23519, count = 50 }, -- Frozen Lightning
	{ itemId = 23520, count = 50 }, -- Plasmatic Lightning
	{ itemId = 23521, count = 50 }, -- Crystal Bone
	{ itemId = 23523, count = 50 }, -- Energy Ball
	{ itemId = 24380, count = 50 }, -- Bone Toothpick
	{ itemId = 24384, count = 50 }, -- Ancient Belt Buckle
	{ itemId = 24385, count = 50 }, -- Cracked Alabaster Vase
	{ itemId = 24938, count = 50 }, -- Dragon Tongue
	{ itemId = 25691, count = 50 }, -- Wild Flowers
	{ itemId = 25693, count = 50 }, -- Shimmering Beetles
	{ itemId = 25695, count = 50 }, -- Dandelion Seeds
	{ itemId = 25696, count = 50 }, -- Colourful Snail Shell
	{ itemId = 25697, count = 50 }, -- Green Bandage
	{ itemId = 25699, count = 50 }, -- Wooden Spellbook
	{ itemId = 25701, count = 50 }, -- Single Human Eye
	{ itemId = 25742, count = 50 }, -- Fig Leaf
	{ itemId = 27369, count = 50 }, -- Half-Digested Stones
	{ itemId = 27462, count = 50 }, -- Fox Paw
	{ itemId = 27463, count = 50 }, -- Werefox Tail
	{ itemId = 27592, count = 50 }, -- Deepworm Spikes
	{ itemId = 27593, count = 50 }, -- Deepworm Spike Roots
	{ itemId = 27594, count = 50 }, -- Deepworm Jaws
	{ itemId = 27595, count = 50 }, -- Tunnel Tyrant Head
	{ itemId = 27596, count = 50 }, -- Tunnel Tyrant Shell
	{ itemId = 27597, count = 50 }, -- Diremaw Brainpan
	{ itemId = 27598, count = 50 }, -- Diremaw Legs
	{ itemId = 27599, count = 50 }, -- Cave Devourer Eyes
	{ itemId = 27600, count = 50 }, -- Cave Devourer Maw
	{ itemId = 27601, count = 50 }, -- Cave Devourer Legs
	{ itemId = 27602, count = 50 }, -- Chasm Spawn Head
	{ itemId = 27603, count = 50 }, -- Chasm Spawn Abdomen
	{ itemId = 27604, count = 50 }, -- Chasm Spawn Tail
	{ itemId = 27606, count = 50 }, -- Stonerefiner's Skull
	{ itemId = 28566, count = 50 }, -- Silken Bookmark
	{ itemId = 28569, count = 50 }, -- Book Page
	{ itemId = 28570, count = 50 }, -- Glowing Rune
	{ itemId = 28822, count = 50 }, -- Damaged Armor Plates
	{ itemId = 28823, count = 50 }, -- Falcon Crest
	{ itemId = 30005, count = 50 }, -- Dream Essence Egg
	{ itemId = 30058, count = 50 }, -- Ice Flower
	{ itemId = 31331, count = 50 }, -- Empty Honey Glass
	{ itemId = 31438, count = 50 }, -- Sphinx Tiara
	{ itemId = 31439, count = 50 }, -- Manticore Tail
	{ itemId = 31440, count = 50 }, -- Manticore Ear
	{ itemId = 31441, count = 50 }, -- Lamassu Hoof
	{ itemId = 31442, count = 50 }, -- Lamassu Horn
	{ itemId = 31443, count = 50 }, -- Fafnar Symbol
	{ itemId = 31558, count = 50 }, -- Red Goanna Scale
	{ itemId = 31559, count = 50 }, -- Blue Goanna Scale
	{ itemId = 31560, count = 50 }, -- Goanna Meat
	{ itemId = 31561, count = 50 }, -- Goanna Claw
	{ itemId = 31678, count = 50 }, -- Cobra Crest
	{ itemId = 32698, count = 50 }, -- Ensouled Essence
	{ itemId = 33934, count = 50 }, -- Telescope Eye
	{ itemId = 33938, count = 50 }, -- Roots
	{ itemId = 33943, count = 50 }, -- Werehyaena Nose
	{ itemId = 33944, count = 50 }, -- Werehyaena Talisman
	{ itemId = 33945, count = 50 }, -- Ivory Carving
	{ itemId = 33982, count = 50 }, -- Crawler's Essence
	{ itemId = 34141, count = 50 }, -- Mould Heart
	{ itemId = 34160, count = 50 }, -- Lion Crest
	{ itemId = 34162, count = 50 }, -- Lion Cloak Patch
	{ itemId = 35571, count = 50 }, -- Small Treasure Chest
	{ itemId = 35572, count = 50 }, -- Pirate Coin
	{ itemId = 35573, count = 50 }, -- Pirat's Tail
	{ itemId = 35574, count = 50 }, -- Shark Fins
	{ itemId = 35596, count = 50 }, -- Mouldy Powder
	{ itemId = 36769, count = 50 }, -- Lavaworm Spike Roots
	{ itemId = 36770, count = 50 }, -- Lavaworm Spikes
	{ itemId = 36771, count = 50 }, -- Lavaworm Jaws
	{ itemId = 36772, count = 50 }, -- Streaked Devourer Eyes
	{ itemId = 36773, count = 50 }, -- Streaked Devourer Maw
	{ itemId = 36774, count = 50 }, -- Streaked Devourer Legs
	{ itemId = 36775, count = 50 }, -- Eyeless Devourer Maw
	{ itemId = 36776, count = 50 }, -- Eyeless Devourer Legs
	{ itemId = 36777, count = 50 }, -- Eyeless Devourer Tongue
	{ itemId = 36778, count = 50 }, -- Blemished Spawn Head
	{ itemId = 36779, count = 50 }, -- Blemished Spawn Abdomen
	{ itemId = 36780, count = 50 }, -- Blemished Spawn Tail
	{ itemId = 36785, count = 50 }, -- Lavafungus Head
	{ itemId = 36786, count = 50 }, -- Lavafungus Ring
	{ itemId = 36789, count = 50 }, -- Afflicted Strider Head
	{ itemId = 36790, count = 50 }, -- Afflicted Strider Worms
	{ itemId = 36805, count = 50 }, -- Carnisylvan Finger
	{ itemId = 36806, count = 50 }, -- Carnisylvan Bark
	{ itemId = 36807, count = 50 }, -- Human Teeth
	{ itemId = 36820, count = 50 }, -- Bashmu Fang
	{ itemId = 36821, count = 50 }, -- Bashmu Tongue
	{ itemId = 36822, count = 50 }, -- Scorpion Charm
	{ itemId = 36823, count = 50 }, -- Bashmu Feather
	{ itemId = 36971, count = 50 }, -- Girtablilu Warrior Carapace
	{ itemId = 36972, count = 50 }, -- Old Girtablilu Carapace
	{ itemId = 37109, count = 50 }, -- Sliver
	{ itemId = 37110, count = 50 }, -- Exalted Core
	{ itemId = 39375, count = 50 }, -- Sulphider Shell
	{ itemId = 39376, count = 50 }, -- Sulphur Powder
	{ itemId = 39377, count = 50 }, -- Gore Horn
	{ itemId = 39378, count = 50 }, -- Sabretooth Fur
	{ itemId = 39379, count = 50 }, -- Emerald Tortoise Shell
	{ itemId = 39380, count = 50 }, -- Undertaker Fangs
	{ itemId = 39381, count = 50 }, -- Nighthunter Wing
	{ itemId = 39382, count = 50 }, -- Prehemoth Horns
	{ itemId = 39383, count = 50 }, -- Prehemoth Claw
	{ itemId = 39384, count = 50 }, -- Stalking Seeds
	{ itemId = 39386, count = 50 }, -- Mantosaurus Jaw
	{ itemId = 39387, count = 50 }, -- Headpecker Beak
	{ itemId = 39388, count = 50 }, -- Headpecker Feather
	{ itemId = 39389, count = 50 }, -- Ripptor Claw
	{ itemId = 39391, count = 50 }, -- Ripptor Scales
	{ itemId = 39392, count = 50 }, -- Gorerilla Mane
	{ itemId = 39393, count = 50 }, -- Gorerilla Tail
	{ itemId = 39394, count = 50 }, -- Cry-Stal
	{ itemId = 39395, count = 50 }, -- Mercurial Wing
	{ itemId = 39401, count = 50 }, -- Makara Fin
	{ itemId = 39402, count = 50 }, -- Makara Tongue
	{ itemId = 39406, count = 50 }, -- Coral Branch
	{ itemId = 39407, count = 50 }, -- Flotsam
	{ itemId = 39408, count = 50 }, -- Small Tropical Fish
	{ itemId = 39409, count = 50 }, -- Two-Headed Turtle Heads
	{ itemId = 39410, count = 50 }, -- Hydrophytes
	{ itemId = 39411, count = 50 }, -- Naga Armring
	{ itemId = 39412, count = 50 }, -- Naga Earring
	{ itemId = 39413, count = 50 }, -- Naga Archer Scales
	{ itemId = 39414, count = 50 }, -- Naga Warrior Scales
	{ itemId = 40582, count = 50 }, -- Crab Man Claws
	{ itemId = 40583, count = 50 }, -- Liodile Fang
	{ itemId = 40584, count = 50 }, -- Boar Man Hoof
	{ itemId = 40585, count = 50 }, -- Harpy Feathers
	{ itemId = 40586, count = 50 }, -- Carnivostrich Feather
	{ itemId = 40587, count = 50 }, -- Rhindeer Antlers
	{ itemId = 43729, count = 50 }, -- Werecrocodile Tongue
	{ itemId = 43730, count = 50 }, -- Weretiger Tooth
	{ itemId = 43731, count = 50 }, -- Werepanther Claw
	{ itemId = 43732, count = 50 }, -- Silver Moon Coin
	{ itemId = 43734, count = 50 }, -- Golden Sun Coin
	{ itemId = 43846, count = 50 }, -- Decayed Finger Bone
	{ itemId = 43848, count = 50 }, -- Worm Sponge
	{ itemId = 43849, count = 50 }, -- Rotten Roots
	{ itemId = 43850, count = 50 }, -- Dark Obsidian Splinter
	{ itemId = 43851, count = 50 }, -- Darklight Matter
	{ itemId = 43852, count = 50 }, -- Darklight Basalt Chunk
	{ itemId = 43853, count = 50 }, -- Darklight Core
	{ itemId = 44743, count = 50 }, -- Nimmersatt's Seal
	{ itemId = 44744, count = 50 }, -- Molten Dragon Essence
	{ itemId = 44745, count = 50 }, -- Mega Dragon Heart
	{ itemId = 44746, count = 50 }, -- Dragolisk Eye
	{ itemId = 44747, count = 50 }, -- Dragolisk Poison Gland
	{ itemId = 44748, count = 50 }, -- Wardragon Claw
	{ itemId = 44749, count = 50 }, -- Wardragon Tooth
	{ itemId = 48252, count = 50 }, -- Brigadeiro
	{ itemId = 48255, count = 50 }, -- Lime Tart
	{ itemId = 48508, count = 50 }, -- Amber Souvenir
	{ itemId = 48509, count = 50 }, -- Resinous Fish Fin
	{ itemId = 48510, count = 50 }, -- Demon Root
	{ itemId = 48511, count = 50 }, -- Resin Parasite
	{ itemId = 49894, count = 50 }, -- Demonic Matter
	{ itemId = 49908, count = 50 }, -- Mummified Demon Finger
	{ itemId = 50056, count = 50 }, -- Brinebrute Claw
	{ itemId = 50057, count = 50 }, -- Sineater Wing
	{ itemId = 50058, count = 50 }, -- Broodrider Saddle
	{ itemId = 50059, count = 50 }, -- Gorger Antlers
	{ itemId = 51419, count = 50 }, -- Paper Plane
	{ itemId = 51420, count = 50 }, -- Paper Boat
	{ itemId = 51422, count = 50 }, -- Star Ink
	{ itemId = 51423, count = 50 }, -- Book with a Dragon
	{ itemId = 51425, count = 50 }, -- Book with an Hourglass
	{ itemId = 51426, count = 50 }, -- Sealing Wax
	{ itemId = 51427, count = 50 }, -- Torn Page
	{ itemId = 51472, count = 50 }, -- Chain Leash
	{ itemId = 51473, count = 50 }, -- Blood Amulet
	{ itemId = 51474, count = 50 }, -- Piece of Frozen Night
	{ itemId = 51475, count = 50 }, -- Ritual Bone Knife
	{ itemId = 51476, count = 50 }, -- Pot of Orcish Warpaint
	{ itemId = 51477, count = 50 }, -- Orcish Toothbrush
	{ itemId = 51478, count = 50 }, -- Bone Rattle
	{ itemId = 51479, count = 50 }, -- Spiked Bracers
	{ itemId = 51480, count = 50 }, -- Blood Hood
	{ itemId = 51482, count = 50 }, -- Bloodshot Giant Eye
	{ itemId = 51484, count = 50 }, -- Heart Amphora
	{ itemId = 51485, count = 50 }, -- Bone Fibula
	{ itemId = 51486, count = 50 }, -- Spiked Gorget
	{ itemId = 52633, count = 50 }, -- Night Harpy Feathers
	{ itemId = 52662, count = 50 }, -- Silver Poniard
	{ itemId = 52663, count = 50 }, -- Cuirass Plate
	{ itemId = 52664, count = 50 }, -- Stag Parchment
	{ itemId = 52705, count = 50 }, -- Necromantic Core
	{ itemId = 52706, count = 50 }, -- Toe Nails
	{ itemId = 52707, count = 50 }, -- Giant Tusk
	{ itemId = 52718, count = 50 }, -- Deadly Fangs
	{ itemId = 52719, count = 50 }, -- Crystallized Death
	{ itemId = 52720, count = 50 }, -- Cluster of Crystallized Death
}
