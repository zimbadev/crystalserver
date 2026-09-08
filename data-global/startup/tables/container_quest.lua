--[[
	Chests and containers that carry an action or unique id -- 175 containers.

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

MapContainersQuest = {
	-- chest at 31981,32893,0
	{
		itemId = 2472,
		itemPos = { x = 31981, y = 32893, z = 0 },
		contents = {
			{ itemId = 6101 }, -- Ron the Ripper's sabre
			{ itemId = 6102, count = 0 }, -- Deadeye Devious' eye patch
			{ itemId = 6099, count = 0 }, -- Brutus Bloodbeard's hat
		},
	},
	-- treasure chest at 32804,31586,0
	{
		itemId = 4073,
		itemPos = { x = 32804, y = 31586, z = 0 },
		contents = {
			{ itemId = 6533, -- book
				text = [[
Guarded by fire and dark walls, a long forgotten secret lies.
Never meant to be opened, yet now it awakes.
Key to magic, wielded as a sword by those who fought.
The first and the last tease, creation and destruction.]] },
		},
	},
	-- chest at 32753,31456,1
	{
		itemId = 2472,
		itemPos = { x = 32753, y = 31456, z = 1 },
		contents = {
			{ itemId = 9389 }, -- fan doll of King Tibianus
		},
	},
	-- wooden trunk at 33195,31765,1
	{
		itemId = 11810,
		itemPos = { x = 33195, y = 31765, z = 1 },
		contents = {
			{ itemId = 28461, -- page from a mystic book
				text = [[
This page seems to be part of a book about ancient rituals, mystic incantations and far away places. Besides a very prominent symbol, embedded in the text, a spell can be deciphered from the strange script:

~ As daylight fades, mix chalk or bone meal with your own blood and water ~
~ Draw with it a circle in the middle of the room ~
~ Stand in this sphere when drawing the symbol "Of Night And Day Intersecting Ostensum Est"
~ Utter all of the following words loudly with clear voice: CERTAGIA SALABANTHR DANNHE GENT'HO" ~
~ Looking upward, repeat the incatation and you shall teleport the periphery of your body ~]] },
		},
	},
	-- chest at 33343,31610,1
	{
		itemId = 2472,
		itemPos = { x = 33343, y = 31610, z = 1 },
		contents = {
			{ itemId = 10217 }, -- Tome of Knowledge
		},
	},
	-- box at 32967,31719,2
	{
		itemId = 2473,
		itemPos = { x = 32967, y = 31719, z = 2 },
		contents = {
			{ itemId = 5940 }, -- wolf tooth chain
		},
	},
	-- sturdy chest at 32032,32276,5
	{
		itemId = 7757,
		itemPos = { x = 32032, y = 32276, z = 5 },
		contents = {
			{ itemId = 2853, -- bag
				inside = {
					{ itemId = 3562 }, -- coat
				},
			},
		},
	},
	-- chest at 33064,32529,5
	{
		itemId = 2472,
		itemPos = { x = 33064, y = 32529, z = 5 },
		contents = {
			{ itemId = 11541, -- Jean Pierre's Cookbook II
				text = [[
Famous Recipes by Maître Jean Pierre

Coconut Shrimp Bake
- 5 vials of milk
- 5 brown mushrooms
- 5 red mushrooms
- 10 rice balls
- 10 shrimps

Pot of Blackjack
- 5 sandcrawler shells
- 2 vials of water
- 20 carrots
- 10 potatoes
- 3 jalapeño peppers

Demonic Candy Ball
- 3 candies
- 3 candy canes
- 2 bar of chocolate
- 15 gingerbreadmen
- 1 concentrated demonic blood

Sweet Mangonaise Elixir
- 100 eggs
- 50 mangoes
- 10 honeycombs
- 1 bottle of bug milk
- 1 blessed wooden stake]] },
		},
	},
	-- chest at 33064,32531,5
	{
		itemId = 2472,
		itemPos = { x = 33064, y = 32531, z = 5 },
		contents = {
			{ itemId = 9093, -- Jean Pierre's Cookbook I
				text = [[
Famous Recipes by Maître Jean Pierre

Rotworm Stew
- 2 Pieces of meat
- 2 Vials of beer
- 20 Potatoes
- 1 Onion
- 1 Garlic
- 5 Ounces of flour

Hydra Tongue Salad
- 2 Hydra tongues
- 2 Tomatoes
- 1 Cucumber
- 2 Eggs
- 1 Troll green
- 1 Vial of wine

Roasted Dragon Wings
- 1 Fresh dead bat
- 3 Jalapeño peppers
- 5 Brown breads
- 2 Eggs
- 1 Powder herb
- 5 Red mushrooms

Tropical Fried Terrorbird
- 1 Fresh dead chicken
- 2 Lemons
- 2 Oranges
- 2 Mangos
- 2 Vials of coconut milk
- 1 Stone herb

Banana Chocolate Shake
- 1 Bar of chocolate
- 1 Cream cake
- 2 Bananas
- 2 Vials of milk
- 1 Sling herb
- 1 Star herb

Veggie Casserole
- 2 Carrots
- 2 Tomatoes
- 2 Corncobs
- 2 Cucumbers
- 1 Onion
- 1 Garlic
- 1 Cheese
- 20 White mushrooms
- 5 Brown mushrooms

Filled Jalapeño Peppers
- 10 Jalapeño peppers
- 2 Cheese
- 1 Troll green
- 1 Shadow herb
- 1 Vial of mead
- 2 Eggs

Blessed Steak
- 1 Piece of ham
- 5 Plums
- 1 Onions
- 2 Beetroot
- 1 Pumpkin
- 2 Jalapeño peppers

Northern Fishburger
- 1 Northern pike
- 1 Rainbow trout
- 1 Green perch
- 5 Shrimps
- 2 Rolls
- 1 Fern

Carrot Cake
- 5 Carrots
- 1 Vial of milk
- 1 Lemon
- 10 Ounces of flour
- 2 Eggs
- 10 Cookies
- 2 Peanuts]] },
		},
	},
	-- bookcase at 33155,32840,6
	{
		itemId = 2438,
		itemPos = { x = 33155, y = 32840, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
In ancient tombs beneath the burning endless sands

Where neither sunlight reaches nor the pale-faced moon

The whispers of the long deceased traitors dance
Bloodthirsty creatures screeching an unholy tune

Dark are the mysteries surrounded by doomed cries

Uncurtained to the warriors of righteous mind

Who well-prepared with magic, sharpened blade and eyes

Step through the doors and leave their mortal fear behind.]] },
		},
	},
	-- box at 31987,31223,7
	{
		itemId = 2469,
		itemPos = { x = 31987, y = 31223, z = 7 },
		contents = {
			{ itemId = 11547 }, -- exquisite wood
		},
	},
	-- sturdy chest at 32059,32265,7
	{
		itemId = 7757,
		itemPos = { x = 32059, y = 32265, z = 7 },
		contents = {
			{ itemId = 3457 }, -- shovel
		},
	},
	-- not named in items.xml at 32475,32493,7
	{
		itemId = 28827,
		itemPos = { x = 32475, y = 32493, z = 7 },
		contents = {
			{ itemId = 9083, count = 1 }, -- banana chocolate shake
		},
	},
	-- box at 32795,31185,7
	{
		itemId = 2469,
		itemPos = { x = 32795, y = 31185, z = 7 },
		contents = {
			{ itemId = 2820, -- sheet of paper
				text = [[
Manifest of the Yalahari, Part I
The city has been neglected for far too long. We concentrated on our research and spiritual evolution and have turned a blind eye on the needs of the people that are our subjects. We have too strongly relied on the help of the Augur who in turn did little but the same routines for many generations. We have decided it is time to take initiative. The experiment to give people too much freedom and too little guidance has to be stopped before all is lost. We have a responsibility for this city and the people living here. Only with our help, they will be able to flourish and to overcome the shadows of the past. The city can be rebuilt and restored to at least some of its former glory when we diligently work for it. It will be hard and it will take the help of determined individuals to assist us in our efforts. However, in the long run, order will be completely re-established and Yalahar will once again be the magnificent city it used to be.
Only with drastic decisions and changes, this great goal can be achieved. We will have to get through hard times and prepare for them as good as we can. Most importantly, a good city needs a solid base. For this reason we have to start at the bottom to clean things up. We have to be precise and consequent in our decisions and actions. This way we will be able to create a solid base for the city.
To some extent, we have to work like a gardener. The rotten parts have to be cut off, and the healthy parts have to be cherished. The city has to be retaken. Then order can be restored and the actual rebuilding can begin. In the end, the city will once again be a centre of prosperity and a shining light in a dark world.]] },
			{ itemId = 2820, -- sheet of paper
				text = [[
Manifest of the Yalahari, Part II
It is obvious that such greatness comes not without sacrifices, but we will make sure to keep them to a minimum. All of our decisions serve a greater good, of course. Even if this is not always obvious, in the end things will work out and provide us all with a better life and a bright future.\nBased on the ruins of our former glory, it is hard to imagine how magnificent this future will be, but we, the Yalahari, still carry the vision of what we want to accomplish in our hearts. To bring this vision to life is our greatest goal which we all work towards.\nThere are elements that see their power and influence waning in these days of change. They are afraid of the things to come, and in their ignorance they cling to the rotting reality they know all too well. They created their own little niches of power and influence and feel guilty for neglecting their duties, and with that also for the decay of the city. They are surely already approaching unsuspecting outsiders to poison their minds with selfish lies. For generations the Augur, once the pride of our people, have done things the same way they had known for generations, and everyone can see where it has taken Yalahar.]] },
		},
	},
	-- box at 32796,31226,7
	{
		itemId = 2469,
		itemPos = { x = 32796, y = 31226, z = 7 },
		contents = {
			{ itemId = 2820, -- sheet of paper
				text = [[
History of the Augur, Part II
They brought more and more people to Yalahar. Not all of them became Augur, a good part of them lived in Yalahar as ordinary citizens. At some point, the city had reached a much larger population than under the rule of the true Yalahari, and it became difficult to provide food and shelter for everyone. Time and overuse took it's toll on the city. Over the years, more and more parts of the city were lost due to ignorance, lack of resources, or catastrophes. The new Yalahari were unable to restore broken machines and devices, and their efforts to retake certain parts of the city with the help of the Augur caused only more disaster. So the new Yalahari decided to stay in the city's centre, letting the Augur care for the rest of the city as well as they could. Still, their image as Yalahari allowed them to claim supremacy and to rule over the whole city.
This all did not matter too much to our ancestors. The new Yalahari were neither cruel nor overly abusive, and they still wielded the powerful weapons and armors of the true Yalahari. So they stuck to the status quo and continued to work for the Yalahari despite everything they had found out. This worked quite well although the city was still declining and great parts of it had been lost to chaos and anarchy.
Lately, though, things started to change. It is not a dramatic change but it can be recognised gradually at many places. Some of the known routines in the orders of the Yalahari have altered. There are more and more orders who have a dubious purpose. The most frightening thing is that some orders obviously hint at a person with Yalahari knowledge that had been considered as lost for centuries. The overwhelming majority of the new Yalahari still clings to their ignorant and self-centred ways, but perhaps one of them or a small group has discovered some hidden secrets of their vanished masters. It is also possible that something completely different is happening, we simply don't know. But these new orders that seem to aim at restoring order in the city have some bitter taste. They are somewhat oppressive and destructive, not in an obvious way, though. Taken together, they paint a dark picture of Yalahar's future. A future of oppression, betrayal, and a much stricter rule by the Yalahari.]] },
			{ itemId = 2820, -- sheet of paper
				text = [[
History of the Augur, Part I
We, the families of the Augur, have been living here for many generations. In the course of time, we acquired certain insights in the ways of our masters, the Yalahari. Many years ago, things used to be very different in this city. Once it was a marvel to behold, but then it started to decay slowly and steadily. This process of deterioration begun in the far past, long before our ancestors came here. At the time they were brought here by the Yalahari as helpers and workers, the city already showed signs of decline. Despite their claim of having great power, the Yalahari could do little to stop the catastrophes that should occur. Neither did they do anything to restore the damaged parts of the city. Still, it took many centuries until the city had reached the pitiful state that you can witness today.
Some decades ago, a group of Augur suspected that we all were lied to by our masters. They started to look for clues that proved their assumptions, and secretly gathered parts of the puzzle one by one. For all we know, there had been indeed a powerful race called the Yalahari that built this city to distance itself from the wars of some capricious gods. So far the tales that our masters had told us, have been true. These Yalahari were served by a group of Augur such as us. They were their helpers and workers, and the Yalahari shared some of their luxuries and achievements with them. The Yalahari concentrated on research and art, and left the more manual work to their servants, who often only knew what they had to do without understanding their tasks.
At one far-away point in history, the Yalahari seemingly vanished. Certain clues that our ancestors gathered, hint that they locked themselves in the city's centre and cut off all contact to their helpers. When the Augur sometime later dared to enter the inner city, the Yalahari were all gone - vanished without a trace. After getting over the initial shock, the Augur assumed the role of the Yalahari themselves. For a while they tried to get familiar with some of the secrets of their lost masters, but they were only able to understand the most basic concepts of the Yalahari's knowledge. They stuck to their usual tasks to keep the city running. Still, they were too few to keep the enormous city, of which they understood so little, in shape.
So they decided to recruit Augur on their own. This way most of our forefathers came to Yalahar. In the meanwhile, the former Augur retreated into the inner city.]] },
		},
	},
	-- chest at 32030,31688,8
	{
		itemId = 2472,
		itemPos = { x = 32030, y = 31688, z = 8 },
		contents = {
			{ itemId = 2970 }, -- copper key
		},
	},
	-- sturdy chest at 32033,32278,8
	{
		itemId = 7757,
		itemPos = { x = 32033, y = 32278, z = 8 },
		contents = {
			{ itemId = 2920 }, -- torch
		},
	},
	-- sturdy chest at 32067,32264,8
	{
		itemId = 7757,
		itemPos = { x = 32067, y = 32264, z = 8 },
		contents = {
			{ itemId = 3003 }, -- rope
		},
	},
	-- box at 32097,32187,8
	{
		itemId = 2473,
		itemPos = { x = 32097, y = 32187, z = 8 },
		contents = {
			{ itemId = 7879 }, -- your student book
		},
	},
	-- chest at 32674,31610,8
	{
		itemId = 2481,
		itemPos = { x = 32674, y = 31610, z = 8 },
		contents = {
			{ itemId = 19064 }, -- opticording sphere
			{ itemId = 22739 }, -- mysterious metal egg
		},
	},
	-- box at 32701,31082,8
	{
		itemId = 2469,
		itemPos = { x = 32701, y = 31082, z = 8 },
		contents = {
			{ itemId = 8818 }, -- alchemists' formulas
		},
	},
	-- box at 32815,32502,8
	{
		itemId = 2469,
		itemPos = { x = 32815, y = 32502, z = 8 },
		contents = {
			{ itemId = 11551 }, -- mystic root
		},
	},
	-- chest at 32053,31939,9
	{
		itemId = 2472,
		itemPos = { x = 32053, y = 31939, z = 9 },
		contents = {
			{ itemId = 2854 }, -- backpack
		},
	},
	-- box at 32757,31953,9
	{
		itemId = 2473,
		itemPos = { x = 32757, y = 31953, z = 9 },
		contents = {
			{ itemId = 3209 }, -- voodoo doll
		},
	},
	-- box at 32757,31957,9
	{
		itemId = 2473,
		itemPos = { x = 32757, y = 31957, z = 9 },
		contents = {
			{ itemId = 3046 }, -- magic light wand
		},
	},
	-- chest at 32084,31062,10
	{
		itemId = 2472,
		itemPos = { x = 32084, y = 31062, z = 10 },
		contents = {
			{ itemId = 2853, -- bag
				inside = {
					{ itemId = 7440, count = 1 }, -- mastermind potion
					{ itemId = 3031, count = 100 }, -- gold coin
					{ itemId = 3031, count = 23 }, -- gold coin
					{ itemId = 7159, count = 1 }, -- green perch
					{ itemId = 7158, count = 2 }, -- rainbow trout
				},
			},
		},
	},
	-- chest at 32172,31602,10
	{
		itemId = 2472,
		itemPos = { x = 32172, y = 31602, z = 10 },
		contents = {
			{ itemId = 2970 }, -- copper key
		},
	},
	-- box at 32576,31572,10
	{
		itemId = 2473,
		itemPos = { x = 32576, y = 31572, z = 10 },
		contents = {
			{ itemId = 9308 }, -- nautical map
		},
	},
	-- bookcase at 32621,31404,10
	{
		itemId = 2435,
		itemPos = { x = 32621, y = 31404, z = 10 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Tunnelling guide
----------------
by Gromward Hammerfist
'The art of building a tunnel lies in the nature of dwarfes.' That's what my grand grand grandfather used to say. First of all I'd like to give you a small historical review of tunnelling. .....<you skip the first 1000 pages containing dwarfen tunnelling history>.
Repairing collapsed tunnels:
Equipment: Pick, tree or bricklayers kit
Before picking away the rubble you need to place a buttress otherwise the tunnel will collapse over and over again. If you don't have a matching tree at hand you could still build a brickwall to stabilize the tunnel. Good luck!
Repairing gaps:
Equipment: Wood, wooden ties, hammer, nails, metal fitting
For each missing part (on the basis of a standard rail) I recommend to use three pieces of wood. Lock them in position by at least 6 nails. For the rail itself use a saw on a piece of wood to build your wooden ties. Then place two metal fittings on them and you can make your first ride on your new rail. Congratulations!
Building a rail on lava:
I advice not to try that until you have at least 20 years experience in rail construction......<Well, seems like you don't match the premises.>

Adventuring old tunnels:
Be aware that our kind mastered the art of tunnelling. It may take you a whole life to understand the techniques that are used and it takes generations to know all the tunnels of a mine and all their exits. You even may find an exit that you never expected to.

To sum up
If you are no dwarf don't even try to think that you have a chance of mastering the art of tunnelling. If you are a dwarf I wish you good luck and don't abandon faith. There is a light at the end of the tunnel.

Yours
Gromward Hammerfist]] },
		},
	},
	-- unknown item at 33215,31413,10
	{
		itemId = 11591,
		itemPos = { x = 33215, y = 31413, z = 10 },
		contents = {
			{ itemId = 11545 }, -- exquisite silk
		},
	},
	-- box at 32216,31168,11
	{
		itemId = 2473,
		itemPos = { x = 32216, y = 31168, z = 11 },
		contents = {
			{ itemId = 2853, -- bag
				inside = {
					{ itemId = 7440, count = 1 }, -- mastermind potion
					{ itemId = 3031, count = 78 }, -- gold coin
				},
			},
		},
	},
	-- dead human at 32262,31861,11
	{
		itemId = 4240,
		itemPos = { x = 32262, y = 31861, z = 11 },
		contents = {
			{ itemId = 2854, -- backpack
				inside = {
					{ itemId = 19148 }, -- torn magic cape
					{ itemId = 3123, count = 0 }, -- worn leather boots
					{ itemId = 3212, -- monk's diary
						text = [[
<the text seems to be a mostly ruined diary of some sort, found on the body of a dead monk. Most passages make no sense at all to you>
... abbot still clueless abour my ...
...
After all those perils and puzzels I have located the throne of darkness at last. I will lead ...
...
... crypts and monsters ... found one of the caged demons that seem to be leached as a powersupply of some sort ...
...
... switches on the end of the scorpion path and the lair of the wicked web ... 
... died but I could make it to the throne. My wards are holding the howling ghosts and spectres at bay for now and I prepare to unleash the powers of the throne ... 
...
... still impossible! My wards are fading and the ancient spirits feel that they will soon claim another victory. I failed the brotherhood and will soon join the howling hords in their eternal torment and madness. ...
...
has stoped. I KNOW they are coming after me now. I can see the flickering of the shadows as they aproach. THEY ARE COMING]] },
					{ itemId = 8275 }, -- torn book
				},
			},
		},
	},
	-- chest at 33143,31800,11
	{
		itemId = 2472,
		itemPos = { x = 33143, y = 31800, z = 11 },
		contents = {
			{ itemId = 3003 }, -- rope
		},
	},
	-- box at 33449,32796,11
	{
		itemId = 2469,
		itemPos = { x = 33449, y = 32796, z = 11 },
		contents = {
			{ itemId = 5467 }, -- fire bug
		},
	},
	-- sarcophagus at 33235,32803,12
	{
		itemId = 1994,
		itemPos = { x = 33235, y = 32803, z = 12 },
		contents = {
			{ itemId = 11552 }, -- magic crystal
		},
	},
	-- box at 33308,32279,12
	{
		itemId = 2469,
		itemPos = { x = 33308, y = 32279, z = 12 },
		contents = {
			{ itemId = 173 }, -- parchment
		},
	},
	-- stone coffin at 32122,31912,14
	{
		itemId = 1983,
		itemPos = { x = 32122, y = 31912, z = 14 },
		contents = {
			{ itemId = 11546 }, -- spectral cloth
		},
	},
	-- chest at 32549,31437,14
	{
		itemId = 2472,
		itemPos = { x = 32549, y = 31437, z = 14 },
		contents = {
			{ itemId = 9027, count = 1 }, -- crystal of focus
		},
	},
	-- box at 32636,31985,14
	{
		itemId = 2469,
		itemPos = { x = 32636, y = 31985, z = 14 },
		contents = {
			{ itemId = 11549 }, -- old iron
		},
	},
	-- box at 32783,32224,14
	{
		itemId = 2469,
		itemPos = { x = 32783, y = 32224, z = 14 },
		contents = {
			{ itemId = 3028, count = 3 }, -- small diamond
		},
	},
	-- sarcophagus at 33041,32772,14
	{
		itemId = 1994,
		itemPos = { x = 33041, y = 32772, z = 14 },
		contents = {
			{ itemId = 3227 }, -- helmet piece
		},
	},
	-- sarcophagus at 33182,32712,14
	{
		itemId = 1994,
		itemPos = { x = 33182, y = 32712, z = 14 },
		contents = {
			{ itemId = 3224 }, -- right horn
		},
	},
	-- sarcophagus at 33186,33010,14
	{
		itemId = 1994,
		itemPos = { x = 33186, y = 33010, z = 14 },
		contents = {
			{ itemId = 3225 }, -- left horn
		},
	},
	-- sarcophagus at 33349,32825,14
	{
		itemId = 1994,
		itemPos = { x = 33349, y = 32825, z = 14 },
		contents = {
			{ itemId = 3226 }, -- damaged helmet
		},
	},
	-- chest at 33409,32278,14
	{
		itemId = 2472,
		itemPos = { x = 33409, y = 32278, z = 14 },
		contents = {
			{ itemId = 22879 }, -- ferumbras' teddy santa
			{ itemId = 22107 }, -- adventurer's map
			{ itemId = 3043, count = 10 }, -- crystal coin
			{ itemId = 22516, count = 0 }, -- silver token
			{ itemId = 22731 }, -- rift tapestry
			{ itemId = 22737, count = 0 }, -- folded rift carpet
			{ itemId = 22731 }, -- rift tapestry
		},
	},
	-- drawers at 32414,32148,15
	{
		itemId = 2434,
		itemPos = { x = 32414, y = 32148, z = 15 },
		contents = {
			{ itemId = 2969 }, -- silver key
		},
	},
	-- box at 32598,31934,15
	{
		itemId = 2473,
		itemPos = { x = 32598, y = 31934, z = 15 },
		contents = {
			{ itemId = 4834 }, -- family brooch
		},
	},
	-- sarcophagus at 33126,32589,15
	{
		itemId = 1994,
		itemPos = { x = 33126, y = 32589, z = 15 },
		contents = {
			{ itemId = 3222 }, -- helmet ornament
		},
	},
	-- sarcophagus at 33145,32663,15
	{
		itemId = 1994,
		itemPos = { x = 33145, y = 32663, z = 15 },
		contents = {
			{ itemId = 3228 }, -- helmet adornment
		},
	},
	-- sarcophagus at 33174,32932,15
	{
		itemId = 1994,
		itemPos = { x = 33174, y = 32932, z = 15 },
		contents = {
			{ itemId = 3223 }, -- gem holder
		},
	},
}
