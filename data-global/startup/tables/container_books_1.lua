--[[
	Bookcases, shelves and corpses holding a book or a scroll (part 1 of 4) -- 200 containers.

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

MapContainersBooks1 = {
	-- bookcase at 31954,32850,1
	{
		itemId = 2438,
		itemPos = { x = 31954, y = 32850, z = 1 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
The flying Venorean is a ship that is cursed to sail the seas forever. Allowed to visit land only every seven years, the ghostly captain uses his shore leave to lure clueless sailors into his crew. Everybody that signs the contract becomes cursed like the captain and might only leave the ship if he finds a suitable exchange on one of his shore leaves every seven years.]] },
			{ itemId = 2826, -- book
				text = [[
Since sightings have been reported by many respectable seamen the existance of the golden whale can no longer be dismissed as a fairy tale. It is said that this whale is as huge as an isle and its body is made of purest gold. Even though many of the reports were made by seamen in the southern seas sailors of the north also claim to have seen this creature. All over the world the sighting of the golden whale is seen as a good omen. No one has yet been able to even hurt the beast; however, several inventors and mages have come up with ideas for the creation of a weapon that might pierce its golden body.]] },
			{ itemId = 2828, -- book
				text = [[
The Animal Kings
In ancient times the Shattered Isles used to be one huge isle. A peaceful and highly advanced civilisation prospered there. With the help of magic and breeding, they refined the very essence of all creatures on the isle. So even the animals became incredibly healthy and practically perfect beings of their species. They even acquired some intelligence that improved from generation to generation. After a catastrophe that destroyed the whole island, only a few of those animals survived. Over the years, other animals added to these special creatures, and soon only a fraction of the animals still had the attributes of their ancestors.
These noble animals chose one of their kind as their king and with the knowledge of their ancestors they acquired immortality. Nowadays, those animal kings still live at remote places, though some of them might have left the isles for more hospitable areas.
If someone succeeds in catching one of them, he might learn their secret of immortality along with other secrets that were thought to be lost with the destruction of the isle.]] },
			{ itemId = 2827, -- book
				text = [[
The Legend of the Swimming Isle]] },
		},
	},
	-- bookcase at 31954,32851,1
	{
		itemId = 2439,
		itemPos = { x = 31954, y = 32851, z = 1 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Treasure Hunter's Manual]] },
			{ itemId = 2828, -- book
				text = [[
Flags of the World]] },
			{ itemId = 2824, -- book
				text = [[
Nautical Studies]] },
		},
	},
	-- bookcase at 31954,32852,1
	{
		itemId = 2440,
		itemPos = { x = 31954, y = 32852, z = 1 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
A Pirate's Life for You]] },
			{ itemId = 2821, -- book
				text = [[
101 Sailing Songs]] },
			{ itemId = 2827, -- book
				text = [[
Treasures of the Southern Isles

Quite a few pirates hoarded up treasures in the past. It is known that pirates tend to hide their treasures on deserted islands for some unknown reason. They just bury them on some remote place and then forget about them. This similarity to the behaviour of squirrels was never scientifically verified. However, since pirates love to dress lightly they also love the south. Therefore, it is only natural that they hide their treasures there. Some of the southern isles are so popular among pirates that there is hardly any free space left to bury new treasure.

If anyone ever is looking for treasures, then those isles are the best place to start with.]] },
		},
	},
	-- bookcase at 33195,31760,1
	{
		itemId = 2438,
		itemPos = { x = 33195, y = 31760, z = 1 },
		contents = {
			{ itemId = 14176, -- notes and coordinates
				text = [[
Knightly Successor Orders of Tibia, loose pages II

(the book goes on to deal with the orders of the other two Etzels)

Kesar Etzel reportedly fell out with Oberon but kept his connection to Scarlet. Kesar led his loyal group of knights under his own banner, the lion, out of Edron to found his own order. They reportedly went to Darashia after the falling out and established a foothold. Many knights of the order were known to go on pilgrimages to the mystical rock formations known as "Lion's Rock". It is rumored that Kesar believed the mythical lions to hold the key to true chivalric virtue. However, there have not been any pilgrims of the Order of the Lion for many years. (...) Scarlet, leading her own group of loyal knights, submerged and is sometimes connected to a presumably large underground operation known as "Order of the Cobra" or "Cobra Crests"/????"Cobra Unit"???? a rag-tag band of hedge knights and men-at-arms. Their motives remain unknown.

Aside from the sudden disappearance of the Order of the Falcon, it is unclear how long these orders (or remnants thereof) have been active or if they are still operating to this day.]] },
		},
	},
	-- bookcase at 33195,31762,1
	{
		itemId = 2438,
		itemPos = { x = 33195, y = 31762, z = 1 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Knightly Successor Orders of Tibia, loose pages I

An abridged version of a book concerning knightly orders by former knights of King Xenom, father of King Tibianus.

In the first year of the young King's rule, the siblings Oberon, Kesar and Scarlet Etzel fell out with each other. Their quarrel over knighthood under their king and the search for more purpose in their knightly duties drove them far away from Edron. Each of them founded a seclusive order but little is known about their paths during the following years. This book tries to summarise all facts known to Tibian historians as of this day.

(the book goes on about the orders and their founding figures, some specific passages draw your attention)

The leader of the Order of the Falcon (Oberon Etzel) was the first to found his own order. He saw himself and his men as true successors of King Xenom. Dismay over the King's opinions and politics led the dedicated knight to build a new order. On the foundations of law, extreme loyalty and dedication to chivalric virtues, the Order of the Falcon was established, not least as a strong signal in King Xenom's direction. Oberon Etzel's following was devout and dedicated to an extreme. Tolerated by the King at first in honour of the knight's former service, they were soon sidelined and ultimately their decisions were seen as those of of outsiders. Soon, the notion "Trapped Falcons" or "Falcon Cage" (referring to their Edron stronghold) was shaped by nobles and common folk alike. It is widely assumed among historians that these circumstances led to a self-imposed exile by the angered Oberon Etzel.

(the book also contains excerpts from an Edron report of the assumed dissolution and exile of the Order of the Falcon, commissioned by the late king Xenom himself)

(...) Among a multitude of other questions, stemming from the seclusive and secretive nature of the successor order, what makes this case most interesting in historical debates is the seemingly immediate disappearance of Oberon Etzel and his knights. The stronghold was reportedly abandoned over night with no trace of the order itself or any hints concerning their whereabouts. Eyewitnesses confirmed vibrant lights and unnerving sounds originating from the top of the stronghold during many nights. Not many dared venture close enough to the perimeter to catch a glimpse of what really happened there. Reports are varied and inconsistent. Apparently lights were also seen in the night before the one that marked the disappearance of the honourable order. It is worth mentioning that the order hosted several guests and workers almost all the time. Despite their dispute with the king and the other Etzel siblings, the order was generally considered honourable and trust-worthy. No notable suspicions have been raised during the time and until the disappearance there have been no noteworthy incidents. The disappearance seems to be connected to several high ranking officials from various cities which have been reported as missing during or around the time in question. Aside from various personally delivered invitations, no real connections could be made. (...)]] },
			{ itemId = 2828, -- book
				text = [[
A collection of anecdotes about various deities. Strangely, some of them seem to be completely fictitious.]] },
		},
	},
	-- bookcase at 33195,31763,1
	{
		itemId = 2440,
		itemPos = { x = 33195, y = 31763, z = 1 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Various depictions of the end of the world. Read backwards, it makes for an enormously comprehensive genesis.]] },
			{ itemId = 2821, -- book
				text = [[
"An extensive encyclopedia of all manner of creatures roaming the lands of Tibia" Unfortunately it is heavily outdated.]] },
		},
	},
	-- bookcase at 32806,31582,2
	{
		itemId = 2435,
		itemPos = { x = 32806, y = 31582, z = 2 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Be cruel to conquer
Be bold to impress
Be even to pass
Be fearless to kill]] },
		},
	},
	-- pile of bones at 32964,31471,2
	{
		itemId = 4285,
		itemPos = { x = 32964, y = 31471, z = 2 },
		contents = {
			{ itemId = 641, -- piece of paper
				text = [[
<this is a ripped page, probably from a diary>
IV. 3rd
Arthei is not getting better... neither is he getting worse, his state has been the same for the last days. We have established a regular watch plan now during the night so that Kala can get some rest. I have not given up hope, yet, but things are not looking good. It is hard to believe that the poor creature in the bed is my brother. I fear that only a miracle can help him now.

IV. 5th
I cannot put into words yet what happened last night... and neither do I know whether it is good... or evil? I have to think about it...]] },
		},
	},
	-- bamboo shelf at 33326,31085,2
	{
		itemId = 2459,
		itemPos = { x = 33326, y = 31085, z = 2 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Contrary to the claims that have been made, the overall health of the peasants is sufficient. Of course this greedy bunch is complaining about the food rations, but it is not our intention to have fat and lazy subjects. When the regents see it fit, they might reward some of them with extra rations but usually we are rather forced to punish the peasants. The most common transgression is indeed the theft of food. Usually a whole village is punished for that as this will teach them to watch over their own kin more closely. Ungrateful as they are, the peasants often complain about the privileges they enjoyed in the past. It is indeed a sad thing that the regents of old lacked the responsibility to their position and did not work hard enough to further the riches of the realm but wasted resources on the ungrateful and greedy masses. The punishment for spreading such stories is a difficult thing since those who are guilty are mostly old and rather fragile. If they do not survive their well deserved whipping, the peasants are enraged and sometimes attack our officials. I therefore strongly suggest to relocate some of the funding of the army to local forces to keep a closer eye on imminent rebellions.]] },
			{ itemId = 2825, -- book
				text = [[
With the orcish hordes in our lands, many of my colleagues have recalled their troops from the borders and patrol duties to fortify their cities. Only me and a few others still maintain some form of patrols. It seems that due to the lack of resistance, the orcs roam quite freely in our lands. Ironically the calling back of troops seems to have brought the plague into the fortresses. So the reinforcement actually turned into weakening the positions. When the emperor learns about this, I am sure some heads will roll. Without any force to restrict them, hordes of infected peasants flee their villages and spread the plague further. From all what I can tell, the plague has spread everywhere by now and even the fortresses are no longer safe. I think once the orcs retreat, we will have a big task of rebuilding at hand. With the obvious failure of certain governors, I will gain more power and influence. Perhaps I can even convince the emperor to merge some of the bordering provinces with mine.]] },
		},
	},
	-- bookcase at 32390,32825,3
	{
		itemId = 2435,
		itemPos = { x = 32390, y = 32825, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Quara, Curse of the Seas
No one knows where they really come from. It seems the murderous quara are living deep down in the ocean in unknown numbers. From there, they plot their raids on the surface in which they cause havoc and mayhem. The quara consist of several subspecies whose relation to each other is still unknown to men. Given their hostile disposition, it is unlikely that we will ever learn more about them. For most humans it is sufficient to know that a quara means danger. Those who are able to fight them should kill them, those who are too weak should avoid them by all means.]] },
			{ itemId = 2828, -- book
				text = [[
Captain's Log]] },
			{ itemId = 2816, -- book
				text = [[
Nautical Studies]] },
			{ itemId = 2824, -- book
				text = [[
Flags of the World]] },
		},
	},
	-- bookcase at 32391,32825,3
	{
		itemId = 2437,
		itemPos = { x = 32391, y = 32825, z = 3 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The Great Sea Serpents
The Sea Serpent is as huge as a house and can swallow a small ship in one bite. Its scales are almost impenetrable and its teeth, which are as big as a cyclops, are coated with a corrosive poison that will dissolve human flesh on touch. In their undersea lairs they hoard treasures that would make a dragons hoard look miserable. ]] },
			{ itemId = 2816, -- book
				text = [[
The Blades of Darkness
Three pirate kings of old made a pact with the powers of darkness and were rewarded with three dark blades of immense powers. No enemy survived an attack with one of these blades. It is said that they allowed their owners to know whenever other ships where near and that storms and wind could be called with the blades to assist in the evil plots of the pirates.
The end came on the day these pirates decided to betray each other. 
In a sea battle, they called for storms of such intensity that all of
their ships sank. None of the pirates survived, and the blades vanished. 
It is assumed they lie on the ocean floor.]] },
		},
	},
	-- drawers at 32397,32831,3
	{
		itemId = 2433,
		itemPos = { x = 32397, y = 32831, z = 3 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Raiders of the Lost Barge]] },
			{ itemId = 2821, -- book
				text = [[
Logs and Leaks, the Daily Life of a Captain]] },
		},
	},
	-- drawers at 32398,32831,3
	{
		itemId = 2433,
		itemPos = { x = 32398, y = 32831, z = 3 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The Legend of the Swimming Isle]] },
		},
	},
	-- drawers at 32645,31902,3
	{
		itemId = 2433,
		itemPos = { x = 32645, y = 31902, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Dear diary,
my son Kruzak is constantly nagging me to resign as emperor and pass the leadership to him. What does this youngster of a few hundreds years think?
I rather shave my beard then to step back!]] },
		},
	},
	-- stone coffin at 32953,31440,3
	{
		itemId = 1983,
		itemPos = { x = 32953, y = 31440, z = 3 },
		contents = {
			{ itemId = 641, -- piece of paper
				text = [[
<this is a ripped page, probably from a diary>
V. 25th
I'm incredibly tired. Each day we work until the sun sets, trying to farm the land but it seems impossible. I'm sure we all have lost a few pounds. Lersatio even had to disguise himself to sneak back into Yalahar and get some supplies. The water on the island is almost swampy now... the grass is brown almost everywhere.... the trees are losing their leaves... jagged stones have formed from the once green hill. We are not speaking of it often, but I know that my two brothers and I are thinking the same... it's a curse, and it sticks to Arthei.

VI. 2nd
Another week lost. Not much more to say.

VI. 5th
We have made a grave decision. We will deliver Arthei, the land and us from this curse. Tonight this will end. It has to end. It's our brother, but I'm sure that this decision will be the best for all of us.]] },
		},
	},
	-- bookcase at 33097,32521,3
	{
		itemId = 2435,
		itemPos = { x = 33097, y = 32521, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Kha'labal Chronicles I - The Creation of the Kha'labal

Every child knows the sad fate of the Kha'labal. Once it was brimming with life, a verdant paradise filled with lush forests and countless freshwater springs. The gods created this paradise and gave it to their newly-made race, the humans, as a present. Protected on all sides by the sea or by insurpassable mountains, the Kha'labal was the perfect environment for the young, vulnerable race to flourish. And flourish and thrive it did. Guided by their leader Banor and endowed with amazing technical skills and knowledge by their creators, the humans managed to settle the whole Kha'labal within few generations, and beautiful buildings rose to the sky, the mightiest of which were to be found in the majestic city of Ankrahmun. These early humans, who today are called the Founders, were a friendly race who lived in peace and harmony with each other, ignorant of the horrors lurking in the outside world. And the gods, who watched them from their thrones in the Kha'zeel, smiled on them.]] },
		},
	},
	-- bookcase at 33098,32520,3
	{
		itemId = 2435,
		itemPos = { x = 33098, y = 32520, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Kha'labal Chronicles II - Shadows from the North

Sadly, the bliss that marked the humans' early hours was not bound to last. The shadows which in those days held the rest of the world in their cold grip became aware of the humans and of their riches, and soon enough they began to plot the young race's destruction. Ferocious orcs built fleets and started raiding the south-western coastline, while the north was threatened by eerie undead who began to spread their insidious poison among the terrified humans. Worse, the corruption slowly found its way into many of the humans's hearts, and strife and armed conflict erupted within the community. Some humans even fell for the morbid attraction of undeath. They formed an evil cult of necromancers and went to the north to found a city of their own. This city was called Drefia, and it soon became a source of the foulest corruption.

The humans, who were not used to such challenges, were full of sadness and despair, and many cursed the gods who apparently watched their plight in apathy. Little did they understand that all this was part of the gods' plan. It would take the humans a long time to understand that the very purpose of their race was to fight evil, and that their fate was not eternal bliss but endless struggle.]] },
		},
	},
	-- bookcase at 33098,32524,3
	{
		itemId = 2435,
		itemPos = { x = 33098, y = 32524, z = 3 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars I - The Insurrection

For a long time Malor had plotted and schemed in secrecy, using promises and threats to recruit followers and to form alliances. Many djinn refused to betray Gabel, but the majority of the strongest djinn warriors rallied to his cause, and since Malor had been plotting his insurrection for a long time the rebels were well-prepared. When Malor finally gave the signal his minions attacked the palace in full force, planning to kill Gabel swiftly. Their attack was deadly effective, and the palace guards were quickly overwhelmed. However, Gabel, who had received warning about the conspiracy was saved in time by his trusted aide and friend Fa'hradin. He managed to flee in the darkness, and that very night he started to gather his troops in order to take revenge on the usurper. Malor, on the other hand, had to acknowledge that his plan to get rid of Gabel quickly had failed. And he ordered his followers to prepare for a long-term military engagement. Neither he nor Gabel realised then that this was the starting point for a war that would last for eons.]] },
		},
	},
	-- bookcase at 33099,32519,3
	{
		itemId = 2435,
		itemPos = { x = 33099, y = 32519, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Kha'labal Chronicles III - Banor

When no prayer was answered anymore and no sacrifice rewarded it became evident that the gods had indeed left the human race so that it would find a destiny of its own. But they did not leave the humans without guidance. There was Daraman, the gods' chosen prophet, who carefully prepared them for the spiritual and ethical challenges that awaited them in a world full of treachery and evil. And there was Banor, the very first human, a champion of superhuman might and life span, who taught his people how to fight on the battlefield. On his advice the pharaoh of Ankrahmun built a strong army, and it was Banor who designed the plans for Ankrahmun's famous fortifications. And soon enough the new human armies proved themselves in fierce battles against their undead and orcish enemies. Their kind paid heavy prices in these costly battles, but they learnt to accept sacrifices, and it soon become apparent that the human race was here to stay. Eventually only the fearsome djinns posed a real threat to the human race. They defeated the humans in several important battles using their fearsome magic and their skill with the scimitar. However, just when the situation appeared to be most dire Daraman, the revered human prophet, entered the scene and helped to neutralise the djinn threat in a way nobody had foreseen.]] },
		},
	},
	-- bookcase at 33099,32524,3
	{
		itemId = 2436,
		itemPos = { x = 33099, y = 32524, z = 3 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars II - The First Years

The war took a long time to unfold. Both Malor and Gabel tried to win over as many followers as they could, and the need to take a choice war weighed heavily on many a djinn's conscience. Still, few of them managed to remain neutral in this terrible war, and so a deep rift opened within the djnn race. Families were torn apart as children turned against their parents and brother fought brother. Worst of all, it soon turned out that both sides were roughly equal in strength, so that even though a number of vicious battles ensued it become more and more apparent that victory could not be won easily in this war. In fact, it appeared more and more likely that even if one of the sides could win it, it would so be crippled by the endeavour that the very existence of the djinn race would be threatened. Still the war raged on relentlessly. And the mutual hatred between the two fractions, who began to call themselves by the distinct names of Marid and Efreet, increased with every battle that was fought.]] },
		},
	},
	-- bookcase at 33100,32519,3
	{
		itemId = 2436,
		itemPos = { x = 33100, y = 32519, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Kha'labal Chronicles IV - The Exodus

Through the force of his convictions Daraman managed to lead Gabel, the djinn's famous king, onto the path of truth and redemption. It has been insinuated that he acted purposefully to sow the seeds of disunity among the djinn race, but considering his personal integrity this seems unlikely. Whatever his motives, though, Daraman's teachings caused a bitter controversy among the djinns, and eventually a fierce civil war broke out. This did a lot to ease the situation for the humans, but Banor was clear-sighted enough to know that his race would sooner or later get involved into the conflict. It was not hard to work out for him which side to support. Under the influence of Daraman's teachings Gabel, his former enemy, openly propagated peaceful coexistence between humans and djinns. Banor accepted this offer in the name of all humans and formed an alliance with the Marid. It was only logical then that the Alliance fought side by side in the battle of Ankrahmun against the Efreet who had secretly allied with the Drefian necromancers. The victory of the Alliance was overwhelming, but it came with a heavy price. A cataclysmic firestorm unleashed by the Efreet set the whole Kha'labal ablaze, forever turning what used to be a paradise into a barren wasteland. Countless human lives were lost in the magic inferno, and the survivors found that their homes had been destroyed. Faced with a choice of slowly starving to death or leaving their native land forever, a large group of survivors followed Banor on his quest for a new home. Their exodus triggered a chain of events that eventually resulted in the cataclysmic wars of the unliving, but it was also the fateful moment when the humans' slow, but steady conquest of the whole of Tibia started. But that is a different story.]] },
		},
	},
	-- bookcase at 33100,32522,3
	{
		itemId = 2435,
		itemPos = { x = 33100, y = 32522, z = 3 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
The Chronicles of Daraman I

That was the time when Daraman was captured by the djinns while he was fasting and meditating in the desert. They put him in heavy chains and brought him before Gabel's throne. There the old man stood, all haggard and torn, amidst the splendour of the djinns' court. And the djinns started teasing and tormenting the human with a thousand malicious tricks, trying to strike terror in his heart. But frail and crippled though he was, Daraman never so much as flinched under the pain, and his will could not be broken. Finally Malor, who was the most vicious and godless of the djinn, lost his patience and raised his hand to strike the final blow. But lo!, just when his deadly scimitar was about to strike the prisoner down Gabel's voice thundered through the hall, ordering Malor to stop. And though mighty Malor trembled with anger and spite, he did not dare challenge his king's authority.]] },
		},
	},
	-- bookcase at 33100,32524,3
	{
		itemId = 2437,
		itemPos = { x = 33100, y = 32524, z = 3 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars III - The Great Battle, Pt. 1

At last, Malor prepared for a decisive strike. He sent a messenger to Gabel and challenged him to a personal duel. Gabel, who was prepared to do anything to stop the fratricidal war, accepted the challenge. The enemies agreed to meet in the fertile plains of Kha'labal. There they stood, face to face, the old king and the usurper, and so did their armies, because neither of two was gullible or foolish enough to come on his own. It was the greatest gathering of djinns in recorded history.

Eventually Gabel stepped forward to meet his opponent. This was the moment Malor, who had never intended to fight honourably, had been waiting for. All of a sudden the earth opened in a thousand places, and hordes of vicious undead attacked Gabel and his army. For Malor had secretly formed an alliance with the dreaded necromancers of Drefia and it was them who controlled the undead hordes that fought for him. Faced with an overwhelming enemy, Gabel and his army turned to flee.]] },
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars III - The Great Battle, Pt. 2

A number of Marid was caught and slaughtered on the spot, but much to Malor's disappointment the majority of Gabel's troops managed to escape southwards in what appeared to be a well-planned strategic withdrawal. And how much greater was his surprise to find that the Marid fled to the city of Ankrahmun where they appeared were expected! It was then that he realised that Gabel had suspected a ruse all along, and that he had prepared a counterstrategy. Malor immediately ordered his troops to abandon pursuit, but it was too late. The undead marched against Ankrahmun with all the determination of a mindless killing machine, and the Efreet, blinded by rage, did not lag behind, only to be met by ceaseless barrages of arrows and catapult stones. A cataclysmic battle ensued. Wave after wave of undead and Efreet stormed against Ankrahmun, and wave after wave broke at the huge fortifications of the ancient city. Both the Marid and the humans were well-prepared for this battle, and even though Malor's army wreaked havoc they never yielded.]] },
		},
	},
	-- bookcase at 33101,32522,3
	{
		itemId = 2436,
		itemPos = { x = 33101, y = 32522, z = 3 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
The Chronicles of Daraman II

Gabel was curious about the strange human who did not seem to know pain or fear. He approached him and asked him if he did not feel any pain. Daraman answered that the pain of the body was nothing compared to the pain of the soul. So Gabel asked Daraman if he was not afraid. And the prophet said the famous words: "The fear of death is but a trifle compared to the fear of life." So Gabel, who was more and more intrigued by the human, asked him whether he did not care at all about his life? Daraman just looked into the mighty djinn king's eyes, and a brief smile shone on his lips. And after a long pause he spoke thus: "I am an old man and I have but little to lose, mylord. But your race has much to gain, for it lives in darkness." When he said those words many djinns were outraged by the human's apparent lack of respect. And if Gabel had not stopped them the prophet would have been killed on spot.]] },
			{ itemId = 2829, -- book
				text = [[
The Chronicles of Daraman III

And so it came to pass that Gabel, the mighty king of the djinns, took interest in Daraman. Here was something that he, who had seen so many things, could simply not understand, and he was determined to find out more about it. In the beginning he was still convinced that the prophet, like all other humans, was driven by a secret weakness, and he tried to use many other temptations to test the prophet. He clad the old man in silk and offered him a thousand gifts. But Daraman was as unimpressed by the djinns' fabulous wealth as he had been unimpressed by their tortures, and he politely rejected all gifts. And when Gabel finally asked him if he did not appreciate his gifts Daraman answered "Mylord, I am an old man who has little use for pretty baubles. And truly I have never valued a thing that could be bought for gold." It was then that Gabel realised that Daraman was indeed a holy man.]] },
		},
	},
	-- bookcase at 33102,32522,3
	{
		itemId = 2436,
		itemPos = { x = 33102, y = 32522, z = 3 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
The Chronicles of Daraman IV

So it came to pass that Daraman, who had come to the djinns' court, became the king's guest and confidant. And even though many djinns disdained their king's new favourite Gabel increasingly sought Daraman's company. Every day they went to the Gabel's personal garden and talked for many hours. It turned out that Gabel, the mighty djinn king who had been the terror of the world for such a long time, was plagued by a terrible feeling inner void, and Daraman's infinite spiritual strength became a source of joy and of redemption for him. And so, day by day and week by week, their relationship slowly changed from one between prisoner and a king to one between a master and his disciple.]] },
			{ itemId = 2829, -- book
				text = [[
The Chronicles of Daraman V

Gabel told Daraman of the visions and dreams that haunted him and asked Daraman for advice. So Daraman asked him to open up his soul for him to see. And Gabel opened his heart and soul to him. When Daraman had seen deep into Gabel's soul he understood the pain and the confusion that lay hidden deep inside it, and he wept bitter tears of pity for Gabel and for the whole of his race, for he saw that the djinn were a forlorn race that had been cast away by its creator. So full of divine compassion were his tears that they froze into immaculate gemstones of pure blue crystal as soon as they left his eyes. It is said that that springs of clear freshwater sprang forth from the earth wherever one of them hit the ground.]] },
		},
	},
	-- bookcase at 33103,32519,3
	{
		itemId = 2435,
		itemPos = { x = 33103, y = 32519, z = 3 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Legends of the Kha'labal IV - Drefia's Downfall

Many are the legends concerning Gha'Zuul’s cometlike career in the necromancer city. Working with superhuman resolve and ruthlessly exterminating all real or imaginary competition, Gha'Zuul managed to rise to the top of the Drefian hierarchy within a few decades, and when a bizarre accident happened to the president of the High Council, Gha'Zuul took his place. He was the first necromancer to take this position while still being alive. However, being the foremost necromancer was still not enough to satisfy Gha'Zuul’s thirst for power. He had great plans for Drefia. Under his rule the necromancer city would expand and conquer, taking over control of the north and perhaps of the whole of Darama! It was his idea to propose an alliance to the Efreet, and when the decisive battle drew near he personally raised the necromancers' troops to march against the Marid.

The rest is well-known. Drefia's troops suffered a decisive defeat in the battle of Ankrahmun. Those undead who were not destroyed during the futile siege of Ankrahmun were pulverised in the searing heat his own allies had summoned. Gha'Zuul realised soon enough that his career in Drefia was rapidly drawing to an end, for if the Marid did not kill him his fellow necromancers surely would. And so he disappeared...

Today, there are nothing but rumours as to what happened to Gha'Zuul after the failed campaign. However, many believe that Gha'Zuul is still out there, waiting for an opportunity to take revenge just like he used to do when he was still a little nomad boy.]] },
		},
	},
	-- bookcase at 33103,32522,3
	{
		itemId = 2437,
		itemPos = { x = 33103, y = 32522, z = 3 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
Daraman's Chronicles VI

And finally he spoke to Gabel: "Alas! Truly thy race hath suffered! But there is hope, mylord, hope even for your race that has been deserted by its reckless creator!" And he went on to teach him the ways of abjuration and of enlightenment. And Gabel listened and learned, and when he saw the wisdom in Daraman's words he decided to renounce the old ways. And soon many others of his race embraced the holy words and became proselytes of Daraman's creed.]] },
		},
	},
	-- bookcase at 33103,32524,3
	{
		itemId = 2435,
		itemPos = { x = 33103, y = 32524, z = 3 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars III - The Great Battle, Pt. 3

At last even Baa'leal, who led the Efreet in battle, had to admit that the Marid and their despised human allies fought valiantly. However, despite the heavy losses he was determined to decide the war there and now. He summoned the most powerful Efreet wizards and ordered them to unleash a huge column of magic fire onto Ankrahmun in order to render the city and all those in it to cinders. The Efreet wizards' followed his orders and soon a wall of devastating fire rose up to the sky. However, when they tried to move it onto Ankrahmun they soon realised that it did not move into the desired direction. The Marid had soon seen through Baa'leals plan, and Fa'hradin and his fellow Marid mages used their own magic to turn the devastating flames against their creators. A fierce battle of wills ensued between the mages from both sides, and the whole battle came to a halt when the two armies watched in horrified fascination as the terrible pile of flames wandered seemingly undecided to and fro. But then, all of a sudden, the pile made a sudden leap to the north, and within seconds those who had summoned it from the sky were reduced to smouldering ashes. That was the turning point of the great battle.]] },
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars III - The Great Battle, Pt. 4

The fire, now entirely out of control, turned northwards, driven by a gently breeze coming from the south. Its devastating flames fed on plants and animals alike, and as the inferno slowly spread to the north the Kha'labal was scorched and marred forever by the magical flame.

Thus, the great battle was won by the allied armies of the Marid and the humans. However, for the winners there was little left to feel triumphant about. The losses had been great on both sides, and the Kha'labal, that beautiful garden given to the humans by the gods, had been turned into a barren, hostile desert. Also, the destruction cause the fire had allowed many Efreet to escape, so it seemed unlikely that the war would end now. However, for the time being Malor and his troops were much too weak to pose a serious military threat, so Gabel decided to abandon pursue. Instead he ordered that his army should move northwards towards Drefia. It seemed time to settle old scores.]] },
		},
	},
	-- bookcase at 33104,32519,3
	{
		itemId = 2437,
		itemPos = { x = 33104, y = 32519, z = 3 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Legends of the Kha'labal II - The Wailing Bride, Pt. 1

Princess Theripat was the beautiful daughter of pharaoh Karkhaneses II. She grew up in the pharaoh's palace, living a seemingly careless life amidst the proverbial luxury and splendour of the Ankrahmunian court, and when her father arranged for her to marry a well-proven northern nobleman her happiness seemed complete. But things were not quite the way they seemed. Theripat, who was a headstrong and idealistic girl, had always despised life at the court, and with the help of her nurse she had made many forays into the city, concealing her true identity. On one of these excursions she had fallen in love with a handsome officer from the pharaoh's guard. The young man requited the love of what he thought was a simple woman, and eventually the two lovers had even married. When the pharaoh finally decided it was time for his daughter to marry she was already 6 months pregnant, and she knew that soon the truth could no longer be hidden. Frightened and confused, Theripat went through the wedding preparations without saying a word, but when the day had finally come she fled the court. The whole extent of the scandal soon became obvious.]] },
			{ itemId = 2825, -- book
				text = [[
Legends of the Kha'labal II - The Wailing Bride, Pt. 2

Karkhaneses, a ruler who believed that his absolute power depended on the fact that no treachery should ever go unpunished, decided to show no mercy. Both Theripat's nurse and her true husband were arrested and publicly drawn and quartered. Theripat herself had escaped into the desert with her new-born child, but her unforgiving father sent half his army after her. She was found soon enough, but just when the troops were about to arrest her, the unexpected happened. Clinging her baby to her breast, the desperate mother fell into a piercing, bloodcurling wail that quickly expanded into an unearthly sound to which nature itself seemed to respond. All of a sudden a sandstorm erupted, fiercer and stronger than anybody could remember, and within minutes destruction rained down upon the pharaoh's terrified troops. When the storm cleared the soldiers were severely shaken, and many of the pharaoh's best chariots lay shattered in the sand. Theripat and her child, however, were gone forever, and nobody has seen them ever since. But each time the storm rages over the Kha'labal the superstitious people fall into a silent prayer to appease the wailing bride's fury.]] },
			{ itemId = 2825, -- book
				text = [[
Legends of the Kha'labal III - Gha'Zuul the Necromancer

Gha'Zuul grew up a simple boy among one of the northern nomad tribes. A frail and meagre child, he was frequently the target of the other childrens' jeers as well as of his despotic father's scorn. Hurt and angered by the constant humiliations, Gha'Zuul developed a bitter, unforgiving personality. He took notes of all the indignities he suffered, and he was determined to take revenge for every single one of them. One day, when his camp was attacked by an undead raiding party he decided it was time to get his revenge. Taking advantage of the general hullabaloo, Gha'Zuul sneaked up on his worst tormentor and quickly cut his throat. However, he had made a mistake when he thought that his crime would go unnoticed. One of the necromancers who was part of the raiding party sensed the evil of this deed, and since he was impressed by the young boy's obvious ruthlessness he ordered his undead troops to kidnap him. And so Gha'Zuul was brought to Drefia.]] },
		},
	},
	-- bookcase at 33104,32524,3
	{
		itemId = 2436,
		itemPos = { x = 33104, y = 32524, z = 3 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The Djnn Wars IV - Drefia's Fall

After the disastrous battle of Ankrahmun Drefia's necromancers knew the end was near. The Marid would never forgive them their treachery, and this would be a battle the necromancers could not win - after all, many of them had already perished in the battle of Ankrahmun, and their Efreet allies could provide no assistance. So the necromancers prepared for the inevitable with the defiant cynicism of those who have been familiar with death all their lives, performing evil rituals and indulging in morbid orgies.

Finally, the end came swifter than they expected. Unwilling to take any risks in the unpredictable halls and passageways of Drefia's dungeons, the Marid performed a fearsome ritual. The tortured earth underneath Drefia started moving like a giant whirlpool, and slowly the unholy city was pulled inside the maelstrom. Within half an hour it was gone completely, and all but the highest buildings were completely covered by sand and by rubble. None of its inhabitants have ever been seen again, but rumour has it that deep beneath the surface the unholy city is still intact, brooding like a vengeful animal in its prison.]] },
		},
	},
	-- bookcase at 33105,32524,3
	{
		itemId = 2436,
		itemPos = { x = 33105, y = 32524, z = 3 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars V - Fa'hradin's Trick

Even though many djinns had lost their lives during the fateful battle of Ankrahmun, the war was still undecided. Malor had lost many of his bravest warriors, but so had Gabel, and they both knew that another epic battle like that would bring the whole djinn race to the brink of destruction. In his desperation, Gabel turned to his trusted friend Fa'Hradin for advice. The old djinn suggested using a trick to eliminate Malor. Without their leader, he reasoned, the Efreet would end the rebellion. Gabel, who wanted to avoid further bloodshed, agreed. And so it came to pass that the magic lamp was created and, by means that are unknown to this very day, secretly placed in Malor's private chamber. The mighty Efreet never had a chance. When he went to sleep in what he thought was his private lamp he was trapped inside the lamp, which was soon enough smuggled out of Mal'Ouquah, the Efreets' fortress, and brought back to the Marid. Fa'hradin's trick had worked - Malor was Gabel's prisoner.]] },
		},
	},
	-- bookcase at 33106,32521,3
	{
		itemId = 2435,
		itemPos = { x = 33106, y = 32521, z = 3 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Legends of the Kha'labal I - The Hyena King

Deep in the heart of the Kha'labal the dreaded hyena king has its lair. This legendary beast is much larger than any other specimen of its race, surpassing lions and even elephants in size, and it can tear a man apart in seconds with its enormous, razor-sharp teeth. What's more, the hyena king is said to be truly immortal, for it has been sighted time and again by numerous travellers and merchants. Many a caravan is said to have fallen prey to this ferocious beast, and it is widely believed to have amassed untold treasures over the centuries. The legend goes that this beast was once a common hyena that was born in the time when the djinn war was at its peak. Somehow it had managed to escape the cataclysmic firestorm unleashed by the Efreet during the battle of Ankrahmun, and when the slaughter had finally ended it fed from the bodies of the fallen djinns, consuming large amounts of magical energy in the process. Perhaps these magical energies were responsible for the fateful mutation that turned a common hyena into this frightful beast.]] },
		},
	},
	-- bookcase at 33106,32524,3
	{
		itemId = 2436,
		itemPos = { x = 33106, y = 32524, z = 3 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars VI - A War in Suspension

With Malor imprisoned, many Marid hoped that peace would finally come. Gabel immediately contacted the Efreet to let them know their leader was his prisoner, but his hopes that the rebellion would collapse without Malor were disappointed. The Efreet hated their Marid cousins too much to yield, and so the war continued. Nonetheless, both sides tried to avoid open conflicts, so there was next to no combat action for a long, long time. In fact, both the Marid and the Efreet planned to wait until their ranks would be replenished. But the losses they had suffered were great, and the djinns are not a fertile race. Century upon century passed and still their numbers had increased little. And while elsewhere the human race rose to power, building beautiful cities and establishing powerful empires, the djnn lived quiet in their remote fortresses. Malor, however, remained imprisoned in Fa'hradin's lamp, oblivious to the strange land his guardians had taken him.]] },
		},
	},
	-- bookcase at 33107,32524,3
	{
		itemId = 2437,
		itemPos = { x = 33107, y = 32524, z = 3 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars VII - Malor's Liberation

Gabel had decided to hide Fa'hradin's lamp and its powerful prisoner in a forlorn place far to the north because he thought it would be safer there than in Ashta'daramai, his own fortress. Little did he know that these were very the lands where many centuries later a race of goblinoid barbarians called the orcs chose to erect a mighty fortress. One fateful day the lamp was found and brought to the orc king. It did not take the king's shamans long to work out that a mighty spirit was caught in the lamp, and soon enough the reckless king released the mighty djinn that had lain dormant for so many centuries. Little is known about what happened next, but even though to this day the orcs claim their king is still alive there are no credible witnesses who confirm that they have seen the orc king ever since. Malor, however, freely roams the world again, and many scholars agree that he will try every trick in the book to rekindle the fire of the djinn war.]] },
		},
	},
	-- bookcase at 33263,31835,3
	{
		itemId = 2439,
		itemPos = { x = 33263, y = 31835, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Fire Walkers
On one of the isles I witnessed an utmost unusual occurrence.
The natives gathered to some festivity. After some singing, dancing and drinking, 
they started to jump through some of the bonfires. They started screaming insanely and then started to walk over glowing logs of wood. I am wondering if this has something to do with the stuff they are drinking. It would be interesting to see if it can be used to cross lava streams.]] },
		},
	},
	-- bookcase at 33264,31833,3
	{
		itemId = 2440,
		itemPos = { x = 33264, y = 31833, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Heresys of the new age
Some people claim that the soul vortex was not a creation of the gods. They argue that the sheer concept of souls from 'beyond' entering our realm is by all means very random and could not be planed at all. They suggest that it's a lot more likely that the vortex was actually some damage that was caused to the fabric of reality. Through this hole in reality souls that were never meant to be entered our realm and, so they assume, it's additionally a leak that leaches away the power of the gods. They suggest that war for creation was NOT interrupted
because the gods wanted to heal the wounds of the world, but because this powerleak frightened them that much. They further speculate that the withdrawel of the world was more an act of panic, an attempt not to lose complete control over
creation, and the process known as awakening is by no means the working of benevolence, but the gods losing grip of the things they tried to hide away from the intruding souls. The theory goes that as there is an ascension for the souls from beyond to achieve some form of godhood, there is a constant descent for the powers of the gods of old due to the power that is leaking away into nothingness and the power the living claim for their own. Of course this heresys is very popular in the ranks of certain ascension cults. More so since it takes care of the more common fear in those conclaves, that the jealous gods may strike back
on those who try the ascension. ]] },
		},
	},
	-- bookcase at 33264,31837,3
	{
		itemId = 2438,
		itemPos = { x = 33264, y = 31837, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
How to create spellbooks by Muriel.]] },
		},
	},
	-- bookcase at 33264,31838,3
	{
		itemId = 2440,
		itemPos = { x = 33264, y = 31838, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Klabautermen
The klabautermen are a race of impish, mischievous beings that live on ships. 
Using invisibility and other magic, they remain unseen most of the time. But be warned, if you antagonise the klabauterman of a ship, his harmless pranks will turn dangerous.
In general it is a smart move to keep your klabauterman happy with little presents 
and a lot of rum. ]] },
		},
	},
	-- bookcase at 33265,31831,3
	{
		itemId = 2435,
		itemPos = { x = 33265, y = 31831, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
What runes are made of by Muriel.]] },
		},
	},
	-- bookcase at 33266,31836,3
	{
		itemId = 2435,
		itemPos = { x = 33266, y = 31836, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
How to manipulate Runes by Muriel.]] },
		},
	},
	-- bookcase at 33267,31838,3
	{
		itemId = 2436,
		itemPos = { x = 33267, y = 31838, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Puldraks wisdom about orcs
As intensely as the orcs hate all other races, they share a feeling of community. The orcs can sense, to some extent, the feelings of other orcs. The shamans develop this ability to such an extent, that they can sense the innermost potential of newborn orc whelps. All newborn are tested and the shamans decide a future function in orcish society. The whelps are fed differently, raised differently, and educated differently. Wise men of other races say that such behavior is similar to some insects, such as bees, and through their empathetic bond might share a kind of 'hive-mind', so they refer to orc communities as hives. The chief of a hive owns a big harem of women who have no other function than to pleasure him and give birth to new orcs. These orcish matrons are usually incredibly big and fat, almost not able to walk on their own. Where 'normal' orcwomen function as laborer and craftwomen and give birth to two to three orcs in their lives, these female orcs are only reproductive machinery, giving birth to about six whelps each half year. Orcs are usually contend with their place in orcish society and only the leaders fight each other on purpose. Rarely will an orc raise a weapon against another orc, even if they are not of the same hive. Rivalry between hives is usually dissolved through a fight of their leaders and the victorious hive absorbs the other one. Now and then, when a new strong warrior reaches maturity he challenges the old leader for a fight of supremacy. Sometimes though, when the hive becomes too big for the area it occupies, such a warrior senses somehow that its time to move on. Then he and a few other orcs leave the hive in peace to settle somewhere else. This unique culture, together with its fertility, makes the orcs the most formidable threat to all other tibian communities.]] },
		},
	},
	-- bookcase at 33268,31830,3
	{
		itemId = 2436,
		itemPos = { x = 33268, y = 31830, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Puldraks wisdom about elves Pt. 3
The Teshial were never fighters. They retreated in the early days of war to hidden refuges, not as a whole caste but only in small family groups. Their hideouts were additionally protected by strong illusionary magic and offered them peace from the madness around them. These elves developed due to meditation and a special philosophy in the art of dream magic, dramatically enhancing their initial abilities in the decades. So they began to exist almost permanently in a state of dreams, only rarely appearing now and then amidst the other elves to give them advice and try to convince some of them to join their way of life. As the war grew more and more fierce these visits became less and less frequent until they were almost a myth, even for elvenkind. In the new awakening of the world they were some of the first to appear, apparently far less disoriented then other beings. Many races welcomed their help, but their teachings seldom found dedicated listeners. After they taught a part of their secrets to some humans they found worthy, they had to see their pupils tortured by developments they judged themselves guilty of.  Also, other elves put pressure on the humans to give up the secrets of dreams.  They withdrew from the world of mortals and it is rumored they have physically entered the realm of dreams. 
The Teshial are 'typical' in appearance for elves, but they could create the illusion of almost any appearance if they so choose. Some people even say that due to their enormous control of dreams they could shape their children as they wish, giving them human or even orcish appearance. On the other hand, even people who come up with such theories go silent when asked why an elf should choose to have a child that looks that way.]] },
		},
	},
	-- bookcase at 33269,31830,3
	{
		itemId = 2437,
		itemPos = { x = 33269, y = 31830, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Ferumbras Files

The followers of Ferumbras believe that in his early career, the ambitious Ferumbras acquired access to the shrouded library of Zathroth. They disagree, however, in the details on how exactly the vile Magician managed to do this. While some claim he was the favoured of Zathroth, others argue that he breached the library's defenses and somehow stole a part of the knowledge. Even in this the specifics are debated. An intriguing variant claims, Ferumbras once was the head librarian of the shrouded hoard. Once a kind and caring man, he became more and more obsessed with the knowledge in his care and the insights he gained turned him cynical and jaded. At some point his ambitions and power became too dangerous and he was expelled from the library. The most outlandish tales even make him a physical manifestation of forbidden knowledge. The story goes that Zathroth, who obsessively accumulated knowledge, did not care about it's containment. The knowledge was powerful though that mere books could not keep it and it seeped into the library, absorbed more and more forbidden knowledge until it became sentient and created itself a physical vessel that fled the library, later becoming known as Ferumbras. Based on the the few sources available, sages of that topic suggest that Ferumbras was the descendant of a member of the brotherhood of bones that fled and got into hiding after their forces suffered a major defeat. Ferumbras was supposedly raised in secrecy and taught in the ways and secrets of the brotherhood. Since this would not explain his immense power in one way or the other, Zathroth's library seems an all too easy and convenient explanation for his stellar rise to power. Others attribute this to his bloodline, which included the likes of Goshnar and dates back to the first magician kings of Ankrahmun who unified their people against the lizard threat.]] },
		},
	},
	-- bookcase at 33270,31836,3
	{
		itemId = 2437,
		itemPos = { x = 33270, y = 31836, z = 3 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Puldraks wisdom about minotaurs Pt. 3
To become an educated warrior-philosopher became the goal of all minotaurkind. Uncontrolled rage was considered to be primitive from then on. A minotaurian warrior is skilled as an artist, often found conentrated drawing, reciting or creating poems and wielding a weapon with awarenes and cold hearted skill. The warriors of the uppermost class are usually so well educated they control some amount of magic, often used to augment their own strength and defense. They are the heroes and role models of the lower class. The minotaurs still have a warrior culture, but the understanding of a true warrior has changed dramatically. 
Minotaur cheese is a specialty, often envied by decadent human nobles. ]] },
		},
	},
	-- bookcase at 33372,31337,3
	{
		itemId = 17872,
		itemPos = { x = 33372, y = 31337, z = 3 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Knightly Successor Orders of Tibia, loose pages I

An abridged version of a book concerning knightly orders by former knights of King Xenom, father of King Tibianus.

In the first year of the young King's rule, the siblings Oberon, Kesar and Scarlet Etzel fell out with each other. Their quarrel over knighthood under their king and the search for more purpose in their knightly duties drove them far away from Edron. Each of them founded a seclusive order but little is known about their paths during the following years. This book tries to summarise all facts known to Tibian historians as of this day.

(the book goes on about the orders and their founding figures, some specific passages draw your attention)

The leader of the Order of the Falcon (Oberon Etzel) was the first to found his own order. He saw himself and his men as true successors of King Xenom. Dismay over the King's opinions and politics led the dedicated knight to build a new order. On the foundations of law, extreme loyalty and dedication to chivalric virtues, the Order of the Falcon was established, not least as a strong signal in King Xenom's direction. Oberon Etzel's following was devout and dedicated to an extreme. Tolerated by the King at first in honour of the knight's former service, they were soon sidelined and ultimately their decisions were seen as those of of outsiders. Soon, the notion "Trapped Falcons" or "Falcon Cage" (referring to their Edron stronghold) was shaped by nobles and common folk alike. It is widely assumed among historians that these circumstances led to a self-imposed exile by the angered Oberon Etzel.

(the book also contains excerpts from an Edron report of the assumed dissolution and exile of the Order of the Falcon, commissioned by the late king Xenom himself)

(...) Among a multitude of other questions, stemming from the seclusive and secretive nature of the successor order, what makes this case most interesting in historical debates is the seemingly immediate disappearance of Oberon Etzel and his knights. The stronghold was reportedly abandoned over night with no trace of the order itself or any hints concerning their whereabouts. Eyewitnesses confirmed vibrant lights and unnerving sounds originating from the top of the stronghold during many nights. Not many dared venture close enough to the perimeter to catch a glimpse of what really happened there. Reports are varied and inconsistent. Apparently lights were also seen in the night before the one that marked the disappearance of the honourable order. It is worth mentioning that the order hosted several guests and workers almost all the time. Despite their dispute with the king and the other Etzel siblings, the order was generally considered honourable and trust-worthy. No notable suspicions have been raised during the time and until the disappearance there have been no noteworthy incidents. The disappearance seems to be connected to several high ranking officials from various cities which have been reported as missing during or around the time in question. Aside from various personally delivered invitations, no real connections could be made. (...)]] },
		},
	},
	-- bookcase at 32062,31889,4
	{
		itemId = 2437,
		itemPos = { x = 32062, y = 31889, z = 4 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Orcs ARE intelligent. Though some dwarves mumble about a shared hivemind of the greenskins, there is no evidence for that. Orcs have speech and are capable to learn other humanoids language quite well ... if they want, what almost never is the case. They lack a written language though. Some of the more educated orcs use human letters to write down orcish texts. Its rumored that the orcs we encounter now and then are just barbarians of their own kind and that there is a more 'civilized' orcish culture somewhere. There are some clues that the orcs indeed had a written language, but the modern orcs is unable to read it as we are.]] },
		},
	},
	-- bamboo shelf at 32068,31898,4
	{
		itemId = 2460,
		itemPos = { x = 32068, y = 31898, z = 4 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
V. ii, The Age of Chaos

The elder gods watched as the cataclysmic battle went on. They felt no pity for those that were slain because they cared little for Zathroth's creatures, but they knew that something was missing, that somebody was needed to take care of the bodies and souls of those who ceased to live. They began to look for a solution, and finally Uman proposed that a new god should be created, a god who should see to it that the dead would be taken care of. They decided that earth, which in a way was the giver of life, should have a part in taking it back, and that Uman should be the newly created god's father. But alas! The elder gods were not as cautious as they should have been, and so Zathroth the Destroyer learnt about their plans all too soon. He was fascinated by the idea of death from the start, because he saw in it a new chance to bring further havoc and destruction into the world. Soon he had devised a vicious plan. He posed as his good half Uman to fool earth, and with it he sired another god: Urgith the Master of the Undead. This hideous deity was devoted to death just like the god Uman and Fardos had in mind, but he was not the benign guardian of the dead they had envisioned. Instead, Urgith was a cruel god who strove to infuse the bodies of the dead with unholy energy, dooming them to a state that was neither life nor death. Thus, the hour of Urgith's birth marked the beginning of undeath.

Soon enough innumerable undead roamed the world. After all, Tibia was still covered by countless bodies of slain orcs, cyclopes and other creatures - the legacy of the many years of ceaseless war. These cadavers provided Urgith with the ideal recruitment pool, and he eagerly transformed all carcasses he could lay his hands into his gruesome servants. The gods watched in horror as a new scourge ravaged their beloved creation. They hurried to finally put their own initial plan into practice, and Uman united with earth in order to sire Toth the Warden of the Souls. It was to be his mission to safely guide the souls of the dead to the otherworld, where they would safely rest in the peace of an eternal dreamless slumber, while the worms, his faithful servants, swarmed out to devour their bodies that scattered the face of Tibia. But the damage had been done, and even though Toth and his servants did the best they could Urgith's ghastly creations continued to roam the land. All the other creatures, who were already greatly weakened by their endless wars, could put up little resistance to the new enemy who increased in strength with every loss they suffered. It looked as if Tibia was forever doomed to be a world that was inhabited by the living dead.

The elder gods looked at what had happened to their world, and their hearts filled with sorrow and resentment. They knew that if they did not act now Tibia would be destined to become a grave, and so they started looking for a solution. Eventually they agreed to try to create a sentient race of their own, a race that would be strong enough to take up the fight against the hordes that ravaged their beloved world. And so they created a race and sent it into Tibia. But alas! Urgith's minions were too strong. Their race was defeated within a generation, and it was wiped from the face of Tibia. So Uman and Fardos created race after race, and race after race was overwhelmed by the vicious abominations that Urgith had released into the world. Most of these races disappeared from the face of Tibia forever, leaving little but melancholy legends and mysterious ruins. Today, this sad era which is commonly known as the Corpse War is largely shrouded in mystery, and the unfortunate races that were destroyed in it are now referred to as the ancients.]] },
			{ itemId = 2830, -- book
				text = [[
The Shattered Isles

Nargor is a hostile rock surrounded by treacherous reefs. Since it is uninhabitable and almost unreachable it is of no interest.

Treasure Island is not only desert-like but also quite deserted. The only people you meet are treasure hunters that travel there occasionally to try their luck.

The inhabitants of the town Liberty Bay live on the numerous plantations. The town has developed into a major trading center in recent years, and is under Thaian rule.

The Forbidden Islands to the north-west are dangerous not only because of the volcanoes that are found there but also due to frequent quara activity. Since there is no real reason to visit these islands, no regular shipping route was ever established.

The Laguna Islands are quite often visited by passing ships to refresh their supply of water and food. Still the isles are too desolate to establish a settlement there. It is rumored that a small tribe of savages calls one of the isles its home.]] },
		},
	},
	-- bookcase at 32069,31889,4
	{
		itemId = 2436,
		itemPos = { x = 32069, y = 31889, z = 4 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Tactics for close-ranged combat
- Use the terrain to your advantage: always know the way to the nearest ropespot, and make sure you are not surrounded by enemies - that can be a death trap!
- Use narrow passages to make sure not more than one enemy at a time can sneak up.
- Avoid being close to more than two enemies at once if you can, because you can only block two at a time.
- Be careful while chasing an enemy: you might run into his allies or other monsters.
- Target the closest enemy, or you'll become confused and might not be able to defend yourself against other attacks.
- Different enemies require different tactics. While some are best to be fought in an agressive combat mode to finish them off quickly, you might want to defend yourself more against others. Choosing between your combat modes also depends on your equipment - play your strengths!]] },
			{ itemId = 2826, -- book
				text = [[
The Tibian Wonders of the World!
The known and acknowledged wonders of the world are:
The colossus of Kazordoon
The black pyramid of Dracoria
The great lighthouse tree of Ab'dendriel
The thorntower of Shadowthorn
The underground city of Mintwallin
The black city of skulls in Hellsgate
The great lava falls in Hellsgate
The pyramid city of Ankrahmun]] },
		},
	},
	-- bamboo shelf at 32075,31894,4
	{
		itemId = 2459,
		itemPos = { x = 32075, y = 31894, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
My travels.

As the orcs approached I've hidden myself in the bushes near the lake. I did hardly dare to breath as they met only some inches from my nose. I thought my wild beating heart might betray me to this murderous beasts. I overheared the greenskined brutes. 'charach' (or so) one said and the other responded the same way, then they began to chat in their strange language, certainly talking about some gruesome plot against mankind. Talking they wandered away and after they vanished from my view I quickly got up and headed to Thais as fast as I could.]] },
			{ itemId = 2826, -- book
				text = [[
Tibiantis: Fact and Fiction

In the light of progress made my modern science the tales of Tibiantis can be cheerfully disregarded as blatant myths. The author of this questionable history merely drew upon several myths and mixed them together to create a tale plausible to those given to believe such romantic nonsense. The recently discovered, or more accurately, recently rediscovered, city of Yalahar is very obviously a major inspiration for the story of Tibiantis. Aspects of the story can be found in actual fact in Yalahar - the city itself is huge, and also extended its borders beyond the land into the sea, and judging from what can be found there, was most definitely at some point in its past a city that was home to great wonders, whose inhabitants were in possession of great knowledge. However, one of the great mysteries of Yalahar is whether in actual fact those that live there are even human or another race, until recently unknown amongst the Tibian civilisations. The aspect of the story of Tibiantis referring to the downfall of a civilisation could be influenced by many different myths. One such source could be based upon the discoveries made far to the North of Tibia which suggest the possibility of a civilisation that was wiped out by an as yet unknown catastrophe of cataclysmic proportions. Equally, to the extreme south of Tibia can be found the Shattered Isles. These Isles were so named with good reason - geological studies conducted by the Explorers' Society reveal that these isles did not so much sink but were blasted by a phenomenal explosion of some kind. Relics found upon the Isles also hint that they were once populated by a great and most likely advanced civilisation. It is the sad fate of these isles to be the home of the infamous Quara. It is these twisted creatures who probably provide the origin of the myth's fish people. In summary, I believe I have gathered enough proof here to dispell any reason for believing the tale of Tibiantis, and have proven it to be nothing but a conglomeration of ancient stories and legends which an overly ambitious and half informed so-called historian has put together into a new myth of his own making, in order to gain cheap fame by hoodwinking a gullible and uninformed public.]] },
			{ itemId = 2831, -- book
				text = [[
You can not even imagine how old I am. In your wildest dreams you won't see the things I have seen. I am the last of my race and even though I am several centuries old I am not immortal and will eventually die. I fear that day. Not for me - I am weary and I don't care much about if I'm alive or dead. But I fear for all these memories that will die with me. For all those who no one will remember anymore.
Words can't truly preserve their essence so I will leave no books or stone tablets. If I die, everything I have witnessed will die with me as if it has never existed. I was there when Rorak slew Tingil at the stairs of the seven temples. I was there as Riik led his peaceloving people to the far north to find refuge from the war. I was there to witness the betrayal of Asric for the whims of a female that was long dead by then. I fought with the last Frdai a futile battle on the plains of Weskurt against the unseen legion. I witnessed Ss'rar making his move on ascension to become the serpent god. I watched the first elves struggling to form a nation with the help of the lightbearers. It was me who assisted the great calculator to assemble the bonelords language. And you come here to this mountain and ask me how to win the heart of some shepherdess? This world has become a ridiculous mockery.]] },
			{ itemId = 2829, -- book
				text = [[
The Lighthouse in the Middle of Nowhere
Sailors claim to have travelled as far as the end of the world where the water pours down into nothingness. Although it is easily recognizable during daylight it poses a special threat at night. To make matters worse, a spooky lighthouse sometimes appears out of nowhere to lure ships over the edge of the world. Whether it is really a lighthouse or some other source of light differs from story to story and remains to be determined.]] },
		},
	},
	-- bookcase at 32625,31915,4
	{
		itemId = 2435,
		itemPos = { x = 32625, y = 31915, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
I, GHOUL
By Himhor

Within this obscure essay lies a remarkable study of a dwarf who poses as a ghoul to view what life is like from the Ghoulish point of view. A particular emphasis of the work is the fascinating ghoulish healing habits, which the author presumes to be, unlike many warriors thinks nowadays, an effective romantic ritual which ghouls aims to the creatures they do found appealing somehow.]] },
			{ itemId = 2816, -- book
				text = [[
Dwarven guide to warfare
Lesson VI

Luring elves with carrots has proven to be an ineffective tactic.]] },
		},
	},
	-- bookcase at 32625,31921,4
	{
		itemId = 2435,
		itemPos = { x = 32625, y = 31921, z = 4 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The Shiron'Fal is an organization that seems to predate the dawn of mankind. A time of constant strife and warfare gave birth to a fledgling organisation of dishevelled but powerful individuals. The original purpose of this pact was probably as mundane as pooling resources for survival but it soon became something more meaningful and sinister. The first members seem to have been some of the last remnants of their race that perished in the god wars. Each of them brought a unique set of skills and talents that quickly added up in power. With the imminent danger of annihilation averted, the group soon consolidated it's power and reasserted their goals. They were probably genuinely surprised by the success their alliance has had and began to hunger for more. Inspired by the synergy their diversity created, they began to look for individuals of power that could provide something beneficial to the group. Over the centuries the scope of their ambitions broadened. They began not only to acquire new members but also powerful artifacts and minions. All the while they operated in the shadows. Making their hidden moves, manipulating people and events, taking whatever they needed to increase their power. Their agents travelled the world in many forms and disguises, looking for relics and recruits. If a target was identified, a powerful member of the Shiron'Fal made its move with deadly efficiency. What could not be taken by guile was taken by force. For the most parts of history, though, the organisation seemed more like a sleeping giant. Waking up now and then, making some devastating moves, only to vanish into obscurity once again. During the last centuries the actions of the pact have become more consistent and frequent. Why there was this increase in activity is yet to be determined. What can be said, however, is that their process of recruitment has been broadened and now also aims at the most powerful specimens of certain races or supernatural beings. Sometimes the organisation has plotted to pit such individuals against perilous odds to determine their worth.
In the most recent history they can be made responsible for events like the discovery of several powerful vampires and the rise of werekin activity on Feyrist. A more personal action of the legion was the presence of one of their members in Rathelton, seeking for an object of power and the attempt to subvert the elven courts of summer and winter to free and recruit or enslave the nightmare beast that was bound by them.
The ancient term Shiron'Fal roughly translates in something along the lines of "dread legion" or "army of the last days". More literal the words translate into "numerous, military organisation" and vaguely describe a special time of reckoning. This might give a hint of their ultimate purpose. Some assume all their efforts are aimed at a final battle for all of creation. Others think it rather hints at the ultimate goal to conquer or destroy everything as soon as they accumulated enough power. Some even claim a renewal of the god wars is their ultimate goal.
Yet most about the Shiron'Fal is shrouded in mystery. Even the most basic information like a base of operation, the number of members or even the names from more than a few of them are unknown. Not even the structure of organisation is apparent, although there are strong hints that an enigmatic single entity is in lead of the legion.]] },
		},
	},
	-- bookcase at 32626,31915,4
	{
		itemId = 2436,
		itemPos = { x = 32626, y = 31915, z = 4 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The Bonelord Threat I
Once in the olden days, the bonelords numbered among the most powerful races of the world. Their mighty cities, which characteristically contained ominous dark pyramids, could be found all over the world. The bonelords erected them using the same innate form of telekinesis which lets their bodies float in the air. However, they could not do completely without hands and arms that did their bidding. For this reason they relied on another innate power of their race - the dark power of necromancy. Thanks to the magical abilities of their tentacles, which are capable of producing various powerful kinds of magic to an extent that is denied to other races unless they study for many decades, the bonelords also knew how to command the dead. As a result, they used a monstrous strategy: Whenever they conquered an area they turned their unfortunate victims into undead slaves. Using these undead legions as their shock troops, the bonelords went from victory to victory. They built a huge fortress that served as their power base, and from there they went to conquer the world.]] },
		},
	},
	-- bookcase at 32626,31918,4
	{
		itemId = 2435,
		itemPos = { x = 32626, y = 31918, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The art of peace]] },
		},
	},
	-- bookcase at 32626,31921,4
	{
		itemId = 2436,
		itemPos = { x = 32626, y = 31921, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Dwarven guide to warfare
Lesson III

Dragon scales make up for good armor and protection. Unless the dragon is still alive!]] },
		},
	},
	-- bookcase at 32626,31924,4
	{
		itemId = 2435,
		itemPos = { x = 32626, y = 31924, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Miners Journal (title)

We've dug that deep, that even we dwarves can hardly see. Fruzek told us stories of a monster making odd sounds from below the earth.These frightening tales of the basilisk have halted our mining schedule, forcing us to double the guards protecting the miners.

A Tired Miner
Melc]] },
		},
	},
	-- bookcase at 32627,31915,4
	{
		itemId = 2437,
		itemPos = { x = 32627, y = 31915, z = 4 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
Vampire Hunter's Handbook II
Vampires can be immobilised, also for a very long time, if the right method is used. If their physical body takes too much damage, it will go down. Sunlight will dry them out and even turn them into dust. If you drive a wooden object into the heart of a vampire, the flow of the vampire's tainted blood is stopped, leaving him completely helpless. It should be mentioned, though, that if the heart is partly missed or if the object is not large enough, the vampire might still be able to move.
Since a vampire is dead anyway, none of these methods allows to destroy a vampire for good. With enough time and blood, a vampire can recover from any of those seeming deaths. The only known way to permanently defeat a vampire is to kill him with a blessed stake. A blessed stake, however, is a rare object that cannot be obtained easily.]] },
		},
	},
	-- bookcase at 32627,31918,4
	{
		itemId = 2436,
		itemPos = { x = 32627, y = 31918, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The great book of firemagic]] },
			{ itemId = 2816, -- book
				text = [[
The great book of earthmagic]] },
		},
	},
	-- bookcase at 32627,31921,4
	{
		itemId = 2437,
		itemPos = { x = 32627, y = 31921, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
(most pages of that book are unreadable, stained with blood and parts are burned)
Horrible screams ..blinding light....pain...happening???....No one ....The light ...closer.....brighter...no visibility....Farewell...]] },
			{ itemId = 2816, -- book
				text = [[
Dwarven guide to warfare
Lesson V

Boats are malevolent.]] },
		},
	},
	-- bookcase at 32627,31924,4
	{
		itemId = 2436,
		itemPos = { x = 32627, y = 31924, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Brighteyes Legend
By: Damius Weirgroth

Long ago, long before the lands of Tibia were known by this name a dwarven fellowship was founded, holding a destiny of fame, power and tragedy. These Individuals were known as the brighteye fellowship. Those who crossed them or did something to anger them never saw the light of day. It is said when enraged these dwarve's eyes grew in light that could be seen a towns distance away and they went into a bezerk frenzy killing all that opposed them. Loosing all control and compassion in that frenzy they became unbearable even to the fellowsships of the savage axes and the dragoneaters. So after great debates between the fellowships they left Kazordoon and the big old one for unknown new lands. Though some setteled at remote spots on the continent the trail of the others was lost. They are considered the lost fellowship in theese days and no britghteye was born since then in the halls of Kazordoon.]] },
		},
	},
	-- bookcase at 32628,31915,4
	{
		itemId = 2435,
		itemPos = { x = 32628, y = 31915, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Technomacers, heretics or geniusses?]] },
		},
	},
	-- bookcase at 32628,31918,4
	{
		itemId = 2437,
		itemPos = { x = 32628, y = 31918, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Dwarven report VII
Enemy magic

Our elemantarists have successfully unrevealed the the secrets of what is called "dream magic". It is a subconscious way of influencing the surroundings. It is mainly used by elven parents that want to shape their unborn child, but, this is the far more important threat, some elves, especially those called "Teshial" posess the ability to wander some kind of "dream realm" instead of the real world. This gives them the oppurtunity to appear somewhere out of the blue, but, fortunately, the Teshial never used this skill to ambush, and the other elves posess only small remnants of this magic.
Never the less, the 2nd earthen chamber is evolving a counter spell for that, that increases the elemental signature of beings near, forcing them into the real realm.

The other kinds of their magics are limited to protective and growing spells, whicht yet do not prove any harm, but are very supportive for their strife. It is rumored that they have also a lot of illusionary and concealing spells, but investigations here have not yet led to final results, as well as we can only deny the existance of aggressive magic by an elven race od caste od unknown origin.

For further information refer to sub-report AX-27.]] },
		},
	},
	-- bookcase at 32628,31924,4
	{
		itemId = 2437,
		itemPos = { x = 32628, y = 31924, z = 4 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Magnor Mournbringer was more a mystic and philosopher than a knight. It is said he was forced into knighthood by his father, albeit himself aspiring to become a sorcerer. He was more a man of the books than of the sword, more often found in the study then on a jousting field. He was permanently banished from tournaments for the usage of alchemical concoctions. Still obligated to fight in battles on behalf of his king he relied more on sorcery then on his physical prowess. He enchanted and inscribed first his armour and weapons, later even his own body. He enhanced his skill and fortitude through powerful potions and brought his enemies down with runes and spells. The other knights shunned him but the 'witch-knight', as they called him, had his uses for the king. Giving little for chivalrous staples and being very pragmatic, the witch-knight was the one that the king called upon, when a dirty deed had to be done, something sinister to be accomplished. As times were dark and dire, the call for his skill was frequent. His fame and notoriety grew. On the height of his might and favour of the king he was nigh untouchable, reigning freely in his realm. Dubious visitors from all corners of the world frequented him. Rumours grew even more then his legend. When his patron, the king surprisingly died and not his sickly child was crowned but his pious cousin was made regent of the realm, his enemies made their complaints heard loudly. Soon the inquisition investigated in the case and it came to a direct confrontation when they tried to size Magnor's vast library for examination. Blows were traded and in the end the keep of Magnor was besieged by the regents army. With no other way to escape, the witch-knight summoned winged demons to carry him into safety. But the priests, accompanying the army, banished the creatures and Magnor fell to his death. When the regency ended and the king's son became ruler, Magnors honor was reinstated to some extent in memory of the dead king that cherished him. So he was given a proper funeral.]] },
		},
	},
	-- bookcase at 32629,31915,4
	{
		itemId = 2436,
		itemPos = { x = 32629, y = 31915, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Hammerfalls tales of 1001 wife]] },
		},
	},
	-- bookcase at 32629,31921,4
	{
		itemId = 2435,
		itemPos = { x = 32629, y = 31921, z = 4 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The principle of opening a gate for a demonic army is the same as summoning a demon. You need to accumulate some critical mass of synergistic energy and open a rift between the worlds. The needed ingredients consist of some of the negative energy that is similar to the essence of the demonic realm. The first part of the summoning ritual opens only a small rift to the demonic realm. Through this rift demonic energy enters into our world infiltrating into the ingredients and filling them with more power. With stronger ingredients, the ritual opens a larger rift this time, letting more demonic energy in to strengthen the ingredients. This ritual is repeated over and over again until the ingredients are strong enough to open a portal through which the demons can pass. This ritual can also be initiated from the demon side. Sightings of Orshabaal and similar entities clearly show all characteristics common for such rituals. Once the gate is open, demonic minions appear and boost the negative energy of the place by their sheer presence. Later, the demonic master is following. His appearance causes a drop of the negative energy as the demon lord is feeding on it to sustain his existence in our realm. As long as there are enough minions to boost the negative energy of a place, demons can exist for a very long time in our realm. So in theory, it would also be possible that the gate between the two realms is kept open, allowing more and more demons to enter our world that can easily form a demonic army causing mayhem and havoc. The archdemon Shervad the Destroyer wore an armor made of an unknown material that allowed him to stay in our realm for at least three centuries. In his last battle, he lost his strength, even though he was not physically hurt - his enemies had destroyed his armor. It is said that the armor was made by some ore found in the old mines.]] },
		},
	},
	-- bookcase at 32630,31915,4
	{
		itemId = 2437,
		itemPos = { x = 32630, y = 31915, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Extended Vision

Most dwarves have a excellent eyesight even in dark enviroments but this spell will one day allow you to see nearly twice as far as you currently do. What's needed is the fire of a fire element, the head of a ghoul,the essence of a red royal blossom, some water from Blood Bay and the laugh of a mute sinner. Light a fire with the flame of the fire element. Pour the water from Blood Bay into a cauldron and place it over the fire. Throw in the head of the ghoul and the essence of the red royal Blossom and mix it untill a grey myst emerges. Take some of the potion and mix it with the laugh while cooling it. Now we only need to find out the missing catalysts and the magic words to imbue it with energy.]] },
		},
	},
	-- bookcase at 32630,31918,4
	{
		itemId = 2435,
		itemPos = { x = 32630, y = 31918, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Dwarven report XII
Enemy territory and settlements

Our scouts recently discovered a great number of elven hideouts within the "deeper woodlands". They also have a great city, comparable to a capital, there, which is called Ab'Dendriel, and is mainly inhabitated by Deraisim and Cenath. The defenses are rather weak, and it seems like a lot of nomads and wanderers pass through the region.

We also found ruins within the hidden mystic valley, the structure of the buildings is typically elven. The ruins seem to be the result of a harsh thunderstorm of magic, but it was too long ago for us to find closer traces.

More interesting should be the fact, that the volcanic regions beyond the thundery mountains seem to be colonised by the elves as well. There dwells a race called Kuridai, and they seem to be the most aggressive and militant elves we encountered yet.

Suggestions about possible assault targets if war will be at hand are envoiced in sub-report EY-01.]] },
		},
	},
	-- bookcase at 32630,31921,4
	{
		itemId = 2436,
		itemPos = { x = 32630, y = 31921, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Elves by Iregarn Pt. 1
The elves are able to manipulate their unborn children by some kind of dream magic. This magic changes appearance and personality slightly, allowing elven parents to give birth to 'wish-kids'. In their shared dreams the elven parents seem to sculpture their child like a piece of art. Though most of the dream magic of the past is long forgotten, this rudimentary magic seems to be natural to the elves. It is possible to 'choose' things like hair or eye color and even gender. Even slight changes of the physique are possible, though considerable changes take place in the span of generations. Wise men assume this ability was a 'gift' of the gods to make more adaptable tools for the elves' war. But the mentality of the elves did not allow them to form their children in a 'convenient' way. Since most of this magic is instinctual, they form their children in an aesthetic way. On the other hand, what is seen as aesthetic is based on the philosophy of the parents and so their background changes this view dramatically. This is even more evident in the castes that were separated in the war.]] },
		},
	},
	-- bookcase at 32630,31924,4
	{
		itemId = 2435,
		itemPos = { x = 32630, y = 31924, z = 4 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The Rise of the Pumpkin
After many wars and always new threats by the forces of darkness, humanity was afraid of many things. It was no cowardice but a gnawing fear that slowly eroded courage and faith. The servants of evil seemed to appear everywhere and in many horrible forms. Humans had grown accustomed to be afraid of the dark and the unknown. This weakened their resolve and with that also the forces of good. The gods came together to find a way to rise the spirit of humanity once again. They discussed and debated but could not come to an agreement because their views were too contrasting. And while they still deliberated, suddenly one of their least and minor creations stood amongst them. It was the lord of the rabbit race who had passed unnoticed by the mighty guardians. Without fear the little rabbit faced the gods who looked upon him in astonishment. Then the lord of the rabbits proposed his idea to the mighty and great gods. Since rabbits are tiny and their enemies are many, they are quite familiar with fear and how to handle it. So the lord of the rabbits came up with the idea to have the humans overcome their fear by learning to laugh in the face of evil. The gods were amazed by this simple but clever idea. So they chose the mightiest warrior of the rabbit race and bestowed magical powers upon him. The daring hare gained the protection of the gods and the power to disguise humans with hideous appearances of monsters. Each year, the hare would appear for some time and do his work. So the humans learnt to laugh and had fun while appearing as monsters, and the great fear that had darkened the souls of humans gradually vanished. This enraged the forces of evil and so they called forth the most malevolent spirit from the realm of darkness. It was his task to spread fear among mankind once again. The spirit was sent to take possession of the greatest living hero among the humans and to wreak havoc in the name of darkness. Unbeknownst to them, the lord of the rabbits had anticipated that the forces of evil would strike back. So he had sent some spies to the realm of darkness and learnt about their plan in time. He warned the humans about the approaching danger and once again had the right plan to save the day. He asked the humans to build a puppet clad in a shining armor and to put it on a throne in the midst of their festivities. As the puppet's head served a pumpkin with a carved face. The clever hare had figured that a spirit from the depths of the realm of darkness was not familiar with humans and would assume the figure on a throne in the centre of festivities as humanity's greatest hero. And indeed he was proven right when the spirit arrived and tried to possess what he assumed a human body. But the spirit had immense powers and so he finally managed to take possession of the pumpkin head on the cost of nearly all of his powers. With hardly any power left, the spirit made the pumpkin move and began to attack the celebrating humans. But the humans had long regained their courage and were not afraid to fight back. They drove off the evil pumpkin that escaped to some remote place where he was finally banished from the world. It took the spirit one year to regain enough of his strength to fight his way back into reality. He re-entered the world at the place of his defeat and to his shock and dismay he was no longer a spirit but bound to a pumpkin-like body. The beast roared in rage but could do little about it. Again he tried to wreak havoc in the world but again valiant heroes stopped his rampage and banished him for another year. Since this day on, the spirit returns every year hoping that one day humanity will be weakened enough for him to finally take revenge.]] },
			{ itemId = 2816, -- book
				text = [[
Create Beer
No Dwarve can resist a good mug of Jimbin's beer and this spell will one day allow you to create such beer with a few simple ingredients. Collect the hair of a troll, a mushroom of any sort, a small amount of soul from the mad mage valley, some water from around the mad mage valley and the silence befire dawn. Place the ingredients into a flask of the mad mage valley water, cork it and boil it. Remove the cork and pour a small amount of the potion into a cup and shake it. Now we have to find out how to bring in the silence gefore dawn in an appropriate way. You should then have a full cup of beer if all works as calculated so far. We estimate one potion should be a weeks suply of beer if you minimize your drinking to 7 mugs a day.
(Oh, and don't tell jimbin about this spell)

Those are the findings. It was also found that the water that flows by the mad mage valley is quite magical. One of our mages suggested that it is the "soul of the sea".]] },
		},
	},
	-- bookcase at 32631,31915,4
	{
		itemId = 2435,
		itemPos = { x = 32631, y = 31915, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The elves are able to manipulate their unborn children by some kind of dream magic. This magic changes appearance and personality slightly, allowing elven parents to give birth to 'wish-kids'. In their shared dreams the elven parents seem to sculpture their child like a piece of art. Though most of the dream magic of the past is long forgotten, this rudimentary magic seems to be natural to the elves. It is possible to 'choose' things like hair or eye color and even gender. Even slight changes of the physique are possible, though considerable changes take place in the span of generations. Wise men assume this ability was a 'gift' of the gods to make more adaptable tools for the elves' war. But the mentality of the elves did not allow them to form their children in a 'convenient' way. Since most of this magic is instinctual, they form their children in an aesthetic way. On the other hand, what is seen as aesthetic is based on the philosophy of the parents and so their background changes this view dramatically. This is even more evident in the castes that were separated in the war.]] },
		},
	},
	-- bookcase at 32631,31918,4
	{
		itemId = 2436,
		itemPos = { x = 32631, y = 31918, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
You read in big red letters: <TOP SECRET! ONLY FOR YOUR EYES!> Dwarfish Beer ingredients and brewing]] },
			{ itemId = 2816, -- book
				text = [[
Dwarven Magic I
By Marokin

Most of the other races look down upon the Dwarves because we seem to lack in magical abilites. What they don't understand is that our best mages concentrate on the magic of earth and fire, the give and take. They come up with some magic that might give us the upper hand. In theese books I will reveal some of their findings.]] },
			{ itemId = 2816, -- book
				text = [[
Dwarven guide to warfare
Lesson II

Never wash yourself before combat - it will only lower your natural protection!]] },
		},
	},
	-- bookcase at 32631,31921,4
	{
		itemId = 2437,
		itemPos = { x = 32631, y = 31921, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
War of Welcome Begins
It happened suddenly one morning. A group of Dwarves were passing by the Orc territory outside their mountain. They were on their way to Thais to sell off some of their jewels of the mountain. The orcs tried to ambush them but falied. The dwarves reacted quick and by valor and superior equipment defeated the raiders. This ensued the War of Welcome. After this incident the dwarves who claimed that the time had come to stand up for their beliefs and their treasure got the proof they needed to convince their brethren and sisters of their cause. The orcs would not retreat though and prepared themselfes for war. After a year of battle the orcs were finaly crushed and the tribe scattered. The dwarves now again claimed dominance over the heart of the continent and all the land that 'where under the shadow of the big old one'. The humans of the thaian kingdom became allys to the dwarfen empires soon after theese wars and trade flourished.]] },
		},
	},
	-- bookcase at 32631,31924,4
	{
		itemId = 2436,
		itemPos = { x = 32631, y = 31924, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Miner's Entry

What it was I cannot say! But its horrible! Horrible! We heard rumors of such things before but we just ignored them ...Im the only survivor ..that...THING...they couldn't move...they were helpless...oh why ...what....what is that..something is coming...my feet....stone...]] },
		},
	},
	-- bookcase at 32632,31915,4
	{
		itemId = 2436,
		itemPos = { x = 32632, y = 31915, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
As intensely as the orcs hate all other races, they share a feeling of community. The orcs can sense, to some extent, the feelings of other orcs. The shamans develop this ability to such an extent, that they can sense the innermost potential of newborn orc whelps. All newborn are tested and the shamans decide a future function in orcish society. The whelps are fed differently, raised differently, and educated differently. Wise men of other races say that such behavior is similar to some insects, such as bees, and through their empathetic bond might share a kind of 'hive-mind', so they refer to orc communities as hives. The chief of a hive owns a big harem of women who have no other function than to pleasure him and give birth to new orcs. These orcish matrons are usually incredibly big and fat, almost not able to walk on their own. Where 'normal' orcwomen function as laborer and craftwomen and give birth to two to three orcs in their lives, these female orcs are only reproductive machinery, giving birth to about six whelps each half year. Orcs are usually contend with their place in orcish society and only the leaders fight each other on purpose. Rarely will an orc raise a weapon against another orc, even if they are not of the same hive. Rivalry between hives is usually dissolved through a fight of their leaders and the victorious hive absorbs the other one. Now and then, when a new strong warrior reaches maturity he challenges the old leader for a fight of supremacy. Sometimes though, when the hive becomes too big for the area it occupies, such a warrior senses somehow that its time to move on. Then he and a few other orcs leave the hive in peace to settle somewhere else. This unique culture, together with its fertility, makes the orcs the most formidable threat to all other tibian communities.]] },
		},
	},
	-- bookcase at 32632,31918,4
	{
		itemId = 2437,
		itemPos = { x = 32632, y = 31918, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
INTERESTING FACTS ABOUT KAZORDOON issue 1
Author: John Barrel
Once upon a time there came a horrible snakelike beeing to the deeper mines. It killed many miners, because that 'snake' was a bassilsk horrible beeing with a gaze that could turn living beeings into stone. Many heroes tried to kill it but none suceeded, some fled, most died. One day a wise man which name is forgotten. (I did many studies but i looks like for some reason none wrote down his name) He had some knowledge about theese horrible creatures. He advised the miners to cover the minewalls with torches and lamps. Scared by the dispised bright light the basilisk retreated deeper and deeper into the mines until the mines managed to create a cave in behind him. If the miners I talked to did not make fun of me we have to assume that the basilisk is still there...]] },
			{ itemId = 2816, -- book
				text = [[
Dwarven Magic II
By Marokin

Floatation

This spell will one day allow any dwarf that may not be a good swimmer the ability to almost walk on water. What we found out you would probably need are the remains of a slain stone golem, the branch of a willow, the wing of a wasp, and a flask full of slime. Pour the slime into a cold cauldron and add in the other ingrediants into the cauldron and boil it. This seems to be the base of a powerful potion, though the finalization and the spells needed to enchant it are still a riddle to be solved.]] },
		},
	},
	-- bookcase at 32632,31924,4
	{
		itemId = 2437,
		itemPos = { x = 32632, y = 31924, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Thousand ways to cook rotworm meat]] },
			{ itemId = 2824, -- book
				text = [[
The blood cult

The blood god's rise to power also brought about the birth of a blood cult, a circle of devout followers, a sect devoted to worshipping and serving their deity. The cult's roots were steeped in darkness and their practices were macabre and gruesome. The blood god flourished. The first inhuman vampire spawn were his creations. The vampire priests served as his heralds and prophets and gathered a flock of devout followers, lured into their folds by promises of immortality and power. The inner circle of his priesthood was taught the darkest secrets of the blood. They learned forbidden things that were even unknown to the gods themselves. The truths they learned opened their minds to the true powers of their vampiric forms and elevated them far above their kin. Their splendour and power lured in more and more subjects, willing to undergo the transformation, yet only the most worthy were chosen.

This neglect lead to envy though and one of the more powerful among the scorned betrayed the cult and gave away their secrets to their enemies. Yet they were afraid of the might of the blood priests and only when the gods struck down the god of blood they dared to strike on their own, attacking the confused priests and their followers. They routed out all they could find and brought a cruel end to their existence, which otherwise would have endured the test of time.]] },
		},
	},
	-- bookcase at 32633,31915,4
	{
		itemId = 2437,
		itemPos = { x = 32633, y = 31915, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Introduction of the War of Welcome

The War of Welcome took place near the southern bridge, that the humans call 'the dwarf bridge'. The southern territory was once inhabited by a mighty orcish tribe and the few dwarves brave enough to stick around the mountain were constantly being hasseled by these orcish people and some were enslaved by the vile orcs! To the Northwest lie Carlin, a place inhabited by humans who struggled for survival on their own and could not help the dwarves in this matter either. As time went by the dwarves who called for war against the orcis raiders grew in number and voice. They felt they had a right to reatake these lands from the orcish invaders.]] },
		},
	},
	-- bookcase at 32633,31921,4
	{
		itemId = 2435,
		itemPos = { x = 32633, y = 31921, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
To give and to take
storys about earth and fire]] },
		},
	},
	-- bookcase at 32634,31918,4
	{
		itemId = 2435,
		itemPos = { x = 32634, y = 31918, z = 4 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
The songs of Azaram were numerous and several of them lived on to be still sung in our days. His chivalrous exploits were the base of many modern fairy tales and three of the lections of the art of fighting still bear his name. All the more his fall from grace was more than tragic. It's a bitter and sad tale, recounted numerous times in different ways. Most of this tale still romanticise what has happened. Historical records thankfully give us a more precise picture. In one of his chivalric journeys he met a damsel of incredible beauty. Yet she was engaged to another, much older knight for political reasons. What exactly transpired is still disputed. Though the historical texts give us some plain fact. It cannot be ruled out that his love was indeed the result of a curse of a swamp witch coven. Azaram had certainly participated in several witch-hunts, albeit not in a more active way then his compatriots. It is still possible that he, as a prominent figure was chosen for a curse, to have a greater impact. Also it can't be ruled out, that the damsel in question had a more active and sinister role in the things that transpired. Though the stage play 'The poisoned love of noble Azaram' depicts her as an evil schemer there is little factual evidence to support that claim. Indeed though, she took an unusual road for her travel to her fiance and certainly not in a time that was suited to traveling. But the assumption she orchestrated the attack on her company and the timely rescue by Azaram seems a bit farfetched. For sure it's recorded that he accompanied her on her way from there on. What transpired on their trip together no historian can tell. When they arrived at the home of her fiance, Azaram stayed as honoured guest. When the wedding drew near he was more and more often found in a drunken stupor and susceptible to fits of rage. In the evening before the wedding, the groom took offence of his behaviour and scolded Azaram, reminding him of the knightly virtues. This lead to an outburst of Azaram in which he drew his weapon and swiftly slew his offender. Sobered up by the shock of his own action, he grabbed the maid and forced their way out of the castle, leaving several men at arms dead. The nightly chase lead them to the swamp. Perhaps he wasn't aware where he was riding or perhaps he hoped to lose the pursuers in the marsh under cover of darkness. When the hunters arrived they only saw a gnarled, armoured fist raising from the swamp. when they managed to retrieve the body, OOO was dead. The maid was nowhere to be found, supposedly resting in the swamp for eternity.]] },
		},
	},
	-- bookcase at 32634,31921,4
	{
		itemId = 2436,
		itemPos = { x = 32634, y = 31921, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
From a hole to a mine
A step by step guide to mining]] },
		},
	},
	-- bookcase at 32634,31924,4
	{
		itemId = 2435,
		itemPos = { x = 32634, y = 31924, z = 4 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The Bonelord Threat I
Once in the olden days, the bonelords numbered among the most powerful races of the world. Their mighty cities, which characteristically contained ominous dark pyramids, could be found all over the world. The bonelords erected them using the same innate form of telekinesis which lets their bodies float in the air. However, they could not do completely without hands and arms that did their bidding. For this reason they relied on another innate power of their race - the dark power of necromancy. Thanks to the magical abilities of their tentacles, which are capable of producing various powerful kinds of magic to an extent that is denied to other races unless they study for many decades, the bonelords also knew how to command the dead. As a result, they used a monstrous strategy: Whenever they conquered an area they turned their unfortunate victims into undead slaves. Using these undead legions as their shock troops, the bonelords went from victory to victory. They built a huge fortress that served as their power base, and from there they went to conquer the world.]] },
		},
	},
	-- bookcase at 32635,31918,4
	{
		itemId = 2436,
		itemPos = { x = 32635, y = 31918, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Prisonisle

Most of the rebelious dwarves who betrayed us and allied themselves with the cyclopses and some dishonorfull human knights were prosecuted and thrown in jail on the prisonisle Dwacatra. They now have to live or fight the captured Minotaurs, Orcs, and Cyclopses they seem to like that much.
Justice is served.]] },
		},
	},
	-- bookcase at 32635,31921,4
	{
		itemId = 2437,
		itemPos = { x = 32635, y = 31921, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Mining made easy]] },
			{ itemId = 2816, -- book
				text = [[
Mining for dummys and elves]] },
		},
	},
	-- bookcase at 32635,31924,4
	{
		itemId = 2436,
		itemPos = { x = 32635, y = 31924, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Human Tongue (title)

Speaking it. (short text)

by Dnobagev]] },
			{ itemId = 2816, -- book
				text = [[
Elven Tongue (title)

Cooking it. (short text)

by Dnobagev]] },
		},
	},
	-- bookcase at 32636,31918,4
	{
		itemId = 2437,
		itemPos = { x = 32636, y = 31918, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Goldfinger]] },
			{ itemId = 2816, -- book
				text = [[
You only mine twice]] },
			{ itemId = 2816, -- book
				text = [[
Golden mine]] },
			{ itemId = 2816, -- book
				text = [[
The mine never dies]] },
			{ itemId = 2816, -- book
				text = [[
The mine is not enough]] },
		},
	},
	-- bookcase at 32636,31924,4
	{
		itemId = 2437,
		itemPos = { x = 32636, y = 31924, z = 4 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
The Dark Woman III
Stumbling out of the mausoleum, he found himself in the ruins of a once-proud city. It did not take him long to realise that these ruins were the remnants of his own capital. It appeared that he had lain in an unholy slumber for a very long time. And now his kingdom was lost, run over by his enemies, and his former subjects were enslaved or dead. Stunned with shock and disbelief, he wandered aimlessly through the ruins. To his own amazement, however, his heart did not race as furiously as might have been expected. In fact, it did not beat at all. Stricken by panic and confusion, the king went on and on until he came across a small group of travellers, who had sought refuge in the ruined city. The meeting was not a coincidence because he had felt their presence for quite some time and purposefully directed his steps towards them. In fact, all of a sudden a hunger had taken hold of him such as he had never experienced before. He rushed towards the strangers as fast as he could, his mind inexplicably clouded by this weird hunger. When he finally returned to his senses, the travellers lay dead before him, their bodies twisted and mutilated. He was confused and aggrieved to find that the only living beings he could have asked about what had happened were dead, but at the same time he felt strangely intoxicated by a feeling of mad triumphalism. The weird hunger that had troubled him was nearly gone and he felt stronger and more alive than he had ever done before. He fled the city that very night, running away from his painful memories. He made it his habit to travel only by night as he found that daylight caused him insufferable pain. Today, little is known of his fate or of what is driving the creature that once was a king. Some say the demon he devoured has taken control of this new form, while others claim that the accursed king is driven by guilt, looking for redemption from the sins he committed against his people, distorted though his vision of redemption might be. Yet another group of scholars claims that the accursed king is bent on revenge against the dark gods who plotted his downfall or perhaps against the gods of light who let him down in the hour of need. What is certain, though, is that he fathered many others like him who share his curse, and that he has lived longer than any mortal creature should, enduring the aeons and watching the ever changing world frozen forever in the moment of death that did not lead to true death.]] },
			{ itemId = 2832, -- book
				text = [[
The Dark Woman II
However, the demon that was his wife was not prepared to give in. She began using her dark powers to entrance him whenever he lay down to sleep. That way, she managed to secretly drink his blood to sap away his strength. Having fallen out of the true gods' favour because of his sins and excesses, he had grown vulnerable to the darkness, and he could not free himself of the evil that had befallen him. With every day that final battle grew nearer and nearer the king grew weaker and weaker. And yet not all was lost. The king was still in his prime and his strong will, which was without equal among mortals, kept him going. For a while it looked as if he might be able to turn the tide and to lead his armies to victory even in his weakened state. It was then the accursed thing that posed as his loving wife made a fatal mistake. Having become desperate or perhaps simply overwhelmed by greed, she took too much of her husband's life force, revealing her dark nature at last. As the spell that lain upon him for so many years broke and the king awoke from his dark slumber, he surprised the thing he had thought to be his loving wife feeding on his very blood. In a heartbeat the veil of years of deception was torn, and the once-proud king saw the terror that had befallen him for what it was. His despair knew no bounds. Blinded by feelings of rage and guilt, he slew the accursed creature that was neither demon nor man with a single mighty stroke. When he saw the unholy creature whom he had loved so desperately lying in her blood he sunk unhappily to the floor. He wept with sorrow and despair, while outside the drums were beaten and the trumpets of war were sounded. The generals came and tried to call him to battle, but he would not move. Tortured by feelings of remorse and guilt and hate and despair, his mind was close to madness for a long time. Eventually, an idea took hold of his mind that defied sanity. If his strength had been taken from him by stealing his blood, could he not get it back by drinking his accursed wife's blood? And laughing madly, he turned to drinking the dark blood that had poured from the shattered beast. Alas! His hope was in vain. The tainted blood weakened his body instead of making him stronger. Before he knew it, he had passed out. However, when he awoke, he seemed to be strangely invigorated. Feeling ten times stronger than he had ever felt in his life, he tried to get up, only to find that he was surrounded by complete darkness. The air was stale and cold, and not a sound was to be heard. Mustering up all his strength, he pushed against the low ceiling of his stony prison and managed to lift the lid. When his eyes had accustomed to the twilight he realised that he lay in a dusty mausoleum. Stunned and bewildered, the king rose. Everything around him was marked by time and decay.]] },
			{ itemId = 2832, -- book
				text = [[
The Dark Woman I
In the olden days there lived a king that was unlike any other king amongst humankind before and after him, except for the divine Banor himself. His light shone upon his subjects and gave them enlightenment. The dark gods looked at him in malice and hatred, but he was blessed and protected by the gods, and nobody could harm him. The dark gods were furious. They held council and discussed how the good king could be undone. Finally, they came up with a diabolical plan. They took a thousand mortal slaves as well as the most vile and cunning of their succubus demons and went to create an entirely new being. They created a woman and sent her into the realm of the great king. She was human by all appearance, but she was evil to the core. Her exquisite body and her soft voice were of unsurpassed beauty. She was met with rapture and admiration wherever she went, and many a man lost his heart merely by looking into her gentle eyes that seemed oh so innocent. Soon the king himself had heard of her breathtaking beauty. Intrigued, he summoned her to his court. Nobody was surprised when he fell for the graceful girl the minute he cast his eyes on her. Within a day he proposed to her, against his counsellors' better advice, and within a week the kind king had made the pale, dark-haired beauty his queen. The king was madly in love. He soon accepted his newly-wed wife as his confidante, preferring her opinions over those of his former counsellors. At first it seemed that her advice was thoughtful and prudent, and so it came the good king relied more and more on his beautiful wife's opinion. He closed his eyes and ears to other people's good advice and blindly followed her evil counsel. Little did he realise that she purposefully taint his views of the world with darkness. Using honeyed words, she sowed the seed of distrust in his ear, until he started seeing enemies everywhere. He grew suspicious of his advisers, who dared to challenge his beloved wife's wisdom, and turned away from his former friends, who tried in vain to warn him of her wicked influence. In the end, he even started questioning the authority of the true gods themselves, blinded by his wife's promises of power and glory. She made him believe that the country needed a firm hand and a more determined, efficient rule, flattering his vanity by envisioning the immortal fame he could win as such a glorious king and warrior. The enthralled king followed her advice, not realising that he was about to lead his country into tyranny. He became greedy and ambitious, extending his privileges wherever he felt it necessary. He grew more removed from subjects every day, indulging in feasts and orgies while his people suffered. While his armies struggled in futile, pointless wars he chose to stay behind, claiming that he owed it to his people remain alive rather than to risk his skin on the battlefield. In fact, he very much preferred to indulge in debauchery, surrounding himself with flatterers and sycophants, and there was no greater joy for him to impress emissaries from other countries with the splendour of his palace and, above all, the breathtaking beauty of his wife. However, the good life was not to last. The tides of war turned against his leaderless armies, which had never failed to win the day when he had lead them himself. After a series of disastrous defeats, a decisive battle became more and more inevitable, and the king finally realised the danger that he and his whole country faced. Remembering the man he used to be, he finally decided to lead his forces. The queen protested. She wailed and threatened and begged him on his knees, but for once he would not listen to her. For a last fleeting moment it looked like all was not lost for the good king and his realm.]] },
		},
	},
	-- bookcase at 33040,32619,4
	{
		itemId = 2435,
		itemPos = { x = 33040, y = 32619, z = 4 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Legends of the Kha'labal I - The Hyena King

Deep in the heart of the Kha'labal the dreaded hyena king has its lair. This legendary beast is much larger than any other specimen of its race, surpassing lions and even elephants in size, and it can tear a man apart in seconds with its enormous, razor-sharp teeth. What's more, the hyena king is said to be truly immortal, for it has been sighted time and again by numerous travellers and merchants. Many a caravan is said to have fallen prey to this ferocious beast, and it is widely believed to have amassed untold treasures over the centuries.
The legend goes that this beast was once a common hyena that was born in the time when the djinn war was at its peak. Somehow it had managed to escape the cataclysmic firestorm unleashed by the Efreet during the battle of Ankrahmun, and when the slaughter had finally ended it fed from the bodies of the fallen djinns, consuming large amounts of magical energy in the process. Perhaps these magical energies were responsible for the fateful mutation that turned a common hyena into this frightful beast.]] },
		},
	},
	-- bookcase at 33040,32621,4
	{
		itemId = 2438,
		itemPos = { x = 33040, y = 32621, z = 4 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The Kha'labal Chronicles IV - The Exodus

Through the force of his convictions Daraman managed to lead Gabel, the djinn's famous king, onto the path of truth and redemption. It has been insinuated that he acted purposefully to sow the seeds of disunity among the djinn race, but considering his personal integrity this seems unlikely. Whatever his motives, though, Daraman's teachings caused a bitter controversy among the djinns, and eventually a fierce civil war broke out. This did a lot to ease the situation for the humans, but Banor was clear-sighted enough to know that his race would sooner or later get involved into the conflict. It was not hard to work out for him which side to support. Under the influence of Daraman's teachings Gabel, his former enemy, openly propagated peaceful coexistence between humans and djinns. Banor accepted this offer in the name of all humans and formed an alliance with the Marid. It was only logical then that the Alliance fought side by side in the battle of Ankrahmun against the Efreet who had secretly allied with the Drefian necromancers. The victory of the Alliance was overwhelming, but it came with a heavy price. A cataclysmic firestorm unleashed by the Efreet set the whole Kha'labal ablaze, forever turning what used to be a paradise into a barren wasteland. Countless human lives were lost in the magic inferno, and the survivors found that their homes had been destroyed. Faced with a choice of slowly starving to death or leaving their native land forever, a large group of survivors followed Banor on his quest for a new home. Their exodus triggered a chain of events that eventually resulted in the cataclysmic wars of the unliving, but it was also the fateful moment when the humans' slow, but steady conquest of the whole of Tibia started. But that is a different story.]] },
		},
	},
	-- bookcase at 33040,32622,4
	{
		itemId = 2439,
		itemPos = { x = 33040, y = 32622, z = 4 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The Kha'labal Chronicles III - Banor

When no prayer was answered anymore and no sacrifice rewarded it became evident that the gods had indeed left the human race so that it would find a destiny of its own. But they did not leave the humans without guidance. There was Daraman, the gods' chosen prophet, who carefully prepared them for the spiritual and ethical challenges that awaited them in a world full of treachery and evil. And there was Banor, the very first human, a champion of superhuman might and life span, who taught his people how to fight on the battlefield. On his advice the pharaoh of Ankrahmun built a strong army, and it was Banor who designed the plans for Ankrahmun's famous fortifications. And soon enough the new human armies proved themselves in fierce battles against their undead and orcish enemies. Their kind paid heavy prices in these costly battles, but they learnt to accept sacrifices, and it soon become apparent that the human race was here to stay. Eventually only the fearsome djinns posed a real threat to the human race. They defeated the humans in several important battles using their fearsome magic and their skill with the scimitar. However, just when the situation appeared to be most dire Daraman, the revered human prophet, entered the scene and helped to neutralise the djinn threat in a way nobody had foreseen.]] },
		},
	},
	-- bookcase at 33040,32623,4
	{
		itemId = 2439,
		itemPos = { x = 33040, y = 32623, z = 4 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The Kha'labal Chronicles II - Shadows from the North

Sadly, the bliss that marked the humans' early hours was not bound to last. The shadows which in those days held the rest of the world in their cold grip became aware of the humans and of their riches, and soon enough they began to plot the young race's destruction. Ferocious orcs built fleets and started raiding the south-western coastline, while the north was threatened by eerie undead who began to spread their insidious poison among the terrified humans. Worse, the corruption slowly found its way into many of the humans's hearts, and strife and armed conflict erupted within the community. Some humans even fell for the morbid attraction of undeath. They formed an evil cult of necromancers and went to the north to found a city of their own. This city was called Drefia, and it soon became a source of the foulest corruption.
The humans, who were not used to such challenges, were full of sadness and despair, and many cursed the gods who apparently watched their plight in apathy. Little did they understand that all this was part of the gods' plan. It would take the humans a long time to understand that the very purpose of their race was to fight evil, and that their fate was not eternal bliss but endless struggle.]] },
		},
	},
	-- bookcase at 33040,32624,4
	{
		itemId = 2439,
		itemPos = { x = 33040, y = 32624, z = 4 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The Kha'labal Chronicles I - The Creation of the Kha'labal

Every child knows the sad fate of the Kha'labal. Once it was brimming with life, a verdant paradise filled with lush forests and countless freshwater springs. The gods created this paradise and gave it to their newly-made race, the humans, as a present. Protected on all sides by the sea or by insurpassable mountains, the Kha'labal was the perfect environment for the young, vulnerable race to flourish. And flourish and thrive it did. Guided by their leader Banor and endowed with amazing technical skills and knowledge by their creators, the humans managed to settle the whole Kha'labal within few generations, and beautiful buildings rose to the sky, the mightiest of which were to be found in the majestic city of Ankrahmun. These early humans, who today are called the Founders, were a friendly race who lived in peace and harmony with each other, ignorant of the horrors lurking in the outside world. And the gods, who watched them from their thrones in the Kha'zeel, smiled on them. ]] },
		},
	},
	-- bookcase at 33041,32619,4
	{
		itemId = 2436,
		itemPos = { x = 33041, y = 32619, z = 4 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Legends of the Kha'labal II - The Wailing Bride, Pt. 1

Princess Theripat was the beautiful daughter of pharaoh Karkhaneses II. She grew up in the pharaoh's palace, living a seemingly careless life amidst the proverbial luxury and splendour of the Ankrahmunian court, and when her father arranged for her to marry a well-proven northern nobleman her happiness seemed complete. But things were not quite the way they seemed. Theripat, who was a headstrong and idealistic girl, had always despised life at the court, and with the help of her nurse she had made many forays into the city, concealing her true identity. On one of these excursions she had fallen in love with a handsome officer from the pharaoh's guard. The young man requited the love of what he thought was a simple woman, and eventually the two lovers had even married. When the pharaoh finally decided it was time for his daughter to marry she was already 6 months pregnant, and she knew that soon the truth could no longer be hidden. Frightened and confused, Theripat went through the wedding preparations without saying a word, but when the day had finally come she fled the court. The whole extent of the scandal soon became obvious.]] },
			{ itemId = 2832, -- book
				text = [[
Legends of the Kha'labal II - The Wailing Bride, Pt. 2

Karkhaneses, a ruler who believed that his absolute power depended on the fact that no treachery should ever go unpunished, decided to show no mercy. Both Theripat's nurse and her true husband were arrested and publicly drawn and quartered. Theripat herself had escaped into the desert with her new-born child, but her unforgiving father sent half his army after her. She was found soon enough, but just when the troops were about to arrest her, the unexpected happened. Clinging her baby to her breast, the desperate mother fell into a piercing, bloodcurling wail that quickly expanded into an unearthly sound to which nature itself seemed to respond. All of a sudden a sandstorm erupted, fiercer and stronger than anybody could remember, and within minutes destruction rained down upon the pharaoh's terrified troops. When the storm cleared the soldiers were severely shaken, and many of the pharaoh's best chariots lay shattered in the sand. Theripat and her child, however, were gone forever, and nobody has seen them ever since. But each time the storm rages over the Kha'labal the superstitious people fall into a silent prayer to appease the wailing bride's fury.]] },
		},
	},
	-- bookcase at 33042,32619,4
	{
		itemId = 2436,
		itemPos = { x = 33042, y = 32619, z = 4 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Legends of the Kha'labal III - Gha'Zuul the Necromancer 

Gha'Zuul grew up a simple boy among one of the northern nomad tribes. A frail and meagre child, he was frequently the target of the other childrens' jeers as well as of his despotic father's scorn. Hurt and angered by the constant humiliations, Gha'Zuul developed a bitter, unforgiving personality. He took notes of all the indignities he suffered, and he was determined to take revenge for every single one of them. One day, when his camp was attacked by an undead raiding party he decided it was time to get his revenge. Taking advantage of the general hullabaloo, Gha'Zuul sneaked up on his worst tormentor and quickly cut his throat. However, he had made a mistake when he thought that his crime would go unnoticed. One of the necromancers who was part of the raiding party sensed the evil of this deed, and since he was impressed by the young boy's obvious ruthlessness he ordered his undead troops to kidnap him. And so Gha'Zuul was brought to Drefia.]] },
		},
	},
	-- bookcase at 33043,32619,4
	{
		itemId = 2437,
		itemPos = { x = 33043, y = 32619, z = 4 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Legends of the Kha'labal IV - Drefia's Downfall

Many are the legends concerning Gha'Zuul’s cometlike career in the necromancer city. Working with superhuman resolve and ruthlessly exterminating all real or imaginary competition, Gha'Zuul managed to rise to the top of the Drefian hierarchy within a few decades, and when a bizarre accident happened to the president of the High Council, Gha'Zuul took his place. He was the first necromancer to take this position while still being alive. However, being the foremost necromancer was still not enough to satisfy Gha'Zuul’s thirst for power. He had great plans for Drefia. Under his rule the necromancer city would expand and conquer, taking over control of the north and perhaps of the whole of Darama! It was his idea to propose an alliance to the Efreet, and when the decisive battle drew near he personally raised the necromancers' troops to march against the Marid.
The rest is well-known. Drefia's troops suffered a decisive defeat in the battle of Ankrahmun. Those undead who were not destroyed during the futile siege of Ankrahmun were pulverised in the searing heat his own allies had summoned. Gha'Zuul realised soon enough that his career in Drefia was rapidly drawing to an end, for if the Marid did not kill him his fellow necromancers surely would. And so he disappeared...
Today, there are nothing but rumours as to what happened to Gha'Zuul after the failed campaign. However, many believe that Gha'Zuul is still out there, waiting for an opportunity to take revenge just like he used to do when he was still a little nomad boy.]] },
		},
	},
	-- bookcase at 33043,32622,4
	{
		itemId = 2438,
		itemPos = { x = 33043, y = 32622, z = 4 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars III - The Great Battle, Pt. 3

At last even Baa'leal, who led the Efreet in battle, had to admit that the Marid and their despised human allies fought valiantly. However, despite the heavy losses he was determined to decide the war there and now. He summoned the most powerful Efreet wizards and ordered them to unleash a huge column of magic fire onto Ankrahmun in order to render the city and all those in it to cinders. The Efreet wizards' followed his orders and soon a wall of devastating fire rose up to the sky. However, when they tried to move it onto Ankrahmun they soon realised that it did not move into the desired direction. The Marid had soon seen through Baa'leals plan, and Fa'hradin and his fellow Marid mages used their own magic to turn the devastating flames against their creators. A fierce battle of wills ensued between the mages from both sides, and the whole battle came to a halt when the two armies watched in horrified fascination as the terrible pile of flames wandered seemingly undecided to and fro. But then, all of a sudden, the pile made a sudden leap to the north, and within seconds those who had summoned it from the sky were reduced to smouldering ashes. That was the turning point of the great battle.]] },
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars III - The Great Battle, Pt. 4

The fire, now entirely out of control, turned northwards, driven by a gently breeze coming from the south. Its devastating flames fed on plants and animals alike, and as the inferno slowly spread to the north the Kha'labal was scorched and marred forever by the magical flame. 
Thus, the great battle was won by the allied armies of the Marid and the humans. However, for the winners there was little left to feel triumphant about. The losses had been great on both sides, and the Kha'labal, that beautiful garden given to the humans by the gods, had been turned into a barren, hostile desert. Also, the destruction cause the fire had allowed many Efreet to escape, so it seemed unlikely that the war would end now. However, for the time being Malor and his troops were much too weak to pose a serious military threat, so Gabel decided to abandon pursue. Instead he ordered that his army should move northwards towards Drefia. It seemed time to settle old scores.]] },
		},
	},
	-- bookcase at 33043,32623,4
	{
		itemId = 2439,
		itemPos = { x = 33043, y = 32623, z = 4 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The Djnn Wars III - The Great Battle, Pt. 1

At last, Malor prepared for a decisive strike. He sent a messenger to Gabel and challenged him to a personal duel. Gabel, who was prepared to do anything to stop the fratricidal war, accepted the challenge. The enemies agreed to meet in the fertile plains of Kha'labal. There they stood, face to face, the old king and the usurper, and so did their armies, because neither of two was gullible or foolish enough to come on his own. It was the greatest gathering of djinns in recorded history.
Eventually Gabel stepped forward to meet his opponent. This was the moment Malor, who had never intended to fight honourably, had been waiting for. All of a sudden the earth opened in a thousand places, and hordes of vicious undead attacked the Gabel and his army. For Malor had secretly formed an alliance with the dreaded necromancers of Drefia and it was them who controlled the undead hordes that fought for him. Faced with an overwhelming enemy, Gabel and his army turned to flee.]] },
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars III - The Great Battle, Pt. 2

A number of Marid was caught and slaughtered on the spot, but much to Malor's disappointment the majority of Gabel's troops managed to escape southwards in what appeared to be a well-planned strategic withdrawal. And how much greater was his surprise to find that the Marid fled to the city of Ankrahmun where they appeared were expected! It was then that he realised that Gabel had suspected a ruse all along, and that he had prepared a counterstrategy. Malor immediately ordered his troops to abandon pursuit, but it was too late. The undead marched against Ankrahmun with all the determination of a mindless killing machine, and the Efreet, blinded by rage, did not lag behind, only to be met by ceaseless barrages of arrows and catapult stones. A cataclysmic battle ensued.  
Wave after wave of undead and Efreet stormed against Ankrahmun, and wave after wave broke at the huge fortifications of the ancient city. Both the Marid and the humans were well-prepared for this battle, and even though Malor's army wreaked havoc they never yielded. ]] },
		},
	},
	-- bookcase at 33043,32624,4
	{
		itemId = 2440,
		itemPos = { x = 33043, y = 32624, z = 4 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars I - The Insurrection

For a long time Malor had plotted and schemed in secrecy, using promises and threats to recruit followers and to form alliances. Many djinn refused to betray Gabel, but the majority of the strongest djinn warriors rallied to his cause, and since Malor had been plotting his insurrection for a long time the rebels were well-prepared. When Malor finally gave the signal his minions attacked the palace in full force, planning to kill Gabel swiftly. Their attack was deadly effective, and the palace guards were quickly overwhelmed. However, Gabel, who had received warning about the conspiracy was saved in time by his trusted aide and friend Fa'hradin. He managed to flee in the darkness, and that very night he started to gather his troops in order to take revenge on the usurper. Malor, on the other hand, had to acknowledge that his plan to get rid of Gabel quickly had failed. And he ordered his followers to prepare for a long-term military engagement. Neither he nor Gabel realised then that this was the starting point for a war that would last for eons.]] },
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars II - The First Years

The war took a long time to unfold. Both Malor and Gabel tried to win over as many followers as they could, and the need to take a choice war weighed heavily on many a djinn's conscience. Still, few of them managed to remain neutral in this terrible war, and so a deep rift opened within the djinn race. Families were torn apart as children turned against their parents and brother fought brother. Worst of all, it soon turned out that both sides were roughly equal in strength, so that even though a number of vicious battles ensued it become more and more apparent that victory could not be won easily in this war. In fact, it appeared more and more likely that even if one of the sides could win it, it would so be crippled by the endeavour that the very existence of the djinn race would be threatened. Still the war raged on relentlessly. And the mutual hatred between the two fractions, who began to call themselves by the distinct names of Marid and Efreet, increased with every battle that was fought.]] },
		},
	},
	-- bookcase at 33046,32619,4
	{
		itemId = 2435,
		itemPos = { x = 33046, y = 32619, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Chronicles of Daraman I

That was the time when Daraman was captured by the djinns while he was fasting and meditating in the desert. They put him in heavy chains and brought him before Gabel's throne. There the old man stood, all haggard and torn, amidst the splendour of the djnns' court. And the djinns started teasing and tormenting the human with a thousand malicious tricks, trying to strike terror in his heart. But frail and crippled though he was, Daraman never so much as flinched under the pain, and his will could not be broken. Finally Malor, who was the most vicious and godless of the djinn, lost his patience and raised his hand to strike the final blow. But lo!, just when his deadly scimitar was about to strike the prisoner down Gabel's voice thundered through the hall, ordering Malor to stop. And though mighty Malor trembled with anger and spite, he did not dare challenge his king's authority.]] },
			{ itemId = 2816, -- book
				text = [[
The Chronicles of Daraman II

Gabel was curious about the strange human who did not seem to know pain or fear. He approached him and asked him if he did not feel any pain. Daraman answered that the pain of the body was nothing compared to the pain of the soul.  So Gabel asked Daraman if he was not afraid. And the prophet said the famous words: "The fear of death is but a trifle compared to the fear of life." So Gabel, who was more and more intrigued by the human, asked him whether he did not care at all about his life? Daraman just looked into the mighty djinn king's eyes, and a brief smile shone on his lips. And after a long pause he spoke thus: "I am an old man and I have but little to lose, mylord. But your race has much to gain, for it lives in darkness." When he said those words many djinns were outraged by the human's apparent lack of respect. And if Gabel had not stopped them the prophet would have been killed on spot. ]] },
		},
	},
	-- bookcase at 33046,32622,4
	{
		itemId = 2438,
		itemPos = { x = 33046, y = 32622, z = 4 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars VI - A War in Suspension

With Malor imprisoned, many Marid hoped that peace would finally come. Gabel immediately contacted the Efreet to let them know their leader was his prisoner, but his hopes that the rebellion would collapse without Malor were disappointed. The Efreet hated their Marid cousins too much to yield, and so the war continued. Nonetheless, both sides tried to avoid open conflicts, so there was next to no combat action for a long, long time. In fact, both the Marid and the Efreet planned to wait until their ranks would be replenished. But the losses they had suffered were great, and the djinns are not a fertile race. Century upon century passed and still their numbers had increased little. And while elsewhere the human race rose to power, building beautiful cities and establishing powerful empires, the djinn lived quiet in their remote fortresses. Malor, however, remained imprisoned in Fa'hradin's lamp, oblivious to the strange land his guardians had taken him.]] },
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars VII - Malor's Liberation

Gabel had decided to hide Fa'hradin's lamp and its powerful prisoner in a forlorn place far to the north because he thought it would be safer there than in Ashta'daramai, his own fortress. Little did he know that these were very the lands where many centuries later a race of goblinoid barbarians called the orcs chose to erect a mighty fortress. One fateful day the lamp was found and brought to the orc king. It did not take the king's shamans long to work out that a mighty spirit was caught in the lamp, and soon enough the reckless king released the mighty djinn that had lain dormant for so many centuries. Little is known about what happened next, but even though to this day the orcs claim their king is still alive there are no credible witnesses who confirm that they have seen the orc king ever since. Malor, however, freely roams the world again, and many scholars agree that he will try every trick in the book to rekindle the fire of the djinn war.]] },
		},
	},
	-- bookcase at 33046,32623,4
	{
		itemId = 2439,
		itemPos = { x = 33046, y = 32623, z = 4 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The Djnn Wars IV - Drefia's Fall

After the disastrous battle of Ankrahmun Drefia's necromancers knew the end was near. The Marid would never forgive them their treachery, and this would be a battle the necromancers could not win - after all, many of them had already perished in the battle of Ankrahmun, and their Efreet allies could provide no assistance. So the necromancers prepared for the inevitable with the defiant cynicism of those who have been familiar with death all their lives, performing evil rituals and indulging in morbid orgies.
Finally, the end came swifter than they expected. Unwilling to take any risks in the unpredictable halls and passageways of Drefia's dungeons, the Marid performed a fearsome ritual. The tortured earth underneath Drefia started moving like a giant whirlpool, and slowly the unholy city was pulled inside the maelstrom. Within half an hour it was gone completely, and all but the highest buildings were completely covered by sand and by rubble. None of its inhabitants have ever been seen again, but rumour has it that deep beneath the surface the unholy city is still intact, brooding like a vengeful animal in its prison.]] },
			{ itemId = 2831, -- book
				text = [[
The Djinn Wars V - Fa'hradin's Trick

Even though many djinns had lost their lives during the fateful battle of Ankrahmun, the war was still undecided. Malor had lost many of his bravest warriors, but so had Gabel, and they both knew that another epic battle like that would bring the whole djinn race to the brink of destruction. In his desperation, Gabel turned to his trusted friend Fa'Hradin for advice. The old djinn suggested using a trick to eliminate Malor. Without their leader, he reasoned, the Efreet would end the rebellion. Gabel, who wanted to avoid further bloodshed, agreed. And so it came to pass that the magic lamp was created and, by means that are unknown to this very day, secretly placed in Malor's private chamber. The mighty Efreet never had a chance. When he went to sleep in what he thought was his private lamp he was trapped inside the lamp, which was soon enough smuggled out of Mal'Ouquah, the Efreets' fortress, and brought back to the Marid. Fa'hradin's trick had worked - Malor was Gabel's prisoner.]] },
		},
	},
	-- bookcase at 33047,32619,4
	{
		itemId = 2436,
		itemPos = { x = 33047, y = 32619, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Chronicles of Daraman III

And so it came to pass that Gabel, the mighty king of the djinns, took interest in Daraman. Here was something that he, who had seen so many things, could simply not understand, and he was determined to find out more about it. In the beginning he was still convinced that the prophet, like all other humans, was driven by a secret weakness, and he tried to use many other temptations to test the prophet. He clad the old man in silk and offered him a thousand gifts. But Daraman was as unimpressed by the djinns' fabulous wealth as he had been unimpressed by their tortures, and he politely rejected all gifts. And when Gabel finally asked him if he did not appreciate his gifts Daraman answered "Mylord, I am an old man who has little use for pretty baubles. And truly I have never valued a thing that could be bought for gold." It was then that Gabel realised that Daraman was indeed a holy man.]] },
			{ itemId = 2816, -- book
				text = [[
The Chronicles of Daraman IV

So it came to pass that Daraman, who had come to the djinns' court, became the king's guest and confidant. And even though many djinns disdained their king's new favourite Gabel increasingly sought Daraman's company. Every day they went to the Gabel's personal garden and talked for many hours. It turned out that Gabel, the mighty djinn king who had been the terror of the world for such a long time, was plagued by a terrible feeling inner void, and Daraman's infinite spiritual strength became a source of joy and of redemption for him. And so, day by day and week by week, their relationship slowly changed from one between prisoner and a king to one between a master and his disciple.]] },
		},
	},
	-- bookcase at 33048,32619,4
	{
		itemId = 2436,
		itemPos = { x = 33048, y = 32619, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Chronicles of Daraman V

Gabel told Daraman of the visions and dreams that haunted him and asked Daraman for advice. So Daraman asked him to open up his soul for him to see. And Gabel opened his heart and soul to him. When Daraman had seen deep into Gabel's soul he understood the pain and the confusion that lay hidden deep inside it, and he wept bitter tears of pity for Gabel and for the whole of his race, for he saw that the djinn were a forlorn race that had been cast away by its creator. So full of divine compassion were his tears that they froze into immaculate gemstones of pure blue crystal as soon as they left his eyes. It is said that that springs of clear freshwater sprang forth from the earth wherever one of them hit the ground. ]] },
		},
	},
	-- bookcase at 33049,32619,4
	{
		itemId = 2436,
		itemPos = { x = 33049, y = 32619, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Daraman's Chronicles VI 

And finally he spoke to Gabel: "Alas! Truly thy race hath suffered! But there is hope, mylord, hope even for your race that has been deserted by its reckless creator!" And he went on to teach him the ways of abjuration and of enlightenment. And Gabel listened and learned, and when he saw the wisdom in Daraman's words he decided to renounce the old ways. And soon many others of his race embraced the holy words and became proselytes of Daraman's creed.]] },
		},
	},
	-- bookcase at 33263,31835,4
	{
		itemId = 2439,
		itemPos = { x = 33263, y = 31835, z = 4 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Legend of the Frostheart
As the frost walked the lands to put everything under a thorny blanket of ice crystals, he came to the house of the fisher Marl. He had seen the frost coming already from a good distance but he did not flee. Instead he took out his lute and started to play a lovely and solemn tune. The frost, who was quite tired from his long walk, could not resist and fell asleep. Quickly Marl put his hand into the frost's chest and stole his heart. With the heart in his hands, Marl also had the powers of the frost. So he constructed himself a palace completely made of ice and ruled over a land where every day was spring. As the the neighbouring king heard about this, he got envious and decided to invade the kingdom of Marl with his army. But Marl's people were peaceful and were not trained in any fighting. So the army reached the castle of Marl almost unchallenged. And Marl came out of the castle, pleading the army to leave. But they laughed at him and demanded his surrender. Then Marl took the frost's heart and threw it to the ground where it shattered. In that very moment everything on both realms was frozen with a thick layer of ice and each and everyone died. And the frost returned to power, but without a heart he was even more merciless than before.]] },
		},
	},
	-- bookcase at 33264,31832,4
	{
		itemId = 2438,
		itemPos = { x = 33264, y = 31832, z = 4 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Famous Necromants by Muriel.]] },
		},
	},
	-- bookcase at 33264,31833,4
	{
		itemId = 2440,
		itemPos = { x = 33264, y = 31833, z = 4 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Heresys of the new age
Some people claim that the soul vortex was not a creation of the gods. They argue that the sheer concept of souls from 'beyond' entering our realm is by all means very random and could not be planed at all. They suggest that it's a lot more likely that the vortex was actually some damage that was caused to the fabric of reality. Through this hole in reality souls that were never meant to be entered our realm and, so they assume, it's additionally a leak that leaches away the power of the gods. They suggest that war for creation was NOT interrupted
because the gods wanted to heal the wounds of the world, but because this powerleak frightened them that much. They further speculate that the withdrawel of the world was more an act of panic, an attempt not to lose complete control over
creation, and the process known as awakening is by no means the working of benevolence, but the gods losing grip of the things they tried to hide away from the intruding souls. The theory goes that as there is an ascension for the souls from beyond to achieve some form of godhood, there is a constant descent for the powers of the gods of old due to the power that is leaking away into nothingness and the power the living claim for their own. Of course this heresys is very popular in the ranks of certain ascension cults. More so since it takes care of the more common fear in those conclaves, that the jealous gods may strike back
on those who try the ascension.]] },
		},
	},
	-- bookcase at 33264,31837,4
	{
		itemId = 2438,
		itemPos = { x = 33264, y = 31837, z = 4 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
How to create spellbooks by Muriel.]] },
		},
	},
	-- bookcase at 33264,31838,4
	{
		itemId = 2440,
		itemPos = { x = 33264, y = 31838, z = 4 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Puldraks wisdom about minotaurs Pt. 1
Minotaur society rejects the raging of Blog. In the past, the berserker rage of the minotaurs was feared by all their enemies. But this rage had cost more than one life and some of the most promising warriors died young on the battlefields. Heavy casualties caused their numbers to decrease dramatically. The minotaurs withdrew from the wars, but in a world gone mad, skirmishes with other races were part of their daily routine. The demise of the whole race continued. As the minotaur race became nearly extinct in the fights, they found refuge in caves, adopting a lifestyle much like their ancient enemies the dwarfs.]] },
		},
	},
	-- bookcase at 33265,31831,4
	{
		itemId = 2435,
		itemPos = { x = 33265, y = 31831, z = 4 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Puldraks wisdom about elves Pt. 1
The Deraisim had become homeless in the wars. As nomadic wanderers they hid in the woods, setteling nowhere for a longer time. Their families joined each other to travel together for a while, only to disband again soon whenever an area could not supply them all any longer. Hunted by countless enemies and almost everytime outnumbered when it came to fights with 'neighbours' they retreated into the deepest woods where the greater number of their foes was evened out. There they created encampments they visited now and then. They had contact with many creatures and cultures. They adopted ideas and inventions that suited their nomadic lifestyle and begun even a very cautious trade with other races to aquire things they were not able to build on their own. As the attention of the other races turned more and more away from the elves and wars broke out between them, some of the elves begun to live at their up to then only part time ecampment on a permanent base. Adopting what they had seen from other races and things they vaguely remembered from their own past some trading posts were established in this way. Usually only one to three families lived there. After the reunification with the Cenath the majority of them could be convinced to give a permanent settlement a try and the biggest tradingpost became the settlement Ab'Dendriel. Some families refused to join their brethren and continued to wander the world, only visiting the city now and then, each vistit convincing them more that they have only little in common with the  Deraisim anymore. So they begun to see themselves as Abdaisim and continued to be the nomads and restless wanderers of elvenkind.]] },
		},
	},
	-- bookcase at 33266,31833,4
	{
		itemId = 2435,
		itemPos = { x = 33266, y = 31833, z = 4 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Fools From Beyond
Many of the dead leave some kind of unfinished business behind. Some of them manage to stay in the world of the living as some form of ghost or undead, but most of them simply move on to the afterlife. But even there, some of them simply don't give up. And as there is little in the world as persistent and diligent as a bad entertainer, many of them stay at the border between the two realms and contemplate their ill fates. They mourn the fame they never acquired and which they feel was unjustly stolen from them. They partner with similar minded individuals and complain to each other how cruel the world has treated them. Of course none of them is actually listening to each other because they are too absorbed with their own misery. So they grow louder and louder and over the course of time, their monologues are heard everywhere in the plain of death.
Sadly, one of the things even more persistent and diligent as a bad entertainer is a whole bunch of them. In the end, they grow that loud and annoying that the guardians of the gates of death themselves lose their patience. So once a year they throw the annoying fools out and banish them to the realm of the living, knowing that they would not stay there for long given their annoying nature.
So once a year hordes of undead jesters raid the cities where they once were seeking fame and glory. As undead, they try to terrorise the living, however, as they are even worse as undead than they are as entertainers they pose only a minor threat. Usually they find themselves back in the afterworld quite soon, and for another year, they dream of greatness that was never theirs.]] },
		},
	},
	-- bookcase at 33266,31836,4
	{
		itemId = 2435,
		itemPos = { x = 33266, y = 31836, z = 4 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The great book of firemagic]] },
		},
	},
	-- bookcase at 33266,31838,4
	{
		itemId = 2435,
		itemPos = { x = 33266, y = 31838, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Knightly Successor Orders of Tibia, loose pages I

An abridged version of a book concerning knightly orders by former knights of King Xenom, father of King Tibianus.

In the first year of the young King's rule, the siblings Oberon, Kesar and Scarlet Etzel fell out with each other. Their quarrel over knighthood under their king and the search for more purpose in their knightly duties drove them far away from Edron. Each of them founded a seclusive order but little is known about their paths during the following years. This book tries to summarise all facts known to Tibian historians as of this day.

(the book goes on about the orders and their founding figures, some specific passages draw your attention)

The leader of the Order of the Falcon (Oberon Etzel) was the first to found his own order. He saw himself and his men as true successors of King Xenom. Dismay over the King's opinions and politics led the dedicated knight to build a new order. On the foundations of law, extreme loyalty and dedication to chivalric virtues, the Order of the Falcon was established, not least as a strong signal in King Xenom's direction. Oberon Etzel's following was devout and dedicated to an extreme. Tolerated by the King at first in honour of the knight's former service, they were soon sidelined and ultimately their decisions were seen as those of of outsiders. Soon, the notion "Trapped Falcons" or "Falcon Cage" (referring to their Edron stronghold) was shaped by nobles and common folk alike. It is widely assumed among historians that these circumstances led to a self-imposed exile by the angered Oberon Etzel.

(the book also contains excerpts from an Edron report of the assumed dissolution and exile of the Order of the Falcon, commissioned by the late king Xenom himself)

(...) Among a multitude of other questions, stemming from the seclusive and secretive nature of the successor order, what makes this case most interesting in historical debates is the seemingly immediate disappearance of Oberon Etzel and his knights. The stronghold was reportedly abandoned over night with no trace of the order itself or any hints concerning their whereabouts. Eyewitnesses confirmed vibrant lights and unnerving sounds originating from the top of the stronghold during many nights. Not many dared venture close enough to the perimeter to catch a glimpse of what really happened there. Reports are varied and inconsistent. Apparently lights were also seen in the night before the one that marked the disappearance of the honourable order. It is worth mentioning that the order hosted several guests and workers almost all the time. Despite their dispute with the king and the other Etzel siblings, the order was generally considered honourable and trust-worthy. No notable suspicions have been raised during the time and until the disappearance there have been no noteworthy incidents. The disappearance seems to be connected to several high ranking officials from various cities which have been reported as missing during or around the time in question. Aside from various personally delivered invitations, no real connections could be made. (...)]] },
		},
	},
	-- bookcase at 33267,31833,4
	{
		itemId = 2436,
		itemPos = { x = 33267, y = 31833, z = 4 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
The network of the Shapers was a marvel of magical science. It is certain though that it was completely useless to anyone lacking the magic senses the Astral Shapers possessed. This network seems to have been some kind of communication device and knowledge storage. Almost like a library, the Shapers had access to it as long as they were close enough to certain transmitting towers. At the height of the Shapers' power those towers must have dotted the whole world. The Shapers became not only highly dependent on this network but also highly addicted to it. Even more, most of their communication was handled via this network. When it was destroyed, the single Shaper was overwhelmed by loneliness and lack of information. Moreover, they had lost the ability to teach younger generations without using their network. It was reported that some Shapers that found refuge by other non-hostile races became passive and depressed, sometimes they even refused to drink or to eat. This explains the swift vanishing of the race. When something that had been an integral part of their culture all of a sudden no longer existed, they were unable to cope with the changed circumstances.]] },
		},
	},
	-- bookcase at 33267,31836,4
	{
		itemId = 2436,
		itemPos = { x = 33267, y = 31836, z = 4 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
How to learn Magic easy. Level 1: For Knights and non Vocation people (Part one)
Magic is Life, Life is Magic. Well, life is sex too, but this is a book for little children, so we wont talk about that here. But never forget that Magic is a jealous Lady and if you try to take her out of your head she will sure take revenge. 
The first thing you must know about the Noble Art of Magic is that not all Tibia inhabitant and monsters of the underworld, has the same ways to make magic. All civilizated people that lives over the earth has the same Magic style, no matter what race they are: humans, the elves in Ab'Dendriel the Beauty and even the dwarfs in their underearth city, Kazordoon. Theres only a isolated from Magic whole world and is the island knowed as Rookaard (Newbie Island) becouse no magic can be casted there. Perhaps some Dark Rituals turned Magic impossible to do.
In the civilization not all we have same skill and amount of magic power, common knowed as Mana, but it will be explained in next Book.]] },
		},
	},
	-- bookcase at 33267,31838,4
	{
		itemId = 2436,
		itemPos = { x = 33267, y = 31838, z = 4 },
		contents = {
			{ itemId = 642, -- piece of paper
				text = [[
Knightly Successor Orders of Tibia, loose pages II

(the book goes on to deal with the orders of the other two Etzels)

Kesar Etzel reportedly fell out with Oberon but kept his connection to Scarlet. Kesar led his loyal group of knights under his own banner, the lion, out of Edron to found his own order. They reportedly went to Darashia after the falling out and established a foothold. Many knights of the order were known to go on pilgrimages to the mystical rock formations known as "Lion's Rock". It is rumored that Kesar believed the mythical lions to hold the key to true chivalric virtue. However, there have not been any pilgrims of the Order of the Lion for many years. (...) Scarlet, leading her own group of loyal knights, submerged and is sometimes connected to a presumably large underground operation known as "Order of the Cobra" or "Cobra Crests"/????"Cobra Unit"???? a rag-tag band of hedge knights and men-at-arms. Their motives remain unknown.

Aside from the sudden disappearance of the Order of the Falcon, it is unclear how long these orders (or remnants thereof) have been active or if they are still operating to this day.]] },
		},
	},
	-- bookcase at 33268,31833,4
	{
		itemId = 2436,
		itemPos = { x = 33268, y = 31833, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The demon boasted about the exploits he achieved in his life which already lasted a few millennia. Though most of it is probably nothing more than shameless exaggeration and outright lies, there may be some truth behind some of those stories. In particular, he insisted to have fought and defeated a race 'far better and noble' than us humans ages ago. I was able to provoke him to reveal some more information on that issue. In the end it seems a group of demons found some race that had taken refuge from the wars of the gods in some remote place. Several times, the demons attacked that race to steal some powerful relic or something like that from them. In the end the refugees or the force of the demon attack destroyed that item which resulted in a disaster in which the race and also most of the demons were wiped out.]] },
		},
	},
	-- bookcase at 33268,31836,4
	{
		itemId = 2436,
		itemPos = { x = 33268, y = 31836, z = 4 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Witches' Grotto
On a remote isle in the South there is a grotto where all witches come together to celebrate some demonic festivity once a year. They teach each other new malicious 
tricks to torment other beings. The legend goes that everybody that dares to disturb them is put to death or faces a fate even worse than death. But if you manage to step into their dancing circle at the height of the ceremony, the witches have to fulfil you a wish.]] },
		},
	},
	-- bookcase at 33268,31838,4
	{
		itemId = 2436,
		itemPos = { x = 33268, y = 31838, z = 4 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Rise of the Pumpkin
After many wars and always new threats by the forces of darkness, humanity was afraid of many things. It was no cowardice but a gnawing fear that slowly eroded courage and faith. The servants of evil seemed to appear everywhere and in many horrible forms. Humans had grown accustomed to be afraid of the dark and the unknown. This weakened their resolve and with that also the forces of good. The gods came together to find a way to rise the spirit of humanity once again. They discussed and debated but could not come to an agreement because their views were too contrasting. And while they still deliberated, suddenly one of their least and minor creations stood amongst them. It was the lord of the rabbit race who had passed unnoticed by the mighty guardians. Without fear the little rabbit faced the gods who looked upon him in astonishment. Then the lord of the rabbits proposed his idea to the mighty and great gods. Since rabbits are tiny and their enemies are many, they are quite familiar with fear and how to handle it. So the lord of the rabbits came up with the idea to have the humans overcome their fear by learning to laugh in the face of evil. The gods were amazed by this simple but clever idea. So they chose the mightiest warrior of the rabbit race and bestowed magical powers upon him. The daring hare gained the protection of the gods and the power to disguise humans with hideous appearances of monsters. Each year, the hare would appear for some time and do his work. So the humans learnt to laugh and had fun while appearing as monsters, and the great fear that had darkened the souls of humans gradually vanished. This enraged the forces of evil and so they called forth the most malevolent spirit from the realm of darkness. It was his task to spread fear among mankind once again. The spirit was sent to take possession of the greatest living hero among the humans and to wreak havoc in the name of darkness. Unbeknownst to them, the lord of the rabbits had anticipated that the forces of evil would strike back. So he had sent some spies to the realm of darkness and learnt about their plan in time. He warned the humans about the approaching danger and once again had the right plan to save the day. He asked the humans to build a puppet clad in a shining armor and to put it on a throne in the midst of their festivities. As the puppet's head served a pumpkin with a carved face. The clever hare had figured that a spirit from the depths of the realm of darkness was not familiar with humans and would assume the figure on a throne in the centre of festivities as humanity's greatest hero. And indeed he was proven right when the spirit arrived and tried to possess what he assumed a human body. But the spirit had immense powers and so he finally managed to take possession of the pumpkin head on the cost of nearly all of his powers. With hardly any power left, the spirit made the pumpkin move and began to attack the celebrating humans. But the humans had long regained their courage and were not afraid to fight back. They drove off the evil pumpkin that escaped to some remote place where he was finally banished from the world. It took the spirit one year to regain enough of his strength to fight his way back into reality. He re-entered the world at the place of his defeat and to his shock and dismay he was no longer a spirit but bound to a pumpkin-like body. The beast roared in rage but could do little about it. Again he tried to wreak havoc in the world but again valiant heroes stopped his rampage and banished him for another year. Since this day on, the spirit returns every year hoping that one day humanity will be weakened enough for him to finally take revenge.]] },
		},
	},
	-- bookcase at 33269,31830,4
	{
		itemId = 2437,
		itemPos = { x = 33269, y = 31830, z = 4 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The Seeds of Life
Spring is the time when the powers of the vital force are strongest. It is this time of the year when everything is growing and nature is vibrant of life. But not only nature is growing and giving birth, also the pure force of life is pulsating with energy and the power of creation. This energy often enters in living beings, making them stronger, healthier, and more fertile. Sometimes it enters in seeds of the most diverse plants. No one can tell what kind of plant may grow from these seeds, but many creatures instinctively feel the vital force in the seeds and collect them. Some creatures of nature think of these seeds as holy relics. They cannot stand the thought that those who they regard as defilers of nature could gain possession of such seeds. Therefore, the activity of those who see themselves as preservers of nature is unusually high in spring. Dryads and other creatures of nature who are hardly ever seen for the rest of the year suddenly appear in great numbers and often pose a threat to unwary travellers of the woods. The fact that the powers of the vital force infuse them with additional energy makes matters only worse. For some time, whole forests might be impassable while the trees seem to come alive. Roots try to snare and trap travellers, walls of rapidly growing tendrils and thorns block passages, and dryads and tree spirits ambush exhausted and tired travellers. Still, not all dryads are that hostile. Some of them are even willing to trade these special seeds for other items or help the finder to cultivate the seed into a magnificent plant. Sadly such helpful spirits are rare and as capricious as all dryads. So you never can be sure what exactly to expect from them. Stories are abound in which dryads deal seemingly peacefully with humans only to turn them into trees once they have earned their trust. Other stories tell about dryads that kidnapped humans and took them into their homes in some ancient tree where they had to work as servants forever. There are even stories about people who went to the dryads to trade with them or get some advice, and when they returned from their trips which had only lasted a few days, years or even decades had passed in their hometown. Of course most of these stories are fairy tales, exaggerations or outright lies, but mortals are well-advised to be extremely careful when dealing with dryads.]] },
		},
	},
	-- bookcase at 33269,31833,4
	{
		itemId = 2436,
		itemPos = { x = 33269, y = 31833, z = 4 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Misleading Myths
The veiled hoard of Zathroth is obviously only a myth. Ancient sages used it as an allegory to a certain state of mind. To reach the hoard is to unify the greatest and most complex secrets of the world. It means to understand them in such a natural way they can be weaved into a universal pattern that allows understanding the inner workings of the world. This would be an amount of knowledge that could only be called 'godly'. Of course no mortal being could reach such a level of understanding. The followers of this path strife for it nonetheless. This knowledge is by definition only limited, a mere stepping stone to the next level of understanding on a never ending staircase. The assumption that a hoard would actually need a physical representation of knowledge on the other hand, seems rather blasphemous. Why would a god need books and why would a god of secret knowledge risk to accumulate all forbidden knowledge at one place I ask? The story about Zathroth's hoard of knowledge is just that, a story. Everything else is a ridiculous theory of past days of unenlightenment.]] },
		},
	},
	-- bookcase at 33270,31836,4
	{
		itemId = 2437,
		itemPos = { x = 33270, y = 31836, z = 4 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The ghostlands
The ghostlands where already cursed since ages even in the founding days of carlin.
Unease befell those who wandered there and the area was avoided when possible.
After the female reign of Carlin was established and the independent city tried to expand its influence settlers were sent there to claim the nearby area.
Soon they where troubled by nightmares and bad omen. People hallucinated and became agressive if not even outright mad. Serial killings, berserk rages and strange but lethal accidents became commonplace until the people moved back to
the city. The queen was displeased but their citziens won't make another try. So the Queen sent the druids to cleanse the area. As their returned weary and wounded and three of them missing they, explained that the area was cursed, haunted and lost for humanity. The queen argued but the druids where adamant in their oppinion. The conclave of druids decided to seal the area with magic wards
and maically erected a hedge which they empowered with magic. The queen was not happy but did not intervene to stop them. Since then the area is known as the ghostlands (and several other nicknames suggesting the same).]] },
		},
	},
	-- small bamboo shelf at 33352,31123,4
	{
		itemId = 2463,
		itemPos = { x = 33352, y = 31123, z = 4 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Year 30 Tzuzak VII
Our forces are ready to strike now. We are only a few but we are dedicated to our cause. The dragons must die or everything is lost. I know they had arrived in desperate times. Although some of them looked weary when they arrived from the north, they were powerful and majestic beasts indeed. I assume they are the survivors of some great catastrophe but they did not want to talk about that and nobody wanted to push them. With all the losses due to plague and war, their promises to lead us to victory over our enemies sounded too tempting to resist. Moreover, there was no other option left. Which each victory their support amongst the people grew stronger. Tzuzak soon called for them and they nourished the king with favours like someone is feeding a pet snake with rats. Their influence over the court grew steadily and many of the officials were eager to please them to gain their favours as well. It became more and more obvious that the dragons had turned into the actual leaders. Some of us could no longer stand this situation. We gathered in secrecy to form an alliance against the dragons. Treachery is abound in this land, and we have to act now or all will be lost. We will strike this night at several key positions and hopefully not only cause considerable damage but also lead the people to oppose the remaining dragons. Tomorrow night I will know if our rebellion has been victorious.]] },
		},
	},
	-- bookcase at 33609,31897,4
	{
		itemId = 17870,
		itemPos = { x = 33609, y = 31897, z = 4 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
A Venture through the Oramond Fields, by Doctor Alaistar Stanton.


The Oramond Fields that surround the city of Rathleton hold many a marvel to behold. The grasslands are home to many small and larger animals, peaceful like the gloothworms and aggressive like the devourers. Indeed, glooth is what has given the fauna and flora of the isle its particular shape.
Studying old carcasses in the deeper earth layers have led me to believe the creatures may have looked differently in earlier centuries. Glooth residue varies in the bones, indicating the creatures absorbed it somehow and were changed by it - the bones are similar, but not quite alike those of today's animal inhabitants.
The flora of Oramond is less developed than the fauna. Again, I believe the glooth to be the reason. Though in earlier days, maybe the climate was milder too before the mists closed in. The few trees that grow in the shelter of the city centre are the last remnants of forests that must have once covered the southern grasslands. But when the weather grew colder and darker through the mist clouding the skies and keeping off the warm winds, they must have retreated. The gloothworms, revelling in damp and cold earth, spread, and I believe their soaking the earth with glooth residue must have prevented the tree seeds from growing again. The grazing animals consequently chose to eat more of the glooth-imbibed grasses, and adapted to the changed environment, while the carnivores, feeding on them in turn, absorbed the glooth through their prey.
Though much of this is still theory, I am confident that through ongoing research I will one day have a reliable amount of data on the natural history of Oramond to prove my assumptions right.]] },
			{ itemId = 2821, -- book
				text = [[
The Fauna and Flora of the Isle of Oramond, by Doctor Alaistar Stanton.

Chapter I: Ruling Species of the Fauna.

The flora and fauna of Oramond are, maybe, very ingrown in comparison to unknown lands where our own ancestors may have come from in the days before the mist. However, they form a beautiful and complex whole. The isle of Oramond shows signs of long-dead creatures that have arrived at different times here and, sometimes, strove for supremacy, leaving only inexplicable ruins, as well as signs of younger creatures that arrived maybe only some generations ago. However, the different species do not mingle and are often very reluctant to make peaceful contact.

I.i. Of Minotaurs and Men


Amidst the newer species, one must count the minotaurs and the humans. While the minotaurs are the newer arrivals, both have been settled here long enough to vie for supremacy of the island, trying to eradicate the other. Yet while our own origins are still shrouded in mist, there are ancient ruins on this isle that seem man-made. The minotaurs seem to have evolved on another island or continent though. They are not natives to this isle who left and returned when the mist lifted, but are new arrivals on this isle, which they immediately claimed as their own. Closer examination of their camps and habits led me to the hypothesis that they may have followed a call of some bold chieftain or supreme ruler of theirs, searching for a holy, paradisical land, which led them to the isle and which they must defend from the grip of barbarians, the humans.]] },
			{ itemId = 2832, -- book
				text = [[
The Old Man and the Sea Serpent. A novel by A. N. Onymous

Day 88
... He scanned the horizon. The turmoil of the waves that had lasted these three days now seemed to settle down, the sea not seething anymore, but instead, merely tossing and turning as the body beneath the waves lashed out less and less violently at the fishing line. "Ah, brother", the old man murmured, "you and me both." Perhaps not even he himself knew what he meant, but he felt a moment of closeness to the wild animal, not only connected by a fishing line, but by a far more insubstantial, and yet, more tangible thread. Blinking at the sun, he felt cold.]] },
		},
	},
	-- bookcase at 33631,31879,4
	{
		itemId = 17871,
		itemPos = { x = 33631, y = 31879, z = 4 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The Layers of the Worlds. A treatise on Life and Death, the Stars and Oramond. By Barnabas Dee]] },
			{ itemId = 2825, -- book
				text = [[
The Movement of the Stars. By Barnabas Dee]] },
		},
	},
	-- bookcase at 33636,31901,4
	{
		itemId = 17870,
		itemPos = { x = 33636, y = 31901, z = 4 },
		contents = {
			{ itemId = 641, -- piece of paper
				text = [[
"Finger Flights To Musical Heights" - Piano lessons, advanced level, grade 2.]] },
			{ itemId = 641, -- piece of paper
				text = [[
"The Apprentice Pieces", advanced level, grade 1.]] },
			{ itemId = 641, -- piece of paper
				text = [[
"The Key To Chamber Music" - Piano primer grade 1.]] },
			{ itemId = 641, -- piece of paper
				text = [[
"The Scales To Success" - Piano primer grade 2.]] },
		},
	},
	-- bookcase at 33649,31886,4
	{
		itemId = 17870,
		itemPos = { x = 33649, y = 31886, z = 4 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The perilous adventures of captain caveworm Pt. I
The saga of captain caveworm begun with a daring couple of cave explorers. After their wedding the two scientists decided to go on a rather unusual honeymoon trip and to explore some recently discovered caves together. Venturing into the unknown depths beneath Rathleton they became cut off from their return route by a cave in. Using their unique knowledge of the subterranean flora and fauna they managed to survive and build a shelter to await some sort of rescue. Because they were assumed dead this rescue never arrived though. As time passed they became aware that they would have to work on their rescue all alone. This became more complicated by the pregnancy of the wife. They decided to focus on survival first and to find a way to escape later on. The husband begun the capture and training of caveworms, a more social and less dangerous cousin of the rotworm. They were used as means of digging, hunting for food and providing some protection against the more aggressive rotworm colonies nearby. For a while some sort of stability was achieved and the woman gave birth to a boy. Due to unforeseen complications in birth the wife never fully recovered from pregnancy. So it was up to the husband and his caveworms to provide them nourishment and shelter. The attacks of the rotworms continued and became even more fierce. The couple did it's best to raise their child and give it the best education they could provide under this circumstances. At some point the wife's strength finally failed her and she died in her sleep. The grief stricken husband was ridden with guilt and his spirit broken. So one day he let his guard down and their shelter was overrun by rampaging rotworms. He sacrificed his life to allow his son to escape, accompanied by their most trusted caveworms. That much could be deduced by later excavations and reading some remaining notes of the couple and also due to remarks of captain caveworm to some of the people he met and befriended. What then had happened to the boy is a wild mix of myth, speculation and deduction.
It seems the caveworms kind of raised him as one of their own and he learned to live in the caveworm way. It is said that the caveworms discovered a small colony of worms that were closely related to the goothworm and yet astonishing different on several regards. The kid used them as one of his food sources what begun to change him even more than the environment and his foster parents already did. He developed uncanny senses and his teeth and fingernails became incredibly hard and sharp. He also acquired a high grade of agility and a flexibility of his body to wind his way even through the narrowest and winding tunnels.
For some years he lived the adventurous life of a caveworm until one day the rotworms found his new home. This time though the youth would not flee but use his new found powers to fight back. He managed to slay the murderous worms but his new shelter was destroyed and his foster parents were killed.]] },
			{ itemId = 2831, -- book
				text = [[
The perilous adventures of captain caveworm Pt. II
He lonely roamed the caves for a while but eventually the youth begun to long for human companionship and used his skills to search for the people of his parents. It seemed the first people he encountered were some simple glooth farmers in some remote caves. They befriended the shy kid and took him in. He once more showed his ability to adapt and soon grasped the concepts of human society. But not all he learned though appealed to the youth who had grown up with the lectures of his scientific parents and the simple but just way of the caveworms. The kid got himself into some fights against what he saw as unjust and oppressive and he had to flee once again. This time he returned under the cover of a made up identity and kept a low profile. Since his sense of justice had not been diminished he created yet another identity, that of a masked freedom fighter whose uniform bore the likeness and symbolism of the caveworms. For a while 'the worm' appeared out of nowhere, where the weak were severely mistreated, to bring them freedom and punishment to their oppressors.
This culminated into a battle against a powerful factory owner who not only abused his workers but also secretly planned to take over the city. After years of battles in the shadows this lead to a desperate attempt of the factory owner to hastily use his private army to overthrow the government before his schemes were revealed to the public. He might have succeeded if not for the masked figure who managed to lead a huge army of caveworms and other subterranean beasts against him.
The factory owner was defeated and his mysterious opponent disappeared into the darkness of the caves once again. In the gloothpapers he first had many new names like 'the worm general' but soon the public begun to call him captain caveworm instead.
In the days to come the mysterious man would switch more and more to fighting powerful criminals who he saw as a more immediate threat for the people. And indeed there seemed to be no shortage of freaks, mad scientists and criminal masterminds to keep him occupied. Some of the most notorious arch enemies that Captain Caveworm acquired over the years were the nefarious Dr. Dentist, the seductive Minowoman, the sinister Mean Green, the lethal Glooth Fairy and the powerful Pulverizer.
The captain never made a public appearance and his existence is shrouded with myth and rumours.]] },
		},
	},
	-- bamboo shelf at 33958,31498,4
	{
		itemId = 2459,
		itemPos = { x = 33958, y = 31498, z = 4 },
		contents = {
			{ itemId = 2815, -- scroll
				text = [[
trade goods for next shipment of captain Gulliver:

- 50 amphoras of spice oil
- 400 ounces of black pearl powder
- 120 copper ingots
- 30 crates of incense
- 350 rubies
- 60 coral figurines
- 100 crates of papyrus
- 40 ounces of hummingbird feathers
- 60 bales of silk]] },
			{ itemId = 2819, -- parchment
				text = [[
You read some hastily scribbled notes: "Second interlocution with Lord Eshaya ... still unwilling to sell tagralt ... unacceptable to withhold such precious resources from Rathleton ..."]] },
		},
	},
	-- bookcase at 32003,32804,5
	{
		itemId = 2438,
		itemPos = { x = 32003, y = 32804, z = 5 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
Treasures of the Southern Isles

Quite a few pirates hoarded up treasures in the past. It is known that pirates tend to hide their treasures on deserted islands for some unknown reason. They just bury them on some remote place and then forget about them. This similarity to the behaviour of squirrels was never scientifically verified. However, since pirates love to dress lightly they also love the south. Therefore, it is only natural that they hide their treasures there. Some of the southern isles are so popular among pirates that there is hardly any free space left to bury new treasure.

If anyone ever is looking for treasures, then those isles are the best place to start with.]] },
			{ itemId = 2828, -- book
				text = [[
Catalogue of Hooks for the Stylish Pirate]] },
		},
	},
	-- bookcase at 32003,32805,5
	{
		itemId = 2439,
		itemPos = { x = 32003, y = 32805, z = 5 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Parrot and Me]] },
			{ itemId = 2821, -- book
				text = [[
A Pirate's Memoir]] },
		},
	},
	-- bookcase at 32003,32806,5
	{
		itemId = 2440,
		itemPos = { x = 32003, y = 32806, z = 5 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Treasure Hunter's Manual]] },
			{ itemId = 2832, -- book
				text = [[
The Quara, Curse of the Seas

No one knows where they really come from. It seems the murderous quara are living deep down in the ocean in unknown numbers. From there, they plot their raids on the surface in which they cause havoc and mayhem. The quara consist of several subspecies whose relation to each other is still unknown to men. Given their hostile disposition, it is unlikely that we will ever learn more about them. For most humans it is sufficient to know that a quara means danger. Those who are able to fight them should kill them, those who are too weak should avoid them by all means.]] },
			{ itemId = 2826, -- book
				text = [[
Parrot Training]] },
		},
	},
	-- bookcase at 32007,32801,5
	{
		itemId = 2435,
		itemPos = { x = 32007, y = 32801, z = 5 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
101 Sailing Songs]] },
			{ itemId = 2821, -- book
				text = [[
The Shattered Isles

Nargor is a hostile rock surrounded by treacherous reefs. Since it is uninhabitable and almost unreachable it is of no interest.

Treasure Island is not only desert-like but also quite deserted. The only people you meet are treasure hunters that travel there occasionally to try their luck.

The inhabitants of the town Liberty Bay live on the numerous plantations. The town has developed into a major trading center in recent years, and is under Thaian rule.

The Forbidden Islands to the north-west are dangerous not only because of the volcanoes that are found there but also due to frequent quara activity. Since there is no real reason to visit these islands, no regular shipping route was ever established.

The Laguna Islands are quite often visited by passing ships to refresh their supply of water and food. Still the isles are too desolate to establish a settlement there. It is rumored that a small tribe of savages calls one of the isles its home.]] },
			{ itemId = 2827, -- book
				text = [[
Flags of the World]] },
			{ itemId = 2828, -- book
				text = [[
Plundering Made Easy]] },
			{ itemId = 2825, -- book
				text = [[
A Pirate's Life for You]] },
		},
	},
	-- bookcase at 32008,32801,5
	{
		itemId = 2437,
		itemPos = { x = 32008, y = 32801, z = 5 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Become a Pirate in a Week: Ten Easy Steps]] },
			{ itemId = 2826, -- book
				text = [[
Since sightings have been reported by many respectable seamen the existance of the golden whale can no longer be dismissed as a fairy tale. It is said that this whale is as huge as an isle and its body is made of purest gold. Even though many of the reports were made by seamen in the southern seas sailors of the north also claim to have seen this creature. All over the world the sighting of the golden whale is seen as a good omen. No one has yet been able to even hurt the beast; however, several inventors and mages have come up with ideas for the creation of a weapon that might pierce its golden body.]] },
			{ itemId = 2824, -- book
				text = [[
The Klabautermen
The klabautermen are a race of impish, mischievous beings that live on ships. Using invisibility and other magic, they remain unseen most of the time. But be warned, if you antagonise the klabauterman of a ship, his harmless pranks will turn dangerous.
In general it is a smart move to keep your klabauterman happy with little presents
and a lot of rum.]] },
			{ itemId = 2816, -- book
				text = [[
The Great Sea Serpents

The Sea Serpent is as huge as a house and can swallow a small ship in one bite. Its scales are almost impenetrable and its teeth, which are as big as a cyclops, are coated with a corrosive poison that will dissolve human flesh on touch. In their undersea lairs they hoard treasures that would make a dragons hoard look miserable.]] },
		},
	},
	-- wardrobe at 32035,32276,5
	{
		itemId = 2427,
		itemPos = { x = 32035, y = 32276, z = 5 },
		contents = {
			{ itemId = 637, -- document
				text = [[
Fishing Master Certificate


Awarded to Santiago Fuentes by the Tibian Fishing Association TFA.]] },
		},
	},
	-- bookcase at 32075,31885,5
	{
		itemId = 6369,
		itemPos = { x = 32075, y = 31885, z = 5 },
		contents = {
			{ itemId = 637, -- document
				text = [[
This is written proof that Captain Plunderpurse gave away all the cursed gold to the little kiddies, bless his generous heart. No torture, extortion, cut off limbs, manipulation or embezzlement at all was involved in my testimony, I swear! And I am very thankful not to make the acquaintance of the Captain's pet sharks, lovely beasts though they are. Signed, Triomon Tangleweed, certifying notary.]] },
			{ itemId = 2827, -- book
				text = [[
Treasures of the Southern Isles

Quite a few pirates hoarded up treasures in the past. It is known that pirates tend to hide their treasures on deserted islands for some unknown reason. They just bury them on some remote place and then forget about them. This similarity to the behaviour of squirrels was never scientifically verified. However, since pirates love to dress lightly they also love the south. Therefore, it is only natural that they hide their treasures there. Some of the southern isles are so popular among pirates that there is hardly any free space left to bury new treasure.

If anyone ever is looking for treasures, then those isles are the best place to start with.]] },
			{ itemId = 2829, -- book
				text = [[
The Great Sea Serpents

The Sea Serpent is as huge as a house and can swallow a small ship in one bite. Its scales are almost impenetrable and its teeth, which are as big as a cyclops, are coated with a corrosive poison that will dissolve human flesh on touch. In their undersea lairs they hoard treasures that would make a dragons hoard look miserable.]] },
			{ itemId = 2831, -- book
				text = [[
V.i Part 2: The Age of Chaos

However, for all their efforts, the gods could not create creatures that were a match for the ruthless, well-organised hordes that roamed the land. The wolves' hides and the spiders chitinous exoskeletons could not resist the steel of the orcish blades, and for every troll that was brought down by poison two others came to take his place. In the end gods' children withdrew to areas that were easy to defend: The wolves fled into the depths of the forests, while the spiders hid deep in caves. There they continued their fights, defending their realms against the onslaught of the superior enemy. These little pockets of resistance were the only sanctuaries in a world that sank deeper and deeper into chaos. And the worst was yet to come, for now the dragons felt the time had come to take what was theirs by right!

For centuries they had propagated and expanded in silence, largely unnoticed by all other creatures. But now that Garsharak, the very first and strongest of their race, sent them into the world they knew neither restraint nor mercy. The orcish armies were routed by the relentless flames of magical dragon fire, and soon that proud though barbaric race, who until then had not known the meaning of the word defeat, was driven into the shelter of subterranean settlements. Their allies, the mighty cyclopes, fared no better. Although they won a number of notable victories using their powerful weapons and armour, they, too, had to yield to the superior power of the dreaded dragons. They joined their former allies, the orcs, and their weak cousins, the trolls, in their subterranean exile. Their proud cities that had been built in the course of centuries were burnt down to the ground, and their renowned forges were lost forever.

Thus the dragons had taken over the rule of the land, but the war was by no means over. Their bitter enemies, cyclopes and orcs, resented what they felt was an imprisonment in the bowels of the earth, and they continued the fight from their subterranean hideouts. And in fact the dragons, who had already been weakened in the course of the previous battles, suffered serious losses. But now war also erupted among the former allies, as cyclopes and orcs competed for food and space in their subterranean abodes. And even though no side was strong enough to overcome the others the war went on with undiminished force, and all of the races suffered greatly in the epic struggle. The land was scattered with bodies, and while it seemed that life itself would be wiped from the face of Tibia the losses of all races that were involved daily grew in number. It was as if the living would drown in the bodies of the slain.]] },
		},
	},
	-- bookcase at 32121,32676,5
	{
		itemId = 2435,
		itemPos = { x = 32121, y = 32676, z = 5 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
51595646114145190584521765219727830464879636612527578967212778894388727857261185764217614588952196180031651288899751121615127215196805970]] },
			{ itemId = 2816, -- book
				text = [[
A shrinking potion
Take 2 powder herbs, a stone herb and a orange star. Cut them into small pieces and put them in a pot. Add a bottle of snake blood and boil it.
If you've done it right, the potion should be thick.
Wait until it's cold and then add the last ingredience, a 2 inch piece of a swamp plant.
This should make the potion green and much thinner. Fill it up in bottles and it's ready to be used]] },
			{ itemId = 2821, -- book
				text = [[
Beware of the bonelords!
The bonelords are an ancient race of underground dwelling necromancers. Although they can 'speak' like humans using some membranes, their native 'tongue' consists of a blinking code with each eye, where a blinking could mean some syllable, letter or word. It is by far the most complex speech we have ever encountered and it is almost impossible to comprehend. As far as we can tell it is not only a language but also some kind of mathematics. This combination makes it tedious even to try to understand that language.
The books the bonelords write contain only numbers and the code behind them is incredibly complex. This race was one of those which were part in the creation wars and therefore its peak of civilization and power is long gone. There are rumours about still existent bonelord settlements where they try to improve their unspeakable necromantic rituals and create an army of undead.
In general they seem malicious but without any ambition to do more than to claim some lairs and to defend them. They seem to have no ambitions in conquering or allying with other races in a bigger style other than bonelord mercenaries who occasionally join forces with other entities for private reasons.]] },
			{ itemId = 2821, -- book
				text = [[
Heresies of the new age
Some people claim that the soul vortex was not a creation of the gods. They argue that the sheer concept of souls from 'beyond' entering our realm is by all means very random and could not be planned at all. They suggest that it's a lot more likely that the vortex was actually some damage that was caused to the fabric of reality. Through this hole in reality souls that were never meant to be entered our realm and, so they assume, it's additionally a leak that leaches away the power of the gods. They suggest that war for creation was NOT interrupted because the gods wanted to heal the wounds of the world, but because this powerleak frightened them that much. They further speculate that the withdrawel of the world was more an act of panic, an attempt not to lose complete control over creation, and the process known as awakening is by no means the working of benevolence, but the gods losing grip of the things they tried to hide away from the intruding souls. The theory goes that as there is an ascension for the souls from beyond to achieve some form of godhood, there is a constant descent for the powers of the gods of old due to the power that is leaking away into nothingness and the power the living claim for their own. Of course this heresy is very popular in the ranks of certain ascension cults. More so since it takes care of the more common fear in those conclaves, that the jealous gods may strike back on those who try the ascension.]] },
			{ itemId = 401, -- book
				text = [[
I, GHOUL
By Himhor

Within this obscure essay lies a remarkable study of a dwarf who poses as a ghoul to view what life is like from the Ghoulish point of view. A particular emphasis of the work is the fascinating ghoulish healing habits, which the author presumes to be, unlike many warriors thinks nowadays, an effective romantic ritual which ghouls aims to the creatures they do found appealing somehow.]] },
			{ itemId = 2821, -- book
				text = [[
The Blades of Darkness
Three pirate kings of old made a pact with the powers of darkness and got rewarded with three dark blades of immense powers. No enemy survived an attack with one of these blades. It is said that they allowed their owners to know whenever other ships were near and that storms and wind could be called with the blades to assist in the evil plots of the pirates. The end came at the day on which these pirates decided to betray each other. In a sea battle they called for storms of such intensity that all of their ships sank. None of the pirates survived. The blades have vanished since then. It is assumed that they are lying at the floor of the ocean.]] },
		},
	},
	-- bookcase at 32122,32676,5
	{
		itemId = 2436,
		itemPos = { x = 32122, y = 32676, z = 5 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
The great book of firemagic]] },
			{ itemId = 2829, -- book
				text = [[
The Great Sea Serpents

The Sea Serpent is as huge as a house and can swallow a small ship in one bite. Its scales are almost impenetrable and its teeth, which are as big as a cyclops, are coated with a corrosive poison that will dissolve human flesh on touch. In their undersea lairs they hoard treasures that would make a dragons hoard look miserable.]] },
			{ itemId = 2816, -- book
				text = [[
The Klabautermen
The klabautermen are a race of impish, mischievous beings that live on ships. Using invisibility and other magic, they remain unseen most of the time. But be warned, if you antagonise the klabauterman of a ship, his harmless pranks will turn dangerous.
In general it is a smart move to keep your klabauterman happy with little presents
and a lot of rum.]] },
			{ itemId = 2825, -- book
				text = [[
The Lair of Xemal Xoth
Liches are creatures of power that instill terror even in the hearts of the bravest heroes. The lich Xemal Xoth was one of the more notorious of his kind. He was superior to most of the liches and several of them had to follow his orders. In his early days, he enslaved the whole area of Drefia. He reigned supreme until a fraction of the liches tried to overthrow him. They were defeated and put to eternal torment as a warning to enemies and minions alike. Still the forces of Xemal Xoth were weakened and his ranks thinned out. Seizing that opportunity, a mighty circle of necromancers attacked Drefia and the lich had only a narrow escape. Seeking refuge in the pyramid city of Ankrahmun, he served under the Pharaoh and God-King Arkhothep as an advisor and court magician. But serving did not suit the taste of the vain lich and after some years he left the city to follow his own dark agenda. It was at this time when he secretly started to construct his lair. At first it served as a depot for the knowledge and treasures he had rescued from Drefia and acquired in Ankrahmun. Later he began to station his most powerful undead guardians and creations there. Still he was looking for some other centre for his power. A place where he would reign supreme once more. But by and by, his efforts concentrated on his secret lair with which for some unknown reason he became more and more obsessed with. He waged an half-hearted attempt to overrun Darashia with the aid of a handful of vampire lords and their minions. But after the tides of battle turned against them and seemed to favour the pious citizens of Darashia and the heroes that came to help, he abandoned Darashia without further thought. Several other incidents, involving undeads from all over the known world, can be traced back to Xemal Xoth but none of them seemed serious enough to pose a real threat. As the construction of his lair made further progress, he withdrew more and more from the world. So it is no wonder that his name has almost been forgotten today. The motives of Xemal Xoth can only be guessed, but they are certainly nothing good for the people of Tibia. Whatever he is concocting in his lair, it can only be hoped for that he is stopped before he succeeds in his evil plans.
The search for him, however, appears to be almost impossible since no living being seems to know where to find that secret lair. It can only be guessed that he learnt about some place of power and somehow keeps it under control. There are no real clues that can help us in this matter.]] },
			{ itemId = 2827, -- book
				text = [[
The liberators of the spark by Sericos
Also known as liberators of light and several similar names this Banor sect is dedicated to the so called 'liberation of the godly spark' from the unworthy. In theory they agree upon the doctrine of the Banor cult that each human and probably some of the non-human races are born with a part of the divine essence in them. Whereas other cults are dedicated to make this spark flourish for the good of the individual or civilisation, the liberators argue that certain persons are not worthy of the godly spark and it is better to set the divine essence free by killing them in ritual combat. Certain splintergroups of the liberators go even further and claim that a person can claim the divine essence of those slain to strengthen themselves. So this heresy led to two equally dangerous and forbidden subsects of the banor cult. While the original heretics killed only criminals after their foundation, the term 'unworthy' soon became more widely defined, and they began to slay cowards and everyone they considered weak. The so-called 'new liberators' brought this heresy to another equally mad degree. They argue that if you can claim the divine spark of others by killing them you should not target the weak, but the mighty. They 'honor' their victims in duels and admittedly more then one new liberator met his well deserved end at the swordtip of an opponent far superior to him. Still there ARE a considerable number of new liberators around and doing their perverted work for their god. The church of Banor in turn has outlawed both heresies and affiliation with either of those sects is punished with lifelong laborcamp or execution.]] },
		},
	},
	-- bookcase at 32123,32676,5
	{
		itemId = 2436,
		itemPos = { x = 32123, y = 32676, z = 5 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
As long as the four guardians are alive, the door that leads to the inner sanctum won't open. Only the blood of the guardians opens the lock. The crucial point is to locate the guardians. They are hidden at spots where no one would suspect them, disguised as ordinary creatures that inhabit this world. The Eye of Xandalos might be of help to locate and identify them.
If close enough to the guardians, it works like the "find person" spell. Considering the cost of its usage, it is out of question to use it without further thought. The construction of an Eye of Xandalos is an entirely other issue though.]] },
			{ itemId = 2825, -- book
				text = [[
The Witches' Grotto
On a remote isle in the South there is a grotto where all witches come together to celebrate some demonic festivity once a year. They teach each other new malicious tricks to torment other beings. The legend goes that everybody that dares to disturb them is put to death or faces a fate even worse than death. But if you manage to step into their dancing circle at the height of the ceremony, the witches have to fulfil you a wish.]] },
		},
	},
	-- drawers at 32306,32174,5
	{
		itemId = 2434,
		itemPos = { x = 32306, y = 32174, z = 5 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Royal Execution Archives 900 - 950 post genesis

900 p.g Hanging of Isaac Brewton for claiming satanic influences rule the course of history. Especial notice is drawn to his assertion that all objects stay in place or move due to lucifer's plans.

912 p.g Execution of Hamilton Fush on the stake for his continuing support of Brewton's thesis. Additional punishment for his claim that child sacrifice could change the course of satan's plans.

913 p.g Hanging of Gabriel Fush, brother of Hamilton Fush, for his public support of his brother.

943 p.g Execution of Alistair Cropwell. Originally in his majesty's service sent to further HRH glory by exploring the world, he became mad and claimed the existence of another empire besides that of our glorious sovereign. Because of his past services he was buried honorably in the graveyard dungeon.]] },
			{ itemId = 2816, -- book
				text = [[
Royal Execution Archives]] },
			{ itemId = 2816, -- book
				text = [[
Royal Execution Archives]] },
		},
	},
	-- drawers at 32306,32175,5
	{
		itemId = 2434,
		itemPos = { x = 32306, y = 32175, z = 5 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Royal Archives - 943 p.g

Concerns: City graveyard

HRH has ordered an expansion of the city graveyard to the east, due to the increased demand for resting places. It is hoped that the eastward expansion will avoid problems with the undead experienced with previous graveyards closer to the city entrance.]] },
		},
	},
	-- drawers at 32306,32176,5
	{
		itemId = 2434,
		itemPos = { x = 32306, y = 32176, z = 5 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Royal Archives

Asmalat ovrir gogenol amabat hulut a sese sokol. Gogenol faresmal a sese ican.]] },
		},
	},
	-- drawers at 32306,32177,5
	{
		itemId = 2434,
		itemPos = { x = 32306, y = 32177, z = 5 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
The dwarfs, who are well versed in the depths of the earth, know strange tales of weird places and creatures they encountered in the bowels of Tibia. Some of them might be discarded as fairy tales (of course not in the opinions of the dwarfs), but I dare to say that most of them are true. There is one kind of story which you can hear by all kind of dwarven tribes, all describing the same things. These stories tell about some vast structures underground that seem to be the remains of an ancient civilisation. The long-abandoned structures in these stories share striking similarities. Oddly, these structures are found at places in totally different environments and often also far away from each other. Some widely travelled dwarfs claim to have seen similar things in remote continents and isles. Sometimes only a few bricks at some odd place hint at one of these ancient structures. Others, however, are well preserved ruins in which even some rooms are still recognisable. Obviously, the ancient race that once lived in these structures had colonies all over the known world. Some theories try to link these structures to the extinct Morad race - a race of nomadic builders that supposedly left their traces all over the world. The recent researches of Fordworth, though, seem to prove that the Morad used a fast growing crystal substance for their buildings. These crystals, however, only lasted for a dozen years. So nothing the Morad had built would have endured until today. If we compare the aforementioned dwarven records with those of several dungeon crawling adventurers, however, we learn that some of these ruins, sometimes separated by continents, were inhabited by a brutish race of savages. It seems likely that whoever built those structures brought these creatures with them to serve as guardians and workers. When the creators abandoned their structures, they left their servants behind. They, however, were unable to maintain them properly. But who are the ones that built these structures? It seems unlikely that there was another nomad race. Why would they leave their servants behind when moving to another location? My theory is that the structures were used to gather resources. Just like the dwarfs, this race sent out many prospectors to look for a specific resource. Whenever they encountered a vein, they stationed some constructors and their workers. Since there are still workers left at some of these places, the race must have abandoned them in a haste. This of course suggests that valuable information and artefacts might have been left, too, some of them probably in the hands of these brutish workers. This is certainly worth an expedition. If I were to find a sponsor, I would helm an expedition of my own into the depths of Tibia.]] },
		},
	},
	-- drawers at 32306,32178,5
	{
		itemId = 2434,
		itemPos = { x = 32306, y = 32178, z = 5 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Royal Archives Criminal Offences 900 - 950 p.g

900 p.g. Theft of duck by Threpwood Guybrush. Fine of 10 gold.

911 p.g. Attempted assault by Nostradamus Untru. Fine 20 whippings.

911 p.g. Robbery by Homer Vason. Prison sentence of 2 years.

912 p.g. Robbery by Angus Krome. Prison sentence of 3 years.

913 p.g. Assault by Nostradamus Untru. Prison sentence of 1 year.

920 p.g. Burglary by Winston Roper. Prison sentence of 3 years.

925 p.g. Theft by Alison Farmer. Fine of 30 gold.

935 p.g. Poaching by Winston Roper. Fine of 70 gold.]] },
		},
	},
	-- drawers at 32308,32173,5
	{
		itemId = 2434,
		itemPos = { x = 32308, y = 32173, z = 5 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Royal Archives - 960 p.g

Concerning: Graveyard rumours

HRH has issued orders that the continuing rumours about a dungeon entrance at the graveyard be publicly denied and then ignored as they are obviously untrue.

No further action is to be taken.]] },
		},
	},
	-- drawers at 32308,32175,5
	{
		itemId = 2434,
		itemPos = { x = 32308, y = 32175, z = 5 },
		contents = {
			{ itemId = 2820, -- sheet of paper
				text = [[
Dear Flora,
I just returned from my visit to the kings court in Thais. Along with other nobles I was invited to a diner with the crown prince of Thais Rodmund II. He seems a rather shy and reclusive boy. We had not the chance to talk much to him but if it were not for his advisors, the brothers Wisbert and Madol, the heads of the church of Uman and Zathroth respectively, I'd fear for the wellbeing of the realm. The boy seems pale and unhealthy. He had obvious problems to follow any conversation and word at the court is that the untimely death of his father made the boy even more timid then he was before. We were assured though, that the council of nobles and the two grand priests of the both most influential churches were guiding him and leading his hand. The brothers Wisbert and Madol were indeed impressive men of wisdom and charisma. Their eloquence was almost intimidating and beyond their calm demeanor I sensed some kind of animosity between them. Perhaps it was just their way though and their witty remarks and retorts fooled me. They are brothers after all. Both are men with vision though and when they both fully agreed on how our realm should handle the challenges ahead I'm confident these brilliant men will grant security and stability for our beloved country.
I also visited the royal stables and let me tell you, that you'd might be in for a nice surprise when I return home.
Count Allstio sends his regards. He feels sorry that he won't be able to attend our summer feast but he'll be on an expedition to some foreign land by then. You know Allstio and how secretive he can be (I even heard he built some sort of cryptlike retreat in that awful Greenclaw Swamp) so this is all of information I can offer you.
I hope you and the kids are well,
yours,
Dargen]] },
		},
	},
	-- drawers at 32308,32177,5
	{
		itemId = 2434,
		itemPos = { x = 32308, y = 32177, z = 5 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Royal Archives - Inhabitants Log 900-950 p.g
(incomplete due to fire damages)

Homer Vason, 905-939pg Sunset Homes, Flat B

Alison Farmer,931-942 pg, Sunset Homes, Flat A

Threpwood Guybrush, - 911pg, Sunset Homes, Flat C

Alistair Cropwell, 919-930 pg,942-943 pg, Sunset Homes, Flat A]] },
		},
	},
	-- dead human at 32590,31799,5
	{
		itemId = 4240,
		itemPos = { x = 32590, y = 31799, z = 5 },
		contents = {
			{ itemId = 2820, -- sheet of paper
				text = [[
Dear Caramelia,
whatever may happen, my heart will be yours and with you forever. And in the darkest of all hours remember one thing:
True love never dies!
Your Winfred]] },
		},
	},
	-- drawers at 32943,31471,5
	{
		itemId = 2433,
		itemPos = { x = 32943, y = 31471, z = 5 },
		contents = {
			{ itemId = 641, -- piece of paper
				text = [[
<this is a ripped page, probably from a diary>
IV. 7th
Everything is so strange... two nights ago the weirdest thing happened... I fell asleep during the night watch at my brother's bed, must have been only for a few minutes, but when I opened my eyes, I saw a black... being... hovering over Arthei's bed, getting closer and closer to him. I wanted to jump to my feet and scream, but I was unable to move. All I could do was dig my nails into my own flesh. Then suddenly, the being looked directly into my eyes. I remember thinking 'how strange', because the creature had no face and thus no eyes, yet I knew that it was looking at me. Then I couldn't bear the cold of its look anymore and passed out. I don't know what happened afterwards. All that matters now is that Arthei has recovered. And with recovered I mean that there is not a SCRATCH on him anymore. He is completely well, I'm not able to explain why, but I don't care. Kala is crying for joy, I think the black being wasn't evil, but a god.]] },
		},
	},
	-- bookcase at 32954,31471,5
	{
		itemId = 2435,
		itemPos = { x = 32954, y = 31471, z = 5 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
Recipe of the Day: Virgin Colada

Ingredients:
- Virgin, preferably female and young for the best taste

Bite. Squeeze. Shake. Enjoy.]] },
		},
	},
	-- large trunk at 33272,31797,5
	{
		itemId = 2483,
		itemPos = { x = 33272, y = 31797, z = 5 },
		contents = {
			{ itemId = 2820, -- sheet of paper
				text = [[
My dear friend,
as your former teacher and mentor I am pleased by the eagerness you show for your researches, but there are certain things I want to remind you about. First of all, the magic the Yalahari used for their golem creation might as well be based on a entirely different magic system. Just like we cannot use the magic of the mysterious voodoo with our scholarly magic, it might be similarly impossible to use the Yalahari ritual if we were able to get hold of it. It is far more likely that we will have to understand what the ritual does and then try to recreate its effects with our own magical approach. I do not need to point out what a tedious and time consuming process that would require. It is entirely possible that the process would last more than a lifetime to be accomplished. Even if we stumbled on the original ancient rituals involved in the process of golem creation and found the used magic to be similar to our own, we would still face the problem that we were playing with forces which we do not really understand which involves certain risks that better be avoided (but I know that I am talking to deaf ears here given your eagerness to follow your ideas). At a last point I want to remind you that magic as the predominant science in our world has made most other sciences almost obsolete. So we know certainly less about metallurgy and mechanics than the Yalahari did. I strongly recommend to consult the dwarfish technomancers on this issue. They possess the most knowledge concerning these subjects in our world and though they are not known to share their knowledge with outsiders, they might be the only way to gain a glimpse of understanding the nature of the mechanical golems. As long as we do not get help from the technomancers, I strongly recommend to concentrate your researches on the rituals, and to use parts of old and destroyed golems you might acquire one way or the other for your studies. It would not be useful for your researches to wear out your mental and physical resources by trying to solve both problems at once. I will continue my own researches as good as possible from here and keep you informed of every progress I make.
Your friend M.]] },
		},
	},
	-- bookcase at 33273,31797,5
	{
		itemId = 2435,
		itemPos = { x = 33273, y = 31797, z = 5 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
Yalahari Worker Golems - A Treatise
The specific golems that are used by the Yalahari have certain features that distinguish them from the more commonly known elemental golems. While certain physiological features are quite obvious, the most important difference is their mind function. They certainly possess some degree of intelligence that surpasses the instinctive level on which lesser elementals operate. Yet, they seem to lack a great deal of impulsiveness and individuality that is common among elementals. Like other golems some basic tasks can be implemented into their minds, and like parrots they can learn some basic phrases which they, unlike parrots, can use in an intelligent and intentional way. Actually their level of intelligence is only rivalled by certain necromantic golems and constructs that have been created by implanting existing spirits into the constructed body. Their lack of individuality makes it quite easy to control them, which by itself would already classify them as the most useful minions. However, what really lets them shine in the area of artificial servants is the composition of their brain (if the centre of a golem's consciousness can be called that way). Their brain is a certain crystal structure, not too different from the one of the rare crystal golems. Now, the most impressive breakthrough the Yalahari accomplished in the area of golem creation is the duplication of brain patterns from one crystal to another. That way the Yalahari were able to duplicate a certain behaviour of a trained golem into newly created golems. For this reason, newly created golems were almost instantly useful and ready for work. As an interesting side note, the same or at least a quite similar technique was used by the Yalahari to operate certain apparatuses and their so-called factories in which highly modified golems created objects in mass production. The usage of crystals by the ancient Yalahari must have been enormous. For their golems they used the easy controllable mindset of their crystal-stored mind patterns with an endurable and easy producible body of rather cheap metal. For that, they constructed basic metal castings that worked like enormous metal puppets. Using complicated but standardised clockwork mechanisms, they enabled these bodies to use certain forms of movement that usually followed the patterns of natural movement. The movement was amplified by the ingenious usage of physics and metallurgy as well as miniature steam engines. So far the creation of Yalahari golems is comprehensible, even if the mechanic of a golem's body is not fully understood and not reproducible with ordinary metal and alloys. What really baffled the scientific community was the way the two parts, the crystal core or brain and the mechanical clockwork body, worked together. It is quite certain that it has to do with magnetism, electricity and heat but the details are completely unclear. There certainly exists an overall enchantment on the golem but it seems so minor that it is supplementary at best. It seems that in our days no new golems are created anymore, so we must assume that the secret of golem creation might be lost. On the other hand, there is still a great number of existing golems and Yalahari artefacts that can be studied. This might be a chance to either recreate or emulate the process of golem creation which would lead to a tremendous breakthrough in the magical sciences.]] },
		},
	},
	-- bookcase at 33274,31797,5
	{
		itemId = 2436,
		itemPos = { x = 33274, y = 31797, z = 5 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Your Golem and You Volume 3
The second kind of known golems are necromantic golems. Some scientists of high renown question the relation between the two groups of golems but certain similarities hint at a common source. To create a necromantic golem a special vessel is created and prepared. Then a spirit is forced into the body. In a third step the body is animated and becomes some sort of prison for the bound spirit.
The similarity lies in the preparation of the body. The following ritual that forces a spirit into the body shows a striking resemblance of the ritual to create a consciousness in elemental golems. While in an elemental golem the created consciousness is by nature bound to the condensed core, the consciousness of a necromantic golem is the spirit that is bound into the golem.
The form of the necromantic golem is almost neglectable as the bound spirit is usually that of an humanoid who would have difficulties operating a body that has other physical features than a humanoid. The spirits bound by the ritual are usually old and drained that have lost conciousness long ago. Those souls are weak but connect best with the enchantments of the prepared body. Even if some malignant spirit is drawn into the construct, it usually becomes not the core consciousness but technically possesses the original weak soul instead.
Sometimes the creator of a necromantic golem manages to use the head or the brain of a deceased as focus to force the original soul to become the core of the necromantic golem. As this is already possible shortly after death, the anguish that originates from the reconnection with the world of the living causes severe damage to the sentience of the creature and leaves the construct usually mad and demented. Though the whole practice of necromancy is questionable at best, the latter experiments are only frivolous flirts with disaster and are doomed to failure. Even if the creation of necromantic golems can also be seen as another form of raising undead, it has become a science of its own. Skilful necromancers created fascinating variants of the basic ritual to bind animal spirits into corpses that can come in different shapes and sizes, and some even managed to create golems out of single body parts like hands.
The secrecy and prohibitions from which necromancy suffers led to an imbalance between a very small number of competent scientists and a large amount of self-styled necromancers that mess around without the necessary skills. They experiment with incomplete rituals and poor material substitutes resulting in much trouble and many accidents. Even if they live long enough to move further in theirs studies, those self-styled necromancers show neither knowledge nor respect to the roots of necromancy.]] },
			{ itemId = 2825, -- book
				text = [[
Your Golem and You Volume 2
The most common materials for golems are closely related to the element earth. Here the basic material follows the rule that the less hard the material in question is, the more easy it is to condense it to consciousness. The common assumption that softer materials are more prone to burnout, power failures and malfunctions is a misconception. Technically, the "soft" golems are not more faulty than their harder counterparts. Everyday praxis though shows that much less skill is needed to create them, so less skilled enchanters usually choose softer materials for their golems, leading to the great number of failures. Still, there is an issue with durability as the softer material is more vulnerable to the ravages of time than harder one. This can be compensated by the skill of the caster though. In theory, a caster that creates the easier "soft" golems can put more effort into the perfection of the durability of the enchantment. When creating a harder golem, he has to put more attention to the condensation of the consciousness and can spent less effort on durability. Given the different inherent durability of softer and harder golems, all in all the durability should be roughly the same.
The most common material for a golem is clay. It is quite easy to activate and the material allows easy additional, supplemental manipulation like the engraving of runes and glyphs that enhance the control over the entity or add certain capabilities. Clay is closely followed by certain forms of stone, though here significantly more talent is needed for the rituals. This is followed by various forms of metal. The manipulation of metal is not trivial though and the rate of failure rises tremendously. The most difficult creations are those made of crystal or gems. Already the creation of a gem huge enough to create a golem, let alone its modelling, is beyond the grasp of ordinary sorcery. Giant crystals are more common. However, the stability of such crystal formations is often lower than desired, and often, tremendous effort is wasted only to learn that the crystal was flawed from the beginning.
Other variants of elemental golems are speculated about, but yet, there is no solid proof about their existence. Given the scientific knowledge about problems that would have to be overcome, their existence is more than questionable.]] },
			{ itemId = 2825, -- book
				text = [[
Your Golem and You Volume 1
Scientists distinguish between two kinds of golems: elemental and necromantic. Elemental golems consist of primal elements and are magically that condensed that a elemental consciousness is formed. That way a quasi-elemental is created, sharing several characteristics with true elementals. In the process of their creation, such artificial elementals only possess a rudimentary consciousness. Sometimes, if the concentration of elements is not sufficient and no consciousness is created, it leaves the creator with nothing than an empty hull and a burned-out elemental core. Even if activated successfully, a careless ritual might leave the golem flawed, which sooner or later leads to a similar burnout of the core. A flawless golem will exist for many years, probably outliving its creator by far. This might not be desirable, though, as a golem's consciousness might grow over the years, giving him a certain sense of intelligence and unwanted individuality.
Even though in theory all elements qualify to 'spark' the necessary consciousness in a golem, their physical restrictions make certain materials more suitable than others. It is almost impossible to form a body out of air or fire that exists long enough to have the correct enchantments placed upon. Further, the lack of a physical body makes the magic charging of the hull next to impossible. Technically, air and fire golems are beyond the grasp of mortal sorcery. I only include these possibilities of golem creation because we knew it has been done under certain conditions and by gifted individuals or groups with tremendous resources. Water golems are similarly difficult to create, though this can be compensated by freezing water and giving it a solid form. Ice golems can be created, enchanted and manipulated by the usual rituals. The drawback is that a a thawing water elemental's core is subject to destabilisation and water, or better, ice golems are only of limited use. The climate to sustain ice golems is usually that uninhabitable to its creator that the effort of their creation is questionable, particularly considering the fact that there are golems made of more reliable material available.]] },
		},
	},
	-- bookcase at 33275,31797,5
	{
		itemId = 2437,
		itemPos = { x = 33275, y = 31797, z = 5 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
The Art of the Technomancers Volume 2
Both kinds of technomancers work on inventions and improvements. It is usual practice to built something to prove it can be done without any regards to applicability. For instance the technomancer Sileas built a fully functional artificial arm - which was 30 metres long and had a service tunnel for repairs and adjustments.
Later, efforts are made to improve the own work or that of a predecessor. With the patience of a dwarf that spans his whole long lifetime and even longer, they work on a project as long as it takes to finish it. The former mentioned Sileas commented on his finished gigantic arm that it might take only somewhat over 1000 years until an arm might be constructed that could be used as a prosthesis. The whole technomancy circles around inventions and improvements. Most technomancers concentrate on a single project. This is not necessarily part of the technomancy per se, but probably rather a product of the dwarven nature. Though technomancy has established a lot of formal rules that should ensure the safety of the technomancers and their surroundings, it is not uncommon that technomancers get injured by testing their machines. Aged technomancers often have lost limbs, their hearing or even their eyesight to their experiments. Astonishingly enough, death is a rare occurrence among these accidents which might proof that the traditional safety measures are elaborated enough to prevent the worst. Still, other dwarfs who are not exposed to risks in their own professions usually see the injuries of technomancers as sign of their carelessness which is only a prejudice given the existence of the technomancers' code.
As it is common that an invention is worked on over several generations, technomancers gladly share their knowledge among their own people. However, they are more than reserved when it comes to share this knowledge with an outsider. Only a few secrets are actually considered off-limits to outsiders due to some secrecy code, but most technomancers are unwilling to share even the most basic knowledge. It is assumed that this behaviour results from the fact that technomancers had to become outsiders of their society to learn these secrets, so they are not willing to simply share their hard-earned knowledge. Another reason for this secrecy is based on the fact that most technomancers consider even the most complete and polished invention as just not ready to be released to the public. No proud dwarf would ever share an invention with the public that is not absolutely flawless. Others again fear, and with good reason, the harm that could be done if their knowledge would get into the wrong hands and for this reason refuse to share their knowledge.]] },
			{ itemId = 2827, -- book
				text = [[
The Art of the Technomancers Volume 1
While most dwarfs cling to the principle of earth or fire, some individuals break with this tradition and rather follow the principles of what they simply call 'the machine'. This breach with the traditions is a rare act in a society like that of the dwarven race that knows hardly and changes or surprises. One might argue this is the only way a dwarf can do something extraordinary and it might rely on dwarfs with comparatively rebellious mindsets, but all technomancers encountered seemed genuinely interested if not obsessed with their technomancy. It might be debatable if it is rather a religion or a philosophy, for most technomancers it is the only profession they pursue. Unlike other dwarfs that follow the paths of earth or fire, technomancers usually only pick a profession that is directly related to mechanics. Even a farmer that followed the ways of technomancy was known to apply all kinds of self-made machinery to his profession, but this, as previously stated, is a really rare occurrence. Technomancy is not overly popular in the dwarven society. Only a handful of technomancers exits and perhaps a good dozen of apprentices. Other dwarfs respect the technomancers, but usually think of them as at least a bit odd. On the other hand, the dwarven society welcomes technomantic inventions now and then. For the dwarfs the adaption of such new technology is a slow process and it takes often years of testing and getting used to the new tool until it is truly accepted by dwarven society. Some of the more extraordinary inventions never leave the workshops of the technomancers. In particular, inventions that seem to have no direct, practical use and a considerable advantage compared to 'the old ways' have a hard time to be accepted. This leads to two kinds of responses by the technomancers: some just give in and try to built just what the community is ready to accept. Those are usually the more sociable technomancers that sometimes have extensive contacts outside their own society. Others bury themselves deeper and deeper into technomantic knowledge becoming more and more strange over the years. Those technomancers are often far away from the usual thinking processes of a dwarf, as they only think in formulas and numbers. Sometimes their grasp of communication becomes so different that they cannot communicate with dwarfs anymore that are no technomancers.]] },
		},
	},
	-- bookcase at 33649,31885,5
	{
		itemId = 6367,
		itemPos = { x = 33649, y = 31885, z = 5 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
When we arrived here by means I'm not allowed to mention, we found not an abandoned isle and save haven to build a secret base, but a populated and civilised kingdom. Unsure it we were to continue with our initial plan nonetheless I sent word to the other dreammasters for a decision. Meanwhile I sent scouts to watch the strange inhabitants of this new land and get as much information about them as possible. After verifying that they were at least not openly in league with demons or the brotherhood, I decided to make contact. The people we met were seemingly completely human, albeit somewhat pale and of an tired and disinterested attitude. Although they obviously had never encountered a dwarf, they paid my right hand man only little more attention then anyone else. And that was little enough. This already made me suspicious and as we were invited by their leader to dine with him as honoured guests I told my men to be on guard. I postponed the invitation under the ruse of affairs I had to attend before, so I could use the time to see if my dream would grant me some insight and wisdom. As it is known those dreams are never direct, neither prophetic but with all this screams, carnage and bloodshed in my dreams there was little to be mistaken. Yet I refrained, as dreams are treacherous if threatened with ignorance. How easy it is to cause all that you dreamed about by your own actions because of your dreams. So we prepared potent antidotes and runes to deflect any attacks or traps that might await us. King Julas as he was called was a gentle enough host and the feast if not splendid was appropriate. Yet at the serving of the wine the magic amulet I had donned warned me about poison. I silently informed my men as I had told them in advance. Each of us secretly used an antidote rune on himself while others of us distracted our host and his retinue. As the evening turned to night our host was becoming more and more nervous, obviously waiting for his poison to take effect. Smiling inwardly I turned the polite discussion to the ways of our order, casually mentioned that we were known to reward our friends well and deal with traitors and their ilk swiftly and without mercy. More and more that Julas became nervous and more and more my talk became more stern and threatening. Only thinly veiled I finally had told him that I was aware about his treachery and were prepared to retaliate. Finally he broke in and with a shrieking voice he ordered his guards to attack. I and my men were accustomed to fight enemies more fierce then those men who where numerous but trained as militia or city-guardsman at best. We made sort work and soon most of them surrendered. King Julas though had retreated already. I interrogated the men at arms and learned that Julas as his father before him ruled the island with an iron and oppressive fist after years of freedom and prosperity. We searched the castle for Julas, fighting through some of his remaining men who offered only half-hearted resistance before giving up.]] },
			{ itemId = 2828, -- book
				text = [[
As I mentioned we were no strangers to battle and the gruesome sights of war but none of us was prepared for when we found Julas, after hacking through the doors that guarded his personal quarters. Let us just say he had done 'things' to his servants and his own body. The walls were smeared with blood in patterns that reminded me on magic symbols. He was barely alive, more then could be said about his poor servants, a dozens or so. And there was madness in his eyes. A madness that was so deep and intense that you could not stand the look of his eyes for long. He was babbling incoherent sentences and giggling and laughing all the while spittle dropped uncontrollable from his mouth. With his mutilations he might not have survived the night anyway but I was taking no chances. I had a pyre constructed and got rid of him before the turn of midnight. None of his subjects objected. That alone was proof I was right to do that. I assumed now things would take a turn for the better now. I assumed reign over the city awaiting the people to show some rightful successor I could accept and planed to go on with the construction of a base for our order. But perhaps I should have read my dreams better then that. At first it became obvious that each and every night I tried to enter the dream realm I became trapped in nightmares of blood and soon sensed a presence of something malignant, evil but completely elusive that was stalking me. And more! There was something, not yet a voice though, that seemed to urge me to do even more vile and abominable thing as Julas had done. To make matters worse each and every pretender for the throne the citizens half-heartedly presented seemed to be the descendant of the same degenerate branch of a family that hat two generations ago slaughtered any other of the royal lines to the last man. I sensed that non of them was to be trusted, each of one more depraved then the other. So I was in a dilemma. Through the malignant presence the isle was unsuitable for us as a base. No chance to create a dreampath here or to have dreams not tainted by whatever lurked here. On the other hand those people were in desperate need of leadership and something had to be done about whatever haunted this isle. So with no resistance from the citizens who seemed rather glad that not another ruler of that degenerate line would be instituted I assumed the title of lord protector of the realm. Though I had to sent most of my men away to fight in other battles and the other dreammasters showed concern about my decision I think it was the right thing to do. I will lead this people to new prosperity and will see that the evil of the isle is contained while I work to find a way to destroy it once and for all.]] },
		},
	},
	-- bookcase at 33649,31886,5
	{
		itemId = 6367,
		itemPos = { x = 33649, y = 31886, z = 5 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
Since my arrival on the isle I have learned a lot of interesting things. Most of it is folklore of course, as the people sadly had little use for record as it seemed. What I found out, from ancient tales and crumbling tomes as well as from my explorations of the isle, granted me some insights. First of all, before men settled here some ancient race left its mark on the isle. From what I have seen, the remaining ruins indicate some advanced civilisation that pre-dated men. They commanded some technological knowledge beyond what I've seen anywhere. Perhaps those ancient ruins are all what's left from the mythical civilisation of Yalahar. Perhaps while strolling through Rathleton I've walked through what the ravages of time left over from the famous city itself? However, when the first humans arrived, the city had been abandoned and lain in ruins since long ago. The humans, wherever they might have come from, settled for a simple life in the ruins, in ignorance of the marvels ans wonders around them. Curiosity led them to some minor rediscoveries of ancient knowledge, but it seems they made little out of it. Some forages were made into the area of forging and the use of steam, whereas architecture was oddly neglected and people rather sook shelter in caves.
It is uncertain what exactly happened, but I assume at some point their digging and exploring awakened some ancient evil, something so powerful that they stood no chance of resistance. They were overwhelmed and enslaved by an entity that was drawn to sacrifices, and especially blood. But if any of the ancient fairy tales are worth something, it was not some vampire, perhaps not even a physical being. Nonetheless, dark times of servitude began for the people of the isle. Slavery and taxes in blood was their lot for many generations.
This did only change with the arrival of 'princess' Ramora. Now this person is shrouded in mystery, too. Though each story claims highest nobility for her, there is no record at all about such a princess in any archive that I had access to. This might mean nothing though, as it is entirely possible that this princess and her conquest date back to the last days of the mythical Corpse Wars. Though native lore and that of the invaders mingle here, it is often mentioned that things took place in the time when 'dead men walked'. Given the constant threat of the Corpse Wars, it seems likely that those incidents triggered the exodus of said princess and her people. Still, the nobility of this princess is disputable. Granted, there is next to no record that survived from those times. It is entirely possible that the princess was some tribe's ruler or something like that. The key here is that no heritage or title but that of 'princess' in her name connect to her in any existing lore. Knowing to what an end the nobility goes to preserve their family names, at least ist must strike one as odd that no traceable surname survived in all those tales. The next thing are clashing reports about how the exodus took place.]] },
			{ itemId = 2827, -- book
				text = [[
While some stories claim that the princess ruled over a realm besieged by an endless stream of enemies (the undead perhaps), and that she ordered her remaining people to board their ships and set sail, others tell of a long journey through besieged lands, of endless battles that took their toll on her people until they reached the coast where they 'boarded the ships' and set sail. Now, the latter version suggests a perhaps darker version of the story, since the boarding of foreign ships would not have taken place without some force and warfare on its own. Yet in even other stories it is said that the 'goodly seapeople' took pity of the plight of the princess, and that their ships came from the mists to carry her people away. Interestingly, the 'seapeople' are a consistent element in various tales about the exodus. In one version, closest to the basic one, the king of the seapeople became smitten with the brave and strong princess and agreed to save her people if she bore him a child. Upon arrival at their destination, the pregnant princess denied the sea king his child and he therefore cursed her people to never be able to traverse the seas again. In several other stories, the seapeople at least encountered the princess and for some reason or other agreed to guide her through the sea that was in turmoil due to violent storms and savage sea creatures. Most descriptions of the seapeople picture them to be tall, slender, with pointy ears and bluish skin. I believe here the natives mixed up the seapeople with the elves from the stories of the newly arrived settlers.
Be that as it may, the princess and her men finally ended up on an unknown coastline. Stories tell of an attempted ambush on her and her forces. It's entirely possible though that they already arrived as would-be conquerors. Regardless of this, it seemed certain that the populace of the isle was oppressed by some creature so that the princes did not have to fight the human population in any significant way. Instead, they fought the 'other minions' of the blood lord, often described as beasts entirely made up of blood and gore. It is likely that having fought in the Corpse Wars and having survived them, Ramora and her followers had weapons, tactics ans magic available to fight even such abomination, without running away screaming at the first confrontation. Finally they cornered and slew the beast that oppressed the isle. Probably in a gesture of unification she married (? the stories here a irritatingly vague) a local man that was declared to be some hero in the whole affair. Bringing with them more determination than the natives had and possessing some knowledge that was alien to them, the new arrivals changed the isle's civilisation significantly. Houses were built, the crude machines where put to a more efficient use, and more effort was put into understanding the relics of the past.]] },
			{ itemId = 2827, -- book
				text = [[
This led to a rise of steam technology which to the simple-minded must have seemed like magic. Though far removed form the accomplishments of the fabled Yalahari, their progress in those years must have been remarkable whereas in the present it has come to a crawl. Perhaps there are only so many secrets to be unlocked in the mundane world, but only the secrets of magic are endless. But I'm getting carried away.
It seems that even with the destruction of the blood lord, some of his rituals prevailed. Perhaps there has always been a circle of trusted collaborators, who knows. When my order arrived here, that cult prospered again and had intoxicated the royal line. So when our detachment arrived here, the isle was again in the grip of a ruthless dictatorship and alliance with some gruesome blood cult.
The destruction of the cult led to a power vacuum that had to be filled. Two generations of lord protectors have until now overseen the well-being of the native people, and although it is increasingly hard to keep contact with the mainland, our protectorate flourishes. I consider myself fortunate that my superiors in the order allowed me to do my research here. I will prove to them that even without the abilities of dreamwalking I'm a useful member of the order. I've already planned several expeditions with the help of the natives, using old folklore as guidance. With the gracious help of the current Lord Protector, everything seems possible. Who knows what secrets I might discover. Perhaps I can prove that here is indeed what is left of the once proud city of Yalahar.]] },
		},
	},
	-- bookcase at 33652,31884,5
	{
		itemId = 6367,
		itemPos = { x = 33652, y = 31884, z = 5 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
CLASSIFIED CONFISCATED PAMPHLET- AUTHORISED READERS ONLY
The poor without much rights try to make a living by being hired and fired, collecting reusable junk and selling it, fishing stuff out of the canals, killing creatures in the canals, some fishing, doing illegal jobs. Some of them might have a permanent job like providing cheap energy via treadmills in the factories.
The working class works under gruesome conditions in unhealthy environments. Most are replaceable manual workers without much knowledge. They are poorly paid and only seldom replaced by expensive and repair-intensive automatons. Some extremely heavy work is done by automatons with workers that serve like drones to make the automaton work. An individual worker can easily be replaced by another. Crafters, specialists, town clerks enjoy a somewhat more comfortable life. They possess knowledge, skill and/or talent that makes them somewhat unique. The lowest work in factories as overseers and mechanics and recruit their apprentices from talented workers. Some artists can be counted to that class, when they have some skill or renown that allows them to earn a living with their profession, rather than practising their art as a hobby in their limited spare time. Medics, surveyors, magic users, private teachers and the like often fall into that category. They usually come from specialised families that pay for and oversee their education.
The upper class is usually recruited from younger heirs of the factory owners who only inherit some money and monthly allowance. Since this money usually won't suffice for their own children and the allowance is not inheritable, they are often at the mercy of their families. Usually, they get leading positions in the factories and are urged to learn some useful skill. Others end up in key positions of the city's administrative hierarchy. Certain extremely well-liked artists and specialists may advance into this class. They have comparatively much spare time which they spend on social events like formal parties, meetings and more or less exclusive clubs.]] },
			{ itemId = 2829, -- book
				text = [[
CLASSIFIED CONFISCATED PAMPHLET- AUTHORISED READERS ONLY
The high class consists of the factory owners, owners of important patents and their direct relatives. Usually, only the eldest heir, his spouse and their firstborn heir are counted to this class. They own the factories or will own them one day, and the whole family fortune is at their disposal. They undergo a rigid training for their destiny and are schooled in reading, writing, magic and other important matters, depending on the tastes of the heads of the family.They are rarely seen in their factories and don't mingle with less than the upper class; and even this might be rare in some cases. The high class considers itself an elite, important for the city and irreplaceable. Since many town officials are relatives and somewhat dependent on their good will, their influence is sometimes bigger than the importance of their factories might suggest. They are subject to only a few rules and laws of the city, and are the only ones 'important' enough to vote on them.
While in theory it is possible that one of the poor does so much for the city that, through his earned votes, he might become important enough to vote on rules that affect even the high class, this is practically impossible. Everything a poor person can do will grant him only a handful of votes at best, whereas simply owning a factory for a few months will generate enough votes to elevate someone to a status of importance. The high class is quite eager to use their votes in a most efficient way, so they rarely vote on things that won't affect them at all. This gives the lower classes some autonomy in issues that affect only them. Since changing labour conditions and the like is considered a more important decision, only a few of the lower classes are allowed to vote on them at all and are easily overruled by the sheer number of votes a single factory owner owns. Therefore, they rarely waste their votes on such issues at all and leave it to the higher classes.
The upper class has the least votes in comparison, but the most privileges. Since the secondary heirs rarely rise to enough importance to vote about their own class, they sometimes sell their votes to interested higher class members who want to influence lower class decisions without wasting their own more valuable votes. Others generate some considerable amount of votes by working as city officials. Their importance allows them to influence matters that affect the city as a whole, and they are often flattered and ultimately bought by the higher class, mostly of their own family, to vote in their interest. Those officials lead a relatively comfortable life, and some may gather enough wealth to invest in a factory, or to support an artist or inventor. Sometimes this investment pays off, and sometimes this is how the second branch of the family surpasses the first.]] },
		},
	},
	-- bookcase at 33652,31885,5
	{
		itemId = 6367,
		itemPos = { x = 33652, y = 31885, z = 5 },
		contents = {
			{ itemId = 2819, -- parchment
				text = [[
By the rules of the lord protectorate itself I, Humlin Otherford, sentence the reigning Lord Protector Iridin Steelson to death by burning, for being guilty of witchcraft, blood magic and murder. Furthermore, in the name of the people I declare that the title of Lord Protector is no longer. Having seen the atrocities that always corrupt and defile any leadership eventually, we, the people, declare that henceforth no single ruler shall be granted the right of reign over our realm.
From now on a body of chosen spokespersons will rule over city and realm. In their decisions they are obliged to follow the vote of selected people that have proven their dedication to our cause through their actions.]] },
			{ itemId = 2824, -- book
				text = [[
The glooth plant
The construction plans for the glooth plant are considered top secret and only parts of it are available even to the scientists that are part of the crew. The finest minds of Rathleton have worked on this project for years and finally we will be able to reap the rewards of this hard work. Due to the use of natural resources and new, revolutionary ways to put the glooth to use, we will be able to provide the city with glooth power for years to come.
As an example of Rathletons progressive spirit and a proof that our city is the most progressive and successful in the whole world. Under the guidance of our administration we make progress formerly undreamed of by humanity and we shape a better and brighter future.
This monument of Rathletons ingenuity will become a shining example for the whole world. The plant will not only provide our beloved city and its factories with even more glooth power but it will be also more efficient, cleaner and more safe.
By locating it directly under the city center it can provide glooth power wherever it's needed.
By using natural resources of the cavernous systems the plant can be provided with everything needed without complicated transportation systems and even use channelled underground rivers for cooling.
But this prestigious project is yet far from done!
Many challenges still await us and this important project is under constant threat from the enemies of our beloved city.
Therefore each citizen is asked to do his best to keep this new heart of our city beating. Our administration and each citizen is grateful to those heroes that work in the plant. We cheer those repairmen that are fixing those machines and keep them running. We feel grateful for those brave channel workers that keep the cooling water flowing. We adore those scientists down their overseeing all those gauges and machinery. We celebrate those fearless fighters that protect the plant from any danger at hand.
With unity and ingenuity we will make Rathleton a better place.]] },
		},
	},
	-- bookcase at 33652,31886,5
	{
		itemId = 6367,
		itemPos = { x = 33652, y = 31886, z = 5 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Big Book of Glooth Pt.1
It's hard to imagine how life was before the breakthrough discovery of the glooth. Some hundred years ago, the first timid attempts were made to harvest and use the slime of the gloothworms. It was known it could be used to distil a strong glooth wine and in dire times, the substance was thickened and used as food by the poor. But only when inventor Baribar Glooth began his experiments and met with success, the usefulness of the worms and their product became apparent. The unassuming worms and their slime were named after that great man and soon others followed and discovered even more ways to manipulate, change and use glooth to the prosperity of all.
Baribar had studied glooth for years and tried to manipulate it by heat, magic and the like with moderate success. Following a hunch, he used lightning magic on the slime and therefore changed the fate of Rathleton. The first experiments yielded only a solid but brittle substance. By changing the duration and intensity of exposition to energy, he managed to give the substance he created entirely different attributes. First and foremost his efforts concentrated on creating a substitute for metal. On his way to create what later would be known as gloothal, he discovered the elastic gloothy that today is produced in several standard elasticities that found a wide range of usage in the crafts and in daily life.
His assistant Dagomir pushed the research into discovering the properties of more liquid forms of glooth. By mixing the application of heat and lightning, he produced several by-products that were at first discarded, but used by later generations of inventors to expand into new areas of glooth usage. His final discovery, many years after the death of his former master and mentor Glooth, was the gloothomir, a substance that burned with a strange greenish flame that produces almost no heat compared to normal fire but burns for an extremely long time. Later generations refined the gloothomir to the gloothine that has similar properties but produced a lot of invisible smoke, while using itself up quicker than the gloothomir.]] },
			{ itemId = 2821, -- book
				text = [[
The Big Book of Glooth Pt.2
First dismissed as useless, Hergis Brunt, inventor and visionary in the field of mechanics, used the properties of gloothine in the creation of his first brunt-machines. With the spread of glooth usage the demand for the slime grew to an extent where the worm farms could not keep up. Progress was stunted for several decades before a group of scientists made a breakthrough in breaking down garbage of glooth products into the basic slime they were originally made of. Others dedicated their research to finding some use for the by-products of glooth creation. Glooth spice and glooth pudding found their way into the homes of even the poorest to supply them with new glooth-born strength.
With increased reusability and more efficient worm farms and better worm breeding, the supply of glooth was once again secured, but it showed that overdependence was a danger. Efforts to gain other resources were renewed and increased. Still, the glooth inventions flourished even when experiments with other catalysts than energy and to some degree heat, met with little substantial results and ended up as an often mocked side note of science.
In our days it is hard to imagine what a world without glooth would look like. Our day begins when we clean our teeth with a gloothbrush and ends when we lay down in our beds with a glooth casting. This is something the glooth critics readily ignore in their unfounded rants against glooth, whenever they come up with their horror scenarios in which the glooth suddenly reverts back to its slime state, drowning each and everyone in Rathleton in a wave of slime. Those ungrateful enemies of progress just argue for argument's sake and shouldn't be given the attention they are desperately looking for. The glooth has led us to an age of prosperity and progress, and there is no way for a sane person to go back into the dark ages before the glooth.]] },
		},
	},
	-- small bamboo shelf at 33725,32868,5
	{
		itemId = 2464,
		itemPos = { x = 33725, y = 32868, z = 5 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The Fall of the Moon Goddess

Since the beginning of our existence, we have worshipped the moon goddess Amati. She always stood high in the sky, looking down on us benevolently and lighting up the nights. Although we love the warmth of the suns, it is the moon that moves the sea, creating the tides. It is the moon that can charge solid water with energy. That strengthens our magical powers. We think of the moon as a queen and the stars as her many maids. But once, in her wanderings across the night sky, Amati took a misstep and fell. She plummeted down, right above Marapur and landed in the Stardance Mountains. Hurt and alone, she didn't know how to get back up into the sky. And the stars missed her bitterly. Moon and stars shed many tears and mourned many nights - dark nights, without Amati's light in the sky. But then the stars decided to do something they had never done before: they descended from the sky and surrounded the fallen moon. They began a magical dance. And lo and behold, Amati was healed and, with the help of the stars, was able to rise into the sky again. This is why the mountains in the centre of Marapur are called the Stardance Mountains and our city here Moonfall. For it was at this very spot that Amati had fallen.]] },
		},
	},
	-- bookcase at 33870,31490,5
	{
		itemId = 2438,
		itemPos = { x = 33870, y = 31490, z = 5 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Kilmaresh - Flora and Fauna

Animals that live in the steppes of Kilmaresh are mainly lions, hyaenas, goannas, crocodiles, hippos and some clomps. There are also some smaller reptiles like cobras and tortoises as well as partially poisonous vermin like burrowing beetles, sandcrawlers, scarabs and scorpions.

Kilmaresh's flora mainly consists of palm trees, sequoia trees, cactuses, succulents, steppe flowers, banana trees, orange trees, dragon fruit trees and reed.]] },
		},
	},
	-- bookcase at 33870,31492,5
	{
		itemId = 2438,
		itemPos = { x = 33870, y = 31492, z = 5 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Spiderweb Clouds

Spiderweb Clouds are a phenomenon which apparently exists only on Kilmaresh. Tangled strands of a spiderweb-like substance fill the sky like clouds do. It is unknown how those strands come into existence but it is a fact that airborne creatures which fly into a spiderweb cloud can become entangled there. This is why the Anuma detest this wheather phenomenon. Sometimes the clouds fall from the sky and cover the Kilmaresh steppe. Touching them is dangerous because the strands are poisonous and whoever passes the cloud rests can become entangled easily.]] },
		},
	},
	-- bookcase at 33870,31497,5
	{
		itemId = 2438,
		itemPos = { x = 33870, y = 31497, z = 5 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
Geography of Kilmaresh

East of the strait that separates Kilmaresh from Krailos, there are mainly dry steppe regions. At the peninsula's centre lies a large mountain range and one will always discover small oases and tombs scattered over the steppe. In addition, there are many rock formations, interveined with blue ore. This ore can be magically crafted into a rare and precious metal that Sapphire Blade members use for their blades. A large river, the Nykri, rises in the central mountains and forms a fork halfway to the sea. Here lies the big city Issavi, the heart of Kilmaresh. The original capital Nuur was destroyed by Suon's Wrath.

Kilmaresh has a warm, dry climate. The temperatures are very high, especially in summer, and it does not rain much. However, this part od the continent is not plagued by the lack of water that crusts the lakes and rivers of Krailos with salt. In addition to the river Nykri, there are oases in the steppe, which house smaller settlements or stations for travellers.

Kilmaresh is mainly populated by humans. They have lived on this continent for several millennia and developed into the high culture, which now forms the eponymous Empire Kilmaresh. In the past, numerous enslaved ogres lived in Kilmaresh, but since Suon's Wrath and the collapse of the old empire, the ogres are found almost exclusively on Krailos. A single tribe still lives north of the ruined city Nuur. In addition, the magical creatures who call themselves the Anuma live in Kilmaresh since forever. These include sphinxes, manticores, lamassu and griffins.]] },
		},
	},
	-- bookcase at 33870,31498,5
	{
		itemId = 2438,
		itemPos = { x = 33870, y = 31498, z = 5 },
		contents = {
			{ itemId = 401, -- book
				text = [[
History of Kilmaresh

A thousand years ago, a human civilization existed on the then still connected land mass of Krailos and Kilmaresh. They had built large cities, engaged in advanced seafaring and stood at a high scientific, arcane and cultural level. The people worshipped the two sun gods, Suon and Fafnar, and attached great importance to the fact that the worship of both deities was always in balance. However, there came a time when a group of Fafnar's adherers became more and more influential and aggressive until this sect postulated the sole worship of Fafnar. This resulted in a civil war between the Fafnar followers and those who fought for the duality of the two sun gods. Ultimately, the war was ended by a major natural disaster that split off the eastern peninsula from the western part of the land mass. This event was seen as a demonstration of divine wrath. It was believed that Suon had shattered the continent in his anger about the humans' misdeeds. From that day on, the old empire was in shambles and split in half. While the ogres revolted on Krailos, slew their former masters and destroyed the entire human culture, the empire's remains could be preserved on Kilmaresh and a second, new empire was established. However, this was not achieved by humans, but by the Anuma. The magical beings had lived on Kilmaresh much longer than the humans, but had been very withdrawn and barely maintained contact with the ancient empire. After Suon's Wrath they freed the enslaved ogres and took most of them to Krailos. Then they took control of the new empire and established several laws (carved into a large obelisk) that all humans had to comply with. A wise sphinx, lamassu or gryphon has been taking on the role of empress or emperor ever since. However, the Anuma administrate the realm rather than ruling it.

After the great catastrophe, henceforth just known as "Suon's Wrath", Fafnar's worship was banned and prohibited. However, there was still no unity among the humans of Kilmaresh. Some now demanded the sole worship of Suon, while others insisted that there must always be a divine duality. This group believed that the worship of Suon and Fafnar, based on the tradition of the Genesis, had been a delusion from the start as Suon had cast his wild sister out. Instead, they regarded the sea goddess Bastesh as his true, new sister, because Suon had once protected her from Fafnar's jealousy. New religious fights impended due to this question - however, the Anuma intervened immediately. They decreed that both - the sole worship of Suon or Bastesh as well as the worship of both gods together - should be allowed. Only the worship of Fafnar remained prohibited. Nonetheless, a Fafnar cult outlasted in the hiding and is hoping for the return of the Wild Sun for centuries.]] },
		},
	},
	-- bookcase at 33870,31499,5
	{
		itemId = 2438,
		itemPos = { x = 33870, y = 31499, z = 5 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Faith and Religion in Kilmaresh

For the people of Kilmaresh, the faith in Suon, Bastesh or both plays an important role in their lives. On the other hand, there are human groups that orientate themselves strongly by the Anuma. They form circles and groups that are often led by a sphinx or lamassu and the human members adopt the Anuma's world view and customs.

There is some friction between the group, which calls for the sole worship of Suon and those who worship Suon and Bastesh (as his new sister) as a duality. Additionally, there is also the forbidden worship of Fafnar which flourishes in obscurity. Some of the Anuma rather support the sole Suon cult, fearing that a new duality might lead to war again. However, they tolerate the Suon / Bastesh cult, but watch closely what they do. Yet other Anuma actively support the worship of Suon and Bastesh.]] },
		},
	},
	-- bookcase at 33870,31500,5
	{
		itemId = 2439,
		itemPos = { x = 33870, y = 31500, z = 5 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
Issavi, the Golden City

Issavi's buildings are made of solid stone, mostly beige-yellow sandstone, and look massive and edgy. In addition to the smaller, mostly two- or three-story, residential buildings, there are magnificent temples, palaces and government buildings, five to six stories high and built up in stages. One of the cityscape's defining features are the colors red and blue: decorations in the form of tiles, mosaics or frescos predominantly have these two colors. Red / orange represents the sun god Suon and blue the sea goddess Bastesh, both of them worshipped in Kilmaresh. Statues of these two deities can be found in many parts of the city, as well as portraits of sphinxes, manticores, lamassu and gryphons. Sun and wave motifs are the dominant theme in ornamentation. The banks of the river Nykri are paved with massive stone blocks and there is a lively ship traffic. The city has a large marketplace as well as smaller shops on the ground floor of some houses. Overall, Issavi is prosperous, lively, clean and imposing.]] },
		},
	},
	-- bookcase at 33875,31481,5
	{
		itemId = 2435,
		itemPos = { x = 33875, y = 31481, z = 5 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
The Medusa and the Blind Maiden - A Love Story

*This book tells the story of a medusa who falls in love with a blind woman. Neither the medusa nor the young woman are mentioned by name but the story has a familiar ring.*]] },
		},
	},
	-- bookcase at 33877,31491,5
	{
		itemId = 2438,
		itemPos = { x = 33877, y = 31491, z = 5 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The cult of Fafnar

Once, the inhabitants of Kilmaresh worshipped the two sun gods Suon and Fafnar and attached great importance to the fact that the worship of both deities was always in balance. However, there came a time when a group of Fafnar's adherers became more and more influential and aggressive until this sect postulated the sole worship of Fafnar. This resulted in a religious war between the Fafnar followers and those who fought for the duality of the two sun gods. Ultimately, the war was ended by a major natural disaster that split off the eastern peninsula from the western part of the land mass. It is beleived that Suon had shattered the continent in his anger about the humans' misdeeds. From that day on, the old empire was in shambles and the worship of Fafnar is now forbidden in the new empire.

But the cult of Fafnar still exists on Kilmaresh, albeit in secret. Her followers go to great lengths to strengthen Fafnar's influence and try to re-establish her worship. To achieve their goals they are not above using either infiltration or violence. The Burning Gladiators are a special part of the the Wild Sun's cult. They are fierce warriors who seek to enforce Fafnar's will with a vengeance. If necessary they also protect the Priestesses of the Wild Sun on their rather subtle missions.

The Priestesses of the Wild Sun are a special branch of Fafnar's clerics. They serve the Smiter with great devotion but other than the Burning Gladiators they seek to restore Fafnar's worship by intrigues and scheming rather than brute force.]] },
		},
	},
	-- bookcase at 33881,31488,5
	{
		itemId = 2435,
		itemPos = { x = 33881, y = 31488, z = 5 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
On Sphinxes

Sphinxes have a leonine body, big feathered wings and human heads with their faces being a mix of humanoid and feline. The enigmatic creatures are a subspecies of the Anuma and were created by the sun gods Suon and Fafnar.

It is said that the entire continent was once given to them by the gods. But the Anuma conferred the dominance over Kilmaresh to the humans, in an effort to let them take responsibility of their own. However, after the religious war between the worshippers of Suon and Fafnar and the cataclysm that severed the continent, the Anuma took the reign over Kilmaresh back.

As all Anuma, sphinxes are highly intelligent and allegedly immortal, though they can die by lethal violence. Some of them love riddles, others are more interested in stories, poems or songs. Many sphinxes are benevolent, yet some are rather merciless and dangerous. All of them can be short-tempered if they feel that a human being will not accept their well-meant guidance. Sphinxes are physically powerful but possess inherent magical skills as well. They tend to test the worth of those seeking their help by asking them riddles or intricate philosophical questions. Mortals will encounter sphinxes in the vast steppe of Kilmaresh as well as in the ruins of ancient sites where they guard the treasures and secrets of the lost empire.]] },
		},
	},
	-- bookcase at 33882,31488,5
	{
		itemId = 2435,
		itemPos = { x = 33882, y = 31488, z = 5 },
		contents = {
			{ itemId = 23985, -- old tome
				text = [[
The Anuma

The magical Anuma are mainly benevolent towards the humans but the wild manticores can also pose a threat. After the catastrophe the humans brought over the old empire and the crushing of the continent by Suon, the Anuma took over the reign of Kilmaresh. They want to prevent the humans from foolishly causing a disaster again. However, the humans are not oppressed but rather seen as a group that needs to be protected and guided. The Anuma see themselves as the humans' mentors and patrons and treat them a bit like parents would treat their children. As long as the humans do not make political, military or religious decisions that the Anuma disagree with, they will not intervene and let people go about their business undisturbed.]] },
		},
	},
	-- bookcase at 33882,31491,5
	{
		itemId = 2435,
		itemPos = { x = 33882, y = 31491, z = 5 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
Fafnar, the Wild Sun

Fafnar is the wild and relentless daughter of Fardos and also called the Smiter or the Scorching Sun. Unlike her brother Suon, she observes creation with hate and jealousy. Her worhip is forbidden in Kilmaresh since the downfall of the old empire as her followers once caused a religious civil war that led to the old empire's destruction. But the cult of Fafnar secretly survived and the cultists still plague the new empire. They cause plenty of trouble in Issavi and in all of Kilmaresh.]] },
		},
	},
	-- bookcase at 33883,31488,5
	{
		itemId = 2435,
		itemPos = { x = 33883, y = 31488, z = 5 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
On Lamassu

Lamassu have the body of a bull, feathered wings and a human head. The noble and stern creatures are a subspecies of the Anuma and were created by the sun gods Suon and Fafnar.

It is said that the entire continent was once given to them by the gods. But the Anuma conferred the dominance over Kilmaresh to the humans, in an effort to let them take responsibility of their own. However, after the religious war between the worshippers of Suon and Fafnar and the cataclysm that severed the continent, the Anuma took the reign over Kilmaresh back.

Lamassu are willing to assist mortal creatures in combat, if they are convinced that those under their protection are worthy and pure of heart. They never shy away from a conflict and will fight to the last breath rather than to retreat or surrender. Lamassu are capable of flight yet prefer to stay on the ground, roaming Kilmaresh's steppe and - more often - ruins. They prefer deserted cities and abandoned temples as their homesteads. Some lamassu even live underground to guard old graveyards and catacombs. They regard themselves as wardens of those ancient sacred sites and won't tolerate any disturbance or sacrilege.]] },
		},
	},
	-- bookcase at 33883,31491,5
	{
		itemId = 2435,
		itemPos = { x = 33883, y = 31491, z = 5 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
Suon, the Benevolent King.

Suon is a kind and gracious god, a son of Fardos and also called the Life-Bringing Sun. Unlike his sister Fafnar he observes creation with love and blesses all creatures with warmth and growth. The worship of Suon and Bastesh grants Kilmaresh the stability and growth that the empire needs to prosper and flourish.]] },
		},
	},
	-- bookcase at 33883,31494,5
	{
		itemId = 2437,
		itemPos = { x = 33883, y = 31494, z = 5 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The Sapphire Blade

This group consists of elite warriors who all carry blades made of the blue metal tagralt. They are often in conflict with Fafnar cultists and the remaining ogres on Kilmaresh.

reputation: high among humans as well as Anuma
influence: high among humans, medium among Anuma
members: mainly warriors and fighters, some wizards
size: 700 - 1000 members
enemies: Fafnar cultists, ogres
allies: cults of Suon and Bastesh, the Empress of Kilmaresh]] },
		},
	},
	-- bookcase at 33884,31488,5
	{
		itemId = 2435,
		itemPos = { x = 33884, y = 31488, z = 5 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
On Manticores

Manticores have the body of a lion with a human face, leathery wings and a huge scorpion tail. The sting carries a kind of paralytic venom. They are lethal predators which have a preference for human flesh. Manticores devour their victims with triple rows of teeth, leaving behind not even the bones.

Other than most Anuma, manticores are ferocious and savage. Nonetheless they are intelligent, if not as much as their benign sphinx sisters or gracious lamassu brothers. They have an ancient and lasting rivalry with the gryphons for reasons that are unknown to most mortals. The sages of Kilmaresh are researching this question for centuries but by now every story is just mere speculation. The best theory is that the manticores, favourite Anuma of the sun goddess Fafnar, hate the gryphons as they are Suon's favourite children. When Suon cast his wild sister out, the manticores accepted his sentence as all Anuma did, but bear a grudge against the gryphons ever since.

Manticores roam the vast steppes of Kilmaresh, hunting for prey and defending their territories. Interestingly, they are able to interbreed with common lions. The progeny of such a mating is a special kind of very strong lions with poisonous fangs but they are rarely encountered.]] },
		},
	},
	-- bookcase at 33884,31491,5
	{
		itemId = 2435,
		itemPos = { x = 33884, y = 31491, z = 5 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
Bastesh, the Keeper of Wisdom

She Who Knows is the patron of the oceans and sea creatures. Bastesh, the calm and mystical daughter of Uman and Sula, is also called The Mistress of the Sea. She was once attacked by the wild Fafnar, out of jealousy and pride. After the religious war between the worshippers of Suon and Fafnar, Kilmaresh adopted the world view that Suon's true sister isn't Fafnar but Bastesh. So the people startetd worshipping her instead of the Wild Sun. Thus, Bastesh has a firm place in Kilmaresh's religious life since more than thousand years.]] },
		},
	},
	-- bookcase at 33884,31494,5
	{
		itemId = 2435,
		itemPos = { x = 33884, y = 31494, z = 5 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Midnight Flame

This group is a small circle of chosen oracles led by the lamassu Arishum. To honor the blinded lamassu, all members of the order tie gauze scarfs around their eyes. Sometimes, they are in conflict with the Fafnar cultists but in most cases they leave those fights to the Sapphire Blade.

reputation: high among humans as well as Anuma
influence: high among the Anuma, medium among humans
members: mainly seers/oracles, some knights
size: less than 200 members
enemies: Fafnar cultists
allies: Arishum, priesthood of Bastesh]] },
		},
	},
	-- bookcase at 33885,31488,5
	{
		itemId = 2435,
		itemPos = { x = 33885, y = 31488, z = 5 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
On Gryphons

Gryphons are hybrid creatures, part lion and part bird of prey. They have the body, tail and back legs of a lion but the forelegs, head and wings of an eagle.

It is said that the entire continent was once given to them by the gods. But the Anuma conferred the dominance over Kilmaresh to the humans, in an effort to let them take responsibility of their own. However, after the religious war between the worshippers of Suon and Fafnar and the cataclysm that severed the continent, the Anuma took the reign over Kilmaresh back. It is said that out of all Anuma, the sun god Suon loved the gryphons most whereas his wild sister Fafnar favoured the manticores.

Gryphons mate for life and if either partner dies, the other will continue the rest of its life alone and never search for a new mate. They live very reclusive and love the high mountain peaks of Kilmaresh. In very rare cases, a gryphon will forge a bond with a human it regards worthy. If this happens, the gryphon will agree to carry the mortal on its back which is considered the highest possible honour by the people of Kilmaresh.

As gryphons are Suon's holy animals, the sun god's temples are decorated with gilded gryphon eggs. To get the rare egg shells, chosen members of a temple will undertake a pilgrimage to the gryphon nests high in the Kilmaresh mountains. If they find a pair that recently hatched fledglings, they will offer presents to the parents and ask for the leftover egg shells. Mostly the gryphons benevolently agree and gift their now empty eggs to the human priests. The mortals will bring the egg shells to the respective temple, where the eggs are blessed, gilded on the inside and filled with onyx sand. Mostly they are used to hold incense sticks that are burned in the temples or gravesides.]] },
		},
	},
	-- bookcase at 33886,31488,5
	{
		itemId = 2435,
		itemPos = { x = 33886, y = 31488, z = 5 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
On Goannas

Goannas are large predatory lizards with sharp teeth and claws. They have thick skin with camouflage that ranges from bands and stripes to speckles and circles. The skin colour changes as the creatures mature, with juveniles being blue and adult animals being bright red. Goannas lay eggs in a nest or burrow, but sometimes also inside termite mounds, which offers protection as well as incubation. Additionally, the termites provide a meal for the young as they hatch. Goanna eggs are a sought after meal for the human population of Kilmaresh. But as getting them is a dangerous task, they make a rather expensive menu.

Goannas are found throughout the steppes of Kilmaresh. They prey on insects, smaller lizards, snakes, birds, mammals and also humans if they have the chance to do so. But they are also eaters of carrion and thus attracted to rotting meat. There's a debate whether goannas are venomous or not. It is a fact that goanna bites cause incessant bleeding and many sages assume that this is because of toxin-producing glands in the lizards' mouth.]] },
		},
	},
	-- bookcase at 33886,31494,5
	{
		itemId = 2435,
		itemPos = { x = 33886, y = 31494, z = 5 },
		contents = {
			{ itemId = 27929, -- book
				text = [[
The Circle of the Black Sphinx

This group is a dark mage circle that apparently has expanded to other continents long ago. It has strong necromantic tendencies and seems to be in contact with Fafnar cultists, from whom the circle has received undead gladiators. The "Black Sphinx" was a powerful yet evil sphinx, cast out by the rest of the Anuma.

reputation: very poor among the Anuma, poor among humans, high among Fafnar cultists
influence: low in the empire, apparently medium (and growing) in Rathleton
members: mages (mainly necromancers), warlocks, renegade knights, undead
size: unknown
enemies: Midnight Flame, Sapphire Blade, Cults of Suon and Bastesh
allies: Fafnar cultists

known members: - Master Eliphas, First Circle Master
- Mistral the Beautiful, Second Circle Master
- Maeve the Dark Serpent, Third Circle Master
- Ewart the Cold-Hearted, Fourth Circle Master
- Lady Uquora the High-Handed, current Circle Master
- Lady Tenebris (allegedly turned against the circle)]] },
		},
	},
	-- bookcase at 33887,31488,5
	{
		itemId = 2437,
		itemPos = { x = 33887, y = 31488, z = 5 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
On Hippos

Hippos are large, mostly herbivorous mammals who live semiaquatic in the river Nykri in Kilmaresh. The large animals have stocky, nearly hairless bodies and wide-opening mouths revealing large canine tusks. The territorial bulls preside over a stretch of river and groups of several females and young. Despite their rather cute appearance, hippos are among the most dangerous animals of Kilmaresh as they are highly aggressive and unpredictable. Yet, they love balls made of reed flour and appreciate to be fed with those treats.]] },
		},
	},
	-- bookcase at 32020,31441,6
	{
		itemId = 2438,
		itemPos = { x = 32020, y = 31441, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
My little witch begins to manipulate more and more of her people to oppose Carlin's presence here. She proves cunning and easily picks up new magic I'm teaching her. If she have been sent to a good magical college, she might have become a magician of some renown. On the other hand, she is much more interested in worldly affairs and less in research. However, her influence on her people is growing and the spells I taught her earned her great respect. Only the old fashioned clique of druids still oppose her, despite of her obvious power and the knowledge she had gained from me. Some things are seemingly always the same, everywhere in the world.

The Carlin miners are a thick-headed and stubborn bunch. Can't they see that they are not welcome here? Why don't they just leave? However, there are more important things to do. I have unlocked some of the secrets of the frostspire shard. After all these centuries that have passed and the shattering of the frostspire, that released all the contained cold all over the isles, there is still power in this shard. I manipulated some of it's essence to slow my ageing process! What a triumph of science! That alone will make me the greatest magician of all times! But I am sure there is more about this shard! My apprentice sent some of her loyal followers to find more of the shards. The shattering of the frostspire must have produced thousands and thousands of them.

After the first success, the research got really slow. I am able to tap the powers of the shards and drain them for my purposes but that is not very sufficient. One of the few direct effects, I can derive of the shards, is the slowed ageing process for me and my apprentice. Other things progress similarly slowly. There seems little left of the ancient civilisation that once retreated here. I begin to assume that they did not only use the frostspire to bind all that cold to create a hospitable environment, but they also used the contained cold to build their settlements. What a sight it must have been, a green and warm isle with cities of crystal gleaming ice! The shattering of the frostspire probably let this architecture erode over the centuries. This is truly a shame.]] },
			{ itemId = 2816, -- book
				text = [[
Hard to believe but those miners from Carlin did actually something useful for my research. Through my apprentice I learned that their mining uncovered ancient caves and passages in the ice. They also found strange creatures frozen in ice. That creatures could either be the ancients themselves, that got trapped in the ice, or remnants of the invading demon army that laid siege to the frostspire.

My apprentice gets restless more and more. Her lust for power is as disgusting as her body is alluring. Both have little importance for a man of science like me though. Let her be occupied with her petty struggle with those druids on Nibelor. As long as her followers bring us a sufficient amount of shards, I don't care about her private plans. I have to get a better access to the mines. Any confrontation with Carlin authorities, backed up by the druids there, would cripple my researches. There has to be some other way.

What a waste of time! I remember a quite exotic ritual I've learned in my youth from a lizard snakecharmer that I'd captured in the Tiquanda jungle years ago. Although the idea to modify it is ingenious, it will take an incredible amount of time to prepare a complete and useful ritual. In the meantime, I heavily rely on the help of my apprentice.]] },
			{ itemId = 2816, -- book
				text = [[
I finally arrived at my destination. The isles are as cold and inhospitable as expected. I see this as a good sign though. All my investigations strongly hint that there is more about the myth of the frostspire than my ignorant colleagues want to believe. And it will be me who unlocks that secret.

I made contact with some of the primitives that live here. Considering that my investigations here will bind me to these ice islands for some time, it might be a good idea to take some of them into my servitude. Yet, the primitives behaved quite unfriendly and it is questionable how I should be able to repay them for any services. However, pressing them into servitude is no true option. I have not the time to oversee a bunch of rebellious slaves that know the lands far better than I do. There has to be some other way.

It was easy to lure this greedy shaman witch into an alliance. Some display of my abilities combined with blandishments and empty promises and she was mine. Time will tell if this primitive will make a useful apprentice. Her influence among her people is undoubtedly considerable though.

Marvellous! It was so easy to find the remains of the frostspire with the help of my local helpers! Of course it has become a place of importance in their primitive myths. Everything I encountered is true about the ancient myths! Sadly all-too-true. Not much is left from the magnificent frostspire itself and all signs of the ancient civilisation seem to be wiped out. But there is so much to be discovered and we just started.

Today my apprentice gave me a holy item of her people's faith. At first, I was annoyed to be disturbed with such primitive nonsense but to my amazement the object was obviously a shard of the shattered frostspire itself! A short investigation showed me that it will take months to unlock the secrets of its inherent magic. I will need a more suitable base and more resources. In the meantime, settlers from Carlin have arrived. Some prospectors must have find ore in the mountains. Damn them, they are disturbing my research.]] },
		},
	},
	-- bookcase at 32020,31442,6
	{
		itemId = 2439,
		itemPos = { x = 32020, y = 31442, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Finally the ritual is complete. It will take all my skills and strength and even the power of several frostshards but I am positive it will work. Then I will be finally able to return to my actual researches.

It worked! It took a while for the sea serpents to arrive but they could not resist the lure of my spell. Now we will see how brave those sailors of Carlin are. Even if they try to break through the sea serpents, they will lose a ship now and then, which will make it impossible to continue their presence here for a longer period. The climate does not suit those serpents too well, so they are not in a very good mood, I'd suppose. Carlin's presence in this area should be history soon.

Today my apprentice surprised me when she and her followers took over the mines. The remaining Carlin miners fled to the city they have built with those barbarians. Though the mines are ours now, I can only hope the people in Svargrond will not try to retake the mines without backup from Carlin. A war is the last thing I could use for my researches.]] },
			{ itemId = 2816, -- book
				text = [[
Things are going smooth and well for me. I was able to investigate the mines and caves. It seems that most creatures that are frozen in the ice are part of the demon army that fought the ancients. To my surprise, some of the demons are quite alive when they are freed from the ice. So I had to kill a handful of them. Unfortunately, now my barbarian helpers are too scared and won't enter the mines anymore. It is no great loss though. As far as I can tell, there are no significant shards hidden in the ice and I have no use for any rampaging demons. The chances to discover one of the ancients dead or even alive, are slim at best. Most likely, the majority of demons were frozen in ice at that moment the frostspire shattered. It is highly unlikely that any of the ancients was amongst them at that time. So after verifying some of the myth behind the frostspire, I could return to my actual work. The secrets of the shards will be mine, now that all distractions are eliminated.

I am a bit absorbed in my studies. Everything else does not matter. I have spent more than two lifetimes in investigations of the shards. My results so far are amazing, though of little practical value. But it already raised the boundaries of my perspective of magic as a whole. My apprentice is growing more and more restless. She demands more knowledge, more power, more of everything. If I would not need her to maintain things here, I'd get rid of her one way or the other. But the way things are now, I have to live with this nuisance. I have no time to teach her new tricks. She knows enough to impress and frighten her superstitious people. I don't care about her fight with the people of Nibelor. I will not allow her to provoke a war that will further hinder my studies. There has been enough delay already.]] },
		},
	},
	-- bookcase at 32020,31443,6
	{
		itemId = 2439,
		itemPos = { x = 32020, y = 31443, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
I think my apprentice is up to something. Probably a raid on Svargrond or even Nibelor or something foolish like that. After all those years, I know this little scheming snake well enough to smell that something is cooking.

The ritual of binding gets closer. It's hard to believe another seven years have passed. As soon as I have recovered enough strength from casting another spell to lure the sea serpents, I will have to get rid of my apprentice. I almost feel some melancholy after all those years but it has to be done. I probably just freeze her for some decades until I have finished my researches and leave this isle. Then she might become the queen of all her barbarians and kill the druids on Nibelor or die trying. I don't care.]] },
		},
	},
	-- bookcase at 32020,31444,6
	{
		itemId = 2440,
		itemPos = { x = 32020, y = 31444, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
... figured out at least some of the secrets of the ancient artefact I have found. Its purpose was to focus the power of some other structure, probably the destroyed frostheart spire. However, the shards of the frostheart, which can be found in this land, seem to have enough power remaining to fuel the powers of the sarcophagus. At least I was able to unlock the healing and restoring abilities of the artefact. The annoying part is the function of the sarcophagus itself. I put much effort in figuring out how to open it. It seems that starlight is the key! The sarcophagus is easily accessible by starlight. At sunrise it seals itself and only opens again when the stars brighten the sky. Since my first tries in some dark ice cave, the sarcophagus won't open at all of course. My first experiments with the sarcophagus left me with a claustrophobic feeling. What if a cover of snow makes the sarcophagus inaccessible while I am inside? I will have to trust my apprentice to see that I am freed in such a case. It's a good thing my vain apprentice is very concerned about conserving her youth and beauty. For this reason, she has a vital interest in opening and accessing the sarcophagus on a regular basis. Still there is a slight risk, but that's a risk a scientist like me has to take I suppose.]] },
		},
	},
	-- chest at 32099,31963,6
	{
		itemId = 2472,
		itemPos = { x = 32099, y = 31963, z = 6 },
		contents = {
			{ itemId = 16277 }, -- adventurer's stone
			{ itemId = 2819, -- parchment
				text = [[
Brave adventurer,

the Adventurers Guild bids you welcome as a new hero of the land.

We are a fellowship which endeavours to help new heroes such as you taking their first steps in a hostile and sometimes confusing world.
Please take this adventurer's stone as a gift and first part of the help that we provide.
You can use the stone in any greater temple of the main cities of the land to instantly travel to our guild hall.
There, we will humbly provide you with some basic services and information.
The city guide, whom you should find near the place of your arrival in the city of your choice, will provide you not only with valuable advice but also with directions, so it should be easy to find a temple in any town.
If you should ever lose your adventurer's stone you can replace it by talking to a priest in the temple.
I hope you will be visiting us soon.

Kind regards,
Rotem, Head of the Adventurers Guild]] },
		},
	},
	-- bookcase at 32167,31925,6
	{
		itemId = 2435,
		itemPos = { x = 32167, y = 31925, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Chronicles of the Realm XXI
In the third year of the reign of prince-king Rodmund II it was exposed that the priests of Zathroth planned a coup to assassinate the young king and usurp the kingship. Hastily but in secrecy the first Inquisition was formed under the helmsmanship of grand priest Wisbert from the temple of Uman who was chief advisor of the uncrowned, 15 year old Rodmund. The traitorous elements were exposed and routed out. In the whole land Zathroth's temples were seized and the conspiring priesthood put in jail. Interrogations by the Inquisition unearthed the massive extent of the treachery and the church of Zathroth fell in irredeemable disgrace with the crown. Within a year under the guidance of Wisbert, the Purger, the worship of Zathroth was forbidden in the whole realm and their temples where destroyed or cleansed and reclaimed by the churches of the other gods. The grand priest of Zathroth, Madol, the Defiler, was burned at the stake, north of Thais. Even after his coronation in the year after the purge had begun, king Rodmund II had to live reclusive and under the vigilance of the Inquisition and the church of Banor since several attempts on his live were made by remaining Zathroth cultists. To honor his efforts and wisdom, Wisbert was named chancelor of the realm. In his tireless efforts he spearheaded the purge and managed to rout out several traitorous nobles that were in league with the Zathrothi. In his renewal and healing of the realm, a significant amount of lesser but pious houses were elevated to positions of honor and influence and the realm prospered by their wise, divine inspired guidance in the years to come.]] },
			{ itemId = 2821, -- book
				text = [[
Once upon a time there was a little gnome.
And as all gnomes he was a treacherous, greedy coward (and that's pretty treacherous, greedy and cowardish). One day in the middle of a deep forest the little gnome met a little girl wearing a pretty red cap. As the greedy gnome saw that she was carrying a bag full of finest bread and a flask of wine, he pretended to be starving and begged the little girl for food and water in a way anoying as only gnomes can be (and that's pretty anoying). But the girl was warned of treacherous gnomes by a valiant huntsman she met before and she quickly ran away from the greedy little gnome. The gnome became angry but was afraid to steal from her, because she might have been stronger than him. So he wandered into the woods cursing as only gnomes can curse (and that's pretty ugly). By chance he almost stumbled over a sleeping bard. Quickly figuring out the magical nature of the flute lying near the sleeping bard, he stole it as quickly as only a gnome can do (and that's pretty quick). Using the magic flute he lured a pack of wolves to the little girls grandmas house and let the beasts chase both into the wilderness and laughed wickedly as only gnomes can laugh (and that's pretty wicked). Laughing the gnome gulped the wine and swallowed the bread as fast as only gnomes can (and that's pretty fast). So he lived in the woods and molested squirrels happily ever after.]] },
			{ itemId = 2816, -- book
				text = [[
Poems of Rathon]] },
		},
	},
	-- bookcase at 32167,31928,6
	{
		itemId = 2438,
		itemPos = { x = 32167, y = 31928, z = 6 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
The Howling Grotto
The Howling Grotto of Nargor used to be a hideout for criminals in the early days when colonisation just started on the isles. Those criminals were probably the first pirates although is unlikely that they had more than a few fishing boats at their disposal. They built some rooms in the caverns but supposedly they found evidence of prior attempts to use the grotto in some way and some of the caverns seemed to be not natural. For some reasons they were attracted to the lower caves where the howling of the wind was that fierce that people said it could drive a man crazy. Be that as it may, those first pirates were known for their bloodthirst, their frequent infightings and for torturing their prisoners. It is assumed that they all killed themselves in their madness. The grotto is rumoured to be haunted by the ghosts of these pirates and those of their victims - but those are is only unconfirmed speculations. Nowadays, nobody knows the treacherous passages through the dangerous reefs to reach the isle of Nargor.]] },
			{ itemId = 2826, -- book
				text = [[
The Great Sea Serpents

The Sea Serpent is as huge as a house and can swallow a small ship in one bite. Its scales are almost impenetrable and its teeth, which are as big as a cyclops, are coated with a corrosive poison that will dissolve human flesh on touch. In their undersea lairs they hoard treasures that would make a dragons hoard look miserable.]] },
			{ itemId = 2816, -- book
				text = [[
The godslayer races
As with the ascensonist movement, the godslayer cults are incredibly old. Although the term 'races' is usually applied, this generalization is not a correct one. Indeed the first of those cults where founded by ancient races, most long forgotten, that suffered greatly in the creation wars. Most of those races only barely escaped complete extinction and none ever recovered from the blood toll of the wars. In fact some of those 'races' are rumored to have been reduced to a handful of beings or even a single entity. However some of them tried to gain converts from the younger races to bolster their ranks. The methods to keep their races and cults alive over the centuries differed and most tries were in vain. It's assumed that in our days only a handful of godslayer cults exists and perhaps another handful of single entities that follow this agenda. Be it as it may, for sure is that the name godslayer defines and summarizes their philosophies, or at least the ends of these philosophies. Their goal is nothing less than the extermination of the gods (or in some cases of a specific god). The means through which this goal is to be achieved differ, if they are clear at all. Most cultists are probably content with hating the gods and
spreading discord among their worshipers. Some might have very specific plans as the last of the Rardor, Tel'Chac Agur, who tried to take over the soulvortex in the early new ages. In most cases a godslayer cult surfaced, it was handled by human worshipers of the gods without real divine interference. It's said though, that the destruction of the isle Molinora was caused by the dark magic
of Zathroth and his demon armies and the last of the dark race of Souleaters (also known as the Noshar) were annihilated with their dark temple and forbidden secrets they had collected in this last retreat of that cruel race.]] },
			{ itemId = 2816, -- book
				text = [[
Manasphere?

by Othis Ethna

I don't want to minimize the value of <name of First author>'s work. But to me it lacks any proof! Thus Ashkil's explanation is as good as the idea that the beings are producing the mana themselfes! And what about the "planet is surrounded"-statement? How should he know without leaving this planet? Either there's another (now lost) book that deals with the experiments and their results, or the whole "manasphere" is only an unproofable theory!]] },
			{ itemId = 2821, -- book
				text = [[
Dwarven Magic I
By Marokin

Most of the other races look down upon the Dwarves because we seem to lack in magical abilites. What they don't understand is that our best mages concentrate on the magic of earth and fire, the give and take. They come up with some magic that might give us the upper hand. In theese books I will reveal some of their findings.]] },
		},
	},
	-- bookcase at 32167,31929,6
	{
		itemId = 2439,
		itemPos = { x = 32167, y = 31929, z = 6 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
Behind The Veil Of Ignorance I

Zathroth's shrouded hoard of forbidden knowledge is known by many names in many cultures.
Parts of this hoard of ancient knowledge were compiled by races long gone and creatures that were not meant to exist. Other parts manifested on their own by means so unfathomable, only some book hidden away in that library might tell about.
Most of what is known about it comes from the scriptures of Zathroth of which many were destroyed in the great purge of the first Inquisition. Other information was gathered from sealed notes the inquisition took in their interrogations. Yet some parts of the compiled information was gained by whisperers in the dark that claimed to be on a mission of enlightenment. Most of what is complied here is old, fractured and incomplete - yet the best available by our means and efforts which were both substantial.
It is said that much of the hoard's knowledge was gained by divine insights of Zathroth. Some might just be the ramblings of madmen but still contain disturbing insights. Other parts are even more obscure and can't be reasonably associated with any kind of writer at all.
Most texts are said to hold the secrets of acquiring more arcane power for oneself - yet to a terrible price. But to the people who ventured that far into the territory of dark knowledge, these prices seem trivial at best.
Some of the knowledge centers on summoning forth unspeakable things from beyond the known worlds, out of abysses of darkness and madness. Others are supposed to bend elements, space, minds and souls to the will of the user.
The accumulated knowledge is immense and twisted to condense and enrich it even more in a way that words can't truly contain it any longer.
Most books are encrusted with wards and sigils that try to contain as much of the knowledge as possible bound to the volume.
The knowledge is still so powerful and potent that it often gained a form of will on its own and maliciously preyed on the minds of the unwary. This knowledge acts like a parasite, draining its bearers soul and mind, whispering misleading and tainted lies, drawing them deeper onto forbidden paths.
Secrets thought long lost and deceptively easy answers to tantalising questions are bound to lead scholars and mystics alike to treachery and the denouncement of all gods but Zathroth.
It is said the hoard is located at a place that 'one time might be' and that 'it is lost to the forever'. It is shrouded by magic, arcane wards, deceptions and ignorance. The key is said to be a state of mind and the lock is ready to break any key that is not strong enough to unlock it.]] },
			{ itemId = 2827, -- book
				text = [[
Behind The Veil Of Ignorance II

The concentrated knowledge is said to be that strong, that it can absorb even the mightiest, turning his essence into another few pages of one of the books. The endless library knows no limits or bounds. Zathroth's teachings say that knowledge is infinite and so is his library.
It is said in the beginning the library was only the virtual shadow that was cast by Umans hallowed halls of enlightenment, but the shadow grew with each secret that was kept, each piece of knowledge that wasn't meant to be known. And so dark secrets gave birth to even more twisted insights.
Since its creation the hoard feasts on secrets and knowledge. It grows and spawns new rooms and chambers, hidden passages and halls of displaced geometry. In the case of the hidden library, the phrase that 'knowledge is power' becomes reality in that the power of the accumulated knowledge manifests in reality bending ways that seem to mock the very concepts of time, space and existence. Fanatics of Zathroth claim that the library also contains at least parts of 'the true speech', the first and only true language, the syllables the gods whispered at the dawn of creation. Each word, eons long, containing the power to create or destroy, shredding its speaker out of existence.
Knowledge hidden in lies, truth gained by insanity, enlightenment by force of will combined with greed and selfishness that leads to power: these are the hallmarks of the shrouded hoard.
Though they enviously protect the hoard, Zathroth and his minions tempt the powerful with glimpsing visits of the hoard. If they prove ruthless and powerful enough to force their way into it. The reward is of course a poisoned one since one shed of forbidden knowledge is never enough. The taste of knowledge seeds a hunger that becomes unbearable to overcome. Everything but more dark knowledge loses its worth and the tainted view of the world becomes cynical and dull. Things once held in value don't matter anymore and the only pleasure one can experience is gaining more knowledge - and even that has to be more substantial yet obscure with every time. This spiral into mad-stricken greed leads many to compile knowledge on their own, figure out forbidden things and bind them into new tomes that one day mysteriously make their way into the hoard with their author vanished under curious circumstances.]] },
			{ itemId = 2816, -- book
				text = [[
ORCS! by Silvius
Orcs ARE intelligent. Though some dwarfes mumble about a shared hivemind of the greenskins, there is no evidence for that. Orcs have speech and are capable to learn other humanoids language quite well ... if they want, what almost never is the case. They lack a written language though. Some of the more educated orcs use human letters to write down orcish texts. Its rumored that the orcs we encounter now and then are just barbarians of their own kind and that there is a more 'civilized' orcish culture somewhere. There are some clues that the orcs indeed had a written language, but the modern orcs is unable to read it as we are.]] },
			{ itemId = 2816, -- book
				text = [[
Tactics handbook - Use training to your advantage. Avoid fighting more than one enemy at once. Be careful while chasing an enemy, you might get hurt by his allies or other monsters and can't defend yourself while trageting him.
Target only the closest enemy, or you'll become confused and might not be able to defend yourself against other attacks.
Different enemies require different tactics. While some are best to be fought in an agressive way, you should encounter others in a defensive way. Choosing between your attack styles also depends from your equipment - if you have only little defense at your disposal, there is likely no point in fighting defensively and vice versa.]] },
		},
	},
	-- bookcase at 32167,31930,6
	{
		itemId = 2439,
		itemPos = { x = 32167, y = 31930, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Duke Krule was born into a zealous family of thaian nobility. His oppressive and pious upbringing suited him well and from early age he joined an order of knights, dedicated to erase anything they deemed heretic. It was not much a choice of heart but the only sanctioned opportunity to escape the control of his overbearing father. The knights run several campaigns against the orcs and minotaurs mostly. Picking easy targets they were met with little resistance and the already very loose organisation of the order begun to dissipate more and more with the members often following their own petty agendas. Krule lead several raids against renegade orcs and later human bandits. His claiming of the loot did not suit the victims of the robbers well so as an empty gesture towards them, Krule disposed captured criminals in a rather gruesome fashion, claiming his campaigns were rather aimed at discouraging other criminals, then reclaiming stolen goods. With a growing strength and order in the kingdom, his targets became less and less and so he begun campaigns far from the borders to strike any easy target that seemed suitable. Under the pretence of doing the god's work, he begun to plunder ancient ritual sites and burial grounds of what he deemed heathens. Over time he and his war band had degraded into little more than bandits and grave robbers. Although operating far from the realm and not facing imminent threats, his acts of cruelty continued. It's not known if these vile acts lead to some shaman to curse him or if he was cursed in some ancient tomb which treasures he stole. But it's safe to say that his later years were spent in campaigns of slaughter and fire to acquire the means to end at least some form of curse. The nature of the curse could never truly be determined as he and all who accompanied him were slaughtered by an orcish warlord and his army in an ambush. Some brethren of his order later reclaimed his remains and despite his deeds and reputation gave him a proper burial.]] },
			{ itemId = 2821, -- book
				text = [[
Zathroth's library was the major temple of the cult of Zathroth in ancient times. Though supposed to be secret, it was unavoidable that such a place became known through rumors and gossip. There the high priests of Zathroth compiled all knowledge they came into possession. Some of it was written by themselves, others were donations of worshipers and others simply bought. When the great purge came, the hidden library as it was called, was seized and destroyed by the Inquisition. The books were secured and given to the priests of Uman to be reviewed, along with any artifacts that were found. Everything that was deemed blasphemous was destroyed by them. The worldly possessions such as land, gold and jewelry fell to the crown. The library was dismantled stone by stone and its caverns filled with earth. No sign of the library remained, though desperate Zathrothi still claimed it was not the real hoard of their divine patron that was destroyed but only an insignificant mimicry of the true place. Since the Inquisition could not prove these claims to be true, all of them have to be assumed wishful thinking of desperate Zathroth worshipers and propaganda for their underground movement.]] },
			{ itemId = 2816, -- book
				text = [[
He who commands those w............................................................................ The twice fallen will fall ................... the coming doom. Evil will feast on the weak to bring an end, not knowing that it was just the beginning of their own destruc...........leeping will be awakend to ...........l live longer than the .........
Many eyes will see the coming of the light in......................king.
The ...........ill cheer for the .....................e heroes must fall. Where blood runs red ...... awaits ........ Where there are many .............................. will be victorious. Wher.................... be revealed. Hope only arises from .............................................]] },
			{ itemId = 2821, -- book
				text = [[
May Banor bless our souls.
May the kiss of Kirok bring us inspiration.
May Fardos give us the force of will to forge our souls to tools of good.
May Crunor protect our health and essence.
May Uman teach us to use his gifts and use them wisely.
May the archangels guide and guard us.]] },
		},
	},
	-- bookcase at 32167,31931,6
	{
		itemId = 2439,
		itemPos = { x = 32167, y = 31931, z = 6 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Magnor Mournbringer was more a mystic and philosopher than a knight. It is said he was forced into knighthood by his father, albeit himself aspiring to become a sorcerer. He was more a man of the books than of the sword, more often found in the study then on a jousting field. He was permanently banished from tournaments for the usage of alchemical concoctions. Still obligated to fight in battles on behalf of his king he relied more on sorcery then on his physical prowess. He enchanted and inscribed first his armour and weapons, later even his own body. He enhanced his skill and fortitude through powerful potions and brought his enemies down with runes and spells. The other knights shunned him but the 'witch-knight', as they called him, had his uses for the king. Giving little for chivalrous staples and being very pragmatic, the witch-knight was the one that the king called upon, when a dirty deed had to be done, something sinister to be accomplished. As times were dark and dire, the call for his skill was frequent. His fame and notoriety grew. On the height of his might and favour of the king he was nigh untouchable, reigning freely in his realm. Dubious visitors from all corners of the world frequented him. Rumours grew even more then his legend. When his patron, the king surprisingly died and not his sickly child was crowned but his pious cousin was made regent of the realm, his enemies made their complaints heard loudly. Soon the inquisition investigated in the case and it came to a direct confrontation when they tried to size Magnor's vast library for examination. Blows were traded and in the end the keep of Magnor was besieged by the regents army. With no other way to escape, the witch-knight summoned winged demons to carry him into safety. But the priests, accompanying the army, banished the creatures and Magnor fell to his death. When the regency ended and the king's son became ruler, Magnors honor was reinstated to some extent in memory of the dead king that cherished him. So he was given a proper funeral.]] },
			{ itemId = 2825, -- book
				text = [[
Vlarkorth was a wandering hero even in his youth. Heroic quests lead him all over the world and perhaps even beyond. Sometimes in his travels, while he already was a well-known and established knight, he acquired the secret of eternal youth. It is said that it was granted to him as a wish by fairies whom he had helped. Some whisper he had to sacrifice his own heart to acquire this gift. At least all sources agree that he was a changed man in his later live. While friends of old one by one retired and died, loved ones came and went, he grew more and more bitter and jaded. While he perfected his knightly arts more and more over the decades that passed, his views on knightly virtues became cynical at best. He sought out more and more perilous challenges, as they say out of a death wish. Regardless what fighter or menace he challenged, he went out victorious. He begun to let the more promising opponents live, albeit scarred and disfigured by his hand. It was assumed that this was his way to groom new challengers, to endanger his own live to at least sometimes feel some form of thrill. He antagonized the mighty and had only spite for the just and religious. Yet no challenger could match his skills. He fathered many children over the years and raised them with an iron fist, putting them through rigorous trainings and humiliation. That way he was fostering new generations of opponents that might be worthy one day to give him a challenge at last. At last it was his halve-elven daughter that would be his downfall. While she was a promising fighter he mistreated her like he always did with his children. When she dared to question his attitude once he had her mouth stitched shut. When he held a dashing young adventurer captive in his hold, she rescued him and the two fled. Vlarkorth followed them dispassionately. The hunt was just a mild thrill for him but better than nothing. So he chased them from one end of the world to another. Over the course of their adventures the fleeing pair made new friends and gathered a party of merry men and women. Sometimes Vlarkorth caught up but his prey eluded him in the end, albeit not without casualties. At some point the couple decided they could not run any longer. Alongside their allies they made a last stand and faced the heartless Vlarkorth. In a fierce battle one by one of their companions were wounded or killed. In the end only the halve-even maid and her lover stood against the barely wounded Vlarkorth. It was apparent that they both were no match for the ancient knight. As he was about to kill his daughter, the adventurer impaled himself on Vlarkorth 's weapon and weightened it down. The women, using her refined reflexes to honour his sacrifice, dispatched her ruthless father with a swift blow once and for all. Vlarkorth was buried in shame at a remote place.]] },
			{ itemId = 2821, -- book
				text = [[
The great book of Heraldy]] },
			{ itemId = 2816, -- book
				text = [[
Elves by Iregarn Pt. 1
Elven names are chosen in adulthood. Until they acquire a name, elves are called 'son/daughter of ___' usually naming the parent with the same gender. Upon reaching adulthood, the young elf gets his first name, divined by the elders who know him in dreams. It is merely a single name, a description of the elf in the elven tongue. Usually elves love to add a translation of their name which is often mistaken for a second name by other races. Since the elven language is far more complicated and has thousands of nuances, often elves with the same 'second name' have a different first name, confusing the other races even more.]] },
		},
	},
	-- bookcase at 32167,31934,6
	{
		itemId = 2435,
		itemPos = { x = 32167, y = 31934, z = 6 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Biographies of the Rich and Infamous
Dustbeard the Pirate Vol. 2

Those crewmen who were capable of realising that what they had seen was not a drink induced mass hallucination, believed Brian dead, but soon thereafter a second flash of lightning revealed his seemingly unconscious body floating in the water. They were able to retrieve Brian, more dead than alive from the waves. Over the next few days, it became clear that Brian's brush with the lightning had not left him unchanged. His hair was completely statically charged and reacted to any contact with metal with violent sparks of lightning, and any contact with others led to them getting slight electric shocks. Brian reacted rather stoically and refrained from shaving his beard and cutting his hair. The static charge meant that his hair attracted dust - thus giving him the nickname of Dustbeard. When Jolly Jack went into retirement, Dustbeard's characteristic appearance, his golden tongue, his skills as a seaman and liberal amounts of homebrewed alcohol led him to be the natural choice of the crew as captain.

Upon becoming captain he remembered his old grudge towards his hometown and began to harass the coastal towns of Carlin. When Carlin re-established contact to the town of Svargrond, Dustbeard was there to threaten the new shipping lines. Dustbeard and his men might not be the most skilled pirates but they are known to attack ships against all odds when they are drunk enough. Their unpredictability in battle often gives them the element of surprise, and often their victims are so astonished at the sight of the drunken pirates with their manically haired Captain, that Dustbeard's men more often than not meet with success. It is only a question of time though, before this kind of behaviour will lead to their demise.]] },
			{ itemId = 2824, -- book
				text = [[
Biographies of the Rich and Infamous
Dustbeard the Pirate Vol. 1

This is the sensational story behind one of our most notorious pirates, whose hairstyle has sparked a veritable fashion amongst the more rebellious Tibian nobility! It is the story of (who else could it be?) Dustbeard, the infamous and follicly advantaged Pirate! Dustbeard was born under the unassuming name of Brian Eagleston in the City of Carlin. Even in his youth he made a name for himself with the town's authorities, getting involved in brawls in taverns and vandalising public property. He was among the first to be banned from Karl's pub in Carlin. Before he could even grow the beard that was to become his trademark he was involved in the illegal production and trade of alcohol. After some of his customers suffered severe illnesses (hallucinations, memory loss, blindness) he was arrested and sentenced to forced labour in the woods and docks. It was in this milieu that he reinvented himself as a political activist and freedom fighter, demonstrating the skills in leadership and oratory that were to serve him so well in his later career. He convinced his inmates that his trade in alcohol was in fact a form of rebellion. He was not even 20 years of age when he led his fellow prisoners in a revolt in which they captured the ship they had just helped to build and set sail for Thais. Unfortunately, none of his followers were proficient in sailing or navigation, and his first outing as a pirate was doomed to end in failure. The ship was wrecked on a reef while they were trying to reach a village to pilfer food and water. However, he and his men made it to the shore, where they proceeded to relieve the terrified villagers of their food, while faithfully promising that they would be repaid for the loss in due course in the name of the Thaian King. This procedure turned commonplace - he and his crew roamed the wilderness, harassing towns, knowing full well that this questionable course would provoke and bring them into conflict with the authorities, should they ever show up in Thais.

However, this career of pillaging villages and coastal towns was fated to meet an end when he attempted to capture the cargo of a trade ship docked in the harbour of a sleepy coastal town. The Pirate Jolly Jack and his men had beaten them to the town and in the ensuing battle the majority of Brian's men were killed or fled, and Brian, a survivor as always, surrendered. The survivors were given the choice to join Jolly Jack's crew or be left to face the fury of the townsfolk. Of course, Brian and his remaining men chose to join the pirates. The following years saw Brian bloom into a capable seaman and pirate. His popularity amongst his pirate brethren was assured by his skill in brewing alcohol from anything and everything which he could get his hands on. However, it was his brewing skills that once again get him into trouble. A storm struck the ship after a night of particularly heavy drinking from a particularly heavy brew - half of the crew was unconscious and the other half were feeding the fishes. It was on this evening that an air elemental chose to attack the ship. It focused its attacks upon the sails of the ship, hoping to break the mast and drown the drunken sailors. Brian, more drunk than sober, climbed the mast and challenged the elemental fiend. Although it is unlikely that the elemental understood the curses and insults hurled at it by the drunken Brian, it was angered enough to attack him. It left off trying to drown the crew, and focussed instead upon the hapless Brian. It grabbed him and carried him high up into the air, where they were struck by lightning.]] },
			{ itemId = 2821, -- book
				text = [[
The Minotaurs by Iregarn Pt. 1
The minotaurs claimed that they were once the marshals and favoured people of Blog, the raging one. In the wars over creation they were one of the most successful races. But as the war grew more and more fierce it were the wild and raging minotaurs that had to pay the worst blood toll. The berserker rage inherent to their race made them a formidable opponent but also very vulnerable.
Though victorious in most battles, in the end the berserking warriors had to surrender to their wounds or were left crippled and executed and fed to Blogs lesser followers. Even worse, the raging minotaurs knew neither friend nor enemy. Brother slew brother, fathers slaughtered their sons in their rage. Then, one day a minotaur, named Tha'kull conquered his rage. He withdrew from battle and became a hermit. In his travels he met Akkor, the blind one. This minotaur was by fate not subjected to the rage inherent to the minotauren race and had aquired a tranquility and wisdom, unknown to his kind so far. Tha'Kull thaught the blind one how to improve his body and fortitude and Akkor in return teached the warrior how to improve his soul.
He looked upon the world and for the first time in aeons a minotaurean warrior saw the world without hatred. He saw the beauty in things, simple and complex. He saw the harmony in creation and the place the living had in it. He also saw the place that was meant to be taken by the sentient beings among the living. And he went back to his people to teach. Never a warrior of the minotaurs had neglected his rage and even though he was cautious the angry berserker warlords would not allow the words he spoke to be heard by their people.]] },
			{ itemId = 2821, -- book
				text = [[
Dancing made easy]] },
			{ itemId = 2816, -- book
				text = [[
The craven hordes are not for me
I may have less than you've got

But less to watch over? Oh no
    dear sir,
For I've a lovely carrot

Watermelons and Grapes, Some
    honey-flowers
A ripening banana tree

Treasure you fight for and
   Treasure you earn
But a good patch of dirt is free

          -Farmer's Mantra]] },
		},
	},
	-- bookcase at 32167,31936,6
	{
		itemId = 2435,
		itemPos = { x = 32167, y = 31936, z = 6 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
Nictros and Baeloc Blackwood were the greatest knights of their time. Even in their youth, their exploits have been impressive. The siblings were motivated by their competition towards each other. Whatever one of them achieved, the other tried to outdo. They excelled in the athletic arts and it is said that they surpassed their combat instructors constantly soon after they were replaced by more competent ones. They achieved knighthood in an early age and joined the army in numerous campaigns against the orcs and fought valiantly in the outlaw wars. As times of peace didn't suit them well, they went on daring quests and pitted themselves against some of the most fearsome monsters of the land. They killed the two-sided hydra, the three headed dragon of Cormaya, the ancient vampire of Senja and the abominable beast of Guddenwood. On tourneys they were only bested by each other, with either brother claiming similarly frequent victories. Legend has it that their excellence lead to a great deal of vanity with a hint of cruelty. Though they acquired many admirers, they rarely made friends. Their casual cruelty and insulting arrogance caused wounds and created trenches over the years. But the brothers did not care. It seemed they needed only each other and despised the company or even presence of strangers. According to the laws of those days they had a certain leeway how to handle the affairs of their estates and legend tells that they were cruel masters whose subjects often were left dead or maimed for the slightest failures. The treatment of their subjects lead to many wanting to flee their lands to which the bothers responded with a peculiar death penalty for anyone caught in the act. They did not outright kill them, but made them target of a hunt in which they were chased down without having a true chance to escape. Over the years the number of their enemies and contenders swell. One day when they were on their way home from a victory feast, still halve drunk and spent from their previous battle, they were waylaid by a coalition of their enemies and their forces. Although the brothers fought even long after their whole retinue had been slaughtered, eventually weariness took its toll and one of the brothers slipped on the floor that had long turned into bloody mud. Immediately his opponents were upon him and took his life. The other brother went into a frenzy, fighting like a madman. It is said, he might even have won the battle against all odds had he not in the end allowed his dying foes to stab him, for he lost his reason to live.]] },
			{ itemId = 2828, -- book
				text = [[
The Fire Walkers
On one of the isles I witnessed an utmost unusual occurrence. The natives gathered to some festivity. After some singing, dancing and drinking, they started to jump through some of the bonfires. They started screaming insanely and then started to walk over glowing logs of wood. I am wondering if this has something to do with the stuff they are drinking. It would be interesting to see if it can be used to cross lava streams.]] },
			{ itemId = 2827, -- book
				text = [[
Most pirates started their career as smugglers and reavers at the beaches. With the help of small shipping boats, they boarded ships in remote bays where they restocked supplies. Often whole villages made a living from such acts of banditry. At some point they decided that they had become strong enough to take over the ships and raid the seas. Another source of pirates were the mutinous crews that took over ships and who were hunted by the navy anyways.]] },
			{ itemId = 2816, -- book
				text = [[
Extended Vision

Most dwarves have a excellent eyesight even in dark enviroments but this spell will one day allow you to see nearly twice as far as you currently do. What's needed is the fire of a fire element, the head of a ghoul,the essence of a red royal blossom, some water from Blood Bay and the laugh of a mute sinner. Light a fire with the flame of the fire element. Pour the water from Blood Bay into a cauldron and place it over the fire. Throw in the head of the ghoul and the essence of the red royal Blossom and mix it untill a grey myst emerges. Take some of the potion and mix it with the laugh while cooling it. Now we only need to find out the missing catalysts and the magic words to imbue it with energy.]] },
			{ itemId = 2816, -- book
				text = [[
The .........
Some of he ancients formed .......amlands. They build mighty fortresses to ........................, conscious or not. It was then, when the mysteri............... and his anger shook the foundation of .....................................awakened screaming in fear and pain. And after the ................................................................................ were gone! All of them with all ..........................................................ost their best men in theese days and never recovered from the ........................................... for the other ancients and so the time of the first dreammasters ended.
From this time on ............. manipulate little of the matter of the dreamlands to ................................................. others in their .................... and prophecy, but not to ..........]] },
			{ itemId = 2816, -- book
				text = [[
Oh me hearties,
For simpler times
When nary a bridge in sight

And Thais, the town,
Was lit till dawn
By an eastern dragon's light

Oh me scallywags,
For better times
When treasure hunting wasn't so
    tough

But then that vermin
Came into the depot
Killed me, and took all my stuff

Oh me fools
For newer days
All things come to an end

For let it be known
This world it has grown
But I still don't know who's my
    friend

       -Old Drinking Song]] },
		},
	},
	-- bookcase at 32168,31925,6
	{
		itemId = 2436,
		itemPos = { x = 32168, y = 31925, z = 6 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
Tibiantis: Fact and Fiction

In the light of progress made my modern science the tales of Tibiantis can be cheerfully disregarded as blatant myths. The author of this questionable history merely drew upon several myths and mixed them together to create a tale plausible to those given to believe such romantic nonsense. The recently discovered, or more accurately, recently rediscovered, city of Yalahar is very obviously a major inspiration for the story of Tibiantis. Aspects of the story can be found in actual fact in Yalahar - the city itself is huge, and also extended its borders beyond the land into the sea, and judging from what can be found there, was most definitely at some point in its past a city that was home to great wonders, whose inhabitants were in possession of great knowledge. However, one of the great mysteries of Yalahar is whether in actual fact those that live there are even human or another race, until recently unknown amongst the Tibian civilisations. The aspect of the story of Tibiantis referring to the downfall of a civilisation could be influenced by many different myths. One such source could be based upon the discoveries made far to the North of Tibia which suggest the possibility of a civilisation that was wiped out by an as yet unknown catastrophe of cataclysmic proportions. Equally, to the extreme south of Tibia can be found the Shattered Isles. These Isles were so named with good reason - geological studies conducted by the Explorers' Society reveal that these isles did not so much sink but were blasted by a phenomenal explosion of some kind. Relics found upon the Isles also hint that they were once populated by a great and most likely advanced civilisation. It is the sad fate of these isles to be the home of the infamous Quara. It is these twisted creatures who probably provide the origin of the myth's fish people. In summary, I believe I have gathered enough proof here to dispell any reason for believing the tale of Tibiantis, and have proven it to be nothing but a conglomeration of ancient stories and legends which an overly ambitious and half informed so-called historian has put together into a new myth of his own making, in order to gain cheap fame by hoodwinking a gullible and uninformed public.]] },
			{ itemId = 2816, -- book
				text = [[
The superiority of males - a fantasy tale]] },
			{ itemId = 2816, -- book
				text = [[
The liberators of the spark by Sericos
Also known as liberators of light and several similar names this Banor sect is dedicated to the so called 'liberation of the godly spark' from the unworthy. In theory they agree upon the doctrine of the Banor cult that each human and probably some of the non-human races are born with a part of the divine essence in them. Whereas other cults are dedicated to make this spark flourish for the good of the individual or civilisation, the liberators argue that certain persons are not worthy of the godly spark and it is better to set the divine essence free by killing them in ritual combat. Certain splintergroups of the liberators go even further and claim that a person can claim the divine essence of those slain to strengthen themselves. So this heresy led to two equally dangerous and forbidden subsects of the banor cult. While the original heretics killed only criminals after their foundation, the term 'unworthy' soon became more widely defined, and they began to slay cowards and everyone they considered weak. The so-called 'new liberators' brought this heresy to another equally mad degree. They argue that if you can claim the divine spark of others by killing them you should not target the weak, but the mighty. They 'honor' their victims in duels and admittedly more then one new liberator met his well deserved end at the swordtip of an opponent far superior to him. Still there ARE a considerable number of new liberators around and doing their perverted work for their god. The church of Banor in turn has outlawed both heresies and affiliation with either of those sects is punished with lifelong laborcamp or execution.]] },
			{ itemId = 2821, -- book
				text = [[
Legends about the wand of might.
Written by Herion

This book is about the origin of the wand of might.

First of all I want to say that nobody is sure who made it and how it was made. But it contains a powerful magic energy of unknown kind.

Since we lost most books written by our ancients we cant say how the ancients got the wand in their hands.

However, we are very happy that we own it because it helped us and it will help us to understand the magic web around Tibia.

For example, only with its help we could find the gates of teleportation of the magic web.

We are making right now some experiments with several magic stuff and we hope that the wand of might will react to some of them somehow.]] },
			{ itemId = 2832, -- book
				text = [[
The Iks

A Disquisition (abridged) by the venerable Sir Galthen

The tale of Iksupan, the City of Gold, is of a vast kingdom of old. Once prospering and shining in the radiance of its own glory it did not sink to perish like many a lost world: it was taken. To grasp the full magnitude of this most peculiar end, one has to understand the lore and culture of a very ancient part of this world. Due to a lingering fear of the wrath of Kopakhn, god of the balance of life, the people of the Tribe of Iks have been building vast underground cities and palaces. Kopakhn was thought to be the bringer of a cleansing storm, sweeping over the face of the known world. Destroying man, animal and growth alike. So the Iks saw their only salvation in taking to the innards of this earth while forestalling the cleansing by conquering as much of their known world as possible. To appease him, the Iks amassed a wealth of treasure, conquered all the lands of their ancestors and built intricate structures of stone and gold deep underground. Their sincere worship of Kopakhn was also a gesture of gratitude towards his might and divine judgement. Feeling safe in their untiring contributions towards the great goal of the propitiation of their powerful god, their civilisation thrived. The more kingdoms they seized, the more wealth they hoarded, the further they would reach.

When conquerors came from distant parts of the world, the Iks prevailed. Lured by the gold and wealth of their sanctuaries build in the name and spirit of their gods, many foreign knights and mercenaries would invade their sacred grounds. Driven by the lust for riches and glory, the invaders would come ever further and soon roam the lands of the Iks in great numbers. Fending off the foreign aggressor month after month, year after year, the Iks grew angrier and more relentless. They blamed their gods and even Kopakhn became a subject of their ire. The people lost faith in their deities and blamed their priests and sages. In fear of losing control, the highest caste of the Iks tried to uphold order by demanding sacrifices to Kopakhn as well as Tikatl, god of lightning, rage and war. And sacrifices where made. The steps of the great sanctuary of Kopakhn ran red with blood. The worshippers of Tikatl built large outside structures with high beams made of pure gold to attract his mighty thunder and sweeping lightning. Man and animal alike where presented and delivered to the wrath of the furious priests and their angry gods. Their victims in battle would suffer dark rituals and wild ceremonies to feed their souls directly to Tikatl, presenting the hearts to the ever watching Kopakhn.

Then came the time of the iron haze. An otherworldly mist fell on many settlements and underground sanctuaries. The day the mist arrived would mark the end of any such habitat. Inhaling this haze seemed to have a strange benumbing effect on every living creature and even the walls and the very gold and stone the Iks built their mighty empire upon. After the mist cleared, the iron silenced the few Iks still able to stand. Like leaves brought by a swift wind, sharp blades and quick knives danced through the golden chambers. Room after room emptied of life, torches choked, the fires dead like the people of the Iks lying scattered amongst unfathomable riches. Priest, guard and worker alike, all betrayed, their bones shattered and their souls hurt in disbelief, doubting their gods. Word of these occurrences travelled through the Ikian world and its remaining people fled their homes, temples and sanctuaries. During a long and burdensome time of nomadism far away from their ancestral realm, the Iks all but disappeared. They never recovered and ultimately died in exile.]] },
			{ itemId = 641, -- piece of paper
				text = [[
Addendum to 'The Iks' (first revision)

Conquerors and adventurers from all corners of the world tried to find and occupy the lost cities of the Iks but no expedition bore fruit, all attempts failed. The Ikian civilisation has indeed been wiped clean from the face of the world. Was it the cleansing storm long prophesied? Or did their rampant lust for blood cost them their lives and legacy? Was the ultimate sacrifice of their souls over challenging the fear of the wrath of a vengeful god their downfall? It will probably never be known.

Legend has it, that the last remnants of the exiles once again built a home under the earth, deep down, made of stone and gold and filled with riches beyond belief (a scribbled note says Iksupan and "Ik'kal" after this sentence). The final exiles are believed to have never returned to the surface. A lost tribe, forever wandering their golden city in the deep, the entrance sealed shut for no god nor man to ever find them again.]] },
		},
	},
	-- bookcase at 32168,31934,6
	{
		itemId = 2436,
		itemPos = { x = 32168, y = 31934, z = 6 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
The Blood Curse
Sages claim that we owe vampires to the dark deeds of some gods or demons. Some say, Urgith created them as a new tool for his wars. Others believe that vampires are an undead variation created by some powerful but not godlike being, very likely by one of the Ruthless Seven. Some think vampires are made by the Lord of the undead, other see Verminor as their creator. Again others see vampirism as some kind of curse.
It is said that the first vampire was a powerful warrior king who successfully fought the undead in the Corpse War. Being promised forbidden power and unification with his beloved ones, a once loyal follower of the king became the pawn of the dark powers. He poisoned his liege, probably over several months, using some nasty mixture which was handed to him.
As the king became sick and no one was able to heal him, the traitor stepped forward with a strange medicine. Trusting in his beloved servant, the king drank the medicine which actually was the blood of some servant that had been murdered recently. The medicine seemed to restore the king's strength, so the traitor had no trouble to feed him with more blood. Soon the king's appearance started to change. His aversion to sunlight and his paleness were attributed to his illness, but also the king's temper and behaviour turned more and more violent and aggressive. Nonetheless, the people loved their king and put up with his moods.
The traitor fuelled the king's growing paranoia with lies, so it was easy to convince him to get rid of certain court members. One by one the loyal advisers were removed and replaced with dark cultists. When the king was cut off from any loyal support, they stopped to give him blood and his illness returned, even worse than before. When he convulsed in pain and agony, they presented him a peasant to drain blood from. Almost insane by his ravenous thirst, the king accepted this sinister gift. As soon as he realised what was happening, he went berserk. In a fit of rage, he slaughtered each and every cultist that he encountered, but in the end they trapped him in his castle. The survivors fled with the corpse of the peasant who soon rose as a vampire. They drained him of his dark blood and killed him. Then they drank the blood to become vampires themselves.
The king was finally freed by loyal subjects. He had turned into something he had fought his whole life - an undead. It is said he left his castle in that very night, some say to hunt the traitors, others claim to end his undead life.]] },
			{ itemId = 2816, -- book
				text = [[
Tales from the Crypt
by an unknown necromancer.]] },
			{ itemId = 2821, -- book
				text = [[
The Minotaurs by Iregarn Pt. 1
The minotaurs claimed that they were once the marshals and favoured people of Blog, the raging one. In the wars over creation they were one of the most successful races. But as the war grew more and more fierce it were the wild and raging minotaurs that had to pay the worst blood toll. The berserker rage inherent to their race made them a formidable opponent but also very vulnerable.
Though victorious in most battles, in the end the berserking warriors had to surrender to their wounds or were left crippled and executed and fed to Blogs lesser followers. Even worse, the raging minotaurs knew neither friend nor enemy. Brother slew brother, fathers slaughtered their sons in their rage. Then, one day a minotaur, named Tha'kull conquered his rage. He withdrew from battle and became a hermit. In his travels he met Akkor, the blind one. This minotaur was by fate not subjected to the rage inherent to the minotauren race and had aquired a tranquility and wisdom, unknown to his kind so far. Tha'Kull thaught the blind one how to improve his body and fortitude and Akkor in return teached the warrior how to improve his soul.
He looked upon the world and for the first time in aeons a minotaurean warrior saw the world without hatred. He saw the beauty in things, simple and complex. He saw the harmony in creation and the place the living had in it. He also saw the place that was meant to be taken by the sentient beings among the living. And he went back to his people to teach. Never a warrior of the minotaurs had neglected his rage and even though he was cautious the angry berserker warlords would not allow the words he spoke to be heard by their people.]] },
			{ itemId = 2816, -- book
				text = [[
The Minotaurs by Iregarn Pt. 2
He was challenged and battled again and again. But Tha'kull had been one of the mightiest warriors in the wars and his meditations and understanding of the ways of the world gave him the edge.
Where his enemies attacked him with rage, he countered them with oversight. Where the enemies tried to hurt him with the powers born from rage, he slew them with elegance. No emotion clouded his fights and he was superior and victorious. The minotaurs of those days were accustomed that might makes right and so it was easy for this first warrior philosopher to gain followers. The harder part was to make them listen and only the patience gained in his meditations let him succeed in the end. After some time his philosophies spread like a wildfire in the minotaur tribes. His and Akkors pupils wandered the world and through example and patience spread their words. The higher teachings of the philosophy were never truly understood by the masses but even the least of them were taught to overcome the hatred and rage that made them tools in a war that was not theirs. By neglecting the rage at first the minotaurs became the prime targets of Blogs other minions but in the end the formidable skills and persistence of the warrior-philosophers combined with the inability to lead a two front war let the followers of Blog lose interest in pursuing the minotaurs who had fled underground and fortified several bases. In the coming years the minotaurs defended their new found freedom with all their might and the principles of their philosophy, known as Mooh'Tah, were founded.]] },
		},
	},
	-- bookcase at 32169,31925,6
	{
		itemId = 2436,
		itemPos = { x = 32169, y = 31925, z = 6 },
		contents = {
			{ itemId = 23985, -- old tome
				text = [[
The Fall of the Astral Shapers by Teruvax Tristem - Part 3

Slavery did the Shapers no good. It is said that some of them just withered away and died within a few months. Also, the birth rate dropped dramatically. Two generations later the race of the Shapers was no more - or so it seemed. Some of them had managed to flee to remote areas filled with magic. The strong fluxes of magic there allowed them to erect secret forges to harness their power without being seen by the other greedy races.
For the hidden Shapers these secret bases became a beacon of hope. While the rest of their civilisation perished, some elite survived in hiding. However, since their network was utterly destroyed, most of their vast knowledge was lost forever.
Even worse, the Astral Shapers had been so accustomed to access the network that they found themselves unable to handle the knowledge of their ancestors. Access to recourses necessary to operate their complicated artefacts had been lost as well. Often lacking important skills needed for day-to-day survival, the whole race seemed doomed. Many hideouts became death traps that turned into tombs for those who had hoped to find salvation there. Only a very small number of these colonies managed to survive for a significant amount of time. The harsh environment of the hideouts took a heavy toll on the survivors and slowly moulded them into new beings who only remotely resembled the noble figures of their ancestors.
The Shapers have been forgotten for a long time and their accomplishments seemed to be lost. Recently, however, the great archaeologist Darama Smith uncovered some ancient tomes which led him on many adventures. On his expeditions he rediscovered two of the underground complexes which had been thought to be lost forever. Astonishingly, one of them was still populated with the degenerated descendants of the Shapers. Unfortunately, both facilities were destroyed in fights between the adventurous archaeologist and the minions of the evil mastermind Professor Maxxen. Some knowledge, however, could be salvaged and some insights into the history of the Shapers could be gained and shared.]] },
			{ itemId = 23985, -- old tome
				text = [[
The Fall of the Astral Shapers by Teruvax Tristem - Part 2

The Astral Shapers relied more and more on their slaves' workforce as well as on their knowledge network. This situation worked well for them for a while. But then a new powerful warlord arose. The wars were often a back and forth like the tides of the sea. This was the way things were and the races had grown accustomed to it. This new warlord, however, was tired of that game. He decided to eliminate the one advantage that turned the tides of battle once and for all. Instead of fearing to lose the support of the Shapers by fighting them, he speculated on bolstering his own strength if he managed to steal the Shapers' powers somehow.
The Shapers were no longer prepared for war. Their slave troops, equipped with magically boosted weapons, were labourers not fighters. Moreover, they harboured no love for their masters. The more remote communication towers were the first to fall. This led to confusion and fear among the Shapers. The gaping holes in their communication were highly disturbing, leaving blind spots all over the realm. In this state of disarray, the first cities of the Shapers fell quickly.
As word spread about the actions of the warlord, another flaw became evident. Greedy as the Shapers had been, they had made some humble customers but never friends. When the other races heard about the warlord's success, they feared for their own power. To show the warlord their good will, they started to attack the Shapers, too. Things snowballed as even the more benevolent races decided to join in. After all they could not afford to leave all of the Shapers' knowledge and powers to their enemies.
Soon the Shapers' cities were razed to the ground by a tidal wave of armies. In a last-ditch effort some of the Shapers used their quickly dwindling knowledge to forge themselves into living weapons. This, however, only led to more severe retaliation against the Shaper populace. Within less than a decade the cities of the Shapers lay in ruins. Their people were enslaved and deported into remote realms.
The enslaved Shapers lacked most of the knowledge they had once shared. In an effort to recreate the lost knowledge, several of the captor races squeezed out each bit of knowledge from their captives and compiled them into so-called Shaper records. The fragmentary knowledge they acquired was hardly of any practical use. Moreover, the different races were unwilling to share the records with each other. For this reason, a reconstruction of the Shapers' work was impossible.
During this time, a vast number of Shaper records was created and even copied. However, when the astral forges fell into disrepair, the records were considered worthless. Instead of gathering and comparing the records, they were soon forgotten.
Unable to operate the Shapers' forges, most of them were destroyed by the conquering races. They did not want to risk them falling into the wrong hands.]] },
			{ itemId = 23985, -- old tome
				text = [[
The Fall of the Astral Shapers by Teruvax Tristem - Part 1

Nowadays the beings commonly known as the Astral Shapers have largely been forgotten. Back in the days, however, they were one of the most important races of the God Wars. Favoured by Uman and Zathroth alike, they were blessed with a unique kind of vision that enabled them to see magical structures and flows. Their speech was a mixture of verbal communication and magical emanations. Their true name was a mixture of barely pronounceable syllables and magical symbols. For this reason, the other races of that time referred to them as Astral Shapers or just Shapers.
Their keen understanding of magical structures was oddly paired with a very structured and logical way of thinking. Therefore, the Shapers were never really fond of spontaneous magic based on spells. From the beginning, they preferred to imbue objects with magical effects. While this might have been only a preference in the earlier days of their civilisation, it later became an integral part of their culture, going so far that spell magic was frowned upon as something primitive, dangerous and offensive.
In their earliest days the Astral Shapers were relatively insignificant. Some of them were enslaved or hired as advisors for all kind of magical matters. The creation of enormous, magical towers in their cities was their first major accomplishment. Those towers somehow connected the minds of all Shapers in a city and enabled them to access some sort of hive mind in which they stored and shared their knowledge.
With these shared insights the Shapers' technology made vast progress in a short amount of time. The advances that they made in terms of technology led to a rapid growth in their power and status. This allowed them to construct more towers which were increasingly technologically advanced. Eventually all of the Shaper cities were connected via a network of Shaper towers. Having access to the shared knowledge of a whole nation, the progress to advance the science of bound magic gained momentum and seemed unstoppable. Focusing on knowledge, the wars that ravaged the world became a tedious annoyance for the Shapers. Eventually they assumed a neutral position. When the other races realised that the Shapers were willing to provide their knowledge to everybody who was willing to pay the right price, they grudgingly accepted the Shapers' new status. This allowed the Astral Shapers to explore the depths of magic freely without having to deal with the bickering of the other races of their time.
For a while the Shapers prospered. However, their special status and the constant flattering of the other races that wanted their favours turned the Shapers vain and greedy. Seeing themselves as higher beings, they increasingly relied on slaves for the more mundane tasks. Often the Shapers were paid in slaves for their services. These unfortunate slaves served under their uncaring masters until they died.]] },
			{ itemId = 2821, -- book
				text = [[
Fools From Beyond
Many of the dead leave some kind of unfinished business behind. Some of them manage to stay in the world of the living as some form of ghost or undead, but most of them simply move on to the afterlife. But even there, some of them simply don't give up. And as there is little in the world as persistent and diligent as a bad entertainer, many of them stay at the border between the two realms and contemplate their ill fates. They mourn the fame they never acquired and which they feel was unjustly stolen from them. They partner with similar minded individuals and complain to each other how cruel the world has treated them. Of course none of them is actually listening to each other because they are too absorbed with their own misery. So they grow louder and louder and over the course of time, their monologues are heard everywhere in the plain of death.
Sadly, one of the things even more persistent and diligent as a bad entertainer is a whole bunch of them. In the end, they grow that loud and annoying that the guardians of the gates of death themselves lose their patience. So once a year they throw the annoying fools out and banish them to the realm of the living, knowing that they would not stay there for long given their annoying nature.
So once a year hordes of undead jesters raid the cities where they once were seeking fame and glory. As undead, they try to terrorise the living, however, as they are even worse as undead than they are as entertainers they pose only a minor threat. Usually they find themselves back in the afterworld quite soon, and for another year, they dream of greatness that was never theirs.]] },
			{ itemId = 2816, -- book
				text = [[
<this old book was ruined by time and thoughtles readers>
... of madness ... decoy ... avert ... from the obvious ...]] },
			{ itemId = 2821, -- book
				text = [[
The book of morning sermons]] },
		},
	},
	-- bookcase at 32169,31934,6
	{
		itemId = 2436,
		itemPos = { x = 32169, y = 31934, z = 6 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The Shattered Isles

Nargor is a hostile rock surrounded by treacherous reefs. Since it is uninhabitable and almost unreachable it is of no interest.

Treasure Island is not only desert-like but also quite deserted. The only people you meet are treasure hunters that travel there occasionally to try their luck.

The inhabitants of the town Liberty Bay live on the numerous plantations. The town has developed into a major trading center in recent years, and is under Thaian rule.

The Forbidden Islands to the north-west are dangerous not only because of the volcanoes that are found there but also due to frequent quara activity. Since there is no real reason to visit these islands, no regular shipping route was ever established.

The Laguna Islands are quite often visited by passing ships to refresh their supply of water and food. Still the isles are too desolate to establish a settlement there. It is rumored that a small tribe of savages calls one of the isles its home.]] },
			{ itemId = 2816, -- book
				text = [[
Dwarven Names
A dwarf gets one given name at his birth. This is common among many of the races. From this day on the young dwarf is monitored for his behaviour and interests. With the beginning of adolescense the dwarf gets initiated to a cult that is considered suitable for him. The more progressive dwarves who try to change and create something new are initiated as child of the fire, whereas the conservative, preserving dwarves are initiated to the cult of earth. (Sidenote: the mad inventors that embrace 'undwarfish' priciples and concepts are inititated to the technomancers cults and named children of the machine) So two dwarven siblings may claim to be son/daughter of a different element although they share the same biological parents. Later the dwarf gets to choose a brotherhood (which is a imprecise but common translation of the dwarven term which is far better and literally translates into 'fellowship'). The more aggressive types would choose the savage axes, a rowdy group of dwarves that has some fame to be easily angered. The more patient (sometimes patient to an extent that drives humans nearly mad) would choose the molten rock fellowship and those that are adventurous and even foolhardy risktakers would join the dragoneaters and so on. There are a dozen or so fellowships although only three or four are prominent enough to be commonly known. They could be compared with some kind of social club or guild in human terms.]] },
			{ itemId = 2816, -- book
				text = [[
Philosophy of the races
You await to read a book about philosophy of the elves, dwarves, minotaurs and so on?
Well, forget about it! There's nothing a book can teach you. Go and talk to the philosophers of those races and you MIGHT begin to understand a small percentage of that philosophy. In a book you will find only misconceptions. Written by people that neither live, nor embrace that philosophy, a book is destined to be flawed. Further by having been written by a member of another race there's no chance to understand what a philosophy of another race is about. You will read what the author has in prejudices and expectations but no truth. Further ...]] },
			{ itemId = 2821, -- book
				text = [[
How to learn magic easily. Level 1: For Knights and non-Vocation people (Part two)
Two ways exists to wield magic: through an instant magic use like common spells or spells that need a high amount of mana; or magic can be stored in little stone pieces called runes, which are easy to make and easy to use.
To make a rune spell you need a blank rune - a little grey piece of stone you can buy in any Magic shop all around Tibia. It is just a rune with no spell in yet. If you are skilled enough to make the rune and you have enough mana, put the blank rune in your hand and say the words. Spells made to be stored in runes start with the syllable 'AD', so don't mess with them. The rune will be charged with magic power, changing shape, colour and sign, showing that the magic worked. You can use it now just touching it (Right-Click and Use or just Ctrl+click) and then shoot it at the target. The magic will fly from your hand and one of the charges will disappear. Runes have different amount of charges (one to four) and when all charges are used, the rune will just vanish, as if it never existed.]] },
		},
	},
	-- bookcase at 32170,31925,6
	{
		itemId = 2435,
		itemPos = { x = 32170, y = 31925, z = 6 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The Fall of the Astral Shapers - A Comment

Again Tristem delivers us a half-baked compilation of half-truths. Just as with his former works, he omits sources for most facts. This means the reader can only rely on his words. Even worse, obvious speculations are presented hand in hand with the few verified historical facts without any distinction. He even goes so far to omit any historical facts that do not fit into his own theories.
If you like to read a book about fiction instead of solid facts, you might find his work entertaining. However, for everybody who is really interested in science, the lack of validity is simply underwhelming.]] },
			{ itemId = 2831, -- book
				text = [[
Monsters of the Sea]] },
			{ itemId = 2821, -- book
				text = [[
Magic by Puffels
There are two kinds of spells: rune-spells, and spontaneous spells.
Rune-spells are cast on blank runestones and some mana is used up in this proces. This stones can easily be carried around and store the specific spell. It can be used at any time, and only some require further investment of mana.
Spontaneous spells are cased in the heartbeat they are needed and take effect instantly. Most of these spells are spells of healing but some of them are agressive and some even have more astonishing effectes, as invisibility, illusionary shapechange etc.]] },
			{ itemId = 2821, -- book
				text = [[
Cityguide Venore
The city of commerce built its wealth on four major factors. One is the freetrade agreement with the thaian kingdom to which they in theory belong. This ensures trade with all cities, cultures and lands, known or yet to be discovered. Often seen as a separate law but actually part of the free trade agreement is the gambling licence, that is unique in the Thaian Kingdom, because 'commercial' gambling is outlawed since the times of king Yorik I. Another factor is the shipping dock and the woodcutting in the Venore area. Before the Edron colony was established, the Venore area was the major source for wood needed for constrution and tools. What seems odd at the first glance, given the swamp area Venore was built in becomes more understandable when considering the next factor: Until the Druids and mages drove away all those poisonous insects and creatures the area was known for its diseases and a criminal colony in the beginning. So the merchants had a steady supply of cheap workers that had to do every job appointed to. The last factor was the discovery of the Spiceweed. A special swamp grass that was soon used by cooks and households all over the continent. Soon enough the merchants became rich and powerfull, rivaling most of Thais noble families in wealth and power. For now the merchants seem content with their station and the place Venore takes on the continent and in the kingdom. There are voices that Venore might separate one day or use it influence to wrest even more rights and privileges from the kingdom that becomes more and more dependent on its economical power.]] },
			{ itemId = 2821, -- book
				text = [[
Selfmade Skeletons By BH]] },
			{ itemId = 2816, -- book
				text = [[
The Magic of the Ghouls
by Paramor.]] },
		},
	},
	-- bookcase at 32170,31934,6
	{
		itemId = 2436,
		itemPos = { x = 32170, y = 31934, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
In days long past, when the wars of the gods ravaged the land long before any human set foot on the world, there were races and civilisations that flourished and decayed. Long before even the bonelord civilisation reached its peak, only to begin its steady decline that lasts even until today, there was a race of beings such noble and peaceful that they withdrew from the world and turned away from the constant war. But the gods considered them as traitors to their cause and cursed the whole race, turning them into snow and ice. And sometimes in cold winter nights when the wind blows through heavy snowstorms, you can still hear their moaning.]] },
			{ itemId = 2821, -- book
				text = [[
Kazordoon, the hidden city
In the blocklike Mountain, known as the big old one, the hidden city of kazordoon is nestled. Its the last refuge of the ancient race of dwarves. Hidden and heavily fortified it was the last stand of dwarvenhood in the wars of creation and the last hope of that race to adapt to and survive the new ages. The famous giant statue, known as colossus guards its entry, alhough the narrow valley makes it difficult to see that fortress-statue and admire its beauty. Kazordoon is known for its safety and masterful smithery throughout the lands.
Since some generations the dwarven city (whose ruler claims a title that might be translated as 'emperor') is allied with the thaian kingdom.]] },
			{ itemId = 2821, -- book
				text = [[
How to seduce a Man
<this seems to be a cooking book>]] },
		},
	},
	-- bookcase at 32170,31936,6
	{
		itemId = 2435,
		itemPos = { x = 32170, y = 31936, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Shiron'Fal is an organization that seems to predate the dawn of mankind. A time of constant strife and warfare gave birth to a fledgling organisation of dishevelled but powerful individuals. The original purpose of this pact was probably as mundane as pooling resources for survival but it soon became something more meaningful and sinister. The first members seem to have been some of the last remnants of their race that perished in the god wars. Each of them brought a unique set of skills and talents that quickly added up in power. With the imminent danger of annihilation averted, the group soon consolidated it's power and reasserted their goals. They were probably genuinely surprised by the success their alliance has had and began to hunger for more. Inspired by the synergy their diversity created, they began to look for individuals of power that could provide something beneficial to the group. Over the centuries the scope of their ambitions broadened. They began not only to acquire new members but also powerful artifacts and minions. All the while they operated in the shadows. Making their hidden moves, manipulating people and events, taking whatever they needed to increase their power. Their agents travelled the world in many forms and disguises, looking for relics and recruits. If a target was identified, a powerful member of the Shiron'Fal made its move with deadly efficiency. What could not be taken by guile was taken by force. For the most parts of history, though, the organisation seemed more like a sleeping giant. Waking up now and then, making some devastating moves, only to vanish into obscurity once again. During the last centuries the actions of the pact have become more consistent and frequent. Why there was this increase in activity is yet to be determined. What can be said, however, is that their process of recruitment has been broadened and now also aims at the most powerful specimens of certain races or supernatural beings. Sometimes the organisation has plotted to pit such individuals against perilous odds to determine their worth.
In the most recent history they can be made responsible for events like the discovery of several powerful vampires and the rise of werekin activity on Feyrist. A more personal action of the legion was the presence of one of their members in Rathelton, seeking for an object of power and the attempt to subvert the elven courts of summer and winter to free and recruit or enslave the nightmare beast that was bound by them.
The ancient term Shiron'Fal roughly translates in something along the lines of "dread legion" or "army of the last days". More literal the words translate into "numerous, military organisation" and vaguely describe a special time of reckoning. This might give a hint of their ultimate purpose. Some assume all their efforts are aimed at a final battle for all of creation. Others think it rather hints at the ultimate goal to conquer or destroy everything as soon as they accumulated enough power. Some even claim a renewal of the god wars is their ultimate goal.
Yet most about the Shiron'Fal is shrouded in mystery. Even the most basic information like a base of operation, the number of members or even the names from more than a few of them are unknown. Not even the structure of organisation is apparent, although there are strong hints that an enigmatic single entity is in lead of the legion.]] },
			{ itemId = 2816, -- book
				text = [[
The Book of Vile Evil

A vampire is an impure sinner that in life served the dark gods.
Through this connection he is infused with increasingly tainted and dark energy over the course of his existence. In life they do many damnable things for their dark gods, burdening their souls to such an extent that they will most likely rise as ghosts if the dark gods do not claim their souls.
In some cases where the soul has been claimed, the hollow spirit still captured within the dead soulless body can utilise the dark energies of the corpse and animate it.
Just as an undead being is controlled by a necromancer, the vampire is merely a shell controlled by the spirit residing within.
The spirit constantly needs to refresh the dark energy he is using up and is in dire need for a substitute for the soul. Additional special circumstances such as holy ground or sunlight amplify the rate in which the dark energies decrease. To substitute this, the vampire is forced to steal the souls of the living.
The easiest way for him to accomplish this is by stealing the blood of living humans. The blood normally contains some amount of soul energy, however, a vampire is able to force more soul energy into it's victims blood while feeding.
In his own dead shell the vampire transforms the stolen soul energy into new dark energy. This process keeps him in existence. Over the years, the entire body only consists of dark energy residue and slowly turns into a shadow with substance.
If the vampiric body is destroyed, the spirit within becomes entrapped in the remains. Helpless it is cursed to wait for enough dark energy to accumulate in order to be able to recreate the shadow body in some way. Given time and sacrifices, a vampire might slowly rise from the state of apparent destruction to once again haunt the mortals.
Another possibility is that the remains are close to some source of dark power, giving off enough pure dark energy to occasionally haunt the dreams of the living or to form a ghostly body to steal the life breath of sleepers in the vicinity of the vampires' corpse. This process might take longer but will still lead to the vampires' resurrection.
The only way to irrevocably destroy a vampire is a blessed stake. The stake will destroy the evil spirits' ties to our world and send it into hell screaming.]] },
			{ itemId = 2816, -- book
				text = [[
How to Manipulate Runes
by Muriel.]] },
			{ itemId = 2821, -- book
				text = [[
Famous Necromants by Muriel.]] },
			{ itemId = 2816, -- book
				text = [[
How to Create Spellbooks
by Muriel.]] },
			{ itemId = 2821, -- book
				text = [[
What Runes Are Made Of
by Muriel.]] },
		},
	},
	-- bookcase at 32171,31925,6
	{
		itemId = 2436,
		itemPos = { x = 32171, y = 31925, z = 6 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Raiders of the Lost Barge]] },
			{ itemId = 2828, -- book
				text = [[
A Pirate's Life for You]] },
			{ itemId = 401, -- book
				text = [[
The Klabautermen
The klabautermen are a race of impish, mischievous beings that live on ships. Using invisibility and other magic, they remain unseen most of the time. But be warned, if you antagonise the klabauterman of a ship, his harmless pranks will turn dangerous.
In general it is a smart move to keep your klabauterman happy with little presents
and a lot of rum.]] },
			{ itemId = 2821, -- book
				text = [[
Heresies of the new age
Some people claim that the soul vortex was not a creation of the gods. They argue that the sheer concept of souls from 'beyond' entering our realm is by all means very random and could not be planned at all. They suggest that it's a lot more likely that the vortex was actually some damage that was caused to the fabric of reality. Through this hole in reality souls that were never meant to be entered our realm and, so they assume, it's additionally a leak that leaches away the power of the gods. They suggest that war for creation was NOT interrupted because the gods wanted to heal the wounds of the world, but because this powerleak frightened them that much. They further speculate that the withdrawel of the world was more an act of panic, an attempt not to lose complete control over creation, and the process known as awakening is by no means the working of benevolence, but the gods losing grip of the things they tried to hide away from the intruding souls. The theory goes that as there is an ascension for the souls from beyond to achieve some form of godhood, there is a constant descent for the powers of the gods of old due to the power that is leaking away into nothingness and the power the living claim for their own. Of course this heresy is very popular in the ranks of certain ascension cults. More so since it takes care of the more common fear in those conclaves, that the jealous gods may strike back on those who try the ascension.]] },
			{ itemId = 2816, -- book
				text = [[
How to seduce Women]] },
			{ itemId = 2821, -- book
				text = [[
Imperial Scripts

Transcribed by the Royal
scrivener, Sir Acrothet Simfus

Committee Meeting XVII

Insofar as we have yet to
ascertain the needs of our
citizenry in comparison to those
of our benevolent leader and
other high ranking officials,

It has been deemed forthwith
that a committee should be
formed to handle such concerns,
and will hereafter report its
findings to this committee once
every cycle.

Of matter pertaining to politics,
it has thusly been found that
despite egregious wrongs
committed by here-to-for
unknown assailants, both afield
and afoot, we should, in due
time, attempt to develop a plan
which results in less of our
deaths, and more of theirs.

A committee will be formed
and henceforth be titled
"The diplomatic committee"
and will report to us twice
every cycle, and include their
findings, which shall hope-
fully include less corpses on our
behalf

etc. etc.
~]] },
		},
	},
	-- bookcase at 32171,31927,6
	{
		itemId = 2438,
		itemPos = { x = 32171, y = 31927, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Rise of the Pumpkin
After many wars and always new threats by the forces of darkness, humanity was afraid of many things. It was no cowardice but a gnawing fear that slowly eroded courage and faith. The servants of evil seemed to appear everywhere and in many horrible forms. Humans had grown accustomed to be afraid of the dark and the unknown. This weakened their resolve and with that also the forces of good. The gods came together to find a way to rise the spirit of humanity once again. They discussed and debated but could not come to an agreement because their views were too contrasting. And while they still deliberated, suddenly one of their least and minor creations stood amongst them. It was the lord of the rabbit race who had passed unnoticed by the mighty guardians. Without fear the little rabbit faced the gods who looked upon him in astonishment. Then the lord of the rabbits proposed his idea to the mighty and great gods. Since rabbits are tiny and their enemies are many, they are quite familiar with fear and how to handle it. So the lord of the rabbits came up with the idea to have the humans overcome their fear by learning to laugh in the face of evil. The gods were amazed by this simple but clever idea. So they chose the mightiest warrior of the rabbit race and bestowed magical powers upon him. The daring hare gained the protection of the gods and the power to disguise humans with hideous appearances of monsters. Each year, the hare would appear for some time and do his work. So the humans learnt to laugh and had fun while appearing as monsters, and the great fear that had darkened the souls of humans gradually vanished. This enraged the forces of evil and so they called forth the most malevolent spirit from the realm of darkness. It was his task to spread fear among mankind once again. The spirit was sent to take possession of the greatest living hero among the humans and to wreak havoc in the name of darkness. Unbeknownst to them, the lord of the rabbits had anticipated that the forces of evil would strike back. So he had sent some spies to the realm of darkness and learnt about their plan in time. He warned the humans about the approaching danger and once again had the right plan to save the day. He asked the humans to build a puppet clad in a shining armor and to put it on a throne in the midst of their festivities. As the puppet's head served a pumpkin with a carved face. The clever hare had figured that a spirit from the depths of the realm of darkness was not familiar with humans and would assume the figure on a throne in the centre of festivities as humanity's greatest hero. And indeed he was proven right when the spirit arrived and tried to possess what he assumed a human body. But the spirit had immense powers and so he finally managed to take possession of the pumpkin head on the cost of nearly all of his powers. With hardly any power left, the spirit made the pumpkin move and began to attack the celebrating humans. But the humans had long regained their courage and were not afraid to fight back. They drove off the evil pumpkin that escaped to some remote place where he was finally banished from the world. It took the spirit one year to regain enough of his strength to fight his way back into reality. He re-entered the world at the place of his defeat and to his shock and dismay he was no longer a spirit but bound to a pumpkin-like body. The beast roared in rage but could do little about it. Again he tried to wreak havoc in the world but again valiant heroes stopped his rampage and banished him for another year. Since this day on, the spirit returns every year hoping that one day humanity will be weakened enough for him to finally take revenge.]] },
			{ itemId = 2816, -- book
				text = [[
The Awaking of the Gods BOOK ONE

In the beginning there was only the big gaping void. It was omnipresent and nowhere. Into this desert entered Fardos, the creator, and Uman Zathroth, incorporating magic. Nobody knows where they came from or whether they always have existed and just awaked from the deep slumber of the infinity. Fardos fulfilled by the need to create and give birth. He stepped into existence and began immediately with the act of the creation, because he was fully creative power and impatient. His godly powers emerged from him and created, formed. But all his works slipped out of his hands as the void was everywhere. No single work was to last. Everything that he devised dissolved in the void even before it was completed. Uman Zathroth regarded his undertakings thoughtfully, because Uman Zathroth was wise and fullfilled with magic powers and insatiable hunger for knowledge, comprehension and enlightenment. He was a creature similar and nevertheless different to the clear working of the Fardos, because mysteries and secrets were the aspects of his being. Uman and Zathroth were two entities and nevertheless one. Uman was the light, bright aspect of the magic strength. His was the gift to work benign wonders. Zathroth however, his different - dark - side, was corruptive urge, the vain self purpose of magic, destructive and a desecration! This entity, which was two and one nevertheless, observed now the works of his companion in infinity.]] },
			{ itemId = 2816, -- book
				text = [[
The Awaking of the Gods BOOK ONE

For a long time Fardos exhausted his enormous powers in futile activity. Finally he asked his companion for support in his attempts. Uman consented only too readily, but Zathroth, the dark one of the twins, refused himself. Thus Fardos and Uman strived together to attempt the CREATION - however their laborings were not rewarded with success again. Just like before everything was drained away as soon as they created it, and Zathroth laughed full of contempt. The power however, which Uman and Fardos spent, did seep away in the universe-filling void. Nobody knows whether it was this power that lured another entity to them, whether it aroused this godly being, or whether in a mysterious way it created this entity. In any event, suddenly the enormous entity Tibiasula rose from the void and examined the two other godly beings. Fardos and Uman welcomed Tibiasula as their sister and admired her, because she was the perfect unity of the elements. Zathroth however fumed with silent hate, as he didn't want to share the void with one more entity.]] },
		},
	},
}
