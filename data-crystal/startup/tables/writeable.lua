-- Guidelines for BookDocumentTable:
-- containerId: id of the container item (bookcase, shelf, corpse, etc). Optional.
-- itemId: id of item (book, scroll, letter, etc).
-- position: position of the container or of the item (depending on if the item is on a container or not).
-- text: text of item (book, scroll, letter, etc).
BookDocumentTable = {
	--[1] = {
	--	containerId = 2435,
	--	itemId = 2828,
	--	position = { x = 0, y = 0, z = 4 },
	--	text = [[
	--MONSTERS AND FOES OF DAWNPORT I

	--Intelligent monsters

	--The troll - Though intelligent in a limited way, usually trolls do not pose a major threat to our outpost, though they are scouting the outskirts of our grounds and attack passersby. They are able to create and use some basic equipment, and are tough to lesser weapons and unskilled fighters.

	--The orc - The green-skinned orc is intelligent and able to use weapons and armor. They are warriors of some power and very dangerous in greater numbers. Luckily enough, there are not many of their more skilled fighters around, like the berserker or warrior. Still, a handful of them is enough to get an adventurer into dire straits.

	--The goblin - sneaky and devious, goblins steal everything that is not nailed down. Though small and relatively easy to fight, they don't shirk from attacking humans when they feel superior in numbers. They normally stay in their hideouts underground, where they hoard their loot.

	--The minotaur - a dreaded beast and fearsome fighter, the minotaur is a formidable foe for a young adventurer. Particular caution should be exercised when going to their lair underground, as they have some skilled archers and even some mages that may kill you very, very quickly.

	--Other beasts - It is certain that other beasts live in the dungeons of our isle. But they are not numerous enough to be recognised yet. If you encounter any unknown beast it is certainly dangerous and a potential lethal enemy. Don't underestimate them.
	--		]],
	--	},
}

SignTable = {
	-- Karmia City
	[1] = {
		itemId = 2012,
		itemPos = { x = 438, y = 502, z = 8 },
		text = "Welcome to Karmia City.",
	},
	-- Demon Oak
	[2] = {
		itemId = 2012,
		itemPos = { x = 369, y = 287, z = 7 },
		text = "Choose a reward wisely!",
	},
	-- Premium island
	[3] = {
		itemId = 2022,
		itemPos = { x = 430, y = 630, z = 7 },
		text = "Temple of Premium Island!",
	},
	-- Ferumbras Tower Exit
	[4] = {
		itemId = 2012,
		itemPos = { x = 659, y = 567, z = 8 },
		text = "Exit!!!",
	},
	-- POI
	[5] = {
		itemId = 6121,
		itemPos = { x = 238, y = 827, z = 7 },
		text = [[
POI part 1:
Release the 5 fire barriers.
		]],
	},
	[6] = {
		itemId = 2014,
		itemPos = { x = 260, y = 829, z = 8 },
		text = "You can't return.",
	},
	[7] = {
		itemId = 6121,
		itemPos = { x = 281, y = 824, z = 10 },
		text = [[
POI part 3:
Overcome the challenges.
		]],
	},
	-- Demon Hell
	[8] = {
		itemId = 2017,
		itemPos = { x = 365, y = 817, z = 8 },
		text = [[
Danger!
Be careful when climbing!
Strong monsters They took this place!
		]],
	},
	[9] = {
		itemId = 2012,
		itemPos = { x = 309, y = 886, z = 7 },
		text = "Path to The Pits of Inferno!",
	},
}
