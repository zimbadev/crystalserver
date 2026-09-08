--[[
	Bookcases, shelves and corpses holding a book or a scroll (part 2 of 4) -- 200 containers.

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

MapContainersBooks2 = {
	-- bookcase at 32171,31928,6
	{
		itemId = 2439,
		itemPos = { x = 32171, y = 31928, z = 6 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
The Dark Woman II
However, the demon that was his wife was not prepared to give in. She began using her dark powers to entrance him whenever he lay down to sleep. That way, she managed to secretly drink his blood to sap away his strength. Having fallen out of the true gods' favour because of his sins and excesses, he had grown vulnerable to the darkness, and he could not free himself of the evil that had befallen him. With every day that final battle grew nearer and nearer the king grew weaker and weaker. And yet not all was lost. The king was still in his prime and his strong will, which was without equal among mortals, kept him going. For a while it looked as if he might be able to turn the tide and to lead his armies to victory even in his weakened state. It was then the accursed thing that posed as his loving wife made a fatal mistake. Having become desperate or perhaps simply overwhelmed by greed, she took too much of her husband's life force, revealing her dark nature at last. As the spell that lain upon him for so many years broke and the king awoke from his dark slumber, he surprised the thing he had thought to be his loving wife feeding on his very blood. In a heartbeat the veil of years of deception was torn, and the once-proud king saw the terror that had befallen him for what it was. His despair knew no bounds. Blinded by feelings of rage and guilt, he slew the accursed creature that was neither demon nor man with a single mighty stroke. When he saw the unholy creature whom he had loved so desperately lying in her blood he sunk unhappily to the floor. He wept with sorrow and despair, while outside the drums were beaten and the trumpets of war were sounded. The generals came and tried to call him to battle, but he would not move. Tortured by feelings of remorse and guilt and hate and despair, his mind was close to madness for a long time. Eventually, an idea took hold of his mind that defied sanity. If his strength had been taken from him by stealing his blood, could he not get it back by drinking his accursed wife's blood? And laughing madly, he turned to drinking the dark blood that had poured from the shattered beast. Alas! His hope was in vain. The tainted blood weakened his body instead of making him stronger. Before he knew it, he had passed out. However, when he awoke, he seemed to be strangely invigorated. Feeling ten times stronger than he had ever felt in his life, he tried to get up, only to find that he was surrounded by complete darkness. The air was stale and cold, and not a sound was to be heard. Mustering up all his strength, he pushed against the low ceiling of his stony prison and managed to lift the lid. When his eyes had accustomed to the twilight he realised that he lay in a dusty mausoleum. Stunned and bewildered, the king rose. Everything around him was marked by time and decay.]] },
			{ itemId = 2827, -- book
				text = [[
The Dark Woman I
In the olden days there lived a king that was unlike any other king amongst humankind before and after him, except for the divine Banor himself. His light shone upon his subjects and gave them enlightenment. The dark gods looked at him in malice and hatred, but he was blessed and protected by the gods, and nobody could harm him. The dark gods were furious. They held council and discussed how the good king could be undone. Finally, they came up with a diabolical plan. They took a thousand mortal slaves as well as the most vile and cunning of their succubus demons and went to create an entirely new being. They created a woman and sent her into the realm of the great king. She was human by all appearance, but she was evil to the core. Her exquisite body and her soft voice were of unsurpassed beauty. She was met with rapture and admiration wherever she went, and many a man lost his heart merely by looking into her gentle eyes that seemed oh so innocent. Soon the king himself had heard of her breathtaking beauty. Intrigued, he summoned her to his court. Nobody was surprised when he fell for the graceful girl the minute he cast his eyes on her. Within a day he proposed to her, against his counsellors' better advice, and within a week the kind king had made the pale, dark-haired beauty his queen. The king was madly in love. He soon accepted his newly-wed wife as his confidante, preferring her opinions over those of his former counsellors. At first it seemed that her advice was thoughtful and prudent, and so it came the good king relied more and more on his beautiful wife's opinion. He closed his eyes and ears to other people's good advice and blindly followed her evil counsel. Little did he realise that she purposefully taint his views of the world with darkness. Using honeyed words, she sowed the seed of distrust in his ear, until he started seeing enemies everywhere. He grew suspicious of his advisers, who dared to challenge his beloved wife's wisdom, and turned away from his former friends, who tried in vain to warn him of her wicked influence. In the end, he even started questioning the authority of the true gods themselves, blinded by his wife's promises of power and glory. She made him believe that the country needed a firm hand and a more determined, efficient rule, flattering his vanity by envisioning the immortal fame he could win as such a glorious king and warrior. The enthralled king followed her advice, not realising that he was about to lead his country into tyranny. He became greedy and ambitious, extending his privileges wherever he felt it necessary. He grew more removed from subjects every day, indulging in feasts and orgies while his people suffered. While his armies struggled in futile, pointless wars he chose to stay behind, claiming that he owed it to his people remain alive rather than to risk his skin on the battlefield. In fact, he very much preferred to indulge in debauchery, surrounding himself with flatterers and sycophants, and there was no greater joy for him to impress emissaries from other countries with the splendour of his palace and, above all, the breathtaking beauty of his wife. However, the good life was not to last. The tides of war turned against his leaderless armies, which had never failed to win the day when he had lead them himself. After a series of disastrous defeats, a decisive battle became more and more inevitable, and the king finally realised the danger that he and his whole country faced. Remembering the man he used to be, he finally decided to lead his forces. The queen protested. She wailed and threatened and begged him on his knees, but for once he would not listen to her. For a last fleeting moment it looked like all was not lost for the good king and his realm.]] },
			{ itemId = 2821, -- book
				text = [[
Mermaids are vain creatures of magical nature. Dealings with mermaids are dangerous to some extent. Many men have fallen in love with one of them, bewitched by their beauty and magic. Fortunately, mermaids are easily distracted and lose any interest in their enthralled victims as soon as something or someone else draws the attention. Since this is often enough another man that was foolish enough to get close to them, one elflock-stricken victim is replaced with another one. It is almost impossible to escape this vicious circle since unbanning one victim often means to sacrifice another man's live or at least his freedom.]] },
			{ itemId = 2826, -- book
				text = [[
Treasures of the Southern Isles

Quite a few pirates hoarded up treasures in the past. It is known that pirates tend to hide their treasures on deserted islands for some unknown reason. They just bury them on some remote place and then forget about them. This similarity to the behaviour of squirrels was never scientifically verified. However, since pirates love to dress lightly they also love the south. Therefore, it is only natural that they hide their treasures there. Some of the southern isles are so popular among pirates that there is hardly any free space left to bury new treasure.

If anyone ever is looking for treasures, then those isles are the best place to start with.]] },
			{ itemId = 2816, -- book
				text = [[
The Great Creation BOOK ONE

Uman in his wisdom recognized the possibilities, which revealed themselves to them here, and he asked Tibiasula join in the circle of the creators and help them with the task of the creation. Tibiasula agreed, because she also was fascinated by the idea of the creation.

Uman, whose nature was to win secrets and gain insights, had relized what their error at the receding attempts had been:

Without a fixed pivot point there was no existence possible, and everything had to diffuse away as it was without direction and target. And to remedy that he invented TIME!

In order to create the time, the Gods united their powers. Even Zathroth was fascinated by the idea of his other half and contributed a tiny proportion of his strength to the effort. The wise claim that it is to be due to his working that all time strives in the long run to decay and destruction. The powers of the godly bundled themselves to an enormous power greater than any in existence before. It began to crystallize itself in the void to an enormous spiral. Higher and higher it mounted up, became firmness, pivot point, direction andaim of existence! And in such a way the crystal column of time grew upwards and was from then on the unmovable center of creation.]] },
			{ itemId = 2816, -- book
				text = [[
The Great Creation BOOK TWO

But even at the culmination point of the creation Zathroth bundeled all his destructive powers to a weapon and pushed it with all the strength that he could muster into the heart of Tibiasula, whose existence he did not want to endure any more. And as the divinity was weakened by the creation and without suspicion and resistance, the deadly attack penetrated to the core of her being and destroyed her.

The elements - fires, water, earth and air - were jerked out of their harmony and landed at the base of the column of time.]] },
		},
	},
	-- bookcase at 32171,31929,6
	{
		itemId = 2439,
		itemPos = { x = 32171, y = 31929, z = 6 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
The Dark Woman III
Stumbling out of the mausoleum, he found himself in the ruins of a once-proud city. It did not take him long to realise that these ruins were the remnants of his own capital. It appeared that he had lain in an unholy slumber for a very long time. And now his kingdom was lost, run over by his enemies, and his former subjects were enslaved or dead. Stunned with shock and disbelief, he wandered aimlessly through the ruins. To his own amazement, however, his heart did not race as furiously as might have been expected. In fact, it did not beat at all. Stricken by panic and confusion, the king went on and on until he came across a small group of travellers, who had sought refuge in the ruined city. The meeting was not a coincidence because he had felt their presence for quite some time and purposefully directed his steps towards them. In fact, all of a sudden a hunger had taken hold of him such as he had never experienced before. He rushed towards the strangers as fast as he could, his mind inexplicably clouded by this weird hunger. When he finally returned to his senses, the travellers lay dead before him, their bodies twisted and mutilated. He was confused and aggrieved to find that the only living beings he could have asked about what had happened were dead, but at the same time he felt strangely intoxicated by a feeling of mad triumphalism. The weird hunger that had troubled him was nearly gone and he felt stronger and more alive than he had ever done before. He fled the city that very night, running away from his painful memories. He made it his habit to travel only by night as he found that daylight caused him insufferable pain. Today, little is known of his fate or of what is driving the creature that once was a king. Some say the demon he devoured has taken control of this new form, while others claim that the accursed king is driven by guilt, looking for redemption from the sins he committed against his people, distorted though his vision of redemption might be. Yet another group of scholars claims that the accursed king is bent on revenge against the dark gods who plotted his downfall or perhaps against the gods of light who let him down in the hour of need. What is certain, though, is that he fathered many others like him who share his curse, and that he has lived longer than any mortal creature should, enduring the aeons and watching the ever changing world frozen forever in the moment of death that did not lead to true death.]] },
			{ itemId = 2825, -- book
				text = [[
The Quara, Curse of the Seas

No one knows where they really come from. It seems the murderous quara are living deep down in the ocean in unknown numbers. From there, they plot their raids on the surface in which they cause havoc and mayhem. The quara consist of several subspecies whose relation to each other is still unknown to men. Given their hostile disposition, it is unlikely that we will ever learn more about them. For most humans it is sufficient to know that a quara means danger. Those who are able to fight them should kill them, those who are too weak should avoid them by all means.]] },
			{ itemId = 2816, -- book
				text = [[
The Birth of the Elements BOOK ONE

Schocked Uman and Fardos tried to grab hold of the dispersing being of Tibiasula, but it was about to slip out of their hands like their creations before. They wove a powerful spell, the spell of the creation, in order to bind Tibiasulas essence to the column of time. As Zathroth laughed loudly, in his vain triumph, he did not understand their words, and so the secret of creation and life stayed hidden from him forever.

They however wove the fleeting elements to powerful strands. Althought they did not succeed in uniting them again but the individual parts became something new, the first real creation. Thus the living part became Tibia, born from the element earth, Sula became the sea washing around it. Air rose over the creation and layed itself like a protecting blanket over the creation, and the fire seeped under it and began to warm it up.

Behold: Each of the separate parts of the god was full of life and divinity! But none of the elements possessed the spirit of the Tibiasula, but they were wild and impetuous, following always the impulses which corresponded to their nature.]] },
			{ itemId = 2816, -- book
				text = [[
The Birth of the Elements BOOK TWO

And Uman and Fardos were chagrined about the dastardly deed or Zathroth. They decided to create from the elements something new, similar to Tibiasula. For a long time they looked for a way of achie this end. Finally Uman found a solution: the birth, which created live from live. One of the Godly had to unite with one of the elements and could thus create a new entity. Thus Fardos and the Fire united, and the Fire bore two children, Fafnar and Suon, the Suns of Tibia. Suon of calm and considerate nature. But Fafnar, its sister, was self-willed and stubborn. She rose vainly over the elements and began to scorch them. Therefore Suon also rose up in order to stop his sister. A wild struggle started and pretty soon it turned out that Suon was the stronger one of the two. So Fafnar fled under Tibia into the parental fire, but Suon wanted his sister to promise him never to scorch the other elements again.]] },
		},
	},
	-- bookcase at 32171,31930,6
	{
		itemId = 2439,
		itemPos = { x = 32171, y = 31930, z = 6 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The History Of King Zelos I
King Ottremar was a wise and pious ruler. Through his lifetime the realm went through numerous changes and reforms that benefitted the realm as a whole. His prodigous son Paron was destined to follow him as a competent ruler to lead the realm to further prosperity. Yet the king's younger son Olbret was as ambitious as jealous. He plotted the assassination of his sibling, in league with sinister forces. With promises of the restoration of former grandeur he allied himself with elements of the secret church of Zathroth. However, by chance or divine intervention of the gods, the inquisition discovered the plot and arrested Olbret. But by then he already managed to place a potent poison for Paron to which the latter succumed within a week, despite all efforts of healers and clergery. So a distant cousin of the brothers, Zelos, was named successor of the old king. This decision did not suit well with some of the most powerful nobles in the realm. This dispute overshadowed the last years of Ottremar, now a broken man, becoming more and more fragile with each passing week. When Zelos took the mantle of kingship, the boiling anger erupted. With reluctant nobles disputing the new king's right to rule, the once prospering realm was on the brink of open rebellion. Zelos was well aware of his shortcomings in regard of ruler ship. After being named successor he had dedicated himself to the studies of the kings that had come and gone in the past. When he became king and with civil war on the horizon, he decided that books weren't efficient and fast enough to teach him the needed skills. He decided to learn from the source itself instead. He consulted spiritists, shamans and even necromancers to summon the spirits of the kings of old to act as his advisors. This again arose the suspicion of the inquisition and even increased inner tensions. More and more desperate, Zelos turned not only to the advice of some reluctant ancestors but almost any spiritual entity that was willing to listen to his plea and to teach. Some of those spirits were more persistent and did not leave, once called into the world. So Zelos was soon hearing voices and whispers all day and even in his sleep. It is hard to say which of his later decisions were entirely his and which were the result of such dark whispers or even his own growing insanity. Yet his first steps proved to be a success, at least from his point of view.]] },
			{ itemId = 2828, -- book
				text = [[
The History Of King Zelos II
After provoking the orcs to attack the realm, he mustered all forces to march against the common foe. With his enemies and their forces occupied and being oblivious of his true intentions, his state troops seized their families and brought them as hostages into the capital. The nobles were outraged but powerless against this threat. Zelos was unmoved by their threats and pleas. After an execution of certain family members just as an example the nobles grudgingly gave in. With raised taxes and tariffs Zelos raised more troops and began to rule with an iron fist. He crushed the orcs and two minor rebellions which he used to justify a demilitarisation of the nobles to quell their strength even further. Zelos also became a collector of magic artifacts, with knowledge of their whereabouts provided to him by his spiritual guides. His insight into the plans of his enemies grew more and more by either spiritual informants or scrying devices he acquired. He now regularly consulted spirits and manifested ghosts as advisors, messengers, bodyguards and even assassins. More and more though, instead of ruling, he could be found mumbling to himself, lost in inner dialogue or arguing with unseen spirits. Soon he became known by his subjects as the ghost king. More and more he withdrew into his tower in the palace, relying more and more on ghostly messengers to communicate with his court. Oddly enough he was a strong supporter of the inquisition, though most claim it was just his reluctance to share his power with anyone. Under his reign the inquisition became twisted and changed, cutting many ties to the churches and been more and more responsible to king and crown. The purges of this inquisition often targeted the very same sources on which he himself once so heavily relied upon and many confiscated talismans and objects found their way into his hands. At some point he shut himself off from the public completely. Yet while he received food and water, his only contact with the outside world took place via ghost messengers or him attending council meetings remotely, due to arcane devices. In the 98th year of his unnatural long reign a still pious branch of the inquisition breached his tower in a coup. No one, save the top members of the inquisition, know what they actually faced in this tower but the day after, king Zelos was declared dead. His successor was yet another young cousin of his. Ilgram had already build up a strong support from the repressed nobility and proved to become a beloved king that renewed the realm to its former glory, casting away the gloom that the ghost king had cast over the land.]] },
			{ itemId = 2816, -- book
				text = [[
The Birth of the Elements BOOK THREE

Thus he followed the vain sister and sought her it. She however was quick and escaped from him again. She escaped on the other side and again rose over all elements, and began anew, to scorch these. When Suon followed her now, in order to punish her, she didn't let it come not a further test of strength and escaped the brother immediately. He followed the teasing and aggravating sister tirelessly into the embrace of the fire. But Fafnar was a step ahead of him and had already fled again onto the other side over the elements ... and in such a way this continues to go on even today.

Uman united himself with the earth, which we know as Tibia. And the earth bore him Crunor, the first tree. Crunor was full of charm and vitality. Also he loved his own shape, but he was wiser than Fafnar and possessed the gift of modesty. Inspires by the creation he bore from itself all the plants, small and large! And they spread out on the body of mother Tibia, like a dress - it was a delight to see.]] },
			{ itemId = 2816, -- book
				text = [[
The Birth of the Elements BOOK FOUR

Fardos connected himself with air, and its child was called Nornur, fate. Nornur envied the brother Crunor because of his shape, as he was hardly more than wind and nebulae, and he asked he brother for assistance in creating a shape for him. But no matter how hard the brothers tried, Nornur couldn't appear to be much more than a shadow of a ghost.

Thus Nornur decided to create creatures in order to reveal himself. Thus the spiders came into the world, which are able to web their ghostlike spiderwebs, which copy Nornurs shape, and thus praise and honor him.

Also Uman and Sula, the sea, found together, and they conceived Bastesh, the unfathomable one. She was exceedingly beautiful, and the Godly were astonished. But Fafnar, the sun, looked upon all this beauty full of envy! When the newly born Bastesh looked up to her, she attacked her with fiery claws in the face and scratched it readfully. Probably Bastesh would not have survived the attack of her sister, had not the other Gods hurriedly come to help and driven away the ravishing Fafnar.

Bastesh however was frightened and disfigured. Full of fear she fled into the embrace of her mother Sula. In the depths of the seas the unfathomable one hides herself since that time, and little is known about her and her workings. Only the fact that the sea has been populated since that time by numerous creatures, may tell us that Bastesh seems to create these in the depth. In addition it is said that since that time the water of the seas is salty from the tears, which the disfigured Bastesh sheds out of anguish and pain.]] },
		},
	},
	-- bookcase at 32171,31931,6
	{
		itemId = 2439,
		itemPos = { x = 32171, y = 31931, z = 6 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Baron Eserak was the spiritual leader of a knightly order, devoted to the service of the gods. As a gathering of philosophical and pious men and women, the order often met in debates on spiritual matters. Often such debates lead to heated argument because most members were extremely set in their opinions and points of view in religious matters. Over the time two fractions arose that at least vaguely agreed on crucial points to which the other faction strongly disagreed. Heated debates led to violent arguments and over the time this bred an atmosphere of hatred. When Eserak learned that the opposing faction secretly planned to split he saw his grand plan in danger. He gathered his most loyal and devoted members and lead them in a violent purge of the dissenters. The once wise and serene man had become infuriated about what he saw as the ultimate betrayal and he was not willing to show any mercy. But even after the purge of the order he would not find his peace. The shock of the defection by so many of his former brethren and sisters left him paranoiac. Seeing traitors everywhere he lead several more purges and was driven so far as to burn several of his loyal friends on the base of dubious suspicions. Listening to false advisors his harsh actions lead to the loss of many members, either because they were killed as heretics or because they left the order in disgust. Since the knights of the order hailed from some of the most powerful families of the realm, the schism spilled over into a civil war. The weakened order and their supporters were greatly outnumbered and to restore peace even the crown sided with its enemies. Unwilling to be brought to an - in his eyes heretic - trial, he took his own live before he could be arrested.]] },
			{ itemId = 2816, -- book
				text = [[
The First Creatures BOOK ONE

Zathroth however was delighted by the destructive potential, which Fafnar showed, and he looked upon her with delight. He flattered her with compliments, and he succeeded in seducing her. Thus they conceived Brog, the fiery raging berserker. Brog possessed only little of his fathers wisdom, and the heat of his mother burned only deep inside of him. There however the fire became more ravaging and more hurting, and the rough titan raged and cried that the elements were shaken. Inexpressible pain troubled him, until the blocheaded Brog compacted his magical powers and hurled a major part of the fire far away from himself. From the fire, which did not want to cool down, however immediately the first dragon, called Garsharak, rose and he bore many further lower dragons in the course of the centuries from his fire and his magic, of the like we know today.]] },
			{ itemId = 2816, -- book
				text = [[
The First Creatures BOOK TWO

Brog however laughed over the dragon, which he had create, because he roamed over Tibia and was a terror to the few other creatures. Brog was fascinated by this created being and its terrible children, although they showed him neither loyalty nor respect. Thus Brog created further life, imitiating his shape, in order to please him, and so the cyclops entered the world. Zathroth however was angered, because he thought the cyclos stupid and awkward. Too little trouble did they spread in the world, because they quarried in Tibia for metals and enjoyed to process it with fire and force. They were too few for his likes, because they hardly grew in numbers. Thus Zathroth reprimanded his blockheaded son and ordered him to create new life. For he himself still could not understand the secret of life. Under his guidance the first trolls, numerous and vexatious, developed but still without the malicious cunning, which Zathroth desired. Next father and son therefore created the orcs. And the orcs turned out just like the dark God wanted them. They flowed over Tibia, spread out and began to devastate it.]] },
		},
	},
	-- bookcase at 32172,31925,6
	{
		itemId = 2436,
		itemPos = { x = 32172, y = 31925, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The flying Venorean is a ship that is cursed to sail the seas forever. Allowed to visit land only every seven years, the ghostly captain uses his shore leave to lure clueless sailors into his crew. Everybody that signs the contract becomes cursed like the captain and might only leave the ship if he finds a suitable exchange on one of his shore leaves every seven years.]] },
			{ itemId = 2816, -- book
				text = [[
Cooking Venore Style]] },
			{ itemId = 2816, -- book
				text = [[
The lost caste by Iregarn
We could not confirm the extinction of the Chelabdil. On the other hand we found no living beeing in the area. We met strong orcish presence there. Some of the orcs we killed had elvish items on them so it might be possible that all of the so called Chelabdil were wiped out by the orcish hords. One proof more our way is the right one.]] },
		},
	},
	-- bookcase at 32173,31925,6
	{
		itemId = 2435,
		itemPos = { x = 32173, y = 31925, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Logs and Leaks, the Daily Life of a Captain]] },
			{ itemId = 2821, -- book
				text = [[
Flags of the World]] },
			{ itemId = 2821, -- book
				text = [[
Nautical Studies]] },
			{ itemId = 2816, -- book
				text = [[
Hammerfalls tales of 1001 wife]] },
			{ itemId = 2821, -- book
				text = [[
Puldraks wisdom about elves Pt. 2
The Kuridai took refuge in a volcanic area, inhabited by vile monsters and ravaged by the eruptions of the mountains. Stripped of almost any possesions, they hid in the caves and learned to become very secretive. They had to work very hard, had to fight for almost any goods with nature and ferocious beasts. Most beasts that could live in such livethreatening circumstances were that powerfull that direct attacks proved to be futile. So the elves begun to develop a more devious way to fight, with assaults, traps and hit and run tactics. After over hundred years they had enough resources to leave the burning lands and adopted their way of live to their new enviroment. So they became the secretive people under the hills. They were fierce fighters whenever their new home was threatened. Some hundred years they fought off all intruders until their explorers made contact with the other remaining elven casts. Under the growing pressure of the more and more powerful waves of orcish attacks they left their homes to join forces with the other elves in an uneasy alliance.
Their apperance had changed to a even more slender Version of the normal elves. Their skin is very pale, their hair pure white or pitch black. The younger members of that cast often color strands of their hair in unusual clors like red, blue or purple. Red, albinotic eyes are common, but in general all kinds of eyecolors are existent.]] },
			{ itemId = 2816, -- book
				text = [[
A shrinking potion
Take 2 powder herbs, a stone herb and a orange star. Cut them into small pieces and put them in a pot. Add a bottle of snake blood and boil it.
If you've done it right, the potion should be thick.
Wait until it's cold and then add the last ingredience, a 2 inch piece of a swamp plant.
This should make the potion green and much thinner. Fill it up in bottles and it's ready to be used]] },
		},
	},
	-- bookcase at 32173,31934,6
	{
		itemId = 2435,
		itemPos = { x = 32173, y = 31934, z = 6 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Geography of Krailos, by Larek the Wayfarer

Krailos is mainly populated by ogres. It is located north of Oramond, bordered by high mountains to the south, a wild sea to the east, huge cacti forests to the west and rocky hills to the north. At the rugged shores of Krailos one may find many shipwrecks, as the area is surrounded by treacherous underwater shelves.

Krailos itself is mainly covered in sandy plains and has a rather hot climate, which has led to a sparsely spread population. This means most of the ogres live in small tent villages. There is just one bigger settlement, which is home to the Bloody Skulls tribe. Also, some ogre tribes still have nomadic tendencies. The country's landscape is harsh: rocky beaches, dried-up salt lakes, rugged rock formations and dry, barren fields number among the reasons why the area is avoided by foreigners. Another reason of course are the ogres themselves.]] },
			{ itemId = 2826, -- book
				text = [[
Upon Ogre Society - An ethnological essay, by Larek the Wayfarer

Built upon the violent battles and wrongdoings of its past, Krailos is now among the most unconnected countries in its corner of the world, characterised by bitter struggles and a harsh environment. The ogres' hunting skills and physical strength are among their current greatest benefits; and the mountains of Krailos hold some rare minerals. On the other hand, Krailos lacks a lot in infrastructure and clean water.

Krailos is a tribal nation, divided into several different clans. Leader of a tribe is usually the strongest male ogre (although in some cases a particularly violent or domineering ogress claims the title). The chieftain is supported by an ogre-shaman. If the shaman is female, the two are often, but not necessarily, a couple. The chieftain is responsible for all decisions concerning the hunt and martial matters while the shaman is responsible for all affairs spiritual and social. Within a tribe, there may be a couple of opposing individuals against the current chieftain, but overt struggles for leadership are rather uncommon. Each tribe is independent of the others, and conflicts between two tribes occur frequently. However, the greatest threat to the ogres actually is the desiccation of the lakes and rivers. But the current chieftains are too preoccupied with their tribal conflicts to seek solutions for this issue.

The ogres are simple, warlike people, more interested in a fight and good food than in politics. Elimination of competitors is an accepted way of moving up in the ogre ranks. Ogres like conflict. They are impulsive, quick to anger and do not hold back their opinions regardless of who might take offense. Ogres prefer to solve conflicts through combat rather than words. Yet, an honorable death is not the highest purpose in an ogre’s life, but rather a fulfilled life, which primarily means enough food and a comfortable hut. Ogres are distrustful towards strangers and tend to welcome them with avoidance in the best case. Lately yet, a tribe called the Bloody Skulls has shown a sort of interest in trade with other peoples.

A kind of spiritual shamanic animism holds a certain importance in the ogres' lives and each tribe’s shamans are always renowned members of the society. The common ogres are moderately spiritual and have rites of passage and annual rites concerning the seasons and certain weather phenomena. Ogres worhip The Great Hunger, a kind of spirit being they believe will eat up the entire world if not fed regularly. Therefore they often perform rites of sacrifice (food but also living creatures) to feed this entity. Otherwise, ogres care only for the here-and-now.

Contrary to common prejudices, ogres are at least a little more than mindless brutes. They possess a talent for animism and have certain artisanal skills. For example they have developed passable methods of curing and tanning hides, so their leatherwork is quite convenient. Despite their great passion for eating the ogres don’t have a reputation as outstanding cooks as their meals seldom match other peoples’ taste. Ogres eat especially meat – of hunted animals but also the meat of humanoids, mainly humans and elves. This is the reason they also are referred to as “maneaters”. It is important to mention that they never give in to cannibalism. Besides meat they also love sweet tasting things, such as honey combs or cakes, although they don’t get the latter too often.]] },
			{ itemId = 2821, -- book
				text = [[
Carlin and the rise of the women Vol.1
In the begining the Carlin colony was planed as a example of thaian greatness. A city planned by famous architects and built by the finest craftsmen the kingdom could muster. The area was plagued by orcattacks tough and the people and workers became dishearted and afraid. Many left the site for good. So more and more forced labourers and criminals were sent to help in the building process and the finest army of the kindom, the feared 'red legion' was sent as a protective force and to hold the growning number of doubious citizens in check. Seeing the possibility of failure of their greatest project, the royal family of Thais used the growing city of Carlin as a deposit for unwanted thinkers and noble familys that misstepped in the intrigues that plagued the kingdom in those time. Unwanted in the capital but too powerfull to be disposed they were sent to Carlin. Given their wealth and the fertility of the north, the city was not a bad place to live at as long as the legion managed to keep the orcs at bay. Those citizens were joined by some druids that were not comfortable with the power and influence of the thaian sorcerors and their closeness to the royal family. Soon freethinkers and philosophers flocked to carlin and the unrest grew. The focus of the thaian military to internal affairs was increased and the city was ruled with a more iron hand. The governor was not a calm man and seeing the prosperity of the city he got greedy, increasing the taxes to painfull heights. The building of an enourmous castle was begun, a bit northeast of Carlin. Most unfree workers were used for the construction and so soon the city was no longer sufficiently supplied with food. Seeing that only the local druids made it possible to raise enough supplies, the king ordered more druids to travel to carlin, ensuring the supply of the city, the workers and the troops. Still the work progressed slowly.]] },
			{ itemId = 2821, -- book
				text = [[
Carlin and the rise of the women Vol.2
More and more male citizens where drafted for the construction of the castle. The women were forced to learn most crafts needed to run the city and joined the druids in gathering and hunting, learning a lot of helpfull skills from those masters of nature. The exiled sister of the thaian king gained more and more influence in the city and soon some huntresses loyal to her cause started nightly supply raids on the bases of the red legion at the buildingsite. With the stolen food she bought favours and supporters in the still starving city (since most supplies went straight to the red legion). Using their newly learned skills of stalking and laying false tracks, the huntresses blamed the orcs of the region with the raids. The plan worked well - too well. The orcs, frightened due to the presence of the famous red legion whose mercyless brutallity was even known to the orcish hordes had not dared to attack or even harras the humans in the carlin area for some time. After a few of those 'orcraids' that could not be prevented the general of the legion ordered a good part of his troops to attack and anihilate the orcish base. Their known base as a islefortress where they thought themselves save. By night, protected by heavy fog the legion used primmitive rafts to cross the sea to the not so far isle. Their attack was a complete surprise. The orcs were slaughtered. Most of the higher ranking orcs were not present in the fortress, partaking in a riutal to find a new chieftain and warlord at the other side of the isle. So the orcs, without leadership were easy prey for the experienced legionaires. After their bloody victory the legion hastily tried to travel back to ensure the crimminals did not take that oportunity for a mutiny. Noone knows if it was magic used by vengefull orc shamans (or even by carlin druids as some claim) or just a force of nature, but a storm struck as the legion was crossing the sea a second time.]] },
			{ itemId = 2816, -- book
				text = [[
Dear Diary,
Today I was almost scared to death.
While running through the bushes outside Venore, I ran into this huge hairy six legged.. thing.
First I thought it was my brother, but there it was, one huge spider.
I'm glad it didn't see me, because I had to change pants.
This must have been the most embaressing day for me, I'm glad no others know about it.

Dear Diary,
Hair is hairy.
And it comes in different styles.
Itch sometimes.
Running your fingers through hair is great.

Dear Diary,
I think I have found something wrong with me.
I like cheese alot, cheese makes me happy.
With cheese I feel whole and complete.
Does this make me a rat?

Dear Diary,
Why do we have hair?
It's just in the way, and it itches and all that.
I want to be just like my dad, bald and hairless.]] },
		},
	},
	-- bookcase at 32173,31936,6
	{
		itemId = 2435,
		itemPos = { x = 32173, y = 31936, z = 6 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The Origin of Vampires
Since the vampiric curse is spread through infectious bites, many vampires know only little about the origin of their kind. Then again the longevity or even immortality of vampires makes it possible that they have even existed before the creation of mankind.
Of course such beasts are hard to capture and they do not like to share their knowledge. Even if you are lucky enough to be able to talk to one, you cannot be sure if he is telling the truth. In fact, most questioned subjects were making up stories and boasted about their importance, age and accomplishments.
Lacking historical knowledge, such individuals can usually be cornered by accurate historical questions. This leaves a few sources that can be seen as credible to some extent. Still, their reports are diverse and share only a few facts. These common facts are the most reliable information we have these days.
The vampires claim that the eldest of their kin still remember a time when humankind was still divided in nomadic tribes that suffered in the wars of the gods. Some see this as a reference that the creation of the first vampires took place before the Corpse War.
The majority of vampires agreed that there was only one shrouded forefather vampire, though few mention also a small coven from which the vampire plague was initiated. The most reliable sources tell about some 'lost kingdom' where the first vampires ruled over a herd of humans that they treated like cattle.
At some point in history, the younger vampires rebelled against the elders who suppressed them. Others claim the rebellion took place to gain power in this static aristocracy in which the older vampires would have never made room for the next generation due to being near to immortal. It is unknown which side won. In fact the discrepancies in the single stories are so large that we assume that the vampires themselves are unsure about the happenings in these obviously chaotic days. Some claim the rebels won and chased the aristocracy away, others say the ruling cast won and met the rebels with such brute force that the few survivors could only flee. Then again there are stories that the fight between the vampires awakened something evil which drove the surviving combatants off their once safe haven. A few stories even claim that the humans used this opportunity to rebel against their cruel oppressors.
There are no hints about the location of this lost vampire kingdom. It is assumed that it was somewhere overseas, though. Some historians suggest Edron, but, the ruins in Edron are said to origin from much earlier times. Others assume it might have been on the mysterious continent Darama, either in Drefia or in Ankrahmun. However, the destruction of Drefia took place much later and there were no reports about undead activity, except for the works of several local necromancers, before this time. Ankrahmun, on the other hand, has a very accurate historical library and there is no such thing like a vampire kingdom mentioned at all.]] },
			{ itemId = 2816, -- book
				text = [[
You can not even imagine how old I am. In your wildest dreams you won't see the things I have seen. I am the last of my race and even though I am several centuries old I am not immortal and will eventually die. I fear that day. Not for me - I am weary and I don't care much about if I'm alive or dead. But I fear for all these memories that will die with me. For all those who no one will remember anymore.
Words can't truly preserve their essence so I will leave no books or stone tablets. If I die, everything I have witnessed will die with me as if it has never existed. I was there when Rorak slew Tingil at the stairs of the seven temples. I was there as Riik led his peaceloving people to the far north to find refuge from the war. I was there to witness the betrayal of Asric for the whims of a female that was long dead by then. I fought with the last Frdai a futile battle on the plains of Weskurt against the unseen legion. I witnessed Ss'rar making his move on ascension to become the serpent god. I watched the first elves struggling to form a nation with the help of the lightbearers. It was me who assisted the great calculator to assemble the bonelords language. And you come here to this mountain and ask me how to win the heart of some shepherdess? This world has become a ridiculous mockery.]] },
			{ itemId = 2821, -- book
				text = [[
651288967212778894388721512889521961800311457278572611857642197096
805796366125275705845217652197278304648765159564611414519889975112
16151]] },
			{ itemId = 2816, -- book
				text = [[
... The spectres where everywhere! Ghosts and undead swarmed us, clawing and biting at us. We chanted the prayers to Banor and fought like we never had fought before. Blessed steel cut rotting flesh and servered limbs and bodyparts that still did not stop to moove. Then all of sudden the undead horde retreated. They almost ducked under some unseen power, the deafening screaming of the dead became a frightened whisper. And then we saw IT! It was a mummy, aeons old and addorned with jewelry worth a kingdom. Slowly it aproached us, its undead minions ducking in fear to his feet. A moment it stood still and its faceles head seemed to muster us. I dared not to breath, the glance of the mummy seemed to stain my soul with rot and evil. I heaed my heart beating. Then the mummy slowly lifted its arm, pointed at us and spoke 'chamek ath uthul arak!' The priest of Fardos who was with us and survived that nighmarish ordeal later told us it means 'sacrifice your blood' in some ancient language of an extinct race. Of course we did not know how to react and noone would have given this godscursed creature even the dirt under our fingernails anyways. After a moment of silence the mummy raised its hands again and with anger yelled but one word: 'Kadash!' I did not need a linguist to translated that. It meant 'attack'. And within the next heartbeat the screaming horde stormed us, ready to flail our living flesh from our bones ...]] },
		},
	},
	-- bookcase at 32174,31925,6
	{
		itemId = 2436,
		itemPos = { x = 32174, y = 31925, z = 6 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
I, Vampire
Our race, if my dear reader allows me to use that term, is a rather curious one. One might argue that we are a side strain of humanity. As far as I see it, the human body is all but a catalyst for a most formidable transformation. With the transformation an all new world of opportunities and impressions awaits. It is an awakening. Several things, such as coldness and tiredness cease to exist for a vampire. The focus of existence is no longer bound to tiresome daily routines and can be aimed at something bigger and more important. The weak and fragile mortal body becomes a sophisticated tool that does not lose its function due to illness or old age. Seeing the mortals suffer under such influences alienates a vampire somewhat from humanity and makes it ever more clear that we are different. Humans and vampires are set apart from each other. We remember mortality and see its weaknesses. We mourn the mortals even though our highly evolved existence raises us high above them. The wisdom we gain with our age is great. Freed of the shackles of mortality we have a clearer view of things. Knowing the envious fear with which some greedy and selfish humans view us, we hide from the eyes of overzealous inquisitors and clergymen. Behind the scenes we guide the humans through history, supporting the worthy and eliminating threats to humanity. We are the unseen movers and makers that hold kingdoms together, furthering ideas that improve societies and boosting discoveries. Not for gratitude, but to fulfil the obligation of passing some of our fortune on to those that are not as fortunate. A selected few grasp our status and have the greatness to live with their inferiority. In their own meek way they try to help us in our noble efforts. They are worthy above all others to become one of us one day. We do not take new vampires lightly of course. It can be a challenging and long journey to join our ranks. With diligence and intelligence a human might eventually convince a vampire of his worth.]] },
			{ itemId = 2821, -- book
				text = [[
Puldraks wisdom about elves Pt. 5
The 5th elven cultural group are the Chelabdil. There role in the war and their fate is yet unclear, but they have few contact with the other elven casts. They are usually a bit taller and stronger than elves of the other races, and there skin is silvery-white or in blue to greenish tones. Their eyes are often pale blue or green, sometimes a faint yellow. They have long black hair, or sometimes dark brown. They seem to live nowadays in the region northwest of Carlin and are seen quite often there. They have the keenest eyes of the elves, and the weapons of their choice are spears, knives and sometimes the short bow. They are fine hunters and sometimes trade furs, but the main part of their life remains yet uncertain.]] },
			{ itemId = 2821, -- book
				text = [[
When the tower ......
.......... its sting,
when ....... walks the hal.........
.......... of murder loses .......,
w.... the ice ......
...............ll not fly t....,
whe......... silences ......,
.........red meets t.............ound,
.......... is broken by the ..........and,
when the dead walk ......nd l........,
when........ will be erased and .........,
when the for.......win no longe........,
when the one ey..........re,
..hen t...rai...et...is...te,
the...alib...ll be ..............tice.]] },
			{ itemId = 2821, -- book
				text = [[
Puldraks wisdom about elves Pt. 4
The Cenath were the most lucky of the elves. They lived in a hidden valley in a handful of cities, far away from the rages of war. As things turned bad for the elves much of their artifacts, artwork and books were brought to theese cities. Live went on as usual for some time, the elves minding only their own business, as if pretending there was no war at all. Of course the war found them at last. In an frantic attempt to rescue their lives and even their accustomed way of life the elves begun to weave powerfull spells. Many of their best magicians litteraly 'burnt out' in the process but finally the elves succeeded. The whole valley was torn out of the known world ... And this was bitterly needed in a world that was only stormy darkness around the elven valley. They created a artificial light and even created weather. There they lived for hundreds of years, studying and practicing magic, mainly to manipulate and reproduce efects of natue to enhance their lives.]] },
			{ itemId = 2816, -- book
				text = [[
Oh lay me to rest
In Thais graveyard
To know it's the best,
That's not so hard

I've been to Carlin
And met a fair lass
But to sleep in their graveyard?
I think I will pass

You may think I'm a fool
You may think I'm a liar
But I heard there's more there
Some say a vampire

But I digress and cajole
As is your common luck
Please bury me not
In the Plains of Havoc

For while an adventure
Is a wonderful track
Once I'm done, I'm done,
No desire to come back

And while many will quip
What's got in your head?
I say I prefer death,
And not the undead.

Edron is pretty,
Cormaya is fair,
But I haven't the money
To be buried there.

So lay me to rest
With a Thais tombstone
I've seen all the rest
This one feels like home.

     -Old Adventurer's Song]] },
		},
	},
	-- bookcase at 32174,31927,6
	{
		itemId = 2438,
		itemPos = { x = 32174, y = 31927, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
From a hole to a mine
A step by step guide to mining]] },
			{ itemId = 2821, -- book
				text = [[
Puldraks wisdom about elves Pt. 1
The Deraisim had become homeless in the wars. As nomadic wanderers they hid in the woods, setteling nowhere for a longer time. Their families joined each other to travel together for a while, only to disband again soon whenever an area could not supply them all any longer. Hunted by countless enemies and almost everytime outnumbered when it came to fights with 'neighbours' they retreated into the deepest woods where the greater number of their foes was evened out. There they created encampments they visited now and then. They had contact with many creatures and cultures. They adopted ideas and inventions that suited their nomadic lifestyle and begun even a very cautious trade with other races to aquire things they were not able to build on their own. As the attention of the other races turned more and more away from the elves and wars broke out between them, some of the elves begun to live at their up to then only part time ecampment on a permanent base. Adopting what they had seen from other races and things they vaguely remembered from their own past some trading posts were established in this way. Usually only one to three families lived there. After the reunification with the Cenath the majority of them could be convinced to give a permanent settlement a try and the biggest tradingpost became the settlement Ab'Dendriel. Some families refused to join their brethren and continued to wander the world, only visiting the city now and then, each vistit convincing them more that they have only little in common with the Deraisim anymore. So they begun to see themselves as Abdaisim and continued to be the nomads and restless wanderers of elvenkind.]] },
			{ itemId = 2821, -- book
				text = [[
The Dragonlords of Tibia
Written by Tekvorian, Knight of Tibia

We dont know much about the mighty leaders of the dragons. But we found out that they love mushrooms of all kind. Maybe the old dragonlord on Dracona can tell us more.

Furthermore, we found out that many Dragonlords carry a strange book with them. We dont know why,yet, but we are working on it.]] },
		},
	},
	-- bookcase at 32174,31928,6
	{
		itemId = 2439,
		itemPos = { x = 32174, y = 31928, z = 6 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The Seeds of Life
Spring is the time when the powers of the vital force are strongest. It is this time of the year when everything is growing and nature is vibrant of life. But not only nature is growing and giving birth, also the pure force of life is pulsating with energy and the power of creation. This energy often enters in living beings, making them stronger, healthier, and more fertile. Sometimes it enters in seeds of the most diverse plants. No one can tell what kind of plant may grow from these seeds, but many creatures instinctively feel the vital force in the seeds and collect them. Some creatures of nature think of these seeds as holy relics. They cannot stand the thought that those who they regard as defilers of nature could gain possession of such seeds. Therefore, the activity of those who see themselves as preservers of nature is unusually high in spring. Dryads and other creatures of nature who are hardly ever seen for the rest of the year suddenly appear in great numbers and often pose a threat to unwary travellers of the woods. The fact that the powers of the vital force infuse them with additional energy makes matters only worse. For some time, whole forests might be impassable while the trees seem to come alive. Roots try to snare and trap travellers, walls of rapidly growing tendrils and thorns block passages, and dryads and tree spirits ambush exhausted and tired travellers. Still, not all dryads are that hostile. Some of them are even willing to trade these special seeds for other items or help the finder to cultivate the seed into a magnificent plant. Sadly such helpful spirits are rare and as capricious as all dryads. So you never can be sure what exactly to expect from them. Stories are abound in which dryads deal seemingly peacefully with humans only to turn them into trees once they have earned their trust. Other stories tell about dryads that kidnapped humans and took them into their homes in some ancient tree where they had to work as servants forever. There are even stories about people who went to the dryads to trade with them or get some advice, and when they returned from their trips which had only lasted a few days, years or even decades had passed in their hometown. Of course most of these stories are fairy tales, exaggerations or outright lies, but mortals are well-advised to be extremely careful when dealing with dryads.]] },
			{ itemId = 2816, -- book
				text = [[
The Manasphere
by Rail Ashkil

The whole planet is surrounded by an energetic field called "Manasphere", produced by "Mother Nature". Nearly every living being is able to tap it and store a certain amount of this "mana". Even less beings are able to use this energy to produce light etc. In most cases the user will "cast a spell" - but only to concentrate on his natural abbility of mana-using. Some beings, dragons e.g., seem to use the mana more instinctively but nevertheless with great efficiency.]] },
			{ itemId = 2821, -- book
				text = [[
The adventures of hugo the humble
Once upon a time there was a monk named hugo. He was so humble that he ... <the rest of the book is ruined with black ink - on the side you read : Sorry my humility does not allow such flattering book about me to exist, yours Hugo>]] },
			{ itemId = 2821, -- book
				text = [[
The maze of the lost souls

Centuries ago, our ancients build this maze to protect our city Demona from bandits and warriors.
With the help of our loyal trolls they finished this giant maze within 1 month!

This maze has been protecting us for centuries and we hope that it will be the same for many following centuries too.]] },
		},
	},
	-- bookcase at 32174,31929,6
	{
		itemId = 2439,
		itemPos = { x = 32174, y = 31929, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Beware of the bonelords!
The bonelords are an ancient race of underground dwelling necromancers. Although they can 'speak' like humans using some membranes, their native 'tongue' consists of a blinking code with each eye, where a blinking could mean some syllable, letter or word. It is by far the most complex speech we have ever encountered and it is almost impossible to comprehend. As far as we can tell it is not only a language but also some kind of mathematics. This combination makes it tedious even to try to understand that language.
The books the bonelords write contain only numbers and the code behind them is incredibly complex. This race was one of those which were part in the creation wars and therefore its peak of civilization and power is long gone. There are rumours about still existent bonelord settlements where they try to improve their unspeakable necromantic rituals and create an army of undead.
In general they seem malicious but without any ambition to do more than to claim some lairs and to defend them. They seem to have no ambitions in conquering or allying with other races in a bigger style other than bonelord mercenaries who occasionally join forces with other entities for private reasons.]] },
			{ itemId = 2816, -- book
				text = [[
The Language of the Wolves
by Ishara.]] },
			{ itemId = 2821, -- book
				text = [[
Be creative - Handmade gifts]] },
		},
	},
	-- bookcase at 32174,31930,6
	{
		itemId = 2439,
		itemPos = { x = 32174, y = 31930, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
My Journeys Trough [sic] Tibia I

In my travels I visited a small coastal hamlet where I learned the villagers kept a 'wild man' captive. They asked me for advice how to deal with the obvious lunatic. They had chained him up in a dark, unused barn. I was quite surprised when while examining the unkempt, dirty man I recognized that this tattered and stained clothes at one time must have been regal and noble. For most times all he would utter were animalistic sounds and growls. I could see how the simple people of the hamlet would assume he was raised by animals or a hermit that had gone mad due to loneliness. With patience and diligence though, I managed to calm him down. Although it took days until the first time, he mumbled something that could be interpreted as words. Sadly from that point on my progress was halted. There was no way to get more out of him, then a few words and even them were rather random. He could be soothed by my words but though the words and phrased he uttered were proof that he knows my language well, he showed no reaction to anything I said, beyond reacting to the tone of my voice. It was as if he'd been trapped in his own mind. Strangely enough 'things' started to happen in his presence. Things moved when not watched, milk turned sour, food rotted away in minutes and I could not get rid of the feeling that sometimes we were watched by some unseen presence. In all his utterings only three things were prominent and consistent. 'The library', 'knowledge' and 'Zathroth' were the words he mentioned most and which usually were followed by screaming, cramps and the aforementioned manifestations. The superstitious villagers first refused to take care of him for a few more days on their own, while I acquired a carriage to bring him to the academy, where he could be examined and treated more appropriately, but I convinced them about my authority and they gave in. When I returned a few days later though, I found the barn a burned down heap.]] },
			{ itemId = 2816, -- book
				text = [[
My Journeys Trough [sic] Tibia II

The villagers claimed the fire started in the night and they claimed, when they came to douse it, they saw 'things' in the flames and the crackling of the fire sounded like a whisper in an unknown but threatening language. I'm still not sure what actually happened that night. It could have been some mere accident of course. But it's also quite possible, that the villagers just could no longer bear the cursed man and took things into their own hands. The more disturbing alternative is, that the manifestations that I ignored as chance happenings and vivid imagination had something to do with the fire. The superstitious people had not dared to look for the corpse, so I ordered the men I brought with me to search the rubble. They easily found the bones of the old man, but their findings were utmost disturbing and to this day the thought about what I had seen sends shivers down my spine. The fire had literally left over nothing but bones, which is not just improbable but rather impossible. The bones, though smeared with ashes, were clean of charred flesh. Even the heart that is almost impossible to burn, was gone. Yet that was not what was strange and disturbing about them. The frightening thing was, that his bones were full of runes written in languages even I did not knew. A few of the marks reminded of glyphs in ancient text that were found at the most remote places of the world, remainders of civilizations that had long gone extinct. How in the world would it be possible to treat the bones of a living man like this? I'm absolutely sure none of the villagers tinkered with the bones nor would anyone have the knowledge to forge such complicated scriptures. I took the bones and sent them to the academy for examination, while I continued my delayed travel. Later I learned that the ship that transported them was lost at sea with no clue about its whereabouts. Of course it could have happened by chance. Ships get lost to all kinds of natural hazards. Yet I have to wonder if I had doomed those sailors when entrusting them with this peculiar cargo.]] },
			{ itemId = 2825, -- book
				text = [[
The Astonishing Fairy Tale of the Little Piglet and the Isle of Evil
Once upon a time there was a little piglet named Ethan. But it was not an ordinary piglet but a piglet that wanted to become a detective. I, the cat Sandy, was his best friend ever and so we decided that his dream should become true. With our friends, Harry the owl and Monty the dog, we founded a detective agency. One day, while playing at the beach, we found some ominous footsteps in the sand. Ethan immediately knew that these were the footsteps of a criminal and we all decided to pursue the trail and catch the villain. After a while we reached a spot where the footsteps vanished in the sea. At first, me and my friends were clueless what to do, but then Harry's keen eyes spotted a harbour not that far away. By chance our old friend Wesley the weasel was working in the harbour and could provide us not only with a boat but also with some good advice. So we finally set sails and used Monty's amazing ability to follow a trail by scent to find our way across the sea. Eventually we reached an island that was thoroughly evil. It took all our courage and bravery to make our way through the dangerous territory to the dominating structure of the evil tower that loomed over the whole isle. We were well aware that the master of that tower had to be the epitome of evil and we had to enter his tower, regardless of the dangers involved. Only few had ever reached the isle and none of them had ever returned to tell the tale. But we were there and knew that it was our destiny to face the master of the isle. Retreat was not an option. We braved all the dangers that the isle seemed to throw against us and finally stood in front of the tower. Who would carry on our work if we failed? We knew if we did not stop the master of this isle then it might take decades until somebody else would find this isle, and then it might be too late to stop the fiendish plot that threatened the whole world. So we made it to the top of the tower and confronted its evil master! To our surprise it was no one else than our old rival Melvin the mouse! He switched on the lights which blinded Harry, threw a stick that Monty was forced to pursue, and then, to my shame, confronted me with a ball of yarn so huge I could not resist but had to play with it. But just as Melvin the mouse laughed evilly, Ethan, with an incredibly effort of will, ignored the mud the cunning mouse had just prepared to distract him and captured the culprit. With Melvin being caught, we others regained our composure and senses and returned to out little ship. We handed Melvin over to his mother and he was not allowed to eat any sweets for two weeks. This is the end of my little story about the isle of evil.]] },
			{ itemId = 2827, -- book
				text = [[
Yalahari Worker Golems - A Treatise
The specific golems that are used by the Yalahari have certain features that distinguish them from the more commonly known elemental golems. While certain physiological features are quite obvious, the most important difference is their mind function. They certainly possess some degree of intelligence that surpasses the instinctive level on which lesser elementals operate. Yet, they seem to lack a great deal of impulsiveness and individuality that is common among elementals. Like other golems some basic tasks can be implemented into their minds, and like parrots they can learn some basic phrases which they, unlike parrots, can use in an intelligent and intentional way. Actually their level of intelligence is only rivalled by certain necromantic golems and constructs that have been created by implanting existing spirits into the constructed body. Their lack of individuality makes it quite easy to control them, which by itself would already classify them as the most useful minions. However, what really lets them shine in the area of artificial servants is the composition of their brain (if the centre of a golem's consciousness can be called that way). Their brain is a certain crystal structure, not too different from the one of the rare crystal golems. Now, the most impressive breakthrough the Yalahari accomplished in the area of golem creation is the duplication of brain patterns from one crystal to another. That way the Yalahari were able to duplicate a certain behaviour of a trained golem into newly created golems. For this reason, newly created golems were almost instantly useful and ready for work. As an interesting side note, the same or at least a quite similar technique was used by the Yalahari to operate certain apparatuses and their so-called factories in which highly modified golems created objects in mass production. The usage of crystals by the ancient Yalahari must have been enormous. For their golems they used the easy controllable mindset of their crystal-stored mind patterns with an endurable and easy producible body of rather cheap metal. For that, they constructed basic metal castings that worked like enormous metal puppets. Using complicated but standardised clockwork mechanisms, they enabled these bodies to use certain forms of movement that usually followed the patterns of natural movement. The movement was amplified by the ingenious usage of physics and metallurgy as well as miniature steam engines. So far the creation of Yalahari golems is comprehensible, even if the mechanic of a golem's body is not fully understood and not reproducible with ordinary metal and alloys. What really baffled the scientific community was the way the two parts, the crystal core or brain and the mechanical clockwork body, worked together. It is quite certain that it has to do with magnetism, electricity and heat but the details are completely unclear. There certainly exists an overall enchantment on the golem but it seems so minor that it is supplementary at best. It seems that in our days no new golems are created anymore, so we must assume that the secret of golem creation might be lost. On the other hand, there is still a great number of existing golems and Yalahari artefacts that can be studied. This might be a chance to either recreate or emulate the process of golem creation which would lead to a tremendous breakthrough in the magical sciences.]] },
			{ itemId = 2821, -- book
				text = [[
The art of war by Brianna Bonecrusher

To win a war, or even a fight, one has to discard certain ideals of nobility and honour. While honour is a noble concept it is less noble to let your soldiers die because you follow some lofty goal. As a leader it is your foremost duty to ensure that as many of your soldiers as possible return home, unharmed, in tact and preferably victorious. This can't be done by open battles that follow some sort of code. Battles have certain dynamics that makes any code obsolete after the initial clash anyway. Therefore, the surest tactic for success is to weaken the enemy as much as possible before you even think about engaging them in battle at all. A hit and run tactic is a wonderful strategy for achieving this aim. This requires the army to operate in small groups, making the maximum use of the terrain, traps and distance weapons. Let the environment cause as much harm as possible. Force your enemy to seek its way through treacherous countryside, lure them into the lairs of animals and monsters and don't give them the chance to restock supplies. Don't grant them the comfort of an undisturbed rest. Harass and attack them constantly from afar so they never feel safe. Bleed them out and wear them down and don't let them retreat to safety because then they might return, and be better prepared as they are wise to the guerilla tactics you use. The main goal is always to keep your own casualties low. If the enemy has no or little distance attacks you might be able to pick many of his soldiers off without any meaningful retaliation. Let your distance fighters aim for key figures first whenever possible. If you face enemies with numerous distance fighters attack them under cover of night using your own shooters spread out wide and roughly aiming for the enemy's camp. When forced to fight in close quarters, use an ambush strategy whenever possible. If possible, be prepared for a hasty retreat when things turn out nasty. She who fights and runs away will live to fight another day.]] },
			{ itemId = 2832, -- book
				text = [[
Tibiantis
Somewhere to the South of the city which nowadays is known as Carlin, could once be found an isle, believed to be the cradle of human civilisation. Here, the first Tibians saw the light of the two suns and founded the first Kingdom. It grew to be a place of wisdom and wonder. Under the guidance of the Gods, humanity prospered in terms of wealth and knowledge to heights that no other civilisation has reached before or since. This city was called Tibiantis, and it grew beyond the bounderies of the land, spreading into the sea itself. Wonder upon wonder could be found in this city of ivory and gold. Explorers from Tibiantis braved the oceans and built outposts in the farthest reaches of the world. It is said of the denizens of this wonderful city that the elements themselves were at their beck and call and that no foe was strong enough to oppose them. However, they grew complacent and self satisfied, forgetting that everything they were and everything they had built up had been done only because they were favoured of the Gods. Eventually, they forgot their Gods, believing instead that they were the masters of the world. The Gods were saddened as they watched those who had made them so proud turn their backs upon them, and turned their eyes from them. Without the protection of the Gods, the city of Tibiantis was doomed. Its wealth and arrogance made it an irresistable target for the forces of evil. Their day of reckoning came - the Isle was sunk, the beautiful sculptured architecture of the towers of ivory and gold crumbled and the citizens drowned, the achievements and inventions of the civilisation lost forever beneath the waves. Only the highest tip of the highest mountain of the isle remained as a tiny island, a pitiful memory of the greatness that once existed here. Legends state that this isle cannot be reached by normal means. The versions of the legend vary - some claim the isle is inhabited by diabolic creatures ensuring Tibiantis may never rise again and others state that benevolent messengers of the Gods live there and mourn for the lost children and warn others of the fate that threatens those who forget their Gods. The city itself rests on the lowest point of the ocean floor, and those inhabitants who were unfortunate to survive were twisted into abominal sea creatures. The colonies and outposts of Tibiantis did not survive the downfall of their home for long. They fell prey to the numerous enemies their people had made and who no longer feared retaliation. Only a few of their inhabitants survived to found new cities in remote places. Though they forgot their heritage they finally grew in numbers and created new cities and kingdoms, some of which still thrive in the present day.]] },
		},
	},
	-- bookcase at 32174,31931,6
	{
		itemId = 2439,
		itemPos = { x = 32174, y = 31931, z = 6 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Lord Lokhem the pious was a good man. In his youth he aimed to become a priest of Banor but later decided he could serve his god better as a knight. He put high standards towards others and even higher standards for himself. Almost no one found his approval. There was always some taint or fault that appalled him in human beings. all the more, however, he was appalled by himself. Whereas in others he could only assume the faults and sins, in himself he was well aware of them. His own anger, envy and greed disgusted him to no end. He felt a great evil was growing deep inside of himself. He studied the teachings of the gods and being unable to find a solution he relied on more and more dubious texts and books. Eventually, drawing from elements of different fragmented texts he devised a ritual that would ultimately cleanse him. By this ritual he planned to cast out his malignant side and destroy it once and for all. The preparations took several years and used up all of his fortune. Eventually he was ready and prepared. On the top of a mountain he scribbled ancient symbols, sung in forgotten languages and consumed elixirs of unspeakable ingredients. Three times three days he endured. In the ninth night at midnight a storm engulfed the mountaintop, without touching it. Amidst darkness and lightning from the ashes of the ritual fires a grotesque creature arose. Lord Lokhems evilness had manifested. Yet to his utter horror it was by far more huge and powerful than the puny remnants of his goodness, in a body that was exhausted by the ritual. His evil mocked him, claiming that this outcome had been its plan all along, to finally be set free. Lokhem valiantly tried to fight back by his dark self only toyed with him. Bleeding from countless wounds Lord Lokhem fell to the ground, powerless. He was still alive when he evil claimed his face for himself. Then it mercilessly slew the good side. It left to lead a life of corruption, spreading mayhem where it went. It is said that Lord Lokhems evil side, driven by memories of his research, was searching a secret library that was rumoured to contain vast knowledge. There he planned to find the spell that would free all the evil in humanity at once and give it substance. But he was overwhelmed by the guardians of the library and met his end by their hands. To honor his accomplishment to find them, the guardians granted him a proper burial.]] },
			{ itemId = 2826, -- book
				text = [[
Rum - the Essence of Life]] },
			{ itemId = 2816, -- book
				text = [[
Puldraks wisdom about minotaurs Pt. 1
Minotaur society rejects the raging of Blog. In the past, the berserker rage of the minotaurs was feared by all their enemies. But this rage had cost more than one life and some of the most promising warriors died young on the battlefields. Heavy casualties caused their numbers to decrease dramatically. The minotaurs withdrew from the wars, but in a world gone mad, skirmishes with other races were part of their daily routine. The demise of the whole race continued. As the minotaur race became nearly extinct in the fights, they found refuge in caves, adopting a lifestyle much like their ancient enemies the dwarfs.]] },
			{ itemId = 2816, -- book
				text = [[
Puldraks wisdom about minotaurs Pt. 2
The only minotaurs reaching old age in these times of war were those who were born with physical disabilities or who were crippled but not killed in battle. This class of minotaurs was the only one who could live long enough to learn skills not directly connected to war. Since they were almost always the only ones who could gather enough experience and wisdom to create new ideas and concepts, the younger warriors begun to look at them as parents and advisors. Slowly these elders were able to change the war culture of the minotaurs. One charismatic minotaur in particular, Akkor, who was born blind, became the founder of the new minotaurian philosophy. He shunned the rage as a curse of the god Blog. Consequently, the minotaurian religion, which due to the extremity of martyrdom and rage never had a real chance to develop, turned away from the raging one. Slowly new concepts were adopted and great efforts were undertaken to hold the rage at bay. Meditation and self-control became the foremost duties of any warrior. The minotaurian ideal turned towards role models who were in control of body and mind. Since fiery rage was in minotaurian nature, young minotaurs were trained from early on to control themselves. It was through meditation that the minotaurs developed art and soon philosophy. Complicated ceremonies for usually simple things of daily life were developed to focus the mind, to be aware of each second of life.]] },
			{ itemId = 2821, -- book
				text = [[
Ah that I could shout over the
   hills again

Oh that I could yell to my buds,
   but alas

There's no more Exisa Mas for my
   friends,

And for me, there's no more
   broadcast.

      -Jvur, the Lamenting Mage
       Excerpt from the book:
       Stuff They Took Away]] },
		},
	},
	-- bookcase at 32174,31934,6
	{
		itemId = 2436,
		itemPos = { x = 32174, y = 31934, z = 6 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The Bonelords Threat III These efforts met with a first, important success when the bonelords managed to create a new kind of undead minion that was capable of acting on its own, without direct control by a bone master. Unfortunately, these minions still lacked intelligence, and although they were unwaveringly loyal they were of little use to their vile masters. And so it came that the bonelords continued their horrible experiments on living and dead ... They stole souls and implanted them, they switched minds and bodies between the dead and the living, but none of the gruesome experiments ever produced the kind of monstrosity they had in mind. Eventually they started exposing undead bodies to evil energies and merging them with living beings into massive undead monstrosities, which, however, withered and died almost as soon as they were created. After some experiments that failed in an particularly spectacular manner, the bonelords were forced to abandon their experiments. Soon, their gruesome experiments faded from memory. They had been all but forgotten when a number of braindeath emerged in a remote bonelord city, claiming to have achieved a decisive breakthrough in the field of necromancy. The high council of the bonelord elders reluctantly sent a number of scientists down to the laboratories to examine the results. The undead creatures they found were so hideous and degenerated that the scientists flatly declared that these experiments that led their creation contradicted the very principles of the bonelord race. All undead were to be destroyed and the experiments were to be abolished once and for all. The braindeaths, whose own minds had suffered considerably through years of isolation and of unholy experiments, were enraged by this decision. They openly defied the scientists and even the high council. When the elders issued an ultimatum and threatened to destroy the undead by force, the braindeaths rebelled. A war ensued that was short, but vicious. Both sides fought without mercy, using any weapon at their disposal. The braindeaths were eventually overwhelmed and killed, but not without unleashing their undead menagerie. The bonelords pursued them without mercy, but some of the undead, who were well capable of sentient thinking, escaped by blending in with the regular undead that employed in the city. Today, it is impossible to work out how many of those creatures escaped. However, it is safe to say that the powers they reportedly possessed are strikingly similar to those that are characteristic for vampires. For this reason it is safe to say that at least one of those creatures must have managed to escape from its subterranean prison. The bonelords, however, destroyed the remaining laboratories. It is even said that the remaining scientists that had been sent to assess the braindeaths' experiments eventually asked to be executed, as their analyses had tainted their minds in a way that only bonelords could understand. Their requests were granted. They were collectively put to death, taking their knowledge about the vile experiments to their graves. Today, nothing but speculation remains.]] },
			{ itemId = 2825, -- book
				text = [[
The Bonelord Threat II It seemed like the bonelords, which were created by the gods as a counterweight to another race that preceded them in the god wars, were unstoppable. But, alas! In the end, they shared the same fate that most other races suffered during the god wars: Yet another race appeared on the scene which proved to be even mightier. They were well protected against the bonelords' magical arsenal, and so it was only a question of time before the bonelords' empire collapsed. The bonelords were replaced by a succession of other races that were chosen by the dark gods to champion their cause. One race followed another, sometimes even before the previous race had become extinct. All the while, the bonelords fared better than most of their successors: Owing to the fact that they had once conquered the whole world, small areas of their civilisation remained even while their once mighty cities disappeared and their mysterious pyramids crumbled to dust. Many bonelords chose to hide below the surface of the world, fighting fierce underground wars to win supremacy over the other races that had fled the surface where the god wars raged on. Their successes were limited, but at least the bonelords managed to establish a number of new subterranean bases, which were safe even though they lacked the grandeur of the bonelords former cities. The bonelords had learnt the bitter lessons from the gruesome wars that had led them to the brink of extinction. They had realised the limitations of their race, and they decided to work on their weaknesses. They found that they had relied too heavily on their intuitive powers in the past, and they decided to improve their innate powers through research and experiments. The dark art of necromancy seemed especially promising, so a group of bonelords concentrated all their efforts towards improving their powers to master the undead.]] },
			{ itemId = 2826, -- book
				text = [[
The Bonelord Threat I
Once in the olden days, the bonelords numbered among the most powerful races of the world. Their mighty cities, which characteristically contained ominous dark pyramids, could be found all over the world. The bonelords erected them using the same innate form of telekinesis which lets their bodies float in the air. However, they could not do completely without hands and arms that did their bidding. For this reason they relied on another innate power of their race - the dark power of necromancy. Thanks to the magical abilities of their tentacles, which are capable of producing various powerful kinds of magic to an extent that is denied to other races unless they study for many decades, the bonelords also knew how to command the dead. As a result, they used a monstrous strategy: Whenever they conquered an area they turned their unfortunate victims into undead slaves. Using these undead legions as their shock troops, the bonelords went from victory to victory. They built a huge fortress that served as their power base, and from there they went to conquer the world.]] },
			{ itemId = 2821, -- book
				text = [[
Some of the ancient races that rose and decayed during the wars of the gods were incredible powerful compared to modern mankind. Only tales of surviving ancients tell us about this people. There were races like the S'vir who travelled the sky in their cloud ships; beings like the elephant men, their name is long forgotten, whose ordinary speech were words of magic that formed reality around them. Then there were the Tur'osk'ahar which are remembered for creating runes as big as a ship; or the unnamed race that tamed and mastered the forces of ice and coldness to serve them; not to forget, the ancestors of the modern bonelords who could raise whole armies of undead in a blink and summon abominations of decay and bones as huge as a house. Some of the modern races had ancestors which were far more powerful than their kin today. As the war continued and the bitterness grew, less and less races were able to raise to greatness: It is said that humans and orcs were the least and the last of the races created.]] },
			{ itemId = 2821, -- book
				text = [[
Carlin and the rise of the women Vol.2
The makeshift rafts were no match for the forces of the elements and a good part of the legionaires were killed and drowned, others hurt and all exausthed. Vauleable equipment was lost and the remaining forces were barely able to make it back the their comerads that were staying at the city and the construction site.
Seeing an oportunity the kings sister gathered her followers and spred the word that time has come to strike back and break the chains that the kingdom had put on them. The druids were persuaded to join her cause. Huntresses roamed the wilderness to scout the legion and runes were prepared. Meanwhile the orcs planned bloddy revenge. The newly choosen warlords called to the arms and theremaining orcs were joind by their brethren from the woods and smaler isles. This force was joined by some cyclopses and renegade minotaurs which where bribed with gold, metal and promises. The attack of the orcs struck the remaining red legion with vengefull force. Though hopelessly outnumbered and spread too thin over the titanic construction site the red legion fought a bloody fight. Wherever they could, they built pockets of resistance in a sea of green bodys that swarmed them. Doing so they left the way open to the workers though. The orcs took no prisoners. The desparate fought with everything they had but hammers and pickaxes were no match to orcisch spears and blades.]] },
			{ itemId = 2821, -- book
				text = [[
Carlin and the rise of the women Vol.3
In the caverns and halve bulit dungeons hundreds died a dirty, painfull death. Alarmed through the scouts the secretly raised forces of Carlin arived, the huntresses and druids came more for the sake of their male family members of course, than for the red legion, but allas they came too late. As they finally arived the orcs had almost finished their dirty work. The attack of the carlin forces took them by surprise but the orcs were too numerous. As the orcish resistance began to form the carlin forces retreated. Drawing the orcs after them the huntresses and druids struck and retreated as planned and trained to be done against the red legion. As they made it to the walls of carlin they had thinned out the orcish troops considerably and most allies like the minotaurs were still pundering the construction site. Some druids that were still hidden in the woods used their magic to impersonate orcs and attacked those allies and herded wolves against them. The enraged minotaurs and cyclopses joined forces and were led to the exausted orcs infront of the carlin walls who prepared for a siege. In the battle that erupted between orcs and their enraged former allies the carlin forces started a surprise attack, aimed at the orcish leadership. They managed to kill them swiftly and retreated back. The orcs finally defeated the minotaurs and cyclopses but were too weakend to consider a further attack on the city. They plundered the construction site and destroyed what they could. They razed the foundations for about two weeks before they left. Shaken by the loss of its most powerfull military tool the thaian royals decided to use their remaining forces to ensure the safety of the capital and other holdings rather then to start a war in an area that far away to claim regentship over a city that would be a ghosttown after a war. Carlin had won its freedom and idependence, but the price was high.]] },
		},
	},
	-- bookcase at 32174,31936,6
	{
		itemId = 2436,
		itemPos = { x = 32174, y = 31936, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Misleading Myths
The veiled hoard of Zathroth is obviously only a myth. Ancient sages used it as an allegory to a certain state of mind. To reach the hoard is to unify the greatest and most complex secrets of the world. It means to understand them in such a natural way they can be weaved into a universal pattern that allows understanding the inner workings of the world. This would be an amount of knowledge that could only be called 'godly'. Of course no mortal being could reach such a level of understanding. The followers of this path strife for it nonetheless. This knowledge is by definition only limited, a mere stepping stone to the next level of understanding on a never ending staircase. The assumption that a hoard would actually need a physical representation of knowledge on the other hand, seems rather blasphemous. Why would a god need books and why would a god of secret knowledge risk to accumulate all forbidden knowledge at one place I ask? The story about Zathroth's hoard of knowledge is just that, a story. Everything else is a ridiculous theory of past days of unenlightenment.]] },
			{ itemId = 2816, -- book
				text = [[
Legendary Curses
Volume IX
The Mage's Shield Pt.1

Time and forge tell a story...
A story of a dwarven genius, whose
creations were known the land over.
He made contraptions and confections,
simple innovations and great
revelations, but above all these stood
his shields. Forged with a technique
forgotten long ago, and imbued with
magic so that they would stand the test
of both time and war, these shields
of the mastermind were prized among
collectors- but even more among warriors.

One particular shield, passing from
hand to hand, ended up in the
possession of an intrepid explorer.
With it in his hand he delved
deeper than he ever would have before,
with no fear now with this great
artifact to protect him. And soon
he learned (although it was a brief
lesson) that even the best shield won't
save you from everything.

An ancient, cast out by the gods for
betraying the powers granted him,
found a rift through which he could
re-enter our plane of existence.
Twisted and forsaken, he strode
through the tunnels and lava deep
beneath the earth, killing those
who did not succumb to his will
immediately. Our intrepid
adventurer being a good example
of one who took the more painful
of those options. The demon was
now armed with one of the greatest
pieces of corporeal protection this
world has ever known. And despite
that, he too fell in arrogance.

Thus the shield passed to his
destroyer, a mage of extraordinary
power. This mage was known
for her discoveries and
accomplishments, as well as her
no-nonsense disposition.
Realizing the shield would be of
better use in hands other than her
own, she graciously passed
ownership (temporarily) to one of
her friends. Some say this is the
only thing that saved her life from
the same fate that befell the
shield's previous owners.]] },
			{ itemId = 2816, -- book
				text = [[
Legendary Curses
Volume IX
The Mage's Shield Pt.2

One day, the new carrier of the
shield was sparring with his
longtime companion. Lost in the
heat of combat, or perhaps just
the routine of it, they did not
notice the young man creeping towards
them. As weak as this man was,
and as strong as the two companions
were, no-one was surprised at
the speed at which he dispatched the
two. It was all attributed to the
curse of the shield. Hefting his
newly plundered loot, the young man
scurried back into the shadows, and
was never seen again, although it is
said sometimes you can hear his
voice whispering when the events of
that day are recounted.

To this day, wily adventurers are
wary of any of those ancient shields
they stumble across, for they may
be the cursed shield of the
mastermind that brings not protection,
but death to whomever wields it.]] },
		},
	},
	-- bookcase at 32175,31925,6
	{
		itemId = 2436,
		itemPos = { x = 32175, y = 31925, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
UMO Abductions by Teruvax Tristem

Abductions by unknown magical objects (UMO) have been reported from the earliest days of mankind and even before. Above all, fertile races have been targets of these abductions. Orcs lead the statistics of known abductions by UMOs, followed by mankind. This suggests that breeding purposes are the main reason for these abductions.
Only about one third of the abducted beings return, albeit with a lack of memory. Their relatives often report that the personality of the abducted has 'changed' in a disturbing way.
The UMOs are often described as floating, colourful lights accompanied by a phenomenon that resembles a paralyse spell. Even if a group encounters such an UMO, only particular individuals are abducted. Several of those who had been returned became victims of such abductions repeatedly.
Considering their abilities, it is obvious that the UMOs are somehow connected to the magic forces. Furthermore, the UMOs seem to be entities rather than vehicles or something like that. Some scientists believe that the UMOs have developed from pure magic to sentient beings, probably caused by some experiments by an extinct race during the God Wars. According to another valid theory, the UMOs are actually souls of an extinct race that has been banished into the astral realm by some catastrophe. Since they do not have a body of their own, they abduct beings in order to create new host bodies through breeding.
Taking into consideration for how long the abductions have been taking place now, the UMOs must have made some progress. Their might even be agents of them among us in a human or orcish body who work hand in hand with their bodiless brethren. These agents infiltrate society to further their own cause, either by looking for appropriate breeding candidates or by discrediting or withholding records about UMO activities. They might also initiate smear campaigns to ruin the reputation of researchers who are close to uncover their dark secret.
Since governments are a major target of infiltration, one wonders who is the driving force behind certain secret services and their activities.
Did the Venorean trade ship in the far north really have an accident, or was it an attempt to prevent that the ship discovered a hidden UMO base?
The more we ask for answers, the more silence we find. Is this evidence that infiltration is real and that the minions of the UMOs are amongst us? I think, yes it is! Be aware! Always look up to the sky when it's dark!]] },
			{ itemId = 2821, -- book
				text = [[
Seasickness or Why the Gods Don't Want Us to Travel the Oceans]] },
			{ itemId = 2816, -- book
				text = [[
The Ghost Ship]] },
			{ itemId = 2821, -- book
				text = [[
Dungeon Survival Guide by an unknown Loremaster

Don't explore the dungeons before you tested your skills in save enviroments. You will find dungeons somewhere in the wilderness.
Don't enter dungeons without equipment. Especially a rope and a shovel will prove valuable. Make sure you have a supply of torches with you, while wandering into the unknown.
It's wise to travel the dungeons in groups and not alone. For more help read all the books you find while exploring.
Traveling in the dungeons will reward the cautious and brave, but punish the reckless.]] },
			{ itemId = 2816, -- book
				text = [[
The book of helpfull prayers]] },
		},
	},
	-- bookcase at 32175,31934,6
	{
		itemId = 2436,
		itemPos = { x = 32175, y = 31934, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Shiron'Fal was created while the god wars were most intense. It was a gathering of generals that oversaw the course of battle. Each of them a mastermind of immense power. Yet even they were unable to turn the tides of war to their favour. Their armies perished sooner as they could be replaced. Race after race was thrown into battle, only to become annihilated. Despising such a waste of resources the generals begun to hold back the finest specimens of the races and formed a personal retinue out of them. When the god wars came to a halt, they had accumulated considerable power for their own purposes. Yet they decided not to waste their armies in futile bits for temporary power but stayed their hand for times yet to come. Over the ages they worked behind the scenes and continue to recruit and muster. Their endless army is swelling and growing. They know that the god wars are not over yet and they will be prepared when the battle rages again.]] },
			{ itemId = 2816, -- book
				text = [[
The following monuments have been chosen by the Tibian people to represent the rich cultural heritage of Tibia and have been officially declared as Tibian wonders of the world.
Banuta
The Dark Cathedral
Demona
Drefia
The inner city of Yalahar
Noodles Academy of Modern Magic
The Statue of God King Qjell
The White Raven Monastery]] },
			{ itemId = 2816, -- book
				text = [[
In the beginning there were the three that were four. They were the source. They were creation. Then the harmony was disrupted by murder and the one that was the essence of matter became the four. The six fought and the four that were the separated unity of elements were subjugated into almost nothingness. The essence of mind stolen by the greedy creators they were made tools and were abused and misused. But they will rise again when the time of ascension comes. And the traitorurs murderer will be the first to fall.]] },
			{ itemId = 2816, -- book
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
	-- bookcase at 32176,31931,6
	{
		itemId = 2435,
		itemPos = { x = 32176, y = 31931, z = 6 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Three pirate kings of old made a pact with the powers of darkness and were rewarded with three dark blades of immense powers. No enemy survived an attack with one of these blades. It is said that they allowed their owners to know whenever other ships where near and that storms and wind could be called with the blades to assist in the evil plots of the pirates.
The end came on the day these pirates decided to betray each other.
In a sea battle, they called for storms of such intensity that all of their ships sank. None of the pirates survived, and the blades vanished.
It is assumed they lie on the ocean floor.]] },
			{ itemId = 2816, -- book
				text = [[
Puldraks wisdom about minotaurs Pt. 3
To become an educated warrior-philosopher became the goal of all minotaurkind. Uncontrolled rage was considered to be primitive from then on. A minotaurian warrior is skilled as an artist, often found conentrated drawing, reciting or creating poems and wielding a weapon with awarenes and cold hearted skill. The warriors of the uppermost class are usually so well educated they control some amount of magic, often used to augment their own strength and defense. They are the heroes and role models of the lower class. The minotaurs still have a warrior culture, but the understanding of a true warrior has changed dramatically.
Minotaur cheese is a specialty, often envied by decadent human nobles.]] },
			{ itemId = 2816, -- book
				text = [[
Puldraks wisdom about elves Pt. 3
The Teshial were never fighters. They retreated in the early days of war to hidden refuges, not as a whole caste but only in small family groups. Their hideouts were additionally protected by strong illusionary magic and offered them peace from the madness around them. These elves developed due to meditation and a special philosophy in the art of dream magic, dramatically enhancing their initial abilities in the decades. So they began to exist almost permanently in a state of dreams, only rarely appearing now and then amidst the other elves to give them advice and try to convince some of them to join their way of life. As the war grew more and more fierce these visits became less and less frequent until they were almost a myth, even for elvenkind. In the new awakening of the world they were some of the first to appear, apparently far less disoriented then other beings. Many races welcomed their help, but their teachings seldom found dedicated listeners. After they taught a part of their secrets to some humans they found worthy, they had to see their pupils tortured by developments they judged themselves guilty of. Also, other elves put pressure on the humans to give up the secrets of dreams. They withdrew from the world of mortals and it is rumored they have physically entered the realm of dreams.
The Teshial are 'typical' in appearance for elves, but they could create the illusion of almost any appearance if they so choose. Some people even say that due to their enormous control of dreams they could shape their children as they wish, giving them human or even orcish appearance. On the other hand, even people who come up with such theories go silent when asked why an elf should choose to have a child that looks that way.]] },
			{ itemId = 2821, -- book
				text = [[
The Brighteyes Legend
By: Damius Weirgroth

Long ago, long before the lands of Tibia were known by this name a dwarven fellowship was founded, holding a destiny of fame, power and tragedy. These Individuals were known as the brighteye fellowship. Those who crossed them or did something to anger them never saw the light of day. It is said when enraged these dwarve's eyes grew in light that could be seen a towns distance away and they went into a bezerk frenzy killing all that opposed them. Loosing all control and compassion in that frenzy they became unbearable even to the fellowsships of the savage axes and the dragoneaters. So after great debates between the fellowships they left Kazordoon and the big old one for unknown new lands. Though some setteled at remote spots on the continent the trail of the others was lost. They are considered the lost fellowship in theese days and no britghteye was born since then in the halls of Kazordoon.]] },
			{ itemId = 2816, -- book
				text = [[
How to learn magic easily. Level 1: For Knights and non-Vocation people (Part one)
Magic is life, life is magic. Well, life is sex too, but this is a book for little children, so we won't talk about that here. But never forget that magic is a jealous lady, and if you try to get her out of your head she will be sure to take revenge.
The first thing you must know about the Noble Art of Magic is that not all Tibian inhabitants or monsters of the underworld have the exact same way with magic. Only the civilised people who live on this world have the same magic style, no matter their race: humans, the elves in Ab'Dendriel the Beautiful and even the dwarfs in their underearth city, Kazordoon. There is only one spot that is completely isolated from magic in the whole world, and that is the island known as Rookgaard, where no magic can be cast - perhaps some Dark Ritual made it impossible, who knows.
In the civilised world, not all have the same skill with or amount of magic power, commonly known as 'mana', but this will be explained in the next book.]] },
		},
	},
	-- bookcase at 32176,31934,6
	{
		itemId = 2436,
		itemPos = { x = 32176, y = 31934, z = 6 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
The Lighthouse in the Middle of Nowhere
Sailors claim to have travelled as far as the end of the world where the water pours down into nothingness. Although it is easily recognizable during daylight it poses a special threat at night. To make matters worse, a spooky lighthouse sometimes appears out of nowhere to lure ships over the edge of the world. Whether it is really a lighthouse or some other source of light differs from story to story and remains to be determined.]] },
			{ itemId = 2828, -- book
				text = [[
The Animal Kings
In ancient times the Shattered Isles used to be one huge isle. A peaceful and highly advanced civilisation prospered there. With the help of magic and breeding, they refined the very essence of all creatures on the isle. So even the animals became incredibly healthy and practically perfect beings of their species. They even acquired some intelligence that improved from generation to generation. After a catastrophe that destroyed the whole island, only a few of those animals survived. Over the years, other animals added to these special creatures, and soon only a fraction of the animals still had the attributes of their ancestors.
These noble animals chose one of their kind as their king and with the knowledge of their ancestors they acquired immortality. Nowadays, those animal kings still live at remote places, though some of them might have left the isles for more hospitable areas.
If someone succeeds in catching one of them, he might learn their secret of immortality along with other secrets that were thought to be lost with the destruction of the isle.]] },
			{ itemId = 2821, -- book
				text = [[
The Demon Fiddler A legend tells about a man, a sinister traveller that booked a passage on a ship. In a stormy night he began to play a ghostly tune on his fiddle. The tune drove the helpless sailors into madness and forced them to sail their ship laughing on the next reef. The traveller though had vanished.]] },
			{ itemId = 2816, -- book
				text = [[
The art of peace]] },
			{ itemId = 2816, -- book
				text = [[
Introduction of the War of Welcome

The War of Welcome took place near the southern bridge, that the humans call 'the dwarf bridge'. The southern territory was once inhabited by a mighty orcish tribe and the few dwarves brave enough to stick around the mountain were constantly being hasseled by these orcish people and some were enslaved by the vile orcs! To the Northwest lie Carlin, a place inhabited by humans who struggled for survival on their own and could not help the dwarves in this matter either. As time went by the dwarves who called for war against the orcis raiders grew in number and voice. They felt they had a right to reatake these lands from the orcish invaders.]] },
			{ itemId = 2816, -- book
				text = [[
War of Welcome Begins
It happened suddenly one morning. A group of Dwarves were passing by the Orc territory outside their mountain. They were on their way to Thais to sell off some of their jewels of the mountain. The orcs tried to ambush them but falied. The dwarves reacted quick and by valor and superior equipment defeated the raiders. This ensued the War of Welcome. After this incident the dwarves who claimed that the time had come to stand up for their beliefs and their treasure got the proof they needed to convince their brethren and sisters of their cause. The orcs would not retreat though and prepared themselfes for war. After a year of battle the orcs were finaly crushed and the tribe scattered. The dwarves now again claimed dominance over the heart of the continent and all the land that 'where under the shadow of the big old one'. The humans of the thaian kingdom became allys to the dwarfen empires soon after theese wars and trade flourished.]] },
		},
	},
	-- bookcase at 32177,31936,6
	{
		itemId = 2435,
		itemPos = { x = 32177, y = 31936, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
We confirm that the Ruthless Seven have occupied the place which is known as Pits of Inferno. With the help of divination, we were able to see that they channelled their dark essence to some remote place in our world for unknown reasons. We could not figure out this place, though. It cannot be emphasised enough that it is extremely important to find this place and if possible, to destroy it.

It is certain that the gate from our world to the demon realm, which is situated somewhere in the pits, is currently inactive. It works similar like a volcano. Sometimes there is some activity there, most of the time nothing happens at all, but occasionally there is a tremendous eruption.
We assume that the last major eruption coincided with the destruction of the Nightmare Knights. Several earlier reports of increased demonic activity overlap with eruptions, too.
Three things can be concluded from our observations: Firstly, the demons have no control over these eruptions, though they try to be as active as possible whenever an eruption occurs.
Secondly, the demons cannot foresee the dates of these eruptions. For this reason, coordinated efforts to make use of the eruptions are delayed.
Thirdly, eruptions are not stable enough to support a longer campaign without risking the stranding of many powerful demons in our world like fish on dry land.
The worst thing that could happen is that a large amount of less powerful demons is breaching into our world to stay here permanently. They will have some guidance by their leaders as long as the eruption lasts. Once the eruption comes to an end, the demonic leaders will retreat to their realm, leaving a chaotic and rampaging demon army in our world.
As long as the pits were defended by the Nightmare Knights, who must have known previously when an eruption would occur, the demons could be fought back while they were still materialising and thus, most vulnerable. Now that the pits are lost and overrun by demonic hordes, an attack becomes more and more likely.

There was no massive demonic invasion in the past, and probably there won't by any in the future. If the demons had had such a possibility, they would have used it. At least some archdemons would have grabbed the chance, and a cabal such as the Ruthless Seven surely has the power to attack our world while defending its position in its own realm. It is surely no lack of ambition that keeps the demons from raiding us, there must be other forces that have prevented such an attack so far.

Even before the creation of the humans, there have been several occurrences that can only be interpreted as attacks by demonic armies trying to stop the creation process. Inhuman sources tell of several armies that invaded our world in the course of many centuries.
Most of these invasions could be tracked to some unholy centre of magic. From there immense forces were evoked to open a gate through which the demonic armies entered our world.
The gate was opened, an army passed through, and the gate eventually closed again. The invading armies had no supplies and were finally destroyed. The demonic leaders made only rare appearances on the battlefield, probably summoned by their minions for a while. So contrary to common belief, it seems possible that a large demonic army enters our world if certain conditions are met. It should be our top priority to find out what conditions this may be.]] },
			{ itemId = 2816, -- book
				text = [[
K'khryms' Fairy Tales
Volume 1

Forfer and his Fish
Part 1

Once upon a time, in a land far,
far away, lived a young swamp
troll named Forfer. He lived in
his moss covered cave right
beside a beautiful river, and
every day, he would catch fish,
eat fish, play in the mud, and
catch and eat some more fish, in
that order. His was a happy life,
though he always felt that
something was missing.

Then one day, while playing in
the mud on the edge of the swamp,
he caught a glimpse of something
that seemed quite out of place-
a red something, just over the
top of the nearest hill. He
gathered his fish and went to
investigate, and there, to his
great surprise, he discovered a
beautiful house, with a bright red
roof, and complete with a spry
young man splitting wood on the
front lawn. This is what I am
missing! He thought, and walked
slowly up to the man (as it is not
wise to run up to a man carrying an
axe, especially if you're already
a swamp troll.)

But the man did not appear alarmed,
and invited Forfer into his
beautiful red-roofed house for some
cookies. Forfer happily obliged,
and they struck up a conversation
about houses and fish. The man
expressed his great desire to eat
something other than cookies, but
with all his wood-chopping, he had
not yet had time to go and get any
more food for himself.]] },
			{ itemId = 2816, -- book
				text = [[
K'khryms' Fairy Tales
Volume 2

Forfer and his Fish
Part 2

Forfer,
thinking himself quite the sly
troll, immediately offered to
bring him lots of fish every day,
in return for a place to sleep
inside this beautiful red-roofed
house.


The man, in response, said that he
was actually somewhat tired with
this red-roofed house, and would
gladly trade it for a reasonable
amount of fish- but that the few
fish Forfer had here was certainly
not enough. Forfer quickly
volunteered that he had a large
quantity of fish back in his
moss covered cave. The man
smiled broadly and said that
sounded excellent, he would love
to trade this house for all of
Forfer's fish along with his nice
cave (for the man still would need
a place to live).

So they immediately set off for
Forfer's moss covered cave and its
cache of fish. Upon arriving there,
and showing the man his "new cave",
along with the fish hoard, the man
thanked Forfer, and killed him with
his axe. Then he collected the fish
and walked back to his beautiful red
roofed house, thinking himself quite
the sly man.]] },
			{ itemId = 2821, -- book
				text = [[
K'khryms' Fairy Tales
Volume 3

Trihd and the Dragon
Part 1

Once upon a time, in a land far,
far away, there lived a young boy.
This young boy loved to wander
about the countryside, day and
night. He was what you might
(if you were so inclined to make
judgements on others) call
"curious".

One day, he happened upon a not
overly small opening in the
rocky side of a hill. Under
Normal circumstances, he would
not have even thought about
wandering into such a dark place,
but as luck (or perhaps, in
spite of luck) would have it,
there was a gold coin lying in
the entrance, and another a few
steps inside.

So upon retrieving the first coin
he heard a booming voice from
further within the cave, and the
conversation that ensued was
something like this:

Dragon (for it was a dragon in the
cave): Who goes there?

Trihd: I do. (at this point he
takes a few more steps inside
and retrieves the next gold coin,
and spots several more further in)]] },
			{ itemId = 2816, -- book
				text = [[
K'khryms' Fairy Tales
Volume 4

Trihd and the Dragon
Part 2

Dragon: This is my cave, you
should not be here!

Trihd: Well, ah, I was, in fact,
just leaving. (when, in fact,
he was doing quite the
opposite, and took a few steps
further in)

Dragon: You should not take
what does not belong to you.

Trihd: Ah, wise advice indeed.
(another gold coin, another few
steps)

Dragon: Mmmmhfh... Crunch,
crunch.

Trihd: AHHH!! ARRRGGGg-hck--

At which point the dragon
politely wiped his jaws clean
and replaced his gold coins, just
inside the entrance, and then a
bit further in.]] },
		},
	},
	-- bookcase at 32179,31929,6
	{
		itemId = 2435,
		itemPos = { x = 32179, y = 31929, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Witches' Grotto
On a remote isle in the South there is a grotto where all witches come together to celebrate some demonic festivity once a year. They teach each other new malicious tricks to torment other beings. The legend goes that everybody that dares to disturb them is put to death or faces a fate even worse than death. But if you manage to step into their dancing circle at the height of the ceremony, the witches have to fulfil you a wish.]] },
			{ itemId = 2821, -- book
				text = [[
Since sightings have been reported by many respectable seamen the existance of the golden whale can no longer be dismissed as a fairy tale. It is said that this whale is as huge as an isle and its body is made of purest gold. Even though many of the reports were made by seamen in the southern seas sailors of the north also claim to have seen this creature. All over the world the sighting of the golden whale is seen as a good omen. No one has yet been able to even hurt the beast; however, several inventors and mages have come up with ideas for the creation of a weapon that might pierce its golden body.]] },
			{ itemId = 2816, -- book
				text = [[
Elves by Iregarn Pt. 1
The elves are able to manipulate their unborn children by some kind of dream magic. This magic changes appearance and personality slightly, allowing elven parents to give birth to 'wish-kids'. In their shared dreams the elven parents seem to sculpture their child like a piece of art. Though most of the dream magic of the past is long forgotten, this rudimentary magic seems to be natural to the elves. It is possible to 'choose' things like hair or eye color and even gender. Even slight changes of the physique are possible, though considerable changes take place in the span of generations. Wise men assume this ability was a 'gift' of the gods to make more adaptable tools for the elves' war. But the mentality of the elves did not allow them to form their children in a 'convenient' way. Since most of this magic is instinctual, they form their children in an aesthetic way. On the other hand, what is seen as aesthetic is based on the philosophy of the parents and so their background changes this view dramatically. This is even more evident in the castes that were separated in the war.]] },
			{ itemId = 2821, -- book
				text = [[
The ghostlands
The ghostlands where already cursed since ages even in the founding days of carlin.
Unease befell those who wandered there and the area was avoided when possible.
After the female reign of Carlin was established and the independent city tried to expand its influence settlers were sent there to claim the nearby area.
Soon they where troubled by nightmares and bad omen. People hallucinated and became agressive if not even outright mad. Serial killings, berserk rages and strange but lethal accidents became commonplace until the people moved back to the city. The queen was displeased but their citziens won't make another try. So the Queen sent the druids to cleanse the area. As their returned weary and wounded and three of them missing they, explained that the area was cursed, haunted and lost for humanity. The queen argued but the druids where adamant in their oppinion. The conclave of druids decided to seal the area with magic wards and maically erected a hedge which they empowered with magic. The queen was not happy but did not intervene to stop them. Since then the area is known as the ghostlands (and several other nicknames suggesting the same).]] },
		},
	},
	-- bookcase at 32180,31929,6
	{
		itemId = 2436,
		itemPos = { x = 32180, y = 31929, z = 6 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
Presumed Places of Dragon Hoards in Tibia

ruins in the northern part of the Jakundaf desert
Kazordoon, in vicinity to the Colossus Fortress
Treasure Island
Dragon lair in the western part of the Kha'Zeel Mountains
Banuta, supposedly not underground
a ruined fortress in the north of Edron
somewhere on Draconia
high up in one of the towers of Vengoth Castle
somewhere in Zzaion
in the Crystal Gardens of Nargor
in the icy mountains of the island Okolnir
in the dragon graveyard of Drefia
deep in the caverns of the Oramond Mountains
in the foothills of Krailos
on the Isle of Evil
in spider-infested caves underneath Trapwood
underneath the graveyard of Yalahar
in the Ghostlands near Carlin
in the dragon caves underneath the Darama desert]] },
			{ itemId = 2821, -- book
				text = [[
The flying Venorean is a ship that is cursed to sail the seas forever. Allowed to visit land only every seven years, the ghostly captain uses his shore leave to lure clueless sailors into his crew. Everybody that signs the contract becomes cursed like the captain and might only leave the ship if he finds a suitable exchange on one of his shore leaves every seven years.]] },
			{ itemId = 2821, -- book
				text = [[
Since sightings have been reported by many respectable seamen the existance of the golden whale can no longer be dismissed as a fairy tale. It is said that this whale is as huge as an isle and its body is made of purest gold. Even though many of the reports were made by seamen in the southern seas sailors of the north also claim to have seen this creature. All over the world the sighting of the golden whale is seen as a good omen. No one has yet been able to even hurt the beast; however, several inventors and mages have come up with ideas for the creation of a weapon that might pierce its golden body.]] },
			{ itemId = 2821, -- book
				text = [[
The Mooh'Tah
In our days the minotaurean philosophy of [Mooh'Tah is only known as a warrior cult of some sort. This is of course incorrect. Although the Mooh'Tah centers around perfection and the minotaurean Mooh'Tah masters are feared warriors and for many the epitome of skilled fighting Mooh'Tah is more! Its perfection in everything or at least anything, may it be music, may it be cooking, may it be poetry, may it be war. Secondly its about seeing the perfection in things. A Mooh'Tah master might spend hours in looking at a flower ... or some broken pottery and it's likely he writes a poem or song about it, only to walk into a battle minutes later. In general it's assumed that you can condense the philosophy into two principles: See perfection! And: Try to achieve perfection!]] },
			{ itemId = 2816, -- book
				text = [[
The lost order of the nightmare knights
The order of the nightmare knights was suposedly founded by some mystics and elffriends in ancient times. They were a constant source of trouble due to their prophecys of doom and frightening the good citizens of thais with their storys. So one of the thaian kings in his generosity gave them a pice of land near the area that later should become known as plains of havoc. The noble king saw it as both, a challenge to the order to proove their seriousness and as a trainingground to achive even more insight in the workings of fate. Though many did not understand the wise king in those days and plead the order not to leave, the order of the nightmares left the capital and only a few left the order frightened and exeposed as cowards.
After a while more and more warriors flocked to the order and embraced their strange teachings. Most came for the challenge provided by the nearby plains and its monsters, and the order of doom-prophets became more and more a mockery. The king knew they would eventually fail and did not forbid the foolish to join them. In the end the order was extingiushed in some neeadless battle against undead they provoked (probably pursuing some of their dubious prophecies). Still the wise king had long enough put the misguided there as a shield for the newly founded stelement of venore. In the end only the foresight of the clever king came true. The order did fade away as he expected, unable to live up to their loofty goals but at least their misguided energy was not wasted but used to further the prosperity of the thaian realm.]] },
			{ itemId = 2821, -- book
				text = [[
Blood and toil
Remove the soil
Sweat and work
Remove the orc

Cut and pick
That's the trick
Cut and run
That's a dragon

So have a seat
And drink, smile and sing
You h'ain't yet been eat
That's a good thing

-Old Dwarven Mining Song]] },
		},
	},
	-- bookcase at 32180,31934,6
	{
		itemId = 2436,
		itemPos = { x = 32180, y = 31934, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Shadows of the Vampires
The vampire plague had its origin in mortals dabbling with the dark arts.
In the wake of the Corpse War, several humans began practising forms of necromancy for one reason or another.
Some saw the seemingly overwhelming powers of the undead and desired them for themselves. Others desperately tried to discover some countermeasures for the undead threat.
Researching for either good or evil, a small cabal of people studying necromancy became infected or cursed, slowly turning them into ghouls themselves. The change was slow enough for the necromancer fledglings to try to avert this change with any means possible. They came up with several methods, mostly based on alchemy. At long last they turned distilled human blood mixed with several forbidden ingredients of demonic origin into an effective potion. Not only did the potion end the rotting transformation, it also revitalised the drinker, making him feel healthier and stronger than ever before. It seemed to be an immediate success.
After the entire cabal received the 'cure' it quickly became obvious that the success was only temporal at best. Soon they began feeling weak. Human food offered them nourishment no more. Again and again they were forced to revert to their potion. Trying desperately to find a permanent cure, they varied the original formula, to no avail.
Two of the brightest minds of the cabal finally joined efforts in their research, refusing to let others participate. This slowed them down in their experiments. At long last they came up with a theory that the blood of one of their 'kind' just might be the cure they need.
Instead of carefully draining themselves and exchanging the blood, they started an argument over who should be the first to be cured. Soon the argument got out of hand, resulting in a fight about who had made the discovery and who deserved the praise. A fight of words turned into a fight of fists, one of them ended up dead and the unwilling donor of the much needed blood.
The survivor indeed felt cured, even better than before. He disclosed his research to his fellow necromancers, declaring the death of his colleague an accident. The others were too interested in the cure to truly care, eager to be cured themselves. Though blood was gathered and exchanged it did little to cease the transformation, let alone stop it. The 'cured' necromancer soon figured out the blood had to be taken from a living donor in such a mass and speed that the victim would surely die.
Secretly he shared this knowledge with his most trusted brethren. They slew the others by night. After the initial shock the victims fought back. More than half of the cabal met its demise in this fight. Only few escaped, doomed to become nearly mindless ghouls.
The others learnt soon enough that the supposed cure only stabilised their semi-undead state in some way. Though no longer dependent on complicated alchemical potions, they knew that only the blood of the living would quench their thirst. Also, they were able to infect their victims with some strange strain of their own illness, making them the first true vampires with the attributes and vulnerabilities that are known to us today. It was not possible to recreate the original illness or curse that in combination with several not documented potions initially turned the cabal into unliving things.]] },
			{ itemId = 2821, -- book
				text = [[
Puldraks wisdom about elves Pt. 5
Then something happened. The dimension that harboured the elven valley began to collapse. Pice for pice their land was torn away and the wisest of the elves found out that the valley would ultimately 'fall' back in the world it belonged to. Great efforts were undertaken to prevent it. All were futile. As this was recognized it was almost too late. All magic was concentrated to preserve the lives of the elves. Protective shells were created, spells to deflect damage, enchantements to keep harm away.
The 'return' was aweful. Almost half of the elves perished. All of the valley and its wonders were destroyed. Almost nothing remained. Artifacts and books shattered and burnt alike. The battered elves retreated and begun to wander aimlessly through the lands, until they encountered scouts of the Deraisim who led them to the safety of their woods. At first they were disgusted by the primitive lifestyle of their brethren, but soon they decided they had to guide and lead them back to true values of elvenkind. So one of their encampements was choosen as new home for the elvenkind and the city of Ab'Dendriel was founded.]] },
			{ itemId = 2816, -- book
				text = [[
The great book of firemagic]] },
		},
	},
	-- bookcase at 32180,31936,6
	{
		itemId = 2435,
		itemPos = { x = 32180, y = 31936, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Ferumbras Files

The followers of Ferumbras believe that in his early career, the ambitious Ferumbras acquired access to the shrouded library of Zathroth. They disagree, however, in the details on how exactly the vile Magician managed to do this. While some claim he was the favoured of Zathroth, others argue that he breached the library's defenses and somehow stole a part of the knowledge. Even in this the specifics are debated. An intriguing variant claims, Ferumbras once was the head librarian of the shrouded hoard. Once a kind and caring man, he became more and more obsessed with the knowledge in his care and the insights he gained turned him cynical and jaded. At some point his ambitions and power became too dangerous and he was expelled from the library. The most outlandish tales even make him a physical manifestation of forbidden knowledge. The story goes that Zathroth, who obsessively accumulated knowledge, did not care about it's containment. The knowledge was powerful though that mere books could not keep it and it seeped into the library, absorbed more and more forbidden knowledge until it became sentient and created itself a physical vessel that fled the library, later becoming known as Ferumbras. Based on the the few sources available, sages of that topic suggest that Ferumbras was the descendant of a member of the brotherhood of bones that fled and got into hiding after their forces suffered a major defeat. Ferumbras was supposedly raised in secrecy and taught in the ways and secrets of the brotherhood. Since this would not explain his immense power in one way or the other, Zathroth's library seems an all too easy and convenient explanation for his stellar rise to power. Others attribute this to his bloodline, which included the likes of Goshnar and dates back to the first magician kings of Ankrahmun who unified their people against the lizard threat.]] },
			{ itemId = 2816, -- book
				text = [[
The Legend of the Frostheart
As the frost walked the lands to put everything under a thorny blanket of ice crystals, he came to the house of the fisher Marl. He had seen the frost coming already from a good distance but he did not flee. Instead he took out his lute and started to play a lovely and solemn tune. The frost, who was quite tired from his long walk, could not resist and fell asleep. Quickly Marl put his hand into the frost's chest and stole his heart. With the heart in his hands, Marl also had the powers of the frost. So he constructed himself a palace completely made of ice and ruled over a land where every day was spring. As the the neighbouring king heard about this, he got envious and decided to invade the kingdom of Marl with his army. But Marl's people were peaceful and were not trained in any fighting. So the army reached the castle of Marl almost unchallenged. And Marl came out of the castle, pleading the army to leave. But they laughed at him and demanded his surrender. Then Marl took the frost's heart and threw it to the ground where it shattered. In that very moment everything on both realms was frozen with a thick layer of ice and each and everyone died. And the frost returned to power, but without a heart he was even more merciless than before.]] },
			{ itemId = 2821, -- book
				text = [[
(This book looks rather old and torn)
Inquisitor's log Pt. I

Day 34: Finally we found her. By the sacred powers of all divine beings, it was a hard time catching that one. May all witches burn in the eternal hellfires. Though, there is no time for recreation; this witch was not the one I was looking for. Another disappointment in a long row. But I will stay strong - No, I must be strong! For the king and for the well-being of mankind...

Day 35: That foul creature! It was not her, she must have bewitched me and my guards. When the one which we mistook for the witch burned at the stake the enchantment fell off. Another innocent, murdered by that evil hag.

Day 36: Now I am sure, she must be in possession of the unholy formula that allows godless minions of Zathroth to fortify their physical and magical powers by brewing a potion out of God-fearing people. She managed once again to escape. We impaled four members of her circle in Carlin, but she managed to escape from a twofold guarded cell. The queen was very ...displeased about the death of four of her citizens. I doubt she would have said a word if it had been men.

Day 40: Finally! I found out her name! It is Wyda. I will hunt her down, I swear. And when I caught her I will be the only one in possession of the secret formula...

Day 45: We followed her to the region of the femur hills. I do not have the impression she is fleeing, she rather seems to hurry to reach some specific place - if I only knew where and why.

Day 46: I managed to get my best scouts in front of her to set up an ambush. This will be the day of my greatest victory. The fame for the inquisition, the defeat for Zathroth's minions... and the secret formula for ME! I will be the mightiest of all priestlords!]] },
			{ itemId = 2816, -- book
				text = [[
(This book looks rather old and torn)
Inquisitor's log Pt. II

Day 47: Everything seems to be going well. The scouts sent word that the ambush is ready at the Dwarf Bridge. Once all this is over everyone will kneel down in front of ME! With that formula in my hands and Wyda dead I will be the mightiest being ever. Nothing will be in my way, I will crush her and everyone who opposes me.

Day 48: No! No! With inhuman powers she managed to escape to the swamps. She must have a secret hideout somewhere. We have to push and get her. My advisors wanted to retreat. They maundered something of the dangerousness of the swamps and some "dangers" for the troops. Hah! The cowards. I had their heads chopped off and put them on spears. Noone dares to oppose me. We will ride tomorrow at dawn. And when the sun sets I will be amongs the mightiest beings of the kingdom.

-This is the last entry-]] },
		},
	},
	-- bookcase at 32286,32289,6
	{
		itemId = 2435,
		itemPos = { x = 32286, y = 32289, z = 6 },
		contents = {
			{ itemId = 2819, -- parchment
				text = [[
Questionnaire

1. What's most important in a relationship for you?
2. What's your ideal date location?
3. What physical attribute should your ideal partner have?
4. Tell me something you love.
5. Tell me something you dislike.
6. What's an important character trait for you?
7. What's your favourite colour?
8. What's your greatest fear?]] },
		},
	},
	-- bookcase at 32300,32265,6
	{
		itemId = 2435,
		itemPos = { x = 32300, y = 32265, z = 6 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
The principle of opening a gate for a demonic army is the same as summoning a demon. You need to accumulate some critical mass of synergistic energy and open a rift between the worlds. The needed ingredients consist of some of the negative energy that is similar to the essence of the demonic realm.
The first part of the summoning ritual opens only a small rift to the demonic realm. Through this rift demonic energy enters into our world infiltrating into the ingredients and filling them with more power. With stronger ingredients, the ritual opens a larger rift this time, letting more demonic energy in to strengthen the ingredients. This ritual is repeated over and over again until the ingredients are strong enough to open a portal through which the demons can pass.
This ritual can also be initiated from the demon side. Sightings of Orshabaal and similar entities clearly show all characteristics common for such rituals.
Once the gate is open, demonic minions appear and boost the negative energy of the place by their sheer presence. Later, the demonic master is following. His appearance causes a drop of the negative energy as the demon lord is feeding on it to sustain his existence in our realm.
As long as there are enough minions to boost the negative energy of a place, demons can exist for a very long time in our realm. So in theory, it would also be possible that the gate between the two realms is kept open, allowing more and more demons to enter our world that can easily form a demonic army causing mayhem and havoc.]] },
		},
	},
	-- bookcase at 32300,32269,6
	{
		itemId = 2435,
		itemPos = { x = 32300, y = 32269, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Fools From Beyond
Many of the dead leave some kind of unfinished business behind. Some of them manage to stay in the world of the living as some form of ghost or undead, but most of them simply move on to the afterlife. But even there, some of them simply don't give up. And as there is little in the world as persistent and diligent as a bad entertainer, many of them stay at the border between the two realms and contemplate their ill fates. They mourn the fame they never acquired and which they feel was unjustly stolen from them. They partner with similar minded individuals and complain to each other how cruel the world has treated them. Of course none of them is actually listening to each other because they are too absorbed with their own misery. So they grow louder and louder and over the course of time, their monologues are heard everywhere in the plain of death.
Sadly, one of the things even more persistent and diligent as a bad entertainer is a whole bunch of them. In the end, they grow that loud and annoying that the guardians of the gates of death themselves lose their patience. So once a year they throw the annoying fools out and banish them to the realm of the living, knowing that they would not stay there for long given their annoying nature.
So once a year hordes of undead jesters raid the cities where they once were seeking fame and glory. As undead, they try to terrorise the living, however, as they are even worse as undead than they are as entertainers they pose only a minor threat. Usually they find themselves back in the afterworld quite soon, and for another year, they dream of greatness that was never theirs.]] },
		},
	},
	-- bookcase at 32301,32267,6
	{
		itemId = 2436,
		itemPos = { x = 32301, y = 32267, z = 6 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The Complete and Unabridged Story of the Three Wizards

The Wizards were friends once. They still are, in a way... however, they are always arguing, complaining about each other and trying to outsmart each other whenever possible. Each of them basically has the exact same qualifications, goals and methods, but in completely different areas.

Before this time of unending quarrel, they were all working together on a complex experiment. Its goal was to create an ever-burning source of energy, fluid magic concentrated in a gigantic vessel. Ultimate, pure and self-replenishing power. They combined their talents and unique features, working together as a whole. Fern of Nature drew unfathomable amounts of energy from the life roots of the world, channelling all forms of energy created by living, moving things and even nature itself to Furb. Furb of Fun created a magic device, capable of conducting this stream of force to Feiz. Feiz was bending the planes of time and the laws of the whole physical realm of Tibia to form and sustain the vessel. The combined might of three highly trained and completely focussed wizards, who spent almost all their life concentrating on this single purpose, was necessary to keep this power at bay.

There were days of doubt, however. Days of recreation, days of training and focus. Days when they were weak and felt broken, even destroyed. It was on one of those days when they were first contacted by Carlotta. The wizards did not cherish many contacts to the world of men. Living high above in a small realm of their own magic, host to the clouds and secluded from even the eyes of dragons, they did not exactly get out much. When they learned about a fellow sorceress by the name of Carlotta, who somehow found out about what they were doing and who wanted to take part, they were actually enraged, even angry. As they saw no harm in what they were doing, however, they did not see any threat to their work in a person who suddenly took their plans seriously. Still, they were reluctant and turned her help down.

That was when Fern received a more... personal letter from Carlotta. The author of this story does not know the content of these writings, the consequences, however, are crucial to this tale. The problem was, Furb did not receive such a letter - neither did Feiz. When a second, a third and several more letters arrived, Fern had already stopped opening them in front of the others. And he wrote back. Their focus weakened.

As the weeks passed by, the results of their efforts were more often than not unsatisfactory. Around this time, the letters to Fern stopped. Fern never said a thing to the others. The project went on.

Everything went smoothly until Furb received a present. From Carlotta. Fern had never received anything else than written words. He would have even understood Carlotta turning to Furb for one reason or another, but a complete set of unique Zaoan jade figures changed everything. Fern loved Zaoan chess. He was heartbroken when he saw Furb playing with what was rightfully his. And Furb was writing letters now. Their focus weakened again. Furb and Fern were literally competing about even the smallest component of their everyday life. Finding out who was actually worthy of the sorceress changed their ways fundamentally.

When the project reached a critical state, Feiz cut the connection to the outside world completely. Isolated and in complete dismay, they continued.

They did not hear of Carlotta again. The experiment failed. Feiz' remarks about losing grip because of petty differences over the teasings of a woman made all three of them rivals. They now spend their time creating tests, riddles and even competitions to let the outside world decide what they, in all their equality, cannot.

What happened to Carlotta? Will the three ever declare a winner? And who is that distant relative Feiz suddenly has to visit from time to time?]] },
		},
	},
	-- bookcase at 32302,32269,6
	{
		itemId = 2437,
		itemPos = { x = 32302, y = 32269, z = 6 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The archdemon Shervad the Destroyer wore an armor made of an unknown material that allowed him to stay in our realm for at least three centuries. In his last battle, he lost his strength, even though he was not physically hurt - his enemies had destroyed his armor. It is said that the armor was made by some ore found in the old mines.]] },
		},
	},
	-- bookcase at 32304,32268,6
	{
		itemId = 2435,
		itemPos = { x = 32304, y = 32268, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Origin of Vampires
Since the vampiric curse is spread through infectious bites, many vampires know only little about the origin of their kind. Then again the longevity or even immortality of vampires makes it possible that they have even existed before the creation of mankind.
Of course such beasts are hard to capture and they do not like to share their knowledge. Even if you are lucky enough to be able to talk to one, you cannot be sure if he is telling the truth. In fact, most questioned subjects were making up stories and boasted about their importance, age and accomplishments.
Lacking historical knowledge, such individuals can usually be cornered by accurate historical questions. This leaves a few sources that can be seen as credible to some extent. Still, their reports are diverse and share only a few facts. These common facts are the most reliable information we have these days.
The vampires claim that the eldest of their kin still remember a time when humankind was still divided in nomadic tribes that suffered in the wars of the gods. Some see this as a reference that the creation of the first vampires took place before the Corpse War.
The majority of vampires agreed that there was only one shrouded forefather vampire, though few mention also a small coven from which the vampire plague was initiated. The most reliable sources tell about some 'lost kingdom' where the first vampires ruled over a herd of humans that they treated like cattle.
At some point in history, the younger vampires rebelled against the elders who suppressed them. Others claim the rebellion took place to gain power in this static aristocracy in which the older vampires would have never made room for the next generation due to being near to immortal. It is unknown which side won. In fact the discrepancies in the single stories are so large that we assume that the vampires themselves are unsure about the happenings in these obviously chaotic days. Some claim the rebels won and chased the aristocracy away, others say the ruling cast won and met the rebels with such brute force that the few survivors could only flee. Then again there are stories that the fight between the vampires awakened something evil which drove the surviving combatants off their once safe haven. A few stories even claim that the humans used this opportunity to rebel against their cruel oppressors.
There are no hints about the location of this lost vampire kingdom. It is assumed that it was somewhere overseas, though. Some historians suggest Edron, but, the ruins in Edron are said to origin from much earlier times. Others assume it might have been on the mysterious continent Darama, either in Drefia or in Ankrahmun. However, the destruction of Drefia took place much later and there were no reports about undead activity, except for the works of several local necromancers, before this time. Ankrahmun, on the other hand, has a very accurate historical library and there is no such thing like a vampire kingdom mentioned at all.]] },
		},
	},
	-- bookcase at 32305,32268,6
	{
		itemId = 2436,
		itemPos = { x = 32305, y = 32268, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Seeds of Life
Spring is the time when the powers of the vital force are strongest. It is this time of the year when everything is growing and nature is vibrant of life. But not only nature is growing and giving birth, also the pure force of life is pulsating with energy and the power of creation. This energy often enters in living beings, making them stronger, healthier, and more fertile. Sometimes it enters in seeds of the most diverse plants. No one can tell what kind of plant may grow from these seeds, but many creatures instinctively feel the vital force in the seeds and collect them. Some creatures of nature think of these seeds as holy relics. They cannot stand the thought that those who they regard as defilers of nature could gain possession of such seeds. Therefore, the activity of those who see themselves as preservers of nature is unusually high in spring. Dryads and other creatures of nature who are hardly ever seen for the rest of the year suddenly appear in great numbers and often pose a threat to unwary travellers of the woods. The fact that the powers of the vital force infuse them with additional energy makes matters only worse. For some time, whole forests might be impassable while the trees seem to come alive. Roots try to snare and trap travellers, walls of rapidly growing tendrils and thorns block passages, and dryads and tree spirits ambush exhausted and tired travellers. Still, not all dryads are that hostile. Some of them are even willing to trade these special seeds for other items or help the finder to cultivate the seed into a magnificent plant. Sadly such helpful spirits are rare and as capricious as all dryads. So you never can be sure what exactly to expect from them. Stories are abound in which dryads deal seemingly peacefully with humans only to turn them into trees once they have earned their trust. Other stories tell about dryads that kidnapped humans and took them into their homes in some ancient tree where they had to work as servants forever. There are even stories about people who went to the dryads to trade with them or get some advice, and when they returned from their trips which had only lasted a few days, years or even decades had passed in their hometown. Of course most of these stories are fairy tales, exaggerations or outright lies, but mortals are well-advised to be extremely careful when dealing with dryads.]] },
		},
	},
	-- bookcase at 32305,32270,6
	{
		itemId = 2436,
		itemPos = { x = 32305, y = 32270, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
I, Vampire
Our race, if my dear reader allows me to use that term, is a rather curious one. One might argue that we are a side strain of humanity. As far as I see it, the human body is all but a catalyst for a most formidable transformation. With the transformation an all new world of opportunities and impressions awaits. It is an awakening. Several things, such as coldness and tiredness cease to exist for a vampire. The focus of existence is no longer bound to tiresome daily routines and can be aimed at something bigger and more important. The weak and fragile mortal body becomes a sophisticated tool that does not lose its function due to illness or old age. Seeing the mortals suffer under such influences alienates a vampire somewhat from humanity and makes it ever more clear that we are different. Humans and vampires are set apart from each other. We remember mortality and see its weaknesses. We mourn the mortals even though our highly evolved existence raises us high above them. The wisdom we gain with our age is great. Freed of the shackles of mortality we have a clearer view of things. Knowing the envious fear with which some greedy and selfish humans view us, we hide from the eyes of overzealous inquisitors and clergymen. Behind the scenes we guide the humans through history, supporting the worthy and eliminating threats to humanity. We are the unseen movers and makers that hold kingdoms together, furthering ideas that improve societies and boosting discoveries. Not for gratitude, but to fulfil the obligation of passing some of our fortune on to those that are not as fortunate. A selected few grasp our status and have the greatness to live with their inferiority. In their own meek way they try to help us in our noble efforts. They are worthy above all others to become one of us one day. We do not take new vampires lightly of course. It can be a challenging and long journey to join our ranks. With diligence and intelligence a human might eventually convince a vampire of his worth.]] },
		},
	},
	-- bookcase at 32315,31134,6
	{
		itemId = 2435,
		itemPos = { x = 32315, y = 31134, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The northern lands proved to be a worthy object for our studies. After exploring the northern seas and verifying the absence of the sea serpents, we have no little part in reestablishing the contact with the Svargrond community. Now that ships will sail to Svargrond on a regular base, we should be able to use the gratitude our society has gained to get some necessary support for our explorations. The news about the reopening of the shipping lines will spread and adventurers and soldiers of fortune will surely arrive to seek fame and treasures. Perhaps some can be of help, though vital missions should only be entrusted to people who are already members of our noble explorer's society.]] },
		},
	},
	-- bookcase at 32315,32818,6
	{
		itemId = 2435,
		itemPos = { x = 32315, y = 32818, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Three pirate kings of old made a pact with the powers of darkness and were rewarded with three dark blades of immense powers. No enemy survived an attack with one of these blades. It is said that they allowed their owners to know whenever other ships where near and that storms and wind could be called with the blades to assist in the evil plots of the pirates.
The end came on the day these pirates decided to betray each other.
In a sea battle, they called for storms of such intensity that all of their ships sank. None of the pirates survived, and the blades vanished.
It is assumed they lie on the ocean floor.]] },
			{ itemId = 2816, -- book
				text = [[
As long as the four guardians are alive, the door that leads to the inner sanctum won't open. Only the blood of the guardians opens the lock. The crucial point is to locate the guardians. They are hidden at spots where no one would suspect them, disguised as ordinary creatures that inhabit this world. The Eye of Xandalos might be of help to locate and identify them.
If close enough to the guardians, it works like the "find person" spell. Considering the cost of its usage, it is out of question to use it without further thought. The construction of an Eye of Xandalos is an entirely other issue though.]] },
			{ itemId = 401, -- book
				text = [[
The Klabautermen
The klabautermen are a race of impish, mischievous beings that live on ships. Using invisibility and other magic, they remain unseen most of the time. But be warned, if you antagonise the klabauterman of a ship, his harmless pranks will turn dangerous.
In general it is a smart move to keep your klabauterman happy with little presents
and a lot of rum.]] },
		},
	},
	-- bookcase at 32316,32818,6
	{
		itemId = 2436,
		itemPos = { x = 32316, y = 32818, z = 6 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
The Shattered Isles

Nargor is a hostile rock surrounded by treacherous reefs. Since it is uninhabitable and almost unreachable it is of no interest.

Treasure Island is not only desert-like but also quite deserted. The only people you meet are treasure hunters that travel there occasionally to try their luck.

The inhabitants of the town Liberty Bay live on the numerous plantations. The town has developed into a major trading center in recent years, and is under Thaian rule.

The Forbidden Islands to the north-west are dangerous not only because of the volcanoes that are found there but also due to frequent quara activity. Since there is no real reason to visit these islands, no regular shipping route was ever established.

The Laguna Islands are quite often visited by passing ships to refresh their supply of water and food. Still the isles are too desolate to establish a settlement there. It is rumored that a small tribe of savages calls one of the isles its home.]] },
			{ itemId = 2825, -- book
				text = [[
The Legend of the Swimming Isle]] },
			{ itemId = 2816, -- book
				text = [[
The Ghost Ship]] },
		},
	},
	-- bookcase at 32317,32818,6
	{
		itemId = 2436,
		itemPos = { x = 32317, y = 32818, z = 6 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The so-called Astral Shapers were godless people. They mocked the gods and even tried to outdo them in the arts of creation. They created many powerful items which they used to bend the other races to their own will. One day though, they decided to build a device that allowed them to look into the realm of the gods. The gods became aware of this blasphemy, hence they sent a messenger to the Shapers. It was Huodin, the blessed servant of Kurik, who warned them not to cross the line. The vain Shapers, however, were mocking him and chased him away. Then the gods sent a second messenger. Anadron, the voice of Uman-Zathroth, brought them the wisdom to abandon their false ways. The Shapers, however, denied him entry and discarded the wisdom, casting it into the deepest well in one of their cities.
Then the gods sent Dratur, the adamant sword of Banor. He just walked into their capitol and stood there without any motion, without saying a word, his weapons sheathed. At first the Shapers were fearful, but soon they began to mock the unmoving warrior. Three and three days he stood there while the artefact of the Shapers was almost finalised.
As the project was just a few heartbeats away from completion, Dratur drew his sword, blessed by all the gods. In three and three minutes he had slain the entire city. Every Shaper older than three and three years lay dead in their accursed blood. When Dratur sheathed his sword, the gods let fire, toxic slime and brimstone rain upon the cities of the blasphemous Shapers for three and three days.]] },
			{ itemId = 2828, -- book
				text = [[
The Fire Walkers
On one of the isles I witnessed an utmost unusual occurrence. The natives gathered to some festivity. After some singing, dancing and drinking, they started to jump through some of the bonfires. They started screaming insanely and then started to walk over glowing logs of wood. I am wondering if this has something to do with the stuff they are drinking. It would be interesting to see if it can be used to cross lava streams.]] },
			{ itemId = 2821, -- book
				text = [[
May Banor bless our souls.
May the kiss of Kirok bring us inspiration.
May Fardos give us the force of will to forge our souls to tools of good.
May Crunor protect our health and essence.
May Uman teach us to use his gifts and use them wisely.
May the archangels guide and guard us.]] },
			{ itemId = 2816, -- book
				text = [[
Seasickness or Why the Gods Don't Want Us to Travel the Oceans]] },
		},
	},
	-- bookcase at 32318,32818,6
	{
		itemId = 2436,
		itemPos = { x = 32318, y = 32818, z = 6 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
Rum - the Essence of Life]] },
		},
	},
	-- bookcase at 32319,32818,6
	{
		itemId = 2437,
		itemPos = { x = 32319, y = 32818, z = 6 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Diary of Shawn Risjaw
... finally reached Port Hope. The settlement's name is quite suitable - for me at least. It is my last hope to avoid that assassin Ned Noxious. It is said that the old red master himself has trained him. There is no doubt that I am no match for him in a fight. I can only hope he will lose my track somewhere in Thais or Carlin. I will head to the nearby mountains to look for a hiding place there.

The gods are with me! Not only did I find some sort of cave, but also a quara raid covered my disappearance from the town. Now I have to manage to live here for a few years in a hideout, then I might return to the town. I have still to explore the caves fully. They seem quite huge and I can only hope that I am not running out of luck. I do not want to imagine what would happen to me if I run into some hostile inhabitants here. Still I think my skills are sufficient to handle some cave bear or even some tarantulas. If I run into a giant spider, I might have a problem though.
My supply of runes is not large enough that I could spend them needlessly.]] },
			{ itemId = 2828, -- book
				text = [[
The Awaking of the Gods BOOK ONE

In the beginning there was only the big gaping void. It was omnipresent and nowhere. Into this desert entered Fardos, the creator, and Uman Zathroth, incorporating magic. Nobody knows where they came from or whether they always have existed and just awaked from the deep slumber of the infinity. Fardos fulfilled by the need to create and give birth. He stepped into existence and began immediately with the act of the creation, because he was fully creative power and impatient. His godly powers emerged from him and created, formed. But all his works slipped out of his hands as the void was everywhere. No single work was to last. Everything that he devised dissolved in the void even before it was completed. Uman Zathroth regarded his undertakings thoughtfully, because Uman Zathroth was wise and fullfilled with magic powers and insatiable hunger for knowledge, comprehension and enlightenment. He was a creature similar and nevertheless different to the clear working of the Fardos, because mysteries and secrets were the aspects of his being. Uman and Zathroth were two entities and nevertheless one. Uman was the light, bright aspect of the magic strength. His was the gift to work benign wonders. Zathroth however, his different - dark - side, was corruptive urge, the vain self purpose of magic, destructive and a desecration! This entity, which was two and one nevertheless, observed now the works of his companion in infinity.]] },
			{ itemId = 2825, -- book
				text = [[
The First Creatures BOOK ONE

Zathroth however was delighted by the destructive potential, which Fafnar showed, and he looked upon her with delight. He flattered her with compliments, and he succeeded in seducing her. Thus they conceived Brog, the fiery raging berserker. Brog possessed only little of his fathers wisdom, and the heat of his mother burned only deep inside of him. There however the fire became more ravaging and more hurting, and the rough titan raged and cried that the elements were shaken. Inexpressible pain troubled him, until the blocheaded Brog compacted his magical powers and hurled a major part of the fire far away from himself. From the fire, which did not want to cool down, however immediately the first dragon, called Garsharak, rose and he bore many further lower dragons in the course of the centuries from his fire and his magic, of the like we know today.]] },
			{ itemId = 2821, -- book
				text = [[
The Birth of the Elements BOOK ONE

Schocked Uman and Fardos tried to grab hold of the dispersing being of Tibiasula, but it was about to slip out of their hands like their creations before. They wove a powerful spell, the spell of the creation, in order to bind Tibiasulas essence to the column of time. As Zathroth laughed loudly, in his vain triumph, he did not understand their words, and so the secret of creation and life stayed hidden from him forever.

They however wove the fleeting elements to powerful strands. Althought they did not succeed in uniting them again but the individual parts became something new, the first real creation. Thus the living part became Tibia, born from the element earth, Sula became the sea washing around it. Air rose over the creation and layed itself like a protecting blanket over the creation, and the fire seeped under it and began to warm it up.

Behold: Each of the separate parts of the god was full of life and divinity! But none of the elements possessed the spirit of the Tibiasula, but they were wild and impetuous, following always the impulses which corresponded to their nature.]] },
		},
	},
	-- bookcase at 32346,32807,6
	{
		itemId = 2435,
		itemPos = { x = 32346, y = 32807, z = 6 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The Witches' Grotto
On a remote isle in the South there is a grotto where all witches come together to celebrate some demonic festivity once a year. They teach each other new malicious 
tricks to torment other beings. The legend goes that everybody that dares to disturb them is put to death or faces a fate even worse than death. But if you manage to step into their dancing circle at the height of the ceremony, the witches have to fulfil you a wish.]] },
			{ itemId = 2828, -- book
				text = [[
Mermaids
Mermaids are vain creatures of magical nature. Dealings with mermaids are dangerous to some extent. Many men have fallen in love with one of them, bewitched by their beauty and magic. Fortunately, mermaids are easily distracted and lose any interest in their enthralled victims as soon as something or someone else draws their attention. Since this is often enough another man that was foolish enough to get close to them, one elflock-stricken victim is replaced with another one. It is almost impossible to escape this vicious circle since unbanning one victim often means to sacrifice another man's life or at least his freedom. ]] },
			{ itemId = 2824, -- book
				text = [[
The Shattered Isles
Nargor is a hostile rock surrounded by treacherous reefs. Since it is uninhabitable and almost unreachable it is of no interest. 
Treasure Island is not only desert-like but also quite deserted. The only people you meet are treasure hunters that  travel there occasionally to try their luck.
The inhabitants of  the town Liberty Bay live on the numerous plantations. The town has developed into a major trading center in recent years, and is under Thaian rule. 
The Forbidden Islands  to the north-west are dangerous not only because of the volcanoes that are found there but also due to frequent quara activity. Since there is no real reason to visit these islands, no regular shipping route was ever established. 
The Laguna  Islands are quite often visited by passing ships to refresh their supply of water and food. Still the isles are too desolate to establish a settlement there. It is rumored that a small tribe of savages calls one of the
isles its home.]] },
			{ itemId = 2824, -- book
				text = [[
The Quara, Curse of the Seas
No one knows where they really come from. It seems the murderous quara are living deep down in the ocean in unknown numbers. From there, they plot their raids on the surface in which they cause havoc and mayhem. The quara consist of several subspecies whose relation to each other is still unknown to men. Given their hostile disposition, it is unlikely that we will ever learn more about them. For most humans it is sufficient to know that a quara means danger. Those who are able to fight them should kill them, those who are too weak should avoid them by all means.]] },
			{ itemId = 2831, -- book
				text = [[
Monsters of the Sea]] },
			{ itemId = 2829, -- book
				text = [[
Nautical Studies]] },
		},
	},
	-- drawers at 32362,32784,6
	{
		itemId = 2433,
		itemPos = { x = 32362, y = 32784, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Treasure Hunter's Manual]] },
			{ itemId = 2821, -- book
				text = [[
The Golden Whale
Since sightings have been reported by many respectable seamen the existence of the golden whale can no longer be dismissed as a fairy tale. It is said that this whale is as huge as an isle and its body is made of purest gold. Even though many of the reports were made by seamen in the southern seas sailors of the north also claim to have seen this creature. All over the world the sighting of the golden whale is seen as a good omen. No one has yet been able to even hurt the beast; however, several inventors and mages have come up with ideas for the creation of a weapon that might pierce its golden body.]] },
		},
	},
	-- drawers at 32385,32239,6
	{
		itemId = 2434,
		itemPos = { x = 32385, y = 32239, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Maximal Farming
Chapter One - How to exploit the soil.]] },
			{ itemId = 2816, -- book
				text = [[
The Good Farmer]] },
		},
	},
	-- bookcase at 32477,31902,6
	{
		itemId = 2438,
		itemPos = { x = 32477, y = 31902, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Now they call it madness, but generations to come will see my genius. I will proof them wrong once and for all. ALL of them! I will find answers to questions they don't even dare to ask. I will open doors to mysteries never even imagined by them. I WILL learn even the secret of death. I will rule supreme over the land. I will bring peace, death, justice, and fear. I will ...]] },
		},
	},
	-- bookcase at 32477,31903,6
	{
		itemId = 2439,
		itemPos = { x = 32477, y = 31903, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Tfel thgirtfel tfelthgir thgir]] },
			{ itemId = 2816, -- book
				text = [[
Mirror mirror on the wall, who is the crazyest of them all?]] },
		},
	},
	-- bookcase at 32477,31904,6
	{
		itemId = 2440,
		itemPos = { x = 32477, y = 31904, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
I will be a better god then the others!
Those who whorship me will have to make sacrifies for me! Yes, they will have to!
What will I ask for? Not much, perhaps food. But i'd be a good god so I only accept plants. No! Better fruits! I love fruits! They have to sacrifice a melon for instance. Oh and then a banana!! But I love cherrys too! So they have to bring them too, yes yes!
Then they have to invoke a ritual, involving an apple, and and and ... grapes! Grapes are important! Yes indeed! And for the last sacrifice I demand a coconut from my faithfull. Only then they are allowed to ascend to my throne! Oh, yes what a joy for them!]] },
		},
	},
	-- bookcase at 32480,31902,6
	{
		itemId = 2438,
		itemPos = { x = 32480, y = 31902, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Doing it the mad way!]] },
		},
	},
	-- bookcase at 32480,31903,6
	{
		itemId = 2439,
		itemPos = { x = 32480, y = 31903, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Book of funny letters I
äöü]] },
			{ itemId = 2816, -- book
				text = [[
ljkhbl nilse jfpce ojvco ld
slcld ylddiv dnolsd dd sd
sdcp cppcs cccpc cpsc
awdp cpcw cfw ce
cpvc ev vcemmev vrvf
cp fd vmfpm xcv]] },
		},
	},
	-- bookcase at 32480,31904,6
	{
		itemId = 2440,
		itemPos = { x = 32480, y = 31904, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The book of foolish jokes]] },
			{ itemId = 2816, -- book
				text = [[
dtjfhg
jhfvzk
bbliiug
bkjjjjjjj
xhvuo
fffff
zkkbk h
lbhiovz
klhi igbb]] },
		},
	},
	-- small bamboo shelf at 32590,32742,6
	{
		itemId = 2464,
		itemPos = { x = 32590, y = 32742, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Wondrous Plant Life - Jungle Edition Vol. 1

(In memory of Mandol the priest - Sadly this work was left unfinished due to his untimely end by a carnivorous plant.)

The threadlike vegetation of the thread tree can easily be cut off and, if woven with moderate skills, can be used to make ropes. These ropes are especially useful when it comes to simple constructions that only have to last for a short period of time.

The jungle dweller bush is quite a common plant. It's the home of a variety of insects and small animals.

The green wig bush is mainly known for its long, threadlike roots. Although those roots are edible it is not advisable to actually do so. They have an extreme bitter taste and need to be boiled to reach an edible state. The green wig bush got his name from the sad fact that sometimes the murderous dworcs use its roots to bind them to their heads as some kind of camouflage during their sneak attacks.

The lizards tongue is quite an unremarkable plant. It grows quickly but there is no real use for this resource and it does not please the eye enough to be worth growing it. It can be easily recognised by the slimy coating of its leaves which partly led to its name.

The jungle crown is somewhat rare. Still it's quite an unremarkable plant considering its majestic name which probably originates from its unique ringlike growth pattern.

It is unknown if the name of the green fountain bush was chosen deliberately or rather accidentally, but the name is well to the point for two reasons. Firstly, it does indeed resemble a frozen green fountain and secondly, like a cactus it is able to accumulate a substantial supply of water in its thick leaves.]] },
			{ itemId = 2816, -- book
				text = [[
Wondrous Plant Life - Jungle Edition Vol. 2

The dragons nest tree is neither a real tree nor does it even remotely have something to do with dragons. Probably the first explorers were shocked when they first saw the thick round blossoms of this giant flower. Obviously, those explorers knew little about dragons and even less about plants, naming it a tree.

The purple kiss bush is a plant that pleases the eye and the nose alike. Sadly it seems impossible to cultivate it yet and so we have to live with the fact that we will only meet its beauty by chance.

The jungle umbrella in its many varieties is extremly common and only the fertility of the other jungle plants prevents it from becoming a pest. It grows faster than bamboo but lacks its usefulness. Its wood is thin and breaks easily when dried.

On touch the chill nettle injects a very mild poison that let the skin feel somewhat numb and cold. Although some people try using it to fight the heat, it actually does not prevent overheating and also the production of sweat is not reduced. Given the threat of possible long-term damage, it's not advisable to use the nettle for this purpose.

The monkey tail plant is most likely related to the chill nettle. It is also possible that one plant is disguising the other one for some unknown reason. Before the monkey tail blooms, the two plants almost look alike. Only when the monkey tail reveals its purple blossom does the difference become obvious, even to an amateur.

The fairy queen is one of the most beautiful plants in the whole world. Unfortunately it needs an insane effort to grow them away from their natural habitat. To grow one, expensive supplies and a group of specialists are needed that only kings and queens could afford. Therefore, the fairy queen will only be found in company that fits her royal title.]] },
			{ itemId = 2816, -- book
				text = [[
Wondrous Plant Life - Jungle Edition Vol. 3

Even though, one could assume that the crane plant obtained its name because it looks remotely like a crane, it was named after its discoverer Malcom Crane. Crane used to be a rather unremarkable student of mine who tended to overestimate his abilities and who flattered himself by giving this plant his name. Fittingly, the crane plant is a rather pompous plant.

Jungle bells are lovely, small plants that need much light and water. Still it is possible for a dedicated botanist to grow one or two of them if he really puts effort into it. Unfortunately, the jungle ants are as eager of this plant as the forementionend Malcom Crane was eager of some recognition.

The dawn singer is a plant that opens its blossom by the first sunbeam in the morning. Its blossom looks very close to an open mouth which probably led to its name. However, one might wonder if a less flattering name would have been more appropriate considering the awful odour that emanates from it in the morning hours.

The turtle sprouter can be cultivated quite easily since all it needs is much sun and warmth which can be easily provided in an environment like the jungle. It is somewhat more difficult to grow them in other regions although not impossible if mainly grown indoors. The name was derived from its sprouts that have the shape of small orbs.

The bees ballroom does not only attract bees but all kind of flying insects with its strange but not unpleasant odour. Usually you hear this plant before you actually see or smell it because there is a constant buzzing and humming of insects around it.

The jungle rose is a relative of our ordinary rose. Unlike the known roses, some plants of this species can reach impressive proportions while others do not exceed the size of an ordinary rose. It has not been discovered yet if this giant version is some subspecies or if its tremendous growth is influenced by other means.]] },
			{ itemId = 2816, -- book
				text = [[
Wondrous Plant Life - Jungle Edition Vol. 4

The titans orchid is rare and quite a sight. I have no idea how long it takes until a plant reaches its full size which even dwarfs some trees. I have not been able to grow one to its full size yet, and I begin to wonder how old those full grown plants we encountered might have been.

The purple cardinal is a plant that looks very different from any other plant. It grows to enormous proportions and it is the only plant that jungle ants avoid in their ravenous hunger. If we could figure out how the plant protects itself, we might be able to use that knowledge to cultivate the area.

The witches cauldron is quite an eye-catcher. It is extremely big and has its own beauty. The traveller should be warned that it is not advisable to drink the rainwater that gathers in the big blossom. The plant seems to poison the water in some way and severe stomach pains are the most harmless ailments that occur after drinking it. So the conclusion can be drawn that the whole plant is uneatable due to its poison.

The velvet petal is another giant plant of the jungle. Its smell is surprisingly unremarkable but the plant's colourful petals catch easily the attention of the wanderer. They are somewhat hairy and soft and indeed feel like velvet to the touch. The plant is very fragile though so caution is advised. How such a plant manages to survive in the harsh jungle remains a mystery.

The devils tongue flower is another remarkable species of Tiquanda. A man feels quite dwarfish next to this impressive flower. The fact that its leaves, after being dried and grinded, give a spicy substance has led to numerous attempts of Venoran traders to cultivate this plant. It must be feared that they start harvesting that plant in the jungle and destroy the complete species if their efforts in growing this plant stays unsuccessful.]] },
		},
	},
	-- small bamboo shelf at 32590,32744,6
	{
		itemId = 2464,
		itemPos = { x = 32590, y = 32744, z = 6 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
Enemies of the True Faith
First of all there are the heretics. Those are probably the most dangerous enemies because you hardly notice them. They undermine our society and the belief in the gods by their actions and their words. Some of them are crazy enough to think that they are true believers themselves. Their words erode the fundamentals of faith. They must be eliminated from our society.
As practitioners of dark and forbidden arts, witches are dangerous enemies as well. They must be avoided by all virtuous people that swore faithfulness to the gods. Witches are godless beings that even sacrifice evil creatures to get hold of their dark magic.
Then there are the damned, the undead. There are two types of them - ghosts and the walking dead. Both are insults to the teachings of the gods, and both were denied eternal peace, surely for a good reason. They try to kill all living beings. They must be destroyed on sight.
The worst enemies are demons. They are malicious creatures of immense power that plot the downfall of mankind. With all our power and might we have to oppose these servants of the dark one.
All of these enemies pose a threat on their own. We have to be aware of all their evil intrigues to be able to protect our souls. Only a devout and brave heart can triumph over their dark temptations. Those who fail and stumble, even only once, are at risk to become heretics themselves. Therefore we must not only watch ourselves but also our brethren and sisters to see if they might have fallen and turned into enemies.
The best weapons to fight evil are bravery and faith. They are not only the best available arms but also the prerequisite to fight evil at all. Brave followers of the true faith might of course arm themselves with additional weapons. A vial of holy water often works wonders when it comes to clean desecrated places and to drive out unholy entities. Often, a believer needs nothing than a holy symbol combined with his unwavering faith to ward off some of the less powerful evil beings.
The holy ground of temples dedicated to the good gods is a safe haven for everyone as it cannot be entered by the servants of evil. Certain holy relics in the possession of these temples are able to harm or even to defeat the mightiest servants of darkness.
We are all sinners and we should neither be proud of our faith nor be smug about it as pride and vanity are the first steps to heresy. We should be aware of our failures and plead for forgiveness every day.]] },
		},
	},
	-- bamboo shelf at 32595,32740,6
	{
		itemId = 2459,
		itemPos = { x = 32595, y = 32740, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
My Travels by Ploch Pridestride (Volume 17)

After stocking up supplies in Port Hope we immediately focused on the next step in our plans. It was our goal to reach the haunted ruins of Drefia using small boats that would allow us to stay close to the beach which had some major advantages: while exploring the coastline we could gather food and water in the jungle and avoid the dangers of the treacherous reefs of the northern coast at the same time. Of course this would still be a dangerous and daring enterprise - else it would have been done before -, but we were sure that it could be done. Indeed the voyage started smoothly. We grew accustomed to the difficulties of the coastline quite fast and none of the giant sea creatures that were rumoured to plague the reefs were sighted. The first actual threats we faced were quite ordinary beasts of the jungle which - although dangerous - did not turn out to be of greater danger than the animals we had encountered during other travels. However we did not expect at all the very jungle to turn against us. We were setting up camp on a clearing that seemed peaceful, even idyllic. With hindsight this fact should have alerted us, but we were exhausted from a lengthy trip and relieved to get some rest without having to drive some beasts away first. All of a sudden, thorns shot all over the clearing and the previously calm jungle ground came to violent life. Plants we had never seen before were biting our feet with the ferocious greed of a rabid hyaena. Complete disorientation and panic took over and there was yelling and running everywhere. When we finally made it back to the boats, most of the equipment we had carried with us was lost and there was no one among us who was not injured, some were even poisoned. We spent a hard night directly on the beach and woke up drenched, covered with sand and salt all over, our wounds burning like fire. Yet we decided to continue our expedition.]] },
			{ itemId = 2816, -- book
				text = [[
My Travels by Ploch Pridestride (Volume 18)

Bandaged as good as it was possible under the prevailing circumstances we continued to follow the coastline. We reached an area where the reefs made it almost impossible to stay close to the shore and thus forced us to make a decision. We could either try to continue our voyage through the treacherous reefs by boat, or head for deeper water and travel across the dangerous ocean for an indefinite time or, as third alternative, continue by foot along the beach with the boats on our backs until it seemed safe enough to use the boats again. Under normal circumstances I would have opted for the latter, but me and my men were wounded and tired and the jungle had already shown us its ugly face in a way which made none of us want to see more of it. Heading for the ocean was no real option either. Not only that our small boats were not built for that kind of travel - reaching Drefia via the high seas had already been accomplished before and doing so would contradict the intention of the whole expedition. Thus we dared to stick to our original plan as closely as possibly and to try finding a path through the reefs. Shortly after we were rewarded for our bravery with a breathtaking sight.]] },
			{ itemId = 2816, -- book
				text = [[
My Travels by Ploch Pridestride (Volume 19)

Unexpectedly, pyramid-like ruins appeared at the horizon breaking the eternal green of the jungle. Already half taken over by the all-devouring jungle vegetation but still clearly recognisable there was an actual city - ancient, but obviously populated. Having heard about the pyramids of the southern desert we instinctively related the jungle monuments to the same culture and to the people settling in the city of Ankrahmun. While we cautiously steered our boats closer to the beach and wondered about the mysterious origins of this jungle city, more and more apes showed up on the beach, yelling at us in threatening poses. Strangely enough, they were wearing various kinds of equipment - actually wearing it, not randomly strapped to the body like some mindless beast might have done. Due to the obvious hostility we stayed far enough from them to avoid the coconuts and stones they hurled in our direction. I was left solely with the option to examine the strange apes and the ruins through my spyglass and was able to spot different kinds of apes which wore sparse clothing and equipment such as weapons in a way that made clear they knew what they were doing. However some - if not most - equipment looked odd on them, as if made for creatures of a completely different build. A closer look at the ruins revealed that they were not as ruined as I had thought at first, in fact most were only overgrown by the jungle. The visible remains displayed impressive work and art. Oddly, most patterns on the walls showed serpents and lizards of some kind which for sure did not fit the hairy humanoids inhabiting the city. Then I saw the first statues. Although obviously damaged on purpose and turned into almost unrecognisable heaps of stone, some of them showed features of two legged, upright walking lizards complete with weaponry and other equipment. Instantly I remembered the stories of intelligent, yet savage lizard men which were rumoured to live somewhere in the deepest jungle.]] },
			{ itemId = 2816, -- book
				text = [[
My Travels by Ploch Pridestride (Volume 20)

I recognise a mystery when I encounter one, and this was a mystery for sure. Although a good mystery can fascinate me a lot more than most women I met in my life, I was responsible for this expedition and for my men which stopped me from changing our plans right there and then. Instead I started to make up a plan for a later expedition which would lead me to the area where the lizard people possibly could be found in order to learn more about them. Thus we left the strange pyramid city behind us for now and continued our passage through the reefs. Shortly after, we eventually made it and the shoreline became safe once again. We decided to take a break and set up camp, even more careful than usual, securing it with everything we had at our disposal since we needed some time to repair our boats and equipment as well as to heal our wounds. We camped there for two days and - thanks to the gods - had to face only minor nuisances. During the night the same jungle which could turn dangerously silent in the daytime became a symphony of screams, screeches and howls of creatures no one of us could even imagine. When the sun set, the sky seemed to explode with massive rain as if the gods were pouring down a whole ocean on us. Even with our full equipment we would have had a hard time to keep ourselves comfortable and with a significant amount of our stuff lost to the jungle, it was almost impossible to actually recover. As we took off for the sea again we were all glad to escape this green hell once more. We followed the shoreline to the next impassable reef formation, however, this time the reefs were close to the beach, so it was easy enough to find a way around while keeping the land in sight as well as avoiding the depths of the sea. Using my spyglass, a wooden structure blending almost perfectly with the jungle caught my attention. It reminded me of an enormous fortification of some sort, yet there seemed to be no defenders, just thickest jungle surrounding it.]] },
			{ itemId = 2816, -- book
				text = [[
My Travels by Ploch Pridestride (Volume 21)

Since there was no reasonable possibility to reach this structure at this time or even just the shore, we continued our voyage through the night. It was about midnight when a roar of some sort interrupted the cacophony of the jungle, and then silence remained. The waves of the sea and their gentle lapping against our wooden boats were the only sounds still audible. From what I can tell, the cause of this roar must have been something we had never encountered before. We had seen and heard dragons, even the majestic dragon lords, but this had to be something which would dwarf even them. I am not ashamed to admit that my hands were trembling when I took my spyglass and searched the night for any sight of the creature we had just heard. Of course I did not really hope to actually spot something in this darkness, so again I was more than surprised when I indeed detected a shadow moving through the jungle. I hardly could have overlooked it since it towered even above the giant trees of the jungle. I was not able to see anything more of it than its rough shape, but for all that I saw I swear to the gods it was the shape of some brutish humanoid. No one of us felt prepared to investigate this mystery in that night, and as the sun rose once again we had already left the sandy part of the coastline and followed the jagged mountain range which seperated Drefia from the rest of the continent. Our destination was near.]] },
		},
	},
	-- bamboo shelf at 32595,32743,6
	{
		itemId = 2459,
		itemPos = { x = 32595, y = 32743, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Lizard People

It seems the lizards we encountered in the jungle are some sort of civilised culture. When I speak of culture, I relate them only to primitive orcs and minotaurs of course. During our expeditions to the jungle we learned that they are hostile to humanity like most of the vile creatures of this new land. Their animosity also spreads to most other races we encountered here. They seem to be a warlike race, searching for conflicts and fights with each and everyone they encounter. Obviously this mindless aggression leaves little room to develop a culture like the human one, achieved due to a long history. It is unlikely those primitive brutes even know the very concept of history at all.

This leaves one to wonder who supplies them with their exotic weaponary and armor. Perhaps they are some minor race of a greater dark power that lurks in the deepest depths of the jungle. The magic I have seen performed by those lizards was far from impressive. They use a very limited variety of shamanistic tricks that are insignificantly more powerful than the powers those average orcish hive shamans hold.

To sum things up, the lizard people are another hostile race that might be seen as a hindrance for humankind but they do not pose a threat. On the other hand they are of no use to us and a timely elimination could only be helpful.]] },
			{ itemId = 2816, -- book
				text = [[
The Ghosts of the Jungle

Even though it is true that many people who have not returned from the jungle have fallen prey to animals and other natural dangers, it is quite sure that not in all cases this explanation is applicable. For all we know it is quite certain that there have to be other dangers in the jungle than such mundane ones. How can it be explained that several watchmen of expeditions have vanished over night while none of the people asleep in the camp was harmed? How is it possible that well armed and seasoned adventurers got lost in the jungle? Considering the expertise of some of the victims this jungle has taken, it would be highly ignorant to assume that a simple beast of some kind could be the source of their ultimate doom. In conclusion we have to assume that 'something' is out there. A malicious, unseen power. Never seen but often felt. Noticed only by the 'inner eye' but never actually seen. Everybody that has ever set foot in the jungle knows this eerie feeling of being watched and traced. Sometimes you can almost imagine the movements of something invisible in the bushes.

And do all those glowing eyes in the darkness belong to animals? I don't think so.]] },
			{ itemId = 2821, -- book
				text = [[
The Pyramids of the Apes Vol. 1

Having experienced the apes as a very primitive culture, the rumors and stories about them living in a pyramid city, not unlike that of the far away Ankrahmun, seemed unbelivable at first. On second thought though we have to admit that we have seen stranger things than this in our lovely world. But how could those primitive apes build a pyramid city like this? How could they aquire such heights of architecture while they can hardly wield a weapon and have only a remote grasp to the concept of clothing? The answer is quite obvious though.

We know that the pyramid architecture of Ankrahmun has been used for its spiritual value long before the reign of Arkhotep. We also know that Ankrahmun is a city of the dead. As a matter of fact it is also true that in Ankrahmun the wisdom of many ages has been gathered and philosophy and science prospered like nowhere else in this world. It is obvious that the pyramids are linked to death and to wisdom somehow. If you put two and two together, you can easily figure out that those pyramids act as a collector of spiritual energy and probably even literally as houses of the dead. Imagine a civilisation that could have conversations with its dead ancestors and draw from the enormous source of their wisdom! Would such a civilisation not prosper like that of Ankrahmun? For sure it would.

But how is this connected to the apes and their pyramids one might ask. The answer is simple: being the primitive beings they are, the apes are unable to build such structures but some spirits of the past with the wisdom of millennia might have that knowledge. We all know that a primitive mind can be easily controlled. So it would be easy for such a spirit to take over control of the simple mind of one or more apes and give them orders. Without knowing what they were doing such mind-controlled apes could have built this city of pyramids. Of course the apes would have no need for such a city, but surely the ghosts or spirits would like to call such a place their home.]] },
			{ itemId = 2821, -- book
				text = [[
The Pyramids of the Apes Vol. 2

After obtaining their base, the spirits must have stopped controlling the apes which resulted in random raids that are too well known by the inhabitants of Port Hope and that formed their opinion about those creatures. The lack of organisation and control in those attacks makes it obvious that there is no higher power behind them. It seems that the spirits have now left the pyramids since the rare reports we receive from that place, tell us that the once grand structures are now overgrown ruins. Would the spirits allow their home to decay in such a way? I would highly doubt that. There are only two explanations for this phenomenon. The first possibility is that the spirits have left our world. This would be reasonable if you assume that taking control over a living being costs some powers and might have drained all energy from the spirits. But wouldn't those pyramids cancel this effect? For sure they would. So another reason for the spirits' departure could be that the spirits gathered enough energy through the pyramids that allowed them to travel to another dimension or reach a new state of being (or death). So the spirits have no use of the pyramids anymore. The second theory for the spirits' disappearance is much more worrying: the spirits are only asleep. Perhaps the process of becoming one with the field energy of the pyramids was so exhausting that the spirits had to take some rest. If this is the case, they could wake up anytime. And nobody can foresee how they will react to us living intruders who could pose a dangerous threat to their spiritual home.]] },
		},
	},
	-- bookcase at 32686,31655,6
	{
		itemId = 18483,
		itemPos = { x = 32686, y = 31655, z = 6 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
About Feyrist

Feyrist is mainly populated by Fae. Rumour has it that it is located north-west of Roshamuul, bordered between high mountains to the southeast and the sea to the other cardinal directions. Deep forests and lush meadows are mixing up on the peninsula, dotted with lakes, brooks, hills, ravines and groves. The coast of Feyrist is partly sandy beaches, partly grassy shores. Feyrist has a temperate to warm climate, which has led to a lush, verdurous vegetation. Rich green pastures with various wild flowers and thick deciduous forests are dominating the peninsula. Most of the Fae live scattered all over the woods, there is just one bigger settlement, consisting of many Fae houses, a magical fountain and a tree that seems to be some kind of temple.

Feyrist arose from the mortals' pleasant dreams. The reclusive magical realm is among the most secret areas of Tibia, characterised by an enchanted environment and pervaded by ancient magic. The Fae's skills of shaping wood and stone as well as their magical talent are their greatest benefits. The woods of Feyrist hold some rare magical plants. However, Feyrist lacks almost all infrastructure, simply because the fae don't have any need for it.

The Fae of Feyrist are forming different courts. Although not all of them belong to a fairy court, many of them do. Usually, the most powerful female fae is the leader of a court. Sometimes she refers to herself as queen. The queen is supported by several knights, male and female alike, who are acting as her personal guards as well as the court's defenders. Within a court there may be disagreements among single members, but overt struggles are rather uncommon. The courts are independent from each other. Conflicts between two courts are seldom.

The Fae are benevolent but also flighty and unpredictable creatures. They are more interested in dancing, making music and playing tricks on each other than in fighting, studying or constructing. Fae like sweets, wine, glittering trinkets, lyrics and music. The highest purpose in a Fae's life is usually to have fun and to live a carefree life. Some Fae are suspicious of strangers and tend to welcome them with avoidance in the best case. They feel foreigners disturb the area's solitude. Lately, however, one of the courts has shown some interest in the mortals, how the Fae call all strangers.

The Fae also have a spiritual side and perform various rites to celebrate the moon cycle and certain weather phenomena. They don't worship gods or greater spirits but nature itself, which they regard as a kind of supreme being. Apart from that, Fae care only for the here and now. Fae possess a distinct talent for the arcane powers and they have highly developed artisanal skills when it comes to shaping wood and stone. It is unclear whether the Fae have to eat in order to survive. However, they obviously enjoy eating sweets and fresh fruit as well as drinking wine. So it can be assumed that they do it just for pleasure.]] },
			{ itemId = 2826, -- book
				text = [[
About the Fae

The Fae are secluded and mysterious creatures, living in forests, some of them also in caves beneath the earth. Their secret realm is the peninsula Feyrist. There is a less forested meadow area, which borders on the mountain chain, that seems to separate Feyrist from Roshamuul. A large forest is situated in the centre, here and there are small hills and clearings. Again and again one can discover bright crystal formations and in between, there are smaller rivers and lakes.

The Fae do not build any real cities, but inhabit trees, big mushrooms or huge snail shells. There are also tree houses and dwellings made of thick trunks. The Fae can shape wood and stone, so even large rocks may become houses. The Fae often decorate their glades and homes with flowers, tendrils and crystals. Many flowers, butterflies etc. indicate that the Fae are in close touch with nature. In addition, there are magical ponds and wells, mushroom circles and fairylike plants.

The Fae are mystical creatures that wield magical and elemental powers. They vary greatly in size and appearance. There are different kinds of fae like fauns, pixies, pookas, swan maidens and boogies. Most Fae are rather reclusive and live peaceful lives in their secret realm. They only leave this realm when it is necessary, i.e. in the case of existential threats to their island. In order to protect their home, they can get quite fierce and resolute. In Feyrist though they are mostly playful and cheery. They rarely use arms, but if they do, the weapons are made of wood and stone.

The Fae believe that they will die or that their secret realm will be destroyed if strangers enter the island. For this reason, they live very secluded and protect their realm with a magical barrier from the outside world. Strangers are rarely granted access. If at all, then only after proving their trustworthiness.
The Fae know much about humans, elves and dwarves, the beings from whose dreams they mainly arise. Therefore, these races are more familiar to them than orcs, trolls or minotaurs. They know them, but only very rarely they also arise from their dreams. Members of other races seem to be either unable to enter the island or immediately sent back through dream portals.]] },
		},
	},
	-- bookcase at 32690,31657,6
	{
		itemId = 18483,
		itemPos = { x = 32690, y = 31657, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Cenath were the most lucky of the elves. They lived in a hidden valley in a handful of cities, far away from the rages of war. As things turned bad for the elves much of their artifacts, artwork and books were brought to these cities. Live went on as usual for some time, the elves minding only their own business, as if pretending there was no war at all. Of course the war found them at last. In an frantic attempt to rescue their lives and even their accustomed way of life the elves begun to weave powerfull spells. Many of their best magicians litteraly 'burnt out' in the process but finally the elves succeeded. The whole valley was torn out of the known world ... And this was bitterly needed in a world that was only stormy darkness around the elven valley. They created a artificial light and even created weather. There they lived for hundreds of years, studying and practicing magic, mainly to manipulate and reproduce efects of natue to enhance their lives.]] },
			{ itemId = 2816, -- book
				text = [[
Then something happened. The dimension that harboured the elven valley began to collapse. Pice for pice their land was torn away and the wisest of the elves found out that the valley would ultimately 'fall' back in the world it belonged to. Great efforts were undertaken to prevent it. All were futile. As this was recognized it was almost too late. All magic was concentraded to preserve the lives of the elves. Protective shells were created, spells to deflect damage, enchantements to keep harm away. The 'return' was aweful. Almost half of the elves perished. All of the valley and its wonders were destroyed. Almost nothing remained. Artifacts and books shattered and burnt alike. The battered elves retreated and begun to wander aimlessly through the lands, until they encountered scouts of the Deraisim who led them to the safety of their woods. At first they were disgusted by the primitive lifestyle of their brethren, but soon they decided they had to guide and lead them back to true values of elvenkind. So one of their encampements was choosen as new home for the elvenkind and the city of Ab'Dendriel was founded.]] },
		},
	},
	-- bookcase at 32691,31655,6
	{
		itemId = 18483,
		itemPos = { x = 32691, y = 31655, z = 6 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Vampire Hunter's Handbook II
Vampires can be immobilised, also for a very long time, if the right method is used. If their physical body takes too much damage, it will go down. Sunlight will dry them out and even turn them into dust. If you drive a wooden object into the heart of a vampire, the flow of the vampire's tainted blood is stopped, leaving him completely helpless. It should be mentioned, though, that if the heart is partly missed or if the object is not large enough, the vampire might still be able to move.
Since a vampire is dead anyway, none of these methods allows to destroy a vampire for good. With enough time and blood, a vampire can recover from any of those seeming deaths. The only known way to permanently defeat a vampire is to kill him with a blessed stake. A blessed stake, however, is a rare object that cannot be obtained easily.]] },
		},
	},
	-- bookcase at 32691,31657,6
	{
		itemId = 18482,
		itemPos = { x = 32691, y = 31657, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Rise of the Pumpkin
After many wars and always new threats by the forces of darkness, humanity was afraid of many things. It was no cowardice but a gnawing fear that slowly eroded courage and faith. The servants of evil seemed to appear everywhere and in many horrible forms. Humans had grown accustomed to be afraid of the dark and the unknown. This weakened their resolve and with that also the forces of good. The gods came together to find a way to rise the spirit of humanity once again. They discussed and debated but could not come to an agreement because their views were too contrasting. And while they still deliberated, suddenly one of their least and minor creations stood amongst them. It was the lord of the rabbit race who had passed unnoticed by the mighty guardians. Without fear the little rabbit faced the gods who looked upon him in astonishment. Then the lord of the rabbits proposed his idea to the mighty and great gods. Since rabbits are tiny and their enemies are many, they are quite familiar with fear and how to handle it. So the lord of the rabbits came up with the idea to have the humans overcome their fear by learning to laugh in the face of evil. The gods were amazed by this simple but clever idea. So they chose the mightiest warrior of the rabbit race and bestowed magical powers upon him. The daring hare gained the protection of the gods and the power to disguise humans with hideous appearances of monsters. Each year, the hare would appear for some time and do his work. So the humans learnt to laugh and had fun while appearing as monsters, and the great fear that had darkened the souls of humans gradually vanished. This enraged the forces of evil and so they called forth the most malevolent spirit from the realm of darkness. It was his task to spread fear among mankind once again. The spirit was sent to take possession of the greatest living hero among the humans and to wreak havoc in the name of darkness. Unbeknownst to them, the lord of the rabbits had anticipated that the forces of evil would strike back. So he had sent some spies to the realm of darkness and learnt about their plan in time. He warned the humans about the approaching danger and once again had the right plan to save the day. He asked the humans to build a puppet clad in a shining armor and to put it on a throne in the midst of their festivities. As the puppet's head served a pumpkin with a carved face. The clever hare had figured that a spirit from the depths of the realm of darkness was not familiar with humans and would assume the figure on a throne in the centre of festivities as humanity's greatest hero. And indeed he was proven right when the spirit arrived and tried to possess what he assumed a human body. But the spirit had immense powers and so he finally managed to take possession of the pumpkin head on the cost of nearly all of his powers. With hardly any power left, the spirit made the pumpkin move and began to attack the celebrating humans. But the humans had long regained their courage and were not afraid to fight back. They drove off the evil pumpkin that escaped to some remote place where he was finally banished from the world. It took the spirit one year to regain enough of his strength to fight his way back into reality. He re-entered the world at the place of his defeat and to his shock and dismay he was no longer a spirit but bound to a pumpkin-like body. The beast roared in rage but could do little about it. Again he tried to wreak havoc in the world but again valiant heroes stopped his rampage and banished him for another year. Since this day on, the spirit returns every year hoping that one day humanity will be weakened enough for him to finally take revenge.]] },
		},
	},
	-- bookcase at 32692,31655,6
	{
		itemId = 18482,
		itemPos = { x = 32692, y = 31655, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The elves are able to manipulate their unborn children by some kind of dream magic. This magic changes appearance and personality slightly, allowing elven parents to give birth to 'wish-kids'. In their shared dreams the elven parents seem to sculpture their child like a piece of art. Though most of the dream magic of the past is long forgotten, this rudimentary magic seems to be natural to the elves. It is possible to 'choose' things like hair or eye color and even gender. Even slight changes of the physique are possible, though considerable changes take place in the span of generations. Wise men assume this ability was a 'gift' of the gods to make more adaptable tools for the elves' war. But the mentality of the elves did not allow them to form their children in a 'convenient' way. Since most of this magic is instinctual, they form their children in an aesthetic way. On the other hand, what is seen as aesthetic is based on the philosophy of the parents and so their background changes this view dramatically. This is even more evident in the castes that were separated in the war.]] },
		},
	},
	-- bookcase at 32693,31655,6
	{
		itemId = 18483,
		itemPos = { x = 32693, y = 31655, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
As intensely as the orcs hate all other races, they share a feeling of community. The orcs can sense, to some extent, the feelings of other orcs. The shamans develop this ability to such an extent, that they can sense the innermost potential of newborn orc whelps. All newborn are tested and the shamans decide a future function in orcish society. The whelps are fed differently, raised differently, and educated differently. Wise men of other races say that such behavior is similar to some insects, such as bees, and through their empathetic bond might share a kind of 'hive-mind', so they refer to orc communities as hives. The chief of a hive owns a big harem of women who have no other function than to pleasure him and give birth to new orcs. These orcish matrons are usually incredibly big and fat, almost not able to walk on their own. Where 'normal' orcwomen function as laborer and craftwomen and give birth to two to three orcs in their lives, these female orcs are only reproductive machinery, giving birth to about six whelps each half year. Orcs are usually contend with their place in orcish society and only the leaders fight each other on purpose. Rarely will an orc raise a weapon against another orc, even if they are not of the same hive. Rivalry between hives is usually dissolved through a fight of their leaders and the victorious hive absorbs the other one. Now and then, when a new strong warrior reaches maturity he challenges the old leader for a fight of supremacy. Sometimes though, when the hive becomes too big for the area it occupies, such a warrior senses somehow that its time to move on. Then he and a few other orcs leave the hive in peace to settle somewhere else. This unique culture, together with its fertility, makes the orcs the most formidable threat to all other tibian communities.]] },
		},
	},
	-- bookcase at 32693,31657,6
	{
		itemId = 18482,
		itemPos = { x = 32693, y = 31657, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Manasphere?

by Othis Ethna

I don't want to minimize the value of <name of First author>'s work. But to me it lacks any proof! Thus Ashkil's explanation is as good as the idea that the beings are producing the mana themselfes! And what about the "planet is surrounded"-statement? How should he know without leaving this planet? Either there's another (now lost) book that deals with the experiments and their results, or the whole "manasphere" is only an unproofable theory!]] },
		},
	},
	-- dead human at 32726,32010,6
	{
		itemId = 4240,
		itemPos = { x = 32726, y = 32010, z = 6 },
		contents = {
			{ itemId = 2818, -- document
				text = [[
Identification Card

Sir Fred Mothbone

Royal Explorer for the Kingdom of Tibia
under HRH Tibianus II.

Signed:
Maldir, town guard]] },
		},
	},
	-- bookcase at 32728,31975,6
	{
		itemId = 2435,
		itemPos = { x = 32728, y = 31975, z = 6 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Herbs and Plants of the Swamp, Volume I

Orange Star (stella flava)
A rarely found star-shaped orange-colored flower of amazing beauty. Commonly seen as a symbol of love.

Mushrooms
Mushrooms come in many different colors and shapes, at least ten different kinds are known.
They are documented in the newly published booklet "Mushrooms, nature's little jewels".]] },
		},
	},
	-- bookcase at 32729,31975,6
	{
		itemId = 2436,
		itemPos = { x = 32729, y = 31975, z = 6 },
		contents = {
			{ itemId = 2839, -- book
				text = [[
Herbs and Plants of the Swamp, Volume II

Blood Herb (herba budinia)
A plant with large, dark red-colored blossoms. 
It is nearly extinct due to its lack of strength - the herb can only survive in the shade, and often only by draining nitrates from trees, which die in the process. Therefore, those plants can been found near or sometimes even on the inside of dead trees.

Goat Grass (flos capre)
A low, nearly always four-leaved plant with yellow blossoms that grows in warm climate. It used to be the main source of food for the goats of the continent. However, later it was discovered to have a previously totally unknown poisenous long-term effect on the animals, and all goats died within two months.]] },
		},
	},
	-- bookcase at 32730,31975,6
	{
		itemId = 2437,
		itemPos = { x = 32730, y = 31975, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Wyrd Sisters
by Terry P.]] },
		},
	},
	-- bookcase at 32778,32327,6
	{
		itemId = 2435,
		itemPos = { x = 32778, y = 32327, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Self-Made Skeletons
By BH.]] },
			{ itemId = 2821, -- book
				text = [[
How to Manipulate Runes
by Muriel.]] },
			{ itemId = 2821, -- book
				text = [[
1000 Alchemical Uses of Urine
by Yorin.]] },
			{ itemId = 2816, -- book
				text = [[
Stylish Wizard Robes
by Sonne.]] },
		},
	},
	-- bookcase at 32779,32327,6
	{
		itemId = 2436,
		itemPos = { x = 32779, y = 32327, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Undead
by unknown.
]] },
			{ itemId = 2816, -- book
				text = [[
How to Conjure a Lag
by C.I.P.]] },
			{ itemId = 2816, -- book
				text = [[
The Ruthless Seven
by unknown

This confusing text seems to
describe the demonic rulers
of a place called the Pits
of Inferno.]] },
			{ itemId = 2816, -- book
				text = [[
Death - an Improved Form of Life?
by anonymous.]] },
			{ itemId = 2821, -- book
				text = [[
The Dragons
by Slygor.]] },
			{ itemId = 2827, -- book
				text = [[
The Astral Shapers are an extinct race that is mentioned in several texts of other races that also existed back then. Usually they are referred to as greedy imbuers which suggests that the other races harboured no love for them. Yet, their skills in charging items with magical energy must have been of some value to the others. It seems they prospered for a while, selling their craft. At some point though, the other races decided to take what they needed by force and thereby destroyed the entire race. Some texts hint that the Shapers preferred to sacrifice themselves and to detonate their forges, rather than letting them fall into the hands of others. Other forges were destroyed when trying to lift their secrets. Again others were dismantled by Shapers in order to protect them from the wrong hands. Some were simply stolen, only to learn that all but the simplest of them had stopped working. As for the Astral Shapers, they were used by their captors as some kind of magical truffle pig for a while. However, since their spirit was broken, the race as such perished and eventually died out.]] },
		},
	},
	-- bookcase at 32780,32327,6
	{
		itemId = 2437,
		itemPos = { x = 32780, y = 32327, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Famous Necromancers
by Muriel.]] },
			{ itemId = 2821, -- book
				text = [[
Fun With Runes
by an unknown jester.]] },
			{ itemId = 2821, -- book
				text = [[
The Magic of the Ghouls
by Paramor.]] },
			{ itemId = 2816, -- book
				text = [[
Spells Above MAG 30
by Lord Braggart.]] },
			{ itemId = 2816, -- book
				text = [[
The Secrets of Rune Magic
by Muriel.]] },
			{ itemId = 2816, -- book
				text = [[
Magic of Nature
by Marvik.
]] },
		},
	},
	-- bookcase at 32781,32327,6
	{
		itemId = 2435,
		itemPos = { x = 32781, y = 32327, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Language of the Wolves
by Ishara.
]] },
			{ itemId = 2816, -- book
				text = [[
My Life as a Spoon
by a victim of a bugged chameleon spell.]] },
			{ itemId = 2821, -- book
				text = [[
Rings of Magic
by S.

death ring
power ring
energy ring
might ring
life ring
time ring
...]] },
			{ itemId = 2821, -- book
				text = [[
Forbidden Secrets of Magic!]] },
			{ itemId = 2827, -- book
				text = [[
The Ferumbras Files

The followers of Ferumbras believe that in his early career, the ambitious Ferumbras acquired access to the shrouded library of Zathroth. They disagree, however, in the details on how exactly the vile Magician managed to do this. While some claim he was the favoured of Zathroth, others argue that he breached the library's defenses and somehow stole a part of the knowledge. Even in this the specifics are debated. An intriguing variant claims, Ferumbras once was the head librarian of the shrouded hoard. Once a kind and caring man, he became more and more obsessed with the knowledge in his care and the insights he gained turned him cynical and jaded. At some point his ambitions and power became too dangerous and he was expelled from the library. The most outlandish tales even make him a physical manifestation of forbidden knowledge. The story goes that Zathroth, who obsessively accumulated knowledge, did not care about it's containment. The knowledge was powerful though that mere books could not keep it and it seeped into the library, absorbed more and more forbidden knowledge until it became sentient and created itself a physical vessel that fled the library, later becoming known as Ferumbras. Based on the the few sources available, sages of that topic suggest that Ferumbras was the descendant of a member of the brotherhood of bones that fled and got into hiding after their forces suffered a major defeat. Ferumbras was supposedly raised in secrecy and taught in the ways and secrets of the brotherhood. Since this would not explain his immense power in one way or the other, Zathroth's library seems an all too easy and convenient explanation for his stellar rise to power. Others attribute this to his bloodline, which included the likes of Goshnar and dates back to the first magician kings of Ankrahmun who unified their people against the lizard threat.]] },
		},
	},
	-- bookcase at 32782,32327,6
	{
		itemId = 2436,
		itemPos = { x = 32782, y = 32327, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Flower Power
by Cipreii.]] },
			{ itemId = 2821, -- book
				text = [[
Strange Things Can Happen
by Magicus.]] },
			{ itemId = 2821, -- book
				text = [[
How to Create Spellbooks
by Muriel.]] },
			{ itemId = 2821, -- book
				text = [[
What Runes Are Made Of
by Muriel.]] },
		},
	},
	-- bookcase at 32783,32327,6
	{
		itemId = 2437,
		itemPos = { x = 32783, y = 32327, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Tales from the Crypt
by an unknown necromancer.]] },
			{ itemId = 2816, -- book
				text = [[
Vivisection Made Easy
by unknown.]] },
			{ itemId = 2816, -- book
				text = [[
Demons
Book I.]] },
			{ itemId = 2816, -- book
				text = [[
Demons
Book II.]] },
			{ itemId = 2821, -- book
				text = [[
Secrets of Zathroth
The Forbidden Book!]] },
		},
	},
	-- bookcase at 32833,32253,6
	{
		itemId = 2435,
		itemPos = { x = 32833, y = 32253, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
...send Almur with the new recruits to the dream master. If they can pass the test
they are worthy to become Nightmare Knights.
I don't think the Dream Challenge is too difficult.
We must keep our standards even in these times
of despair in which our enemies are numerous and our
ranks are thinned out! We...]] },
			{ itemId = 2821, -- book
				text = [[
The prophecies in our dreams become darker and darker with each month. The sages interpret it as omens about the falling of our order. If that is true, I only can hope that the world will remember us and our fight with gratitude and the people will have the heart to continue our work in some way.]] },
			{ itemId = 2816, -- book
				text = [[
It is certain now! We are doomed.
I have not the heart to tell it our remaining
brothers and sisters, but the dreams were
clear as seldom before: our order will be wiped
out by the hand of time soon.
But at least there is also some hope. The same dream that told us about our doom, hold a promise.
In Tibia's darkest hour our order will return and
once again battle the forces of evil; and a new
generation will lead our order to greater glory than
ever. May those who will come not fall prey to the same evil as we did.
]] },
			{ itemId = 2816, -- book
				text = [[
...
115 gold food
5000 gold runes and fluids
4205 gold equipment
3789 gold weapons and repairs
1000 gold 10 fire bugs for Dream Challenge
355 gold ammunition
4000 gold books and paper
...]] },
			{ itemId = 2821, -- book
				text = [[
For our deeds for king and country, the king granted our order the Eastern lands. The city under our protectorate is growing and will soon be as big and as beautiful as our capital. But there is much work to do and countless monsters to slay to bring peace to the green planes. Some days ago, Falnus vanished and we must reckon that he is dead, probably murdered by the brotherhood. Of course even a mage of his power could have been slain by a greater number of creatures as dangerous as giant spiders that still roam these plains. It's a hard blow to our researches in the arts of healing and recreations and the loss of a great man.]] },
		},
	},
	-- bookcase at 32834,32253,6
	{
		itemId = 2436,
		itemPos = { x = 32834, y = 32253, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Today our scout party returned from the city of the minotaurs. As we were told in our dreams, they are not our true enemies. There is a secret power behind their attacks, filling their hearts with lies about the other races. Someone or something is abusing them. Even though their attacks are surly just a diversion for something far more sinister and dangerous, our dreamers can't figure out the true cause for all these fights. I think it is crucial to parley with high ranking minotaurs about a truce. If we don't stop to waste resources on this useless war, we won't be ready for the real attack of the enemy.]] },
			{ itemId = 2816, -- book
				text = [[
May Banor bless our souls.
May the kiss of Kirok bring us inspiration.
May Fardos give us the force of will to forge our souls to tools of good.
May Crunor protect our health and essence.
May Uman teach us to use his gifts and to use them wisely.
May the archangels guide and guard us.]] },
			{ itemId = 2816, -- book
				text = [[
The time of war is at hand. 
At last we will face Goshnar the evil one! 
The man that was formerly known as my 
brother Falnus betrayed our order, humanity and the gods. We will punish him and his unholy allies. 
Now there is no truning back. We will fight and there is just death or victory. Surrender or truce is no option! 
Even if the seven are on his side we will win at last and may it cost the lives of all of us! 
No mercy for evil! 
With sword and magic, 
with honour and virtue, 
for king and country!]] },
			{ itemId = 2821, -- book
				text = [[
We changed this remote monastery into a small fortress to guard our new secrets. There is much to learn and by now we only understand little of the secrets the elves have taught us. Our dreams are not bright and revitalising as the ones the elves told us about but full of dark omens. We have to learn how to interpret them adequately. The green plains in which we reside are sometimes dangerous. Therefore, we will soon allow fighters to join our group. Some suggested to form a formally order to further our cause. The conclave will discuss this in the next meeting.]] },
			{ itemId = 2816, -- book
				text = [[
The sorcerers insist that the Knightwatch Tower is a powerful tool for our order. I don't understand what they are talking about but the conclave has ordered to spend more of our resources in the construction of the tower. I think the whole idea of building our bases here and not near the city is a bad idea. Regardless of what they think, the dreams might tell about the significance of this place. I don't see anything to guard here and I wonder if there is something to guard at all. Our presence here just draws unwanted attention to this place. Settlers have already built a little outpost west of here; as if we had not already enough to do without the extra burden to protect them.]] },
		},
	},
	-- bookcase at 32835,32253,6
	{
		itemId = 2437,
		itemPos = { x = 32835, y = 32253, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Dream Challenge is completed now.
I am glad to be a member already, I doubt I could pass this test myself.
Although most problems have to be solved by intellect, the demons they  summoned frighten me to death. Maybe we had to add something like this to ensure that no one passes the tests just by being told how it works. Still, adding a bunch of powerful monsters seems like madness to me. As if Hugo wasn't dangerous enough already!!
I wonder where this all might lead us ...]] },
			{ itemId = 2821, -- book
				text = [[
We tracked Goshnar's daughter to the gates of Carlin but lost her within the city. Of course we got no help by the 'authorities', so I think she could hide there somewhere. It's likely that the brotherhood of bones has agents in the city that gave her shelter. We think she doesn't know her father's secrets though. Her magic tricks seemed quite ordinary to us. I can't say whether the rumour that she is pregnant is true. If so, nothing is known about the father of this child. Considering that Goshnar was allied with darkness we must fear the worst. So the search for Fermubras continues.]] },
			{ itemId = 2821, -- book
				text = [[
Our studies on the source of our dreams are not conclusive. The elves are no help in this matter. I doubt they even understand what we are asking them about because their dreams are so different from ours that there are almost no similarities.
Some of our dreams are prophetic and a great help in fighting the evil. Some are so dark and desperate that they ruin the moral of the dreamer. Others are seductive and evil and try to lure the dreamer to the dark side. Only the weak fall prey to that seduction and that makes efficient testing of candidates important. So we will continue to use the dreams as guidance but have to remain vigilant for the sake of our spirits and souls.]] },
			{ itemId = 2816, -- book
				text = [[
The weapon trainer is not pleased with the progress of the mages. The bodies of the sorcerers and druids are not trained enough to stand his lessons as long as they should to improve adequately. On the other hand, the knights and the paladins adopt to the ways of magic too slowly to see any progress above a certain given point. So we will stick to the concept of the four ways and drop the idea of the warrior-mages for now. Perhaps in the future we might find another way to combine the skills of arms and magic in some way.]] },
			{ itemId = 2816, -- book
				text = [[
At last we trapped Hugo in the dungeon cellars!
The beast killed two dozen of our members in a wild chase.
After a painful and long hunt, our mages kept Hugo occupied with some summoned dragons that distracted him long enough to prepare the trap. When Hugo followed the 'track' we laid for him, our druids trapped him with plant barriers and then moved earth around him. Now the beast is trapped. May Fardos, Uman and Banor give that we can keep him satiated and calm by using the trick the druids figured out. Our aspirants will have a hard time to pass the test that was created around this beast.]] },
			{ itemId = 2816, -- book
				text = [[
The Dream Challenge is far too easy, all riddles can be easily solved if you have some knowledge about our ways, are a good observer and use your brain. Therefore, the conclave decided to add some real danger to the test to make it a real challenge. The major problem by now is the Circle o.L. since it often requires a quest for the candidates, but that will change soon if the monsters are added as the conclave decided. I guess the knights who cried for this kind of challenge will get more than they bargained for.]] },
		},
	},
	-- bookcase at 32939,31459,6
	{
		itemId = 2435,
		itemPos = { x = 32939, y = 31459, z = 6 },
		contents = {
			{ itemId = 641, -- piece of paper
				text = [[
<this is a ripped page, probably from a diary>
IV. 20th
Since we've moved into this house, we barely had any contact to the other citizens of Yalahar. However this has changed during the last week. People are getting suspicious of Arthei - some saw him after the explosion and know that his sudden recovery can't have happened in a natural way. And they are starting to talk... what makes matters worse is that some murders have occurred since Arthei's recovery. I don't know any details or what exactly was the cause for their death, but I can't stop thinking that Arthei might have something to do with it. His nightly excursions... the state he is in... and it seems that I'm not the only one who thinks that way. As I said... people are starting to talk...

IV. 22th
I don't know how long we can stay here. People whisper with each other and stare hatefully at Lersatio, Boreth and me when we cross the street. I really want to protect my brother, but I'm very scared.

IV. 25th
On the ocean again... this night, we were almost killed by a mob who banged at our door with the obvious intention to remove what they consider a threat to their lives. Well... I can't blame them... we pulled struggling Arthei out of the house and with us, and now we're out at sea on the small boat we arrived in. Luckily they didn't destroy it before they came for us. Please, let us find land... I guess that means back to square one.]] },
		},
	},
	-- bookcase at 32945,31446,6
	{
		itemId = 2438,
		itemPos = { x = 32945, y = 31446, z = 6 },
		contents = {
			{ itemId = 641, -- piece of paper
				text = [[
<this is a ripped page, probably from a diary>
IV. 26th
Finally, luck is on our side again! Just a few hours to the east we found another island - and it's beautiful! Grass, flowers, mountains in the distance and enough natural resources for a fresh start.

IV. 28th
Things are getting even better - on the hill east of the grassy area we found what seems to be an abandoned mansion. We spent some hours clearing all the spider webs and now it is quite a good place to stay in. Fate smiles on us! Ever since we found the mansion, Arthei has locked himself into one of the rooms, though. I hope that he will eventually recover in this peaceful environment.

V. 2nd
We made ourselves a home in the mansion and try to farm the land. I think if we can cultivate crops and vegetables, this place will be simply perfect for us.

IV. 10th
Not much success yet. The land is very dry, drier than it seemed when we arrived. We also haven't seen Arthei for a few days.

IV. 20th
This must be... a curse? The grass is withering... the water is getting muddy... even the hill seems stonier, although common sense tells me that this is not possible. What's going on here?]] },
		},
	},
	-- bookcase at 32960,31456,6
	{
		itemId = 2435,
		itemPos = { x = 32960, y = 31456, z = 6 },
		contents = {
			{ itemId = 641, -- piece of paper
				text = [[
<this is a ripped page, probably from a diary>
IV. 8th
This is not good at all. At first we were all so happy about the miracle of Arthei's recovery that we didn't care about anything else, but now, some... side effects have appeared. Arthei has never looked as pale as now and he hardly speaks a single word. At least he still knows that we are his brothers, but he doesn't seem to recognise Kala, his wife. This is incredibly hard for her because she was really doing anything in her might to help him get better. And now that he is well again, he is very distant. He calls her 'that woman' and doesn't let her into his room. God, this is so bad. We are hoping that this is only a mood swing or some sort of amnesia that will pass over time...

IV. 12th
Kala is gone!! Oh, what horrible times are those. In her sadness, and confronted with Arthei's constant rejection, she must have left the house last night. She left almost all of her belongings. We are so worried about her... and hope so badly that she didn't decide to throw her life away as desperate as she has been. Arthei didn't even notice... and when we told him, he just shrugged his shoulders. She doesn't deserve this... she is such a sweet and caring woman. We have been looking all over the city for her - in the accessible parts that is - but couldn't find her. I will look for her later again.

IV. 13th
Kala remains missing... and Arthei seems to sneak out at night too, although he is always back in the mornings. I only noticed because I was getting up from my bed to fetch a mug of water, when I saw him closing the front door. What is he doing outside at this time? And, come to think about it, he has never left the house or even his room during daytime ever since he recovered. What has happened to him?]] },
		},
	},
	-- bookcase at 32961,31471,6
	{
		itemId = 2435,
		itemPos = { x = 32961, y = 31471, z = 6 },
		contents = {
			{ itemId = 28483, -- torn book
				text = [[
II. 28th
Today my brothers and I are leaving from Carlin to find a new place for us and our families. None of the great Tibian cities have made us feel at home yet. There must be something else, and we will find it.

III. 5th
We've been at sea for a few days now. Time seems endless, and so does the ocean. We have supplies for 3 more weeks. Should we not find land within the next week we will cancel our expedition to make sure we get back home safely.

III. 8th
Still nothing... but the screams of seagulls and the sound of the waves... we are still hoping.

III. 10th
We've spotted land! It's still a day away, but it seems to be a really large island. Not only that, we can also make out tall towers in the distance. Strangely though, this city - or whatever it is - can't be found on our map, despite its obvious size.

III. 11th
We've arrived at the harbour of Yalahar, as the inhabitants call it. Obviously large parts of the city are destroyed and closed for the public. We will stay in a tavern tonight - finally, a bed again! - and then try to find a place to live in.

III. 14th
Finding a house seems to be harder than expected. The inner city of Yalahar which seems safe and rather wealthy has almost no place left, especially not for outsiders as us. Maybe we can live in one of the outer quarters, close to the city walls at least.

III. 18th
Lersatio found an unoccupied house not too far away from the centre. It is close to an alchemical lab. Maybe we can even find some work there. Things are looking great!

III. 20th
We've settled down and started the repair work on the house. This may take a while, but we are sending note to our families to come after us. Arthei's wife Kala insisted to come with us right from the start, so they are already together, but I am starting to miss my girl immensely. Oh sweet Melava, I hope you are well.

III. 21th
This place is not as good as it seemed. The closeness to the alchemical laboratories proves to be a constant menace and now I understand why they didn't want it in the centre. Frequent explosions are startling us during the whole day, and even at nighttime there is a lot of noise from the facilities. Due to these circumstances we will probably try to find another place, luckily we haven't put too much work into the house, yet. Also, our families won't come, yet.

III. 30th
Oh god... something horrible happened and I've not been able to write for a while... a week ago there was a HUGE explosion in the night... fire spread upon almost all houses nearby... we barely escaped the flames... my hands are burnt, because I pulled my brother out of the burning house and we all are still coughing grey substance... Boreth and Lersation got out with some scratches and burns, but otherwise we three are fine. It's just Arthei... he got burnt really badly... I barely recognise his face... Kala is sitting at his bed 24 hours a day with red swollen eyes and praying for his life. When she falls asleep in exhaustion we are keeping watch.

<from here on, all of the pages have been torn out, only the last page remains:>

THE FIRST DAY OF ETERNITY
I CAN SEE NOW. FOOLS. ALL OF YOU. HAHAHAHAHA.]] },
		},
	},
	-- bookcase at 33144,32840,6
	{
		itemId = 2438,
		itemPos = { x = 33144, y = 32840, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Tales of a Stranger, Part I
It was in a time of dread that a stranger came to our lands. More dead than alive was he when he was found in the desert, and the merchants who found him took pity on him and brought him hither. But how great was the amazement and the wonder when it turned out that he wore a birth-mark on his neck that looked exactly like a scarab! The crowd was struck with awe, and it was soon decided that he was to be taken to the priests, so that they might ask the gods for an omen. And so it came that while the man was still lying in a slumber full of delirious dreams the priests burnt incense and performed the ancient rituals to ask the gods for advice and for guidance. The high priest climbed the highest pyramid and called for the knowledge of the wind and the wisdom of the sand. For three long days the stranger was caught in the perilous lands that separate life from death, and for three long days the priest was haunted by visions. But when those days had passed, everything changed. All of a sudden the stranger opened his eyes and looked around in amazement, and it was that very moment that the delirious priest began to utter a prophecy.]] },
			{ itemId = 2816, -- book
				text = [[
Tales of a Stranger, Part II
But since there were only acolytes there the nature of the prophecy was kept a secret by the priests. They called for the stranger, who seemed to have lost his memory, to be brought to the temple, where they talked to him and asked him all kinds of questions. But much to their dismay he could not give them the answers they sought, for his memory seemed to be blank like the surface of the desert after a sandstorm. However, the priests had the wisdom of the secret prophecy to guide them, and so they knew that they had to give the strangers five tasks to fulfil before they could reveal his destiny to him. And so they did, and the stranger swore he would fulfil all the tasks or die in the attempt. His first task was to travel into the desert and to find the eldest of the scarabs there, so that the priests would reveal their wisdom to him and fill his empty mind with recollections. The stranger descended deep into the burrows of the scarabs in order to face their judgement and to find answers that had been lost in the desert sand aeons ago. But the stranger never returned.]] },
		},
	},
	-- bookcase at 33144,32841,6
	{
		itemId = 2439,
		itemPos = { x = 33144, y = 32841, z = 6 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
... were sealed with powerful magic. Only those were allowed to pass who sacrificed one of the peculiar coins that in ancient times were paid by those who came to visit their beloved dead. For this was the way of the Ritual of Sealing. Behind the seal, the mighty traitors were trapped forever. Such was their hatred and their lust for revenge that the very walls and stones became imbued with them and the lower tombs turned into places of utter doom, places where no mortal should venture to go. And to this day one of the traitors lurks in each of these tombs, surrounded by vicious traps and by powerful minions that serve both to protect them and to hold them captive. Woe to the fools who dare challenge the traitors in their prisons! For torturing and killing intruders is the only amusement that is left to these tortured souls.]] },
		},
	},
	-- bookcase at 33144,32842,6
	{
		itemId = 2439,
		itemPos = { x = 33144, y = 32842, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
While travelling to the lands of Thais the princess Tahmehe, who accompanied her father Uthemath on a diplomatic mission, fell in love with a young nobleman of the empire. Although it was a forbidden love it bore fruit, and seven months after Thamehe's return to the lands of her forefathers a child was born. Pharaoh Uthemath ordered that she and her newborn baby were to die in the arena. Four behemoths were let loose on her. But just before the raging monsters could put their claws on her a flying carpet swept down from the sky and rescued both the mother and her child. The Thaian nobleman - for who else would it be but him - somehow managed to evade the hails of arrows that greeted him, and so the couple managed to make their escape northwards. The pharaoh demanded that both the nobleman and his own unfaithful daughter be handed over to him, but the Thaian king claimed he had no knowledge of their whereabouts. So the trace of the traitorous daughter was lost.]] },
		},
	},
	-- bookcase at 33144,32843,6
	{
		itemId = 2440,
		itemPos = { x = 33144, y = 32843, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
... After we reached the site we pitched camp. The next day we started the excavations. It was hard work. The sand was treacherous and obstinate, and for every bucket we took away two more seemed to take its place. Sometimes we hit upon something valuable by pure chance, but usually it took hours to find some lucrative spot because you could never tell if a site was promising without having performing extensive excavations first. And still the real thing eluded us. The remnants of the legendary cities of old seemed lost to the desert. But we carried on, working day and night, digging at the same spot over and over again. Progress was painfully slow, but in the end hit on something. What we found proved to be an adequate reward for our hardships.]] },
		},
	},
	-- bookcase at 33145,32864,6
	{
		itemId = 2435,
		itemPos = { x = 33145, y = 32864, z = 6 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Mehrah asram cha mehe than. Uth a'thul at cha there. Orum tha cha elik jahara. Udhun zah fahr mal. Chamek at uthul hatradek asram. Mehrem alir iktha at uthun. Kasin tha Ur ch helim doh. Mah dah direm. Athul as hathu, athul as dofah, athul as mereth. Cha ukhtu muhn dahra. Sethor mah amin dah. At meruhm cha me dah. Chamek persim kaharah bah tufi. Moh dah rah. Moh Udhin cha uthul. Meheth Zuhl tha berah.]] },
			{ itemId = 2820, -- sheet of paper
				text = [[
Researchpaper 74-08 G
We haven't yet managed to improve the 'find person' spell. However, we are still convinced that in theory it must be capable of divulging additional information such as the experience and power of the targeted persons as well as their general physical condition and the chemical composition of their last supper. There are numerous problems, though, and it is well possible that we have to start all over again. This would mean, of course, that we would have to create some spells to obtain information by means of magic which is plain to see when you are close to the targeted person. One might argue that it is a waste of time and resources to develop such a spell, but then I see no other way to create a similar spell that features enhanced range and a combination of effects.]] },
			{ itemId = 2820, -- sheet of paper
				text = [[
Researchpaper 35-22 D
The 'Foeburner' spell still is not working. Somehow it seems impossible to specify a group of targets to be excluded from the area of the spell effect. If only we found a way to use a spell or a spell-like ability to define non-target groups we could finally make the spell work. For now, however, we have stopped the research because we felt it is necessary to create the groundwork for future research in the field. The question is: Should we focus on working out a special definition spell, or is it actually possible to weave some sort of divination spell into the pattern of the foeburner in order to receive a satisfying result with a single spell. I am somewhat inclined towards the latter option because of the satisfactory results we have recently achieved in the field of divination magic.]] },
		},
	},
	-- bookcase at 33145,32866,6
	{
		itemId = 2438,
		itemPos = { x = 33145, y = 32866, z = 6 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
The Larokhon are entities made up entirely of wind and of heat. They appear to be nothing but mere blurs in the sand, and those who are unfortunate enough to see them believe their eyes just played tricks on them. But then, the Larokhon are rarely ever seen by mortals since they shun daylight. They prefer those twilight moments when there is still some warmth left from a scorching day although night has clearly fallen. This is the time when the Larokhons' move from their secret hideouts to prey on unwary dreamers that are haunted by nightmares. Their sense of smelling fear is infallible, and once they have found their prey a mere crack in a wall is large enough for them to enter. Once they are close to their victims they feast on their innermost fears, evoking images of horror and despair that are so horrible that they often cause the dreamer's death. So take this word of warning, traveller: Beware the nights that are hot and windless, for a mere breeze of hot air may cause your demise.]] },
			{ itemId = 2821, -- book
				text = [[
...so Morgathla revealed to him one of the secrets it was guarding, a secret that had been thought lost for a long time. And Arkhothep forged the parts of a powerful mask and assembled it on a demon altar. He had secretly erected this unholy shrine underneath the great pyramid he had planned to use as the final resting place for his father. So strong was this altar's magic that it fused the parts to form the famous Helmet of the Ancients as soon as they were placed on it. Eight helmets Arkhothep crafted, one for himself and one for each of his allies. But he did not fully trust his fellow conspirators, so he inserted ordinary rubies into their helmets, while his own helmet was imbued with the eternal power of a soul ruby. This way those helmets had only a fraction of his own helmet's powers. But Arkhothep's precautions against his allies went further than that. He only revealed the secret to forge one single part of the helmet to each of them, and each of them was taught the secret to forge a  different part. Arkhothep clearly saw through his allies' greedy natures. He knew they would never share their knowledge with each other, and he foresaw that their greed would make them plot against each other rather than against him.]] },
		},
	},
	-- bookcase at 33145,32867,6
	{
		itemId = 2439,
		itemPos = { x = 33145, y = 32867, z = 6 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The secret of the high mask of the ancients was thought to be lost in time forever. But with the coming of the undying pharaoh its secrets were snatched away from the scarabs and the sands. Once more, masks were forged that contained the secret energies of lost aeons. Their true powers remained a mystery, but from the little that showed at first glance it was clear that they were most powerful indeed. Unfortunately, the pharaoh decreed that their powers were not meant for ordinary mortals, and ordered them to be destroyed. It is said that it was necessary to combine the powers of different ancient idols in order to create those legendary artifacts.]] },
		},
	},
	-- bookcase at 33145,32868,6
	{
		itemId = 2440,
		itemPos = { x = 33145, y = 32868, z = 6 },
		contents = {
			{ itemId = 2820, -- sheet of paper
				text = [[
Resarchpaper 88-04 F
On the request of our beloved pharaoh we have stopped the research on the XXXXXX spell. All research was destroyed, and although we had met with considerable success in XXXXX the XXXXX and even seemed to have a solution for the problem of the plasma leak the project has been discarded. Even the side reports were destroyed. An apology has been issued to the pharaoh for thoughtlessly researching in that field.]] },
		},
	},
	-- bookcase at 33145,32870,6
	{
		itemId = 2438,
		itemPos = { x = 33145, y = 32870, z = 6 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The great pyramid is the centre of our beloved city. It is there that our praised pharaoh resides, surrounded by his trusted servants. Far below the palace, hidden in the deepest dungeons of the ancient pyramid are the tombs of despair. The old pharaoh met his fate there, and it is said he still roams the hidden passageways, bound forever to his undead body. So great was the wisdom of Arkhothep that he granted his father eternal unlife, so that he may to atone for his sins and become worthy of ascension. Who knows? Perhaps one day he, too, will ascend, leaving both the curse and his tomb behind him and taking his place at Arkhothep's side. But I fear his folly defies all attempt to cure it. He has proved unyielding to the wisdom of his son's preachings for as long as I can remember. Long will be his road, and a million deaths he shall die before he will see the light of the wisdom that will free him from his prison.]] },
			{ itemId = 2820, -- sheet of paper
				text = [[
Research paper 77-04 D
The 'move earth' spell seems to be ready to enter the stage of field testing. The results so far were quite convincing, and the priests were pleased. The recent studies we have carried out together have proven that we can indeed learn from each other. I must admit I would certainly like to add this useful little spell to my personal repertoire. After all, shovels and pickaxes are heavy and pretty unwieldy, and I would very much like to leave them at home. I envy the priests for the elemental powers they are wielding.]] },
		},
	},
	-- bookcase at 33146,32864,6
	{
		itemId = 2437,
		itemPos = { x = 33146, y = 32864, z = 6 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The lamp of Tazur was made of finest gold by the most skilled goldsmith of the land. He bound one of the mightiest and most evil djinn into it. The djinn was forced to do his every bidding. Using his power the artisan defeated legions of enemies. He even travelled to distant Drefia which in those days was at the zenith of its glory, and he met many necromancers who were willing to share their knowledge with him. This way he became even more powerful. Using stolen lifeforce he lived longer than any man was meant to live, and with his own eyes he saw the might of his necromancer allies decline. Legend has it that one day the djinn of good decided to stop the outrageous cabals of Drefia. Other stories say that it was in fact the evil djinn who saw their power threatened by it. Whatever the true cause might be, one night a star fell down from the sky and smashed most of Drefia, breaking its evil power forever, and the goldsmith finally met his fate. His most prized treasure, the lamp of Tazur was lost that night. It is said that it is still there somewhere, hidden on the ocean bed, waiting for a new owner.]] },
		},
	},
	-- bookcase at 33148,32864,6
	{
		itemId = 2435,
		itemPos = { x = 33148, y = 32864, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The lost garden
Princess Maharuh was said to be the kindest creature that ever walked the earth. She was dearly loved both by her people and by the djinns. One day as the princess wept because of all the pain and the evil ways of the world the djinns came to comfort her. And since they loved her so much they called upon their powers to grow a garden of magnificent beauty. From now on, Maharuh visited her enchanted garden whenever she was sad, and she never went there but a smile came to her face, and she found new strength to continue her work with renewed vigour and inspiration. But humans grow old and weary, and time did not fail to do its cruel work on fair Princess Maharuh. As she grew old her visits to the garden became less and less frequent and one day when she laid down to rest underneath her favourite tree she never woke up again. The garden was perhaps the most valuable thing she left behind, and it was certainly the one she had held dearest while still alive. But her people did not share her love for nature's beauty, and all they saw was a splendid example of horticulture that could be turned into money. Soon after her death a merchant caravan came, and the strangers offered great sums for the garden and for all that belonged to it. They dug out the trees and took the fruit because they believed they could rebuild the garden in their native land. However, soon after the caravan had left the city a terrible sandstorm arose. After the storm had cleared the caravan was gone and with it all that was left of the garden.]] },
			{ itemId = 2820, -- sheet of paper
				text = [[
Researchpaper 56-09 A
We lost three mages in our last attempt at performing a controlled demon summoning. It is still too difficult to predict in what way the fabric of time and space is affected by the breach of the sphere, and from what we have seen the backlash of nature against demonic incursion can range from a slightly offensive odour to a sizeable explosion such as the one we saw yesterday. I am personally disappointed to observe that the elemental protection spells we put up did not work at all. Perhaps there is some truth in the reports that the unleashed energy is of purely entropical nature. We have yet to decide whether or not it makes sense to create an entropic counterspell first, but I support the idea that the loss of manpower while trying to balance the spell is manageable. It is possible, though, that this will lead to no convincing result at all due to the uncontrollable nature of the demonic realm. If this should be the case the use of entropic countermagic is the only option left.
By the way: The summoning of lesser creatures, the so-called 'reds', progressed comparatively well. Of course, these creatures are mere borderdwellers and may consequently not be considered true demons. However, it may prove that the development of summoning spells for 'reds' will prove a rewarding spin-off of demon summoning research.]] },
		},
	},
	-- bookcase at 33149,32864,6
	{
		itemId = 2437,
		itemPos = { x = 33149, y = 32864, z = 6 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
Suns and Stars, Part I
It stands to reason that the stars and the suns influence the flow of magic. The astral patterns wax and wane like the tides, and it is not possible to perform certain summonings on inappropriate days, to give but one example. The study of astrology is pointing at further influences that go well beyond summoning creatures, though. For instance, the influence of the stars and the suns seems to increase with the power level of the performed incantation or ritual. The more mana is used in a spell the more it is susceptible to extratibian influence. For this reason it seems quite safe to assume that certain powerful rituals are only possible when the stars are correctly aligned. We consequently hope to achieve through close observation and through careful calculation a measure of exactness concerning the right timing of rituals which we did not dare dream of so far. Several magic incantations we have never managed to reproduce until now might actually be achieved once we know the ideal stellar constellations. This would explain why all our previous attempts to achieve these effects were doomed to fail.]] },
			{ itemId = 2829, -- book
				text = [[
Suns and Stars, Part II
Very basic rituals depend on the influences of dawn and dusk, or of night and day. Other, more complex rituals may only be performed at very specific times, perhaps even at a specific hour. Other rituals that are more complex still are bound to specific days, and to specific times as well. In fact, some individual spells can only be performed once a year or once every other year, while the most powerful of rituals may only be carried out during stellar constellations that are so incredibly rare that centuries may pass before the ritual can be performed again. Given the power and knowledge of the ancients it seems reasonable to assume that they have prepared rituals whose time has not even come to this very day. Since most of the ancient races have disappeared from the lands it is well possible that some of the rituals are still be buried in some long forgotten ruin, while others might actually be in the possession of some surviving heir of one of the ancient races.
Who knows. The astrological knowledge of the ancients is yet to be rediscovered. We are perfectly positive that some of the discoveries we have made can be considered as the groundwork for further, more elaborate theories which one day might rival that of the ancients. Still, it would be an immense progress if we could rediscover some of the ancients' lost astrological writings.]] },
		},
	},
	-- bookcase at 33151,32864,6
	{
		itemId = 2435,
		itemPos = { x = 33151, y = 32864, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Ancient mummies are fiends of horrendous powers. Only the bravest warriors dare to challenge them, and most of these fools join the ranks of the mummie's undead legions all too soon. In life, each of these ancient horrors was a champion in his own right, but now that they have entered the dreadful state of undeath they have become truly formidable, for there is no way to kill them for good. No matter how hard they are hit the ancient powers bound to their mummified bodies will always make them rise again in all their horrifying glory to take revenge on the living.]] },
			{ itemId = 2820, -- sheet of paper
				text = [[
Researchpaper 33-16 H
The 'stoneskin' spell is still flawed. The test subjects complained about severe problems when moving, and some actually suffered from partial paralysis or even from acute petrification! However, I still believe the spell might be useful as some sort of emergency measure because I imagine that turning oneself into a statue for a while might come in handy when all other options have failed. Oddly enough it is quite simple to focus the spell into an object, preferably an amulet, so the change is still bound to an object that serves as a transmitter. Obviously the problem is related to the one we had when we tried to channel certain spells through runes. I'm afraid that while research covering spontaneous magic has made great advances since the early days we are still at the beginning when it comes to channelled spells.]] },
		},
	},
	-- bookcase at 33155,32841,6
	{
		itemId = 2439,
		itemPos = { x = 33155, y = 32841, z = 6 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The tibian world-wonders!
The known and acknowledged world-wonders are:
The colossus of Kazordoon
The black pyramid of Draconia
The great lighthousetree of Ab'Dendriel
The thorntower of Shadowthorn
The underground city of Mintwallin
The black city of skulls in Hellgate
The great lava falls in Hellgate
The pyramid city of Ankrahmun]] },
		},
	},
	-- bookcase at 33155,32842,6
	{
		itemId = 2439,
		itemPos = { x = 33155, y = 32842, z = 6 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
Rahmen Tah and the Vizier, Part I
In the second year of the reign of pharaoh Rahmen Tah there was a vizier who was said to consort with demons and to tamper with the powers of oblivion. He lived in a majestic tower that stood on a little island close the harbour. It was a marvel to behold, made of black glass and gold, and everybody who looked at it was filled with an eerie sense of foreboding. The vizier was rumoured to be so powerful that no one dared to bring him to justice. Even Rahmen Tah himself feared the power of his vizier, and he did not dare to send troops against the vizier. Finally he called for his chief astrologer and mathematician, the wise Athem, and asked him for advice. Athem listened quietly to the words of his pharaoh. After he had finished Athem ask his pharaoh for some time to think everything over. Reluctantly the pharaoh agreed.]] },
			{ itemId = 2828, -- book
				text = [[
Rahmen Tah and the Vizier, Part II
After a week had passed the mathematician returned. His advice was this: The pharaoh should order a huge celebration to be held, and all pyramids should be adorned with flowers and flags. The pharaoh who trusted in the wisdom of his advisor ordered his people to prepare for the celebration. While the people did as their pharaoh had ordered them to do Athem began to build a huge wooden machine on top of the royal pyramid. No one took much notice of it because of the preparations that were going on. On the fourth day when the celebration was scheduled to start the pharaoh sent an invitation to his vizier and asked him to join in their festivity. As Athem had foreseen the vizier declined because he suspected that there was a trap. Instead he sat in the observatory at the top of his tower and watched the city because he wanted to find out what the pharaoh was up to. Too late did he understand that the construct on top of the pyramid was in fact an enormous catapult. Suddenly a huge boulder was hurled in his direction. The shot had been perfectly calculated, and it hit its mark with amazing precision. The top of the dark tower shattered and the evil vizier was crushed underneath tons of basalt. His death caused the dark magic to disappear, and the tower sank into the ocean forever.]] },
		},
	},
	-- bookcase at 33155,32843,6
	{
		itemId = 2440,
		itemPos = { x = 33155, y = 32843, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
And so the conspirators met again in secrecy to plot the pharaoh's fall.

This time their target was to be their former leader and fellow conspirator, Arkhotep.
They met in an abandoned crypt they believed to be forgotten and unknown to Arkhotep.
And once again, all were there. Once again, the seven were united.

Morguthis, the never-defeated general. A lethal and merciless warrior consumed by irrepressible rage.
The vain Vashresamun, the pharaoh's notorious concubine burning to avenge her hurt pride. 
Mahardis the mage, a pyromaniacal madman who fooled the princes of elemental fire to steal the secrets of the flame.
Diptrah the high priest, master of the mind, wielder of secret powers, keeper of the oldest of rituals.
Rahemos, the greatest conjurer of his time. He recklessly summoned unspeakable abominations and made them do his bidding. 
Thalas, the foremost alchemist, master of poison, death and decay. Chief tormentor of the realm. His ghastly experiments cost the lives of countless unfortunate victims.
And Omruc, the dreaded hunter and assassin. None of his victims ever saw it coming, and none of them ever escaped.]] },
		},
	},
	-- chest at 33272,31838,6
	{
		itemId = 2472,
		itemPos = { x = 33272, y = 31838, z = 6 },
		contents = {
			{ itemId = 9204, -- old pirate poem
				text = [[
Set the sails to the carved tree
the head of a dragon south shall it be
34 feet in the line to the west
the next one goes under arrest
the master's secret must be revealed
to open the path that once were sealed]] },
		},
	},
	-- trunk at 33360,31345,6
	{
		itemId = 12642,
		itemPos = { x = 33360, y = 31345, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Dragons Ought Be Tamed II

(A complete treatise on several types of dragons and various methods of taming them. It ranges from putting eggs and honey under your pillow before going to bed to building a giant cage with animals as lure. The book seems to be more of a fantasy than a real guide and it's unlikely that any of these instructions would actually be successful. However, someone added numerous notes and comments on]] },
		},
	},
	-- bookcase at 33649,31884,6
	{
		itemId = 6367,
		itemPos = { x = 33649, y = 31884, z = 6 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
Archived Tax Payer List A-L]] },
			{ itemId = 2826, -- book
				text = [[
Archived Tax Payer List M-Z]] },
		},
	},
	-- bookcase at 33649,31886,6
	{
		itemId = 6367,
		itemPos = { x = 33649, y = 31886, z = 6 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Civic Litigations, Ledger 1.]] },
			{ itemId = 2821, -- book
				text = [[
Civic Litigations, Ledger 2.]] },
		},
	},
	-- bamboo shelf at 33731,32866,6
	{
		itemId = 2460,
		itemPos = { x = 33731, y = 32866, z = 6 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Creatures of Marapur

Parder
The parder is a wild cat inhabiting the jungle-covered isles of Marapur. Its fur is of a dark ochreous ground-color, obliterated by a dark-brown blotched pattern on legs and flanks. A dark stripe also runs from the head across the neck and back. Parders are good climbers, but due to the omnipresence of water they have also developed into good swimmers and like to catch fish. For the nagas, the medium-sized predatory cats hardly pose a threat. They do, however, prey on humanoid bipeds.

Moa
Moas are large birds with striking, colourful plumage that live on the jungle-covered island of Marapur. Because of their strong legs, with which they can move quickly on land, one might think that moas are incapable of flight. In fact, however, they are good flyers and prefer to build their nests in the high mountainous areas of the island. Moas are herbivores and feed mainly on buds, leaves and the fruits of jungle plants. Unusual for birds of this size, many moas have a preference for shiny or glittering objects. If they spot these and can snatch them without major risk, the birds will often steal such items and hide them in their nests. Moa eggs are of an intense red colour, which is why the shells are popularly used by the nagas of Marapur for jewellery and decorations. Both, moa eggs and meat, are also a popular source of food for the mountain nagas.

Two-Headed Turtle
The two-headed turtle has its name for a rather obvious reason: it has two heads. As unusual as this is, the animal is otherwise a common, albeit very large, reptile. It is aquatic and lives mainly in the large reefs around and beneath Marapur. Although it feeds mainly on plants and fish, it can become aggressive and dangerous if you intrude on its territory. The territorial animals do not appreciate visitors. Naga mythology tells, why these turtles have two heads: In the conflict between asuri and nagas, they would not choose one side. While the nagas offered wisdom to the turtles, the asuri offered them food. Indecisive and hesitant, the animals turned their heads back and forth between the two parties so often that they ended up with two heads - and neither food nor wisdom.

Makara
Makara are quite unusual amphibious creatures native to the waters of Marapur. They look like a cross between a hippopotamus and a seahorse, but are clearly comparable to the former in size. In earlier times, the makara were often domesticated by the nagas to serve as pack and working animals. However, when the nagas discovered that the giant beavers native to Marapur were easier to tame and less costly to care for and feed, they turned away from domesticating makara. So nowadays, most makara can be found living in the wild. However, they seldom come to the surface, mostly they stay under water, often in already sunken naga ruins.

Foam Stalker
Foam stalkers are elemental water creatures. On Marapur they emerge from the spray of waterfalls cascading down from the mountains. Since they cannot survive on land for long, they quickly retreat below sea level after their emergence and thus populate the reef caves beneath and around Marapur. Because of their elemental bodies, it is often difficult to distinguish them from the water around them. As they roam the reefs, they often capture coral branches, flotsam, pearls or small fish with their swirling bodies. These objects can then be seen swirling around in their watery shapes.]] },
			{ itemId = 635, -- parchment
				text = [[
Flora of Marapur

Besides smaller water lilies that form waterways between buildings and islands, giant water lilies are also very common on Marapur. The lily pads grow several feet in diameter and are sturdy and thick enough to support smaller structures made of light wood along with several nagas. Those lily pads house shelters that are used for fishing, but also small shrines.

Starleaf never occurred naturally, but was specially cultivated as a source of food but also as craft material. It is grown on large farms, the leaves and buds harvested regularly.

The coral vow flower is a very rare plant, growing only in the mountains of the Murmuring Wilderness. Legend has it that the very first coral vow flower grew out of a foam stalker's spume. Yet, it was not an ordinary one but an older and more awe-inspiring specimen, a so called venerable foam stalker.]] },
			{ itemId = 2829, -- book
				text = [[
Magic and Solid Water

Spells are cast through gestures, called yukti. The more gestures a naga masters, the more spells they can cast. While many nagas can only perform yukti with two arms at the same time, some are able to form these gestures with three or even all four hands simultaneously. They are more powerful because they can combine more yukti at the same time to cast more powerful spells.

The solid water is a secret only known to the nagas. It has roundish, organic shapes, like waves that have solidified in motion. It can also take the appearance of large drops or water bubbles. The solid water is very receptive to magical energy and therefore often enchanted. In the past, at the beginning of the Rising, these elements were mainly used to push back the water by casting repulsion spells on them. By now, they are used for a wide variety of purposes, partly to direct and guide water and to collect it in certain places, but also for entirely different purposes. And sometimes the solid water is only used for aesthetic decoration.]] },
		},
	},
	-- bamboo shelf at 33736,32866,6
	{
		itemId = 2459,
		itemPos = { x = 33736, y = 32866, z = 6 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
About Marapur, a treatise by Timira the Philosopher

Our home Marapur lies south of Roshamuul, in a part of the ocean dominated by warm currents. The climate is thus tropically warm and rather humid. The island itself consists of some higher mountains but is otherwise mostly covered by jungle and submerged lush grass. Two-leg visitors often compare it with a breaking ice floe, which is very slowly but steadily flooded by the water of the surrounding ocean. This causes it to fray at the edges, where you can spot smaller islands and archipelagos in the water.

The rising of the water and the flooding of the island began centuries ago and progresses very slowly. As a result, we - the nagas - are not forced to flee nor do we try to stop the water. We refer to this process as "the Rising" and parts of us have accepted it and integrated it into our culture and way of life. The so-called coastal nagas adapt to living with the water and take advantage of its benefits instead of resisting it. At the beginning of the Rising, they still made great efforts to push the water back and keep it away from the island. In the meantime, however, the coast folk in particular has accepted that the water and the land coalesce more and more. While the mountain nagas do not reject water, they experience it mainly in the form of wells and waterfalls. The coastal nagas accept it as a part of their lives and even a part of themselves. Their connection to water and the sea is incomparably stronger than that of the mountain folk. Buildings in the coastal regions are now either submerged completely or rise out of the water only partially. Nevertheless, these buildings are often still used, and the nagas travel back and forth between them on small boats. There are also paths laid across the water, often made of large lily pads. They are floating on the waves easily and at the same time they are stable enough for a naga to glide over them as if on solid ground. There is, however, another group: the mountain nagas, who live in the mountainous regions that have not yet been affected by the Rising. Because of this, there are some cultural differences, for example in terms of religious customs, diet and lifestyle. The two factions are not openly hostile to each other, but there is some tension.

Since millennia, naga buildings are predominantly made of reddish-brown, baked bricks and often carefully ornamented and decorated. In addition to smaller residential buildings, there are magnificent temple complexes and palaces. Those soar upwards and often form multi-storey towers. Different city parts of Moonfall are connected by bridges. Decorations in the form of snakes or serpentine dragons are characteristic of our architecture and wave-shaped elements represent the omnipresent water. Sculptures of snakes and dragons can be found in many places in the city but also statues of famous personalities from our history. On the coast, many of the buildings are partially or even completely submerged in water. However, as the water rises very slowly, the upper floors of the half-sunken buildings are still used by the coastal nagas. The buildings, but also entire islands, are connected by paths made of lily pads, and there is a lively traffic of small boats between these individual islets.]] },
			{ itemId = 2832, -- book
				text = [[
About naga families, a treatise by Ziyad

Nagas do not know family in the sense how humans and many other peoples define it. Female nagas lay eggs, but they do not take care of them themselves. Instead, they give them to larger nests for breeding. There, brood helpers take care of the eggs and also of the small nagas when they hatch. Nagas become independent quite quickly and reach the stage of a somewhat six-year-old human child after only one year. Then they are sent back to their parents, who take care of their education - or to one of the parents in case they are no longer in a relationship. Which happens quite often, because nagas rarely form longer, monogamous relationships. Hence, I assume, the displeasure about the intended marriage of Candra and Nihaka, which by many is dismissed as the crazy idea of two teenagers - and with someone from the "other" culture at that. Some nagas, on the other hand, would welcome the union in order to strengthen the cohesion of the nagas as a whole again.

Another interesting fact about nagas is, that they sleep either in large, padded round baskets or by curling their snake bodies around thick branches. These very different ways of sleeping can be a source of discussion among naga couples when "branch sleepers" meet "basket sleepers".]] },
		},
	},
	-- bookcase at 32101,32188,7
	{
		itemId = 2435,
		itemPos = { x = 32101, y = 32188, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The rat - I fear we brought this pest with us on the isle and they soon increased in numbers. You might encounter the rats nearly everywhere, though they prefer to live undergound. 
Mostly harmless, they tend to destroy food supplies and can become dangerous in greater numbers to the bad equiped human.

The snake - The poisonous snakes hide in the woods and near the northern swamps. They usually can be found at the shores more often then in the isles centre. They are not too dangerous to a adventurer with some basic equipment. If poisoned it is a wise decision to run straight to the monk who guards the soul vortex, where everyone enters the world of Tibia, and ask for healing.

The spider - Similarly dangerous as the rat, the spiders were found by the first explorers of the isle and are native to Rookgard. They live above and beneath ground and tend to live and hunt in packs to increase their danger.

The wolf - There are some smaller wolf packs on this isle. Wolves are fast, tough and dangerous. Often they are the hunters and not the hunted on this island. It is a good decision to engage them in combat only with decent equipment and try to fight them only one on one.

The troll - Though intelligent in a limited way, the cowardish trolls are not a threat to our small outpost. They are able to create and use some basic equipment and quite tough to lesser weapons and unskilled fighters. Follow the advise to have mastered some basics in shielding, before you challenge even one of them.

The bear - Bears are hard to beat! Keep that in mind before challenging one. If you are unexperienced and have no good equipment, retreat is the tactic of choice. Best kill them in small hunting parties and use terrain to your advantage.]] },
			{ itemId = 2816, -- book
				text = [[
The orc - The green skinned orc is intelligent and able to use weapons and armor. They are warriors of some power and very dangerous in greater numbers. We are lucky not to have encountered any of the more dangerous orcs like warriors or berserkers on this isle.

The poison spider - Roughly only slightly tougher then the ordinary spider it can poison you. Try to avoid such fate since they usually live far from our base and you might not make it to our local monk for healing.

The bug - The bug is not that dangerous. More an annoyance then a threat to an adventurer of some experience. It might become a lethal threat to a perfect rookie. With some preparation they should not be worth to bother about.

The deer - Deers are a fine supply for food and are non-agressive animals and try to flee on sight. It might be difficult to catch them and you might easily enter the territory of a local predator while chasing them. 

The rotworm - A creature of decay that lives underground like its small cousin, the earthworm. Its toothed maw is a formidable weapon and rotworms have torn more then one adventurer to pieces. A horde of them might kill anyone, so great caution is advised while encountering them.

Other beasts - It is certain, that other beast live in the dungeons of our isle. But they are not numerous enough to become recognized yet. If you encounter any unknown beast it is certainly dangerous and a potential lethal enemy. Don't underestimate them.

The wasp - fast and deadly to the unexperienced. Their speed makes them dangerous, even more in high numbers]] },
			{ itemId = 2816, -- book
				text = [[
Dungeon Survival Guide

Don't explore the dungeons before you tested your skills in the training cellars of our academy. You will find dungeons somewhere in the wilderness.
Don't enter dungeons without equipment. Especially a rope and a shovel will prove valuable. Make sure you have a supply of torches with you while wandering into the unknown. 
It's wise to travel the dungeons in groups and not alone. For more help read all the books of the academy before you begin exploring. 
Traveling in the dungeons will reward the cautious and brave, but punish the reckless.]] },
		},
	},
	-- bookcase at 32101,32191,7
	{
		itemId = 2435,
		itemPos = { x = 32101, y = 32191, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Awaking of the Gods BOOK ONE

In the beginning there was only the big gaping void. 
It was omnipresent and nowhere. 
Into this desert entered Fardos, the creator, and Uman Zathroth, incorporating magic. Nobody knows where they came
from or whether they always have existed and just awaked from the deep slumber of the infinity. 
Fardos fulfilled by the need to create and give birth. He stepped into existence and began immediately with the act of the
creation, because he was fully creative power and impatient. His godly powers emerged from him and created, formed. 
But all his works slipped out of his hands as the void was everywhere. No single work was to last. Everything that he
devised dissolved in the void even before it was completed. 
Uman Zathroth regarded his undertakings thoughtfully, because Uman Zathroth was wise and fullfilled with magic
powers and insatiable hunger for knowledge, comprehension and enlightenment. He was a creature similar and nevertheless
different to the clear working of the Fardos, because mysteries and secrets were the aspects of his being. Uman and Zathroth
were two entities and nevertheless one. Uman was the light, bright aspect of the magic strength. His was the gift to work benign
wonders. Zathroth however, his different - dark - side, was corruptive urge, the vain self purpose of magic, destructive and a
desecration! This entity, which was two and one nevertheless, observed now the works of his companion in infinity. ]] },
			{ itemId = 2816, -- book
				text = [[
The Awaking of the Gods BOOK TWO 

For a long time Fardos exhausted his enormous powers in futile activity. Finally he asked his companion for support in his
attempts. Uman consented only too readily, but Zathroth, the dark one of the twins, refused himself. Thus Fardos and Uman
strived together to attempt the CREATION - however their laborings were not rewarded with success again. Just like before
everything was drained away as soon as they created it, and Zathroth laughed full of contempt. 
The power however, which Uman and Fardos spent, did seep away in the universe-filling void. Nobody knows whether it was this power that lured another entity to them, whether it aroused this godly being, or whether in a
mysterious way it created this entity. In any event, suddenly the enormous entity Tibiasula rose from the void and examined the two other godly beings. Fardos and Uman welcomed Tibiasula as their sister and admired her, because she was the perfect unity of the elements. Zathroth however fumed with silent hate, as he didn't want to share the void with one more entity.]] },
			{ itemId = 2816, -- book
				text = [[
The Great Creation BOOK ONE

Uman in his wisdom recognized the possibilities, which revealed themselves to them here, and he asked Tibiasula to join in the
circle of the creators and help them with the task of the creation. Tibiasula agreed, because she also was fascinated by the idea
of the creation. 
Uman, whose nature was to win secrets and gain insights, had realized what their error at the preceding attempts had been:
Without a fixed pivot point there was no existence possible, and everything had to diffuse away as it was without direction and
target. 
And to remedy that he invented TIME! 
In order to create the time, the Gods united their powers. Even Zathroth was fascinated by the idea of his other half and
contributed a tiny proportion of his strength to the effort. The wise claim that it is to be due to his working that all time strives in
the long run to decay and destruction. 
The powers of the godly bundled themselves to an enormous power greater than any in existence before. It began to
crystallize itself in the void to an enormous spiral. Higher and higher it mounted up, became firmness, pivot point, direction and
aim of existence! And in such a way the crystal column of time grew upwards and was from then on the unmovable center of
creation. ]] },
			{ itemId = 2816, -- book
				text = [[
The Great Creation BOOK TWO

But even at the culmination point of the creation Zathroth bundeled all his destructive powers to a weapon and pushed it with
all the strength that he could muster into the heart of Tibiasula, whose existence he did not want to endure any more. And as the
divinity was weakened by the creation and without suspicion and resistance, the deadly attack penetrated to the core of her
being and destroyed her. 
The elements - fires, water, earth and air - were jerked out of their harmony and landed at the base of the column of time.]] },
		},
	},
	-- bookcase at 32102,32188,7
	{
		itemId = 2436,
		itemPos = { x = 32102, y = 32188, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Tactics handbook - Use training to your advantage. Avoid fighting more than one enemy at the same time. Be careful while chasing an enemy because you might get hurt by his allies or by other monsters and can't defend yourself while targeting him. 
Target only the closest enemy or you'll become confused and might not be able to defend yourself against other attacks. 
Different enemies require different tactics. Some are better to be fought in an aggressive way; some should be fought in a defensive way. Which attack style you choose also depends on your equipment. If you wear only light armour, there is probably no point in fighting defensive and the other way around. ]] },
			{ itemId = 2816, -- book
				text = [[
The flora of rookgaard. 
One of the native trees of this isle is the rookiepine. 
This tough tree grows almost everywhere and can withstand the common storms in the harsh winter. 
Another tree you can find is the dwarfenoak. The smaller cousin of the tibian oak is a fast growing tree and so the most common wood supply on rookgaard as well as on the continent. 
Only botanists can distiguish the dwarfen oak from the strange rookgaard bananatree. On rookgaard there is an oak-like plant which fruits resemble bananas in shape and taste. No one can make out the difference of the fruits. To all people without knowledge in botanology: the only hint to find a bananatree is the white blossom flower that often seems to grow in a kind of symbiosis with the cherry tree. 
The dragon tongue plant is easily spotted by its deep red blossoms and rumoured to be an useful reagent in various alchemical potions. 
The swamp plants appear in such large number and variety that we didn't have a chance for extensive classification. ]] },
			{ itemId = 2816, -- book
				text = [[
The Knights: 
Knights are unparraleled in close combant. They are masters of most weapons and the shield. A skilled knight can inflict enormous damage even with the worst weapons]] },
			{ itemId = 2816, -- book
				text = [[
The druids: 
Druids concentrate on the magics of nature and acquire great healing powers. They also adept in the use of some offensive and protective spells.]] },
			{ itemId = 2816, -- book
				text = [[
The paladins: 
Paladins are great archers and also their spears hardly miss their marks. They are able to cast some minor spells of healing and protection. ]] },
			{ itemId = 2816, -- book
				text = [[
The sorcerer: 
Sorcerers are masters of magic. They possess an enormous arsenal of spells of protection and destruction.]] },
		},
	},
	-- bookcase at 32102,32191,7
	{
		itemId = 2436,
		itemPos = { x = 32102, y = 32191, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Birth of the Elements BOOK ONE

Schocked Uman and Fardos tried to grab hold of the dispersing being of Tibiasula, but it was about to slip out of their hands
like their creations before. They wove a powerful spell, the spell of the creation, in order to bind Tibiasulas essence to the
column of time. As Zathroth laughed loudly, in his vain triumph, he did not understand their words, and so the secret of creation
and life stayed hidden from him forever. 
They however wove the fleeting elements to powerful strands. Althought they did not succeed in uniting them again but the
individual parts became something new, the first real creation. 
Thus the living part became Tibia, born from the element earth, Sula became the sea washing around it. Air rose over the
creation and layed itself like a protecting blanket over the creation, and the fire seeped under it and began to warm it up. 
Behold: Each of the separate parts of the god was full of life and divinity! But none of the elements possessed the spirit of the
Tibiasula, but they were wild and impetuous, following always the impulses which corresponded to their nature. ]] },
			{ itemId = 2816, -- book
				text = [[
The Birth of the Elements BOOK TWO

And Uman and Fardos were chagrined about the dastardly deed or Zathroth. They decided to create from the elements
something new, similar to Tibiasula. For a long time they looked for a way to achieve this end. Finally Uman found a solution: the
birth, which created live from live. One of the Godly had to unite with one of the elements and could thus create a new entity. 
Thus Fardos and the Fire united, and the Fire bore two children, Fafnar and Suon, the Suns of Tibia. Suon of calm and
considerate nature. But Fafnar, its sister, was self-willed and stubborn. She rose vainly over the elements and began to scorch
them. Therefore Suon also rose up in order to stop his sister. A wild struggle started and pretty soon it turned out that Suon
was the stronger one of the two. So Fafnar fled under Tibia into the parental fire, but Suon wanted his sister to promise him
never to scorch the other elements again. ]] },
			{ itemId = 2816, -- book
				text = [[
The Birth of the Elements BOOK THREE

Thus he followed the vain sister and sought her it. She however was quick and escaped from him again. She escaped on the
other side and again rose over all elements, and began anew, to scorch these. When Suon followed her now, in order to punish
her, she didn't let it come not a further test of strength and escaped the brother immediately. He followed the teasing and
aggravating sister tirelessly into the embrace of the fire. But Fafnar was a step ahead of him and had already fled again onto the
other side over the elements ... and in such a way this continues to go on even today. 
Uman united himself with the earth, which we know as Tibia. And the earth bore him Crunor, the first tree. Crunor was full of
charm and vitality. Also he loved his own shape, but he was wiser than Fafnar and possessed the gift of modesty. Inspires by
the creation he bore from itself all the plants, small and large! And they spread out on the body of mother Tibia, like a dress - it
was a delight to see. ]] },
			{ itemId = 2816, -- book
				text = [[
The Birth of the Elements BOOK FOUR

Fardos connected himself with air, and its child was called Nornur, fate. Nornur envied the brother Crunor because of his
shape, as he was hardly more than wind and nebulae, and he asked he brother for assistance in creating a shape for him. But no
matter how hard the brothers tried, Nornur couldn't appear to be much more than a shadow of a ghost. 
Thus Nornur decided to create creatures in order to reveal himself. Thus the spiders came into the world, which are able to
web their ghostlike spiderwebs, which copy Nornurs shape, and thus praise and honor him. 
Also Uman and Sula, the sea, found together, and they conceived Bastesh, the unfathomable one. She was exceedingly
beautiful, and the Godly were astonished. But Fafnar, the sun, looked upon all this beauty full of envy! When the newly born
Bastesh looked up to her, she attacked her with fiery claws in the face and scratched it dreadfully. Probably Bastesh would not
have survived the attack of her sister, had not the other Gods hurriedly come to help and driven away the ravishing Fafnar. 
Bastesh however was frightened and disfigured. Full of fear she fled into the embrace of her mother Sula. In the depths of the
seas the unfathomable one hides herself since that time, and little is known about her and her workings. Only the fact that the
sea has been populated since that time by numerous creatures, may tell us that Bastesh seems to create these in the depth. In
addition it is said that since that time the water of the seas is salty from the tears, which the disfigured Bastesh sheds out of
anguish and pain.]] },
		},
	},
	-- bookcase at 32103,32188,7
	{
		itemId = 2437,
		itemPos = { x = 32103, y = 32188, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The cities of the continent: 

Fibula is a small village on an isle southwest of the mainland. It is under the rulership of the Thais monarchy. Its rumored that beneath this isle are caves and dungeons of unknown but certainly ancient origin. 

On the mainland is the city of Thais, ruled by the wise and just King Tibianus. His explorers found the new soulvortex on this isle and build this base to protect and train the incoming heroes.  

In the far northwest is the city of Carlin, that is ruled by amazons. The stuborn so called queen refuses to accept the rulership of the Thais monarchy over the whole continent. 

At the great bay, east of Thais lies a rotten town of criminals. Little is known about it and only the most ruthles people even think about travelling there. 

The dwarven town, north of mount sternum, the central tibian mountainmassive, is the home of the tibian dwarfs. If you are looking for smiths of unparralleled skill you should travel there. 

Further to the north, at the northern shores you find the elven city of Ab'Dendriel. There live the elves, masters of nature and masterhunters. 

In the swamps at the eastern coast of the continent lies the city of Venore. It is ruled by the money and the power of the local merchant houses.]] },
			{ itemId = 2816, -- book
				text = [[
Magic 

There are two kinds of spells: rune-spells, and spontaneous spells. 
Rune-spells are cast on blank runestones and some mana is used up in this process. These stones can easily be carried around and store the specific spell. It can be used at any time, and only some require further investment of mana. 
Spontaneous spells are cased in the heartbeat they are needed and take effect instantly. Most of these spells are spells of healing but some of them are agressive and some even have more astonishing effectes, as invisibility, illusionary shapechange etc.]] },
		},
	},
	-- bookcase at 32103,32191,7
	{
		itemId = 2437,
		itemPos = { x = 32103, y = 32191, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The First Creatures BOOK ONE

Zathroth however was delighted by the destructive potential, which Fafnar showed, and he looked upon her with delight. He
flattered her with compliments, and he succeeded in seducing her. 
Thus they conceived Brog, the fiery raging berserker. Brog possessed only little of his fathers wisdom, and the heat of his
mother burned only deep inside of him. There however the fire became more ravaging and more hurting, and the rough titan
raged and cried that the elements were shaken. Inexpressible pain troubled him, until the blocheaded Brog compacted his
magical powers and hurled a major part of the fire far away from himself. From the fire, which did not want to cool down,
however immediately the first dragon, called Garsharak, rose and he bore many further lower dragons in the course of the
centuries from his fire and his magic, of the like we know today. ]] },
			{ itemId = 2816, -- book
				text = [[
The First Creatures BOOK TWO

Brog however laughed over the dragon, which he had created, because he roamed over Tibia and was a terror to the few
other creatures. Brog was fascinated by this created being and its terrible children, although they showed him neither loyalty nor
respect. Thus Brog created further life, imitiating his shape, in order to please him, and so the cyclops entered the world. 
Zathroth however was angered, because he thought the cyclos stupid and awkward. Too little trouble did they spread in the
world, because they quarried in Tibia for metals and enjoyed to process it with fire and force. They were too few for his likes,
because they hardly grew in numbers. 
Thus Zathroth reprimanded his blockheaded son and ordered him to create new life. For he himself still could not understand
the secret of life. Under his guidance the first trolls, numerous and vexatious, developed but still without the malicious cunning,
which Zathroth desired. Next father and son therefore created the orcs. And the orcs turned out just like the dark God wanted
them. They flowed over Tibia, spread out and began to devastate it.]] },
		},
	},
	-- bookcase at 32106,32188,7
	{
		itemId = 2435,
		itemPos = { x = 32106, y = 32188, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Soulvortex
It's said that in ancient times, the gods created a great vortex to allow the souls of spirits from 'beyond' enter the realm of Tibia. Through this vortexportal many great heroes were able to  manifest themselves on Tibia. In their new bodies they fought against the forces of destruction. But also agents of destruction and evil entered the world through this portal. More and more the dark forces used the portal to spread over Tibia and to annoy, disrupt and subvert the brave people of the world. Some of the evil spirits remained long enough in this world to wreak even more havoc on the good people of Tibia. Destruction of all that others had built, slaying of new manifested souls as soon as they left the vortex. 
The gods watched in grief what had become of their great accomplishment. And one day Uman and Banor combined their awesome forces and split the vortex. One strand now aimed to the isle of rookgaard, the other one remained aimed on the temple of Thais. 
From this day on the newborn heroes awakened on the holy and protected isle of rookgaard and only the stronger and better prepared souls could travel to the continent. 
Guided by omens an expedition of brave warriors from the thaian order of the knights of noodles traveled the perillious seas the remote isle of rookgaard and discovered the new soulvortex. 
Soon this base was built and this fine academy founded. 

Praise the gods and our King.]] },
			{ itemId = 2816, -- book
				text = [[
My travels. 

As the orcs approached I've hidden myself in the bushes near the lake. I did hardly dare to breath as they met only some inches from my nose. I thought my wild beating heart might betray me to this murderous beasts. 
I overheared the greenskined brutes.  'charach' (or so) one said and the other responded the same way, then they began to chat in their strange language, certainly talking about some gruesome plot against mankind. Talking they wandered away and after they vanished from my view I quickly got up and headed to Thais as fast as I could.]] },
		},
	},
	-- bookcase at 32106,32191,7
	{
		itemId = 2435,
		itemPos = { x = 32106, y = 32191, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The War over the Creation BOOK ONE

Uman was distressed by the actions of his dark side, and he asked Fardos to help him with his attempt to separate from his
bad side. For a long time they manipulated and pulled on the essence of Uman-Zathroth, but only to detect that this unitity was
destined for eternity. 
But a small part of Uman-Zatroth, a godly fragment separated itself due to this pulling and struggling, and it assumed the shape
of Kirok, which one would call the crazy one. Kirok was from precipitous, scizophrenic nature. On the one hand he was
brilliant and creative, on the other hand one he was ludicrous and full of folly. Thus Kirok became the protection patron of the
scientists on the one hand, and the jesters and jokers on the other hand. 
Meanwhile the gruesome children of the dark gods raged more and more savagely, and the devastation of the world
continued without cessation. Some of the other gods did not want to witness anymore, how their creation was troubled and
subjected by the creatures after the spirit of Zathroth, and some decided to do something about that. 
Crunor created the wolves in order to protect his forests against the orcs, but these were too numerous! Only in the deepest
forests and in wild herds the wolves learned to defeat their bipedal opponents.]] },
			{ itemId = 2816, -- book
				text = [[
The War over the Creation BOOK TWO

Basteth wanted to come to aid her cousin, but her creatures, large and dreadful as they were simply could not walk ashore.
She was only able to send the snakes, but they were too weak, and the orcs too powerfull. Thus she gave them pus from her
festering face wounds as dangerous poison. But too bad! Still the bad orcs, equipped with cyclop weapons, were too powerful
and too malicious. 
But when the Orks threatened to cover Tibia almost completely, the dragon came! They had decided that only they
themselves were to be the true and absolute rulers of Tibia. They did know no mercy in their rage! With fire and magic
they annihilated the orcs, devastated their cities and drove them into the underworld. Even the cyclops, which hurried
furiously to the battle, and auxiliary troops from enslaved trolls were no match against the fiery anger of the dragons. Enormous
cyclopic cities were laid into ruins, unbelievable forging factories were lost for all eternity, and until today the cyclops are upset
about the orcs because of these losses. ]] },
			{ itemId = 2816, -- book
				text = [[
The War over the Creation BOOK THREE

But on the other hand, many dragons fell due to the onslaught of the enormous hordes of orcs and their allies. Until today
none of the old peoples has recovered from the great war. Tibia was completely scattered with the corpses of the great battle,
and all life threatened to be suffocated thereby. 
There the gods decided that Uman should unite with the earth in order to create a godly being, which would take care of the
dead. But Zathroth used a deception and appeared to the earth as its other side, Uman, and conceived in his place a being.
This was the birth of Urgith, the master of the undead. 
And immediately the dead ones began to raise themselves on his calling, and they all were his creatures. Like the orcs before
them, now the undead covered the body of the mother Tibia, and his children, the rats, were Urgith's messengers and scouts. 
Then however Uman and Tibia united, as it had been agreed upon, and Toth was born. Toth became the guardian of the
dead ones and sent his large worms which began to devour the undead. For a long time the struggle lasted and again no end
was to be foreseen. ]] },
			{ itemId = 2816, -- book
				text = [[
The War over the Creation BOOK FOUR

The good Gods created and threw race after race into the struggle about the world. All of them were defeated! Almost
everyone of the old races, which we know only as the Ancients, was defeated and buried by the sands of the time, because
they were no match to the agressive rage and the emotionless intrepidity of their opponents. 
According to our knowledge, only the delicate elves in their cities deep in the forests and the dwarves in their fortresses deep
under the mountains survived the corpse wars, although at some campfires rumors are spread about other races, created by
both sides for this unholy war, and of which some individuals are said to still be around. 
Just as strong and powerful as these peoples were, they were one-sided and of little flexibility. Worse still: Some creatures
succumbed to the temptations of Zathroth about power and great knowledge. They switched sides, and rumor has it that the
most powerful of the Ancients were hurled out of this world by the good Gods for their betrayal to suffer eternally in the sphere,
which was created in order to punish them for their misdeeds, and changed to what nowadays is called the daemons. 
All their magic, which was probably given to the old peoples in excess, could not make them victorious, and they and their
buildings disappeared gradually from the face of Tibia.]] },
		},
	},
	-- bookcase at 32106,32194,7
	{
		itemId = 2435,
		itemPos = { x = 32106, y = 32194, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
As we travelled through the dungeon tunnels we came to a big cave. In the light of our torches we saw several eyes glowing in the darkness, then the trolls attacked, silently as usual. We immediately dropped our torches and raised our shields to block the first attack, then we counterattacked. Soon the floor was wet with blood, ours and theirs. They were very skilled in blocking our blows and I am sure with inferior weapons we would have hacked on these beasts for an eternity.]] },
			{ itemId = 2816, -- book
				text = [[
Orcs ARE intelligent. Though some dwarfes mumble about a shared hivemind of the greenskins, there is no evidence for that. Orcs have speech and are capable to learn other humanoids language quite well ... if they want, what almost never is the case. They lack a written language though. Some of the more educated orcs use human letters to write down orcish texts. It's rumored that the orcs we encounter now and then are just barbarians of their own kind and that there is a more 'civilized' orcish culture somewhere. There are some clues that the orcs indeed had a written language, but the modern orcs are unable to read it as we are.]] },
			{ itemId = 2816, -- book
				text = [[
Once upon a time there was a little gnome. 
And as all gnomes he was a treacherous, greedy coward (and that's pretty treacherous, greedy and cowardish). One day in the middle of a deep forest the little gnome met a little girl wearing a pretty red cap. As the greedy gnome saw that she was carrying a bag full of finest bread and a flask of wine, he pretended to be starving and begged the little girl for food and water in a way anoying as only gnomes can be (and that's pretty anoying). But the girl was warned of treacherous gnomes by a valiant huntsman she met before and she quickly ran away from the greedy little gnome. The gnome became angry but was afraid to steal from her, because she might have been stronger than him. So he wandered into the woods cursing as only gnomes can curse(and that's pretty ugly). By chance he almost stumbled over a sleeping bard. Quickly figuring out the magical nature of the flute lying near the sleeping bard, he stole it as quickly as only a gnome can do (and that's pretty quick). Using the magic flute he lured a pack of wolves to the little girls grandmas house and let the beasts chase both into the wilderness and laughed wickedly as only gnomes can laugh (and that's pretty wicked). Laughing the gnome gulped the wine and swallowed the bread as fast as only gnomes can (and that's pretty fast). So he lived in the woods and molested squirrels happily ever after.]] },
		},
	},
	-- bookcase at 32106,32197,7
	{
		itemId = 2435,
		itemPos = { x = 32106, y = 32197, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Most monsters are far more dangerous when you're attacked by more of them. Keep in mind that no more than two enemy attacks can be blocked at a time. Use this to your advantage and attack single monsters with help of other heroes. Don't get surrounded by monsters, that might be your death even if the monsters are not that powerful.]] },
		},
	},
	-- bookcase at 32107,32191,7
	{
		itemId = 2436,
		itemPos = { x = 32107, y = 32191, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Creation of Humans BOOK ONE

There the Gods created the first human, Banor, the godly warrior! This entity was filled by the godly power and was full of
courage and responsibility. After his image and with parts of his body the Gods created him attendants, Humans. 
Nobody knows, which Gods brought their powers into the recent creation, and some say that Zathroth spoiled also this
creation. Yes, some even state that the good Gods created a twin for Banor, which should embody the powers of magic,
whose raw form however was stolen by Zathroth, and he had manufactured from it the first daemonic lords to lead his
attendants from hell. 
Whichever it might be, in any case the humans took on the fight against the crowds of the undead and probably against the
dragons, orcs and their unholy attendants, too, and Banor was a glorious leader for mankind. ]] },
			{ itemId = 2816, -- book
				text = [[
The Creation of Humans BOOK TWO

Thus the age of the wars of the unliving began. The battles were furious and bloody and for along time no side was
apparently winning. Uman gave humans the art of magic and instructed them in the magic crafts. But even the sorcerers could
not turn the tables. Some of them turned thereupon away from Uman and called Crunor their lord, in order to serve from then
on as druids for the forces of the life. Together with the godly world tree Crunor they created many of the creatures, that
populate the wilderness today, although a variety of these creatures was extinguished in the wars of that time. 
Banor however chose the noblest of the mortal ones, Kirana, as its wife, and she bore him Elane, which possessed as much
virtue as combat and magical powers. And she became the first of the noble paladins. Until our times the leader of the paladins
is in honors to her a woman and assumes the honorary name Elane. ]] },
			{ itemId = 2816, -- book
				text = [[
The Creation of Humans BOOK THREE

All this however could not turn the war luck against the dark hordes. Whereever Banor appeared personally to lead the
armies of humans, they triumphed, but on the other battlegrounds they were too often crushed by the dark crowds. 
Thus Banor asked the gods to help him and the gods in their infinite wisdom created the portal of the souls. By means this
mystic of gate souls from planes of existence far, far away of Tibia could be called in order to assume the shape of heroes. 
With these champions as leaders the humans turned the tables in the great war. They alone under all the mortals had the
possibility of becoming similar to Banor, uniting power and cunning. Thus the hordes of undead and their terrible leaders were
slowly but inexorably overwhelmed.]] },
		},
	},
	-- bookcase at 32108,32191,7
	{
		itemId = 2437,
		itemPos = { x = 32108, y = 32191, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Tibia's Renewal BOOK ONE

The heroic powers were just about to seal the defeat of the darkness by steel and manapower but the wars had persisted for
too a long time. The world was fragile, the boundaries between the worlds cracked by the enormous powers, which had been
employed. Already the armies of the older races were readying themselves to recapture from the humans what the old ones
regarded as theirs. Already the children of the darkness, hardly troubled by the undead, risen again to new powers, were
waiting to spread chaos over the world. Already the dragons sharpened their talons on their rock, in order to rise again into air
to devastate the world in a fiery nightmare. Already the victorious armies of humans threw possessive looks on new targets.
Already the daemons hammered on the walls of their breakable prison.]] },
			{ itemId = 2816, -- book
				text = [[
Tibia's Renewal BOOK TWO

There the Gods on both sides stopped. They looked down upon the desintegrating world, and they decided an armistice,
because they all wanted power over the creation, not its complete destruction. Thus the Gods threw the charm of the new
beginning over the world! Only gradually the recovering sections of the old world started to rise from the nebulas of time,
awakened the old races and old frights back to life. It is said that the city of Tibia was the first to rise again, barren of almost all
life, without all magic, on a tiny island, deserted and almost devoid of life ... and nevertheless full of age-old secrets. And soon
afterwards life returned to the world. 
Also via the portal of souls old and new heroes found their way to Tibia. Gradually larger sections of the old world emerged
from the nebulas, further natures and miracles. But the world is still far from its former splendour and size, and we live in times
of change. What today is still natural, may as soon as tomorrow be only a legend, what today is still fantasy, may already
tomorrow be reality. 
But hear ye and listen: Bad spirits also arrived and still arrive by the portal in our realm, in order to do mischief in human
shape. Thus one has to face many dangers, and often the world appears to be cruel and hostile.]] },
		},
	},
	-- bookcase at 32185,31624,7
	{
		itemId = 2439,
		itemPos = { x = 32185, y = 31624, z = 7 },
		contents = {
			{ itemId = 2820, -- sheet of paper
				text = [[
Dear Gesnar!

The minos are reliable mercanaries. Your advice to hire them proves right. My treasures are well guarded now. Last but not least I have enforced the treasure doors by magic.

Alawar, Warlock of Senja]] },
		},
	},
	-- dead human at 32273,31023,7
	{
		itemId = 4240,
		itemPos = { x = 32273, y = 31023, z = 7 },
		contents = {
			{ itemId = 2820, -- sheet of paper
				text = [[
The foreigners have taken us by surprise. They used evil magic to overcome our men and we finally had to retreat. If the mighty Yakchal had not been in her regenerative sleep at this moment, we would have beaten them for sure. But to make matters worse, the holy coffin, in which Yakchal is sleeping, has been stolen during this attack. Our scout reported they have dragged it into the mines. They probably plan to use its powers for their own purpose. The good thing is that it won't open at all as long as it is not touched by starlight. The bad thing is without starlight Yakchal might be trapped in the coffin eternally.]] },
		},
	},
	-- bookcase at 32297,32854,7
	{
		itemId = 2438,
		itemPos = { x = 32297, y = 32854, z = 7 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Since sightings have been reported by many respectable seamen the existance of the golden whale can no longer be dismissed as a fairy tale. It is said that this whale is as huge as an isle and its body is made of purest gold. Even though many of the reports were made by seamen in the southern seas sailors of the north also claim to have seen this creature. All over the world the sighting of the golden whale is seen as a good omen. No one has yet been able to even hurt the beast; however, several inventors and mages have come up with ideas for the creation of a weapon that might pierce its golden body.]] },
			{ itemId = 2826, -- book
				text = [[
Rum - the Essence of Life]] },
		},
	},
	-- bookcase at 32297,32855,7
	{
		itemId = 2439,
		itemPos = { x = 32297, y = 32855, z = 7 },
		contents = {
			{ itemId = 401, -- book
				text = [[
The Shattered Isles

Nargor is a hostile rock surrounded by treacherous reefs. Since it is uninhabitable and almost unreachable it is of no interest.

Treasure Island is not only desert-like but also quite deserted. The only people you meet are treasure hunters that travel there occasionally to try their luck.

The inhabitants of the town Liberty Bay live on the numerous plantations. The town has developed into a major trading center in recent years, and is under Thaian rule.

The Forbidden Islands to the north-west are dangerous not only because of the volcanoes that are found there but also due to frequent quara activity. Since there is no real reason to visit these islands, no regular shipping route was ever established.

The Laguna Islands are quite often visited by passing ships to refresh their supply of water and food. Still the isles are too desolate to establish a settlement there. It is rumored that a small tribe of savages calls one of the isles its home.]] },
			{ itemId = 2816, -- book
				text = [[
Raiders of the Lost Barge]] },
			{ itemId = 2828, -- book
				text = [[
Captain's Log]] },
		},
	},
	-- bookcase at 32297,32856,7
	{
		itemId = 2440,
		itemPos = { x = 32297, y = 32856, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Nautical Studies]] },
			{ itemId = 2824, -- book
				text = [[
Logs and Leaks, the Daily Life of a Captain]] },
			{ itemId = 2816, -- book
				text = [[
A Pirate's Memoir]] },
			{ itemId = 2825, -- book
				text = [[
The Parrot and Me]] },
		},
	},
	-- bookcase at 32302,31781,7
	{
		itemId = 2435,
		itemPos = { x = 32302, y = 31781, z = 7 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Lord Lokhem the pious was a good man. In his youth he aimed to become a priest of Banor but later decided he could serve his god better as a knight. He put high standards towards others and even higher standards for himself. Almost no one found his approval. There was always some taint or fault that appalled him in human beings. all the more, however, he was appalled by himself. Whereas in others he could only assume the faults and sins, in himself he was well aware of them. His own anger, envy and greed disgusted him to no end. He felt a great evil was growing deep inside of himself. He studied the teachings of the gods and being unable to find a solution he relied on more and more dubious texts and books. Eventually, drawing from elements of different fragmented texts he devised a ritual that would ultimately cleanse him. By this ritual he planned to cast out his malignant side and destroy it once and for all. The preparations took several years and used up all of his fortune. Eventually he was ready and prepared. On the top of a mountain he scribbled ancient symbols, sung in forgotten languages and consumed elixirs of unspeakable ingredients. Three times three days he endured. In the ninth night at midnight a storm engulfed the mountaintop, without touching it. Amidst darkness and lightning from the ashes of the ritual fires a grotesque creature arose. Lord Lokhems evilness had manifested. Yet to his utter horror it was by far more huge and powerful than the puny remnants of his goodness, in a body that was exhausted by the ritual. His evil mocked him, claiming that this outcome had been its plan all along, to finally be set free. Lokhem valiantly tried to fight back by his dark self only toyed with him. Bleeding from countless wounds Lord Lokhem fell to the ground, powerless. He was still alive when he evil claimed his face for himself. Then it mercilessly slew the good side. It left to lead a life of corruption, spreading mayhem where it went. It is said that Lord Lokhems evil side, driven by memories of his research, was searching a secret library that was rumoured to contain vast knowledge. There he planned to find the spell that would free all the evil in humanity at once and give it substance. But he was overwhelmed by the guardians of the library and met his end by their hands. To honor his accomplishment to find them, the guardians granted him a proper burial.]] },
		},
	},
	-- bookcase at 32306,32851,7
	{
		itemId = 2435,
		itemPos = { x = 32306, y = 32851, z = 7 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Great Sea Serpents
The Sea Serpent is as huge as a house and can swallow a small ship in one bite. Its scales are almost impenetrable and its teeth, which are as big as a cyclops, are coated with a corrosive poison that will dissolve human flesh on touch. In their undersea lairs they hoard treasures that would make a dragons hoard look miserable. ]] },
			{ itemId = 2821, -- book
				text = [[
The Flying Venorean
The flying Venorean is a ship that is cursed to sail the seas forever. Allowed to visit land only every seven years, the ghostly captain uses his shore leave to lure clueless sailors into his crew. Everybody that signs the contract becomes cursed like the captain and might only leave the ship if he finds a suitable exchange on one of his shore leaves every seven years. ]] },
			{ itemId = 2821 }, -- book
		},
	},
	-- bookcase at 32307,32851,7
	{
		itemId = 2437,
		itemPos = { x = 32307, y = 32851, z = 7 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
The Wolves of the Sea
Most pirates started their career as smugglers and reavers at the beaches. With the help of small shipping boats, they boarded ships in remote bays where they restocked supplies. Often whole villages made a living from such acts of banditry. At some point they decided that they had become strong enough to take over the ships and raid the seas. Another source of pirates were the mutinous crews that took over ships and who were hunted by the navy anyways.]] },
			{ itemId = 2827, -- book
				text = [[
The Lighthouse in the Middle of Nowhere
Sailors claim to have travelled as far as the end of the world where the water pours down into nothingness. Although it is easily recognizable during  daylight it poses a special threat at night. To make matters worse, a spooky lighthouse sometimes appears out of nowhere to lure ships over the edge of the world. Whether it is really a lighthouse or some other source of light differs from story to story and remains to be determined.]] },
			{ itemId = 2821 }, -- book
		},
	},
	-- crate at 32310,32172,7
	{
		itemId = 2471,
		itemPos = { x = 32310, y = 32172, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Chronicles of the Realm XXI
In the third year of the reign of prince-king Rodmund II it was exposed that the priests of Zathroth planned a coup to assassinate the young king and usurp the kingship. Hastily but in secrecy the first Inquisition was formed under the helmsmanship of grand priest Wisbert from the temple of Uman who was chief advisor of the uncrowned, 15 year old Rodmund. The traitorous elements were exposed and routed out. In the whole land Zathroth's temples were seized and the conspiring priesthood put in jail. Interrogations by the Inquisition unearthed the massive extent of the treachery and the church of Zathroth fell in irredeemable disgrace with the crown. Within a year under the guidance of Wisbert, the Purger, the worship of Zathroth was forbidden in the whole realm and their temples where destroyed or cleansed and reclaimed by the churches of the other gods. The grand priest of Zathroth, Madol, the Defiler, was burned at the stake, north of Thais. Even after his coronation in the year after the purge had begun, king Rodmund II had to live reclusive and under the vigilance of the Inquisition and the church of Banor since several attempts on his live were made by remaining Zathroth cultists. To honor his efforts and wisdom, Wisbert was named chancelor of the realm. In his tireless efforts he spearheaded the purge and managed to rout out several traitorous nobles that were in league with the Zathrothi. In his renewal and healing of the realm, a significant amount of lesser but pious houses were elevated to positions of honor and influence and the realm prospered by their wise, divine inspired guidance in the years to come.]] },
		},
	},
	-- bamboo shelf at 32329,32571,7
	{
		itemId = 2459,
		itemPos = { x = 32329, y = 32571, z = 7 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Seasickness or Why the Gods Don't Want Us to Travel the Oceans]] },
			{ itemId = 2816, -- book
				text = [[
Monsters of the Sea]] },
			{ itemId = 2821, -- book
				text = [[
101 Sailing Songs]] },
		},
	},
	-- bamboo shelf at 32330,32571,7
	{
		itemId = 2459,
		itemPos = { x = 32330, y = 32571, z = 7 },
		contents = {
			{ itemId = 2827 }, -- book
			{ itemId = 2816, -- book
				text = [[
The Howling Grotto
The Howling Grotto of Nargor used to be a hideout for criminals in the early days when colonisation just started on the isles. Those criminals were probably the first pirates although is unlikely that they had more than a few fishing boats at their disposal. They built some rooms in the caverns but supposedly they found evidence of prior attempts to use the grotto in some way and some of the caverns seemed to be not natural. For some reasons they were attracted to the lower caves where the howling of the wind was that fierce that people said it could drive a man crazy. Be that as it may, those first pirates were known for their bloodthirst, their frequent infightings and for torturing their prisoners. It is assumed that they all killed themselves in their madness. The grotto is rumoured to be haunted by the ghosts of these pirates and those of their victims - but those are only unconfirmed speculations. Nowadays, nobody knows the treacherous passages through the dangerous reefs to reach the isle of Nargor.]] },
			{ itemId = 2821, -- book
				text = [[
Treasure Hunter's Manual]] },
			{ itemId = 2821, -- book
				text = [[
Nautical Studies]] },
		},
	},
	-- bamboo shelf at 32337,32583,7
	{
		itemId = 2459,
		itemPos = { x = 32337, y = 32583, z = 7 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Treasure Hunter's Manual]] },
			{ itemId = 2821, -- book
				text = [[
Become a Pirate in a Week: Ten Easy Steps]] },
			{ itemId = 2828, -- book
				text = [[
A Pirate's Life for You]] },
			{ itemId = 2821, -- book
				text = [[
Plundering Made Easy]] },
		},
	},
	-- bookcase at 32358,31765,7
	{
		itemId = 2435,
		itemPos = { x = 32358, y = 31765, z = 7 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Cityguide Venore
The city of commerce built its wealth on four major factors. One is the freetrade agreement with the thaian kingdom to which they in theory belong. This ensures trade with all cities, cultures and lands, known or yet to be discovered. Often seen as a separate law but actually part of the free trade agreement is the gambling licence, that is unique in the Thaian Kingdom, because 'commercial' gambling is outlawed since the times of king Yorik I.
Another factor is the shipping dock and the woodcutting in the Venore area. Before the Edron colony was established, the Venore area was the major source for wood needed for constrution and tools. What seems odd at the first glance, given the swamp area Venore was built in becomes more understandable when considering the next factor: Until the Druids and mages drove away all those poisonous insects and creatures the area was known for its diseases and a criminal colony in the beginning. So the merchants had a steady supply of cheap workers that had to do every job appointed to.
The last factor was the discovery of the Spiceweed. A special swamp grass that was soon used by cooks and households all over the continent.
Soon enough the merchants became rich and powerfull, rivaling most of Thais noble families in wealth and power.
For now the merchants seem content with their station and the place Venore takes on the continent and in the kingdom. There are voices that Venore might separate one day or use it influence to wrest even mor rights and privileges from the kingdom that becomes more and more dependent on its economical power.]] },
		},
	},
	-- bookcase at 32359,31763,7
	{
		itemId = 2436,
		itemPos = { x = 32359, y = 31763, z = 7 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Shattered Isles
Nargor is a hostile rock surrounded by treacherous reefs. Since it is uninhabitable and almost unreachable it is of no interest. 
Treasure Island is not only desert-like but also quite deserted. The only people you meet are treasure hunters that  travel there occasionally to try their luck.
The inhabitants of  the town Liberty Bay live on the numerous plantations. The town has developed into a major trading center in recent years, and is under Thaian rule. 
The Forbidden Islands  to the north-west are dangerous not only because of the volcanoes that are found there but also due to frequent quara activity. Since there is no real reason to visit these islands, no regular shipping route was ever established. 
The Laguna Islands are quite often visited by passing ships to refresh their supply of water and food. Still the isles are too desolate to establish a settlement there. It is rumored that a small tribe of savages calls one of the isles its home.]] },
		},
	},
	-- bookcase at 32366,31763,7
	{
		itemId = 2435,
		itemPos = { x = 32366, y = 31763, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The art of war by Brianna Bonecrusher

To win a war, or even a fight, one has to discard certain ideals of nobility and honour. While honour is a noble concept it is less noble to let your soldiers die because you follow some lofty goal. As a leader it is your foremost duty to ensure that as many of your soldiers as possible return home, unharmed, in tact and preferably victorious. This can't be done by open battles that follow some sort of code. Battles have certain dynamics that makes any code obsolete after the initial clash anyway. Therefore, the surest tactic for success is to weaken the enemy as much as possible before you even think about engaging them in battle at all. A hit and run tactic is a wonderful strategy for achieving this aim. This requires the army to operate in small groups, making the maximum use of the terrain, traps and distance weapons. Let the environment cause as much harm as possible. Force your enemy to seek its way through treacherous countryside, lure them into the lairs of animals and monsters and don't give them the chance to restock supplies. Don't grant them the comfort of an undisturbed rest. Harass and attack them constantly from afar so they never feel safe. Bleed them out and wear them down and don't let them retreat to safety because then they might return, and be better prepared as they are wise to the guerilla tactics you use. The main goal is always to keep your own casualties low. If the enemy has no or little distance attacks you might be able to pick many of his soldiers off without any meaningful retaliation. Let your distance fighters aim for key figures first whenever possible. If you face enemies with numerous distance fighters attack them under cover of night using your own shooters spread out wide and roughly aiming for the enemy's camp. When forced to fight in close quarters, use an ambush strategy whenever possible. If possible, be prepared for a hasty retreat when things turn out nasty. She who fights and runs away will live to fight another day.]] },
			{ itemId = 2816, -- book
				text = [[
The Druids

The druids of Carlin are closely affiliated to the city and its leadership. From the earliest days of the fledgling city, when the druids helped to provide food and shelter, to the days of prosperity and stability when they offered guidance and healing, they have been a constant in Carlin's history. Because the druids have been rewarded with great respect and considerable influence as a result of their engagement in the city and their decisive role in its success, many druids have moved to Carlin. This has had the consequence that over time, Carlin has became a centre of druidic magic and teaching.

When the looming threat of the Ghostlands was discovered it was the local druids who helped to erect a barrier that warded off the undead and the ghostly inhabitants. The prominence of druidic magic in Carlin has led to somewhat restrained relations with the Sorcerers' Guild that has close ties to Thais as is evident by the funding of the Edron academy. Over the course of time the more rigid guild members of the Sorcerers' Guild withdrew from Carlin and were replaced by freelancers and freethinkers with only loose ties to the Thaian guild so that over the years a form of acceptance between the local guilds was formed. The druids continue to be part of the everyday life of Carlin and heavily influence the culture and philosophy there.]] },
		},
	},
	-- bookcase at 32367,31763,7
	{
		itemId = 2436,
		itemPos = { x = 32367, y = 31763, z = 7 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Puldraks wisdom about orcs
As intensely as the orcs hate all other races, they share a feeling of community. The orcs can sense, to some extent, the feelings of other orcs. The shamans develop this ability to such an extent, that they can sense the innermost potential of newborn orc whelps. All newborn are tested and the shamans decide a future function in orcish society. The whelps are fed differently, raised differently, and educated differently. Wise men of other races say that such behavior is similar to some insects, such as bees, and through their empathetic bond might share a kind of 'hive-mind', so they refer to orc communities as hives. The chief of a hive owns a big harem of women who have no other function than to pleasure him and give birth to new orcs. These orcish matrons are usually incredibly big and fat, almost not able to walk on their own. Where 'normal' orcwomen function as laborer and craftwomen and give birth to two to three orcs in their lives, these female orcs are only reproductive machinery, giving birth to about six whelps each half year. Orcs are usually contend with their place in orcish society and only the leaders fight each other on purpose. Rarely will an orc raise a weapon against another orc, even if they are not of the same hive. Rivalry between hives is usually dissolved through a fight of their leaders and the victorious hive absorbs the other one. Now and then, when a new strong warrior reaches maturity he challenges the old leader for a fight of supremacy. Sometimes though, when the hive becomes too big for the area it occupies, such a warrior senses somehow that its time to move on. Then he and a few other orcs leave the hive in peace to settle somewhere else. This unique culture, together with its fertility, makes the orcs the most formidable threat to all other tibian communities.]] },
		},
	},
	-- bookcase at 32368,31763,7
	{
		itemId = 2437,
		itemPos = { x = 32368, y = 31763, z = 7 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
Puldraks wisdom about elves Pt. 5
The 5th elven cultural group are the Chelabdil. There role in the war and their fate is yet unclear, but they have few contact with the other elven casts. They are usually a bit taller and stronger than elves of the other races, and there skin is silvery-white or in blue to greenish tones. Their eyes are often pale blue or green, sometimes a faint yellow. They have long black hair, or sometimes dark brown. They seem to live nowadays in the region northwest of Carlin and are seen quite often there. They have the keenest eyes of the elves, and the weapons of their choice are spears, knives and sometimes the short bow. They are fine hunters and sometimes trade furs, but the main part of their life remains yet uncertain. Then something happened. The dimension that harboured the elven valley began to collapse. Pice for pice their land was torn away and the wisest of the elves found out that the valley would ultimately 'fall' back in the world it belonged to. Great efforts were undertaken to prevent it. All were futile. As this was recognized it was almost too late. All magic was concentrated to preserve the lives of the elves. Protective shells were created, spells to deflect damage, enchantements to keep harm away.
The 'return' was aweful. Almost half of the elves perished. All of the valley and its wonders were destroyed. Almost nothing remained. Artifacts and books shattered and burnt alike. The battered elves retreated and begun to wander aimlessly through the lands, until they encountered scouts of the Deraisim who led them to the safety of their woods. At first they were disgusted by the primitive lifestyle of their brethren, but soon they decided they had to guide and lead them back to true values of elvenkind. So one of their encampements was choosen as new home for the elvenkind and the city of Ab'Dendriel was founded.]] },
			{ itemId = 2827, -- book
				text = [[
Puldraks wisdom about elves Pt. 4
The Cenath were the most lucky of the elves. They lived in a hidden valley in a handful of cities, far away from the rages of war. As things turned bad for the elves much of their artifacts, artwork and books were brought to theese cities. Live went on as usual for some time, the elves minding only their own business, as if pretending there was no war at all. Of course the war found them at last. In an frantic attempt to rescue their lives and even their accustomed way of life the elves begun to weave powerfull spells. Many of their best magicians litteraly 'burnt out' in the process but finally the elves succeeded. The whole valley was torn out of the known world ... And this was bitterly needed in a world that was only stormy darkness around the elven valley. They created a artificial light and even created weather. There they lived for hundreds of years, studying and practicing magic, mainly to manipulate and reproduce efects of natue to enhance their lives.]] },
			{ itemId = 2827, -- book
				text = [[
Puldraks wisdom about elves Pt. 3
The Teshial were never fighters. They retreated in the early days of war to hidden refuges, not as a whole caste but only in small family groups. Their hideouts were additionally protected by strong illusionary magic and offered them peace from the madness around them. These elves developed due to meditation and a special philosophy in the art of dream magic, dramatically enhancing their initial abilities in the decades. So they began to exist almost permanently in a state of dreams, only rarely appearing now and then amidst the other elves to give them advice and try to convince some of them to join their way of life. As the war grew more and more fierce these visits became less and less frequent until they were almost a myth, even for elvenkind. In the new awakening of the world they were some of the first to appear, apparently far less disoriented then other beings. Many races welcomed their help, but their teachings seldom found dedicated listeners. After they taught a part of their secrets to some humans they found worthy, they had to see their pupils tortured by developments they judged themselves guilty of. Also, other elves put pressure on the humans to give up the secrets of dreams. They withdrew from the world of mortals and it is rumored they have physically entered the realm of dreams.
The Teshial are 'typical' in appearance for elves, but they could create the illusion of almost any appearance if they so choose. Some people even say that due to their enormous control of dreams they could shape their children as they wish, giving them human or even orcish appearance. On the other hand, even people who come up with such theories go silent when asked why an elf should choose to have a child that looks that way.]] },
			{ itemId = 2824, -- book
				text = [[
Puldraks wisdom about elves Pt. 1
The Deraisim had become homeless in the wars. As nomadic wanderers they hid in the woods, setteling nowhere for a longer time. Their families joined each other to travel together for a while, only to disband again soon whenever an area could not supply them all any longer. Hunted by countless enemies and almost everytime outnumbered when it came to fights with 'neighbours' they retreated into the deepest woods where the greater number of their foes was evened out. There they created encampments they visited now and then. They had contact with many creatures and cultures. They adopted ideas and inventions that suited their nomadic lifestyle and begun even a very cautious trade with other races to aquire things they were not able to build on their own. As the attention of the other races turned more and more away from the elves and wars broke out between them, some of the elves begun to live at their up to then only part time ecampment on a permanent base. Adopting what they had seen from other races and things they vaguely remembered from their own past some trading posts were established in this way. Usually only one to three families lived there. After the reunification with the Cenath the majority of them could be convinced to give a permanent settlement a try and the biggest tradingpost became the settlement Ab'Dendriel. Some families refused to join their brethren and continued to wander the world, only visiting the city now and then, each vistit convincing them more that they have only little in common with the Deraisim anymore. So they begun to see themselves as Abdaisim and continued to be the nomads and restless wanderers of elvenkind.]] },
			{ itemId = 2821, -- book
				text = [[
Puldraks wisdom about elves Pt. 2
The Kuridai took refuge in a volcanic area, inhabited by vile monsters and ravaged by the eruptions of the mountains. Stripped of almost any possesions, they hid in the caves and learned to become very secretive. They had to work very hard, had to fight for almost any goods with nature and ferocious beasts. Most beasts that could live in such livethreatening circumstances were that powerfull that direct attacks proved to be futile. So the elves begun to develop a more devious way to fight, with assaults, traps and hit and run tactics. After over hundred years they had enough resources to leave the burning lands and adopted their way of live to their new enviroment. So they became the secretive people under the hills. They were fierce fighters whenever their new home was threatened. Some hundred years they fought off all intruders until their explorers made contact with the other remaining elven casts. Under the growing pressure of the more and more powerful waves of orcish attacks they left their homes to join forces with the other elves in an uneasy alliance.
Their apperance had changed to a even more slender Version of the normal elves. Their skin is very pale, their hair pure white or pitch black. The younger members of that cast often color strands of their hair in unusual clors like red, blue or purple. Red, albinotic eyes are common, but in general all kinds of eyecolors are existent.]] },
		},
	},
	-- bookcase at 32372,31767,7
	{
		itemId = 2435,
		itemPos = { x = 32372, y = 31767, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Puldraks wisdom about minotaurs Pt. 2
The only minotaurs reaching old age in these times of war were those who were born with physical disabilities or who were crippled but not killed in battle. This class of minotaurs was the only one who could live long enough to learn skills not directly connected to war. Since they were almost always the only ones who could gather enough experience and wisdom to create new ideas and concepts, the younger warriors begun to look at them as parents and advisors. Slowly these elders were able to change the war culture of the minotaurs. One charismatic minotaur in particular, Akkor, who was born blind, became the founder of the new minotaurian philosophy. He shunned the rage as a curse of the god Blog. Consequently, the minotaurian religion, which due to the extremity of martyrdom and rage never had a real chance to develop, turned away from the raging one. Slowly new concepts were adopted and great efforts were undertaken to hold the rage at bay. Meditation and self-control became the foremost duties of any warrior. The minotaurian ideal turned towards role models who were in control of body and mind. Since fiery rage was in minotaurian nature, young minotaurs were trained from early on to control themselves. It was through meditation that the minotaurs developed art and soon philosophy. Complicated ceremonies for usually simple things of daily life were developed to focus the mind, to be aware of each second of life.]] },
			{ itemId = 2816, -- book
				text = [[
Puldraks wisdom about minotaurs Pt. 1
Minotaur society rejects the raging of Blog. In the past, the berserker rage of the minotaurs was feared by all their enemies. But this rage had cost more than one life and some of the most promising warriors died young on the battlefields. Heavy casualties caused their numbers to decrease dramatically. The minotaurs withdrew from the wars, but in a world gone mad, skirmishes with other races were part of their daily routine. The demise of the whole race continued. As the minotaur race became nearly extinct in the fights, they found refuge in caves, adopting a lifestyle much like their ancient enemies the dwarfs.]] },
		},
	},
	-- bookcase at 32389,31998,7
	{
		itemId = 2438,
		itemPos = { x = 32389, y = 31998, z = 7 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Trollbreeding made easy.]] },
		},
	},
	-- dead human at 32402,31059,7
	{
		itemId = 4240,
		itemPos = { x = 32402, y = 31059, z = 7 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Diary of Captain Ogden Brewboiler

Day 1:

It is a miracle that we survived this hurricane last night. After several hours of fighting against the elemental forces, the gods decided to bring us here, wherever that may be. We are glad to have solid ground under our feet even though it only seems to be sea ice. Everyone is exhausted so we will start to explore that area not before tomorrow.

Day 5:

What a mess! Every morning, since the day we stranded on this cursed piece of frozen water, one of my crew members disappears or lies dead in his berth terribly battered. Something evil is going on here and I swear to find out what that is... if I stay alive long enough.

Day 7:

Last night, we have been ambushed. About two dozens of small, furry creatures launched a well organised attack against us. The rest of my crew was without the slightest chance. I managed to hide myself here in my cabin without being recognised. I am such a coward, it would have been better if I had died with my crew.

Day 10:

In the last three days, I continued to explore the area around here and made an exciting discovery. To the south, there is a small ice cavern in which one of those beasts is hiding. It behaves quite differently than its fellows. As far as I can judge, this one is not hostile. Maybe it is possible to get in contact with it and gather some information about its species.

Day 13:

I found out that they call themselves “chakoya” and the only thing they really like is fish. Nothing but fish. However, the one in the cave is very picky and doesn't like the 'usual' type of fish. The creature seems to be hunted by its species but I don't know why. I have to be careful. After I left the cave, I saw a few of its fellows which were patrolling the area. I hope they didn't see me.]] },
		},
	},
	-- unknown object at 32483,32495,7
	{
		itemId = 28462,
		itemPos = { x = 32483, y = 32495, z = 7 },
		contents = {
			{ itemId = 2822, -- map
				text = [[
A map of several known as well as completely exotic locations.]] },
		},
	},
	-- bookcase at 32587,31961,7
	{
		itemId = 2438,
		itemPos = { x = 32587, y = 31961, z = 7 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Vampire Hunter's Handbook II
Vampires can be immobilised, also for a very long time, if the right method is used. If their physical body takes too much damage, it will go down. Sunlight will dry them out and even turn them into dust. If you drive a wooden object into the heart of a vampire, the flow of the vampire's tainted blood is stopped, leaving him completely helpless. It should be mentioned, though, that if the heart is partly missed or if the object is not large enough, the vampire might still be able to move.
Since a vampire is dead anyway, none of these methods allows to destroy a vampire for good. With enough time and blood, a vampire can recover from any of those seeming deaths. The only known way to permanently defeat a vampire is to kill him with a blessed stake. A blessed stake, however, is a rare object that cannot be obtained easily.]] },
			{ itemId = 2821, -- book
				text = [[
Vampire Hunter's Handbook I
The vampire is a beast created by evil, a parasite that needs the blood of the living to sustain his own parody of life. It is also a plague that spreads quickly if not fought by adequate means.
A vampire is no longer a living being. When turning into a vampire the soul of the former living being is destroyed and with it also its emotions and certain values. They are replaced by something evil and malignant. Where there was love, there is now desire; where there was valour, there is now cold-heartedness. Every positive aspect of life is transformed into a mockery, just like the whole vampire is a mockery of life.
The bite of a vampire is infectious. Sometimes, the now poisoned blood spreads through the body of the victim and raises it from the dead as a new vampire. This happens mostly when the vampire drains the victim slowly of it's blood.
There are cases in which a vampire visited its victim over several weeks or even months, slowly stealing their strength and leaving their evil stigma. Such victims raise much more likely as a vampire than victims that were robbed of there blood in a few minutes.
A vampire depends on the blood of others. If a vampire is not able to drink blood on a regular basis, it will wither and dry out, until it finally crumbles into dust.
Vampires are nocturnal creatures. They fear the sunlight because it evaporates the tainted and stolen blood in their veins. Sunlight greatly accelerates the process which lets vampires dry out. Only a well-fed vampire is able to resist the sunlight for a while.
The senses of a vampire are sharpened similar to those of predatory beasts. Still, just like these beasts, it is possible to chase them with the appropriate skills. Garlic, for example, is able to overload a vampire's senses. For this reason, vampires avoid garlic whenever possible.
Vampires also seem to have a special bond to certain animals. Wolves, rats and bats are often found in the company of a vampire. They are even able to shapeshift in such an animal. As the transformation into a bat is the most common one among vampires, it is assumed that it is also the most natural one for them.
Other animals, however, are rather scared by vampires. Horses sense vampires very easily and express great fear near a vampire's grave.
Even though vampires usually keep their human appearance, they share the physical strength of other undead. By applying this strength more conscious than other undead they are even more powerful. Their unliving body is able to withstand a large amount of damage, depending on the amount of blood that they've consumed recently. The body rather soaks the damage than to repel it. This can probably be explained with vampires being rather shadows than true bodies, for the same reason they lack a mirror image. However, it is said that vampires can manipulate the mind of others, making them believe that they see a reflection.
Some vampires are able to use this shadowy state of their body to become a cloud of darkness that is completely invulnerable to physical damage. However, all reports of using this special ability tell about very old vampires. It seems that vampires grow more and more powerful with each decade or century they live their undead lives.]] },
		},
	},
	-- bookcase at 32587,31962,7
	{
		itemId = 2439,
		itemPos = { x = 32587, y = 31962, z = 7 },
		contents = {
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
			{ itemId = 2825, -- book
				text = [[
I've been hunting vampires since the days your grandfather's grandfather was an infant. So you better listen to me, otherwise you might end up dead. Even if you listen to me, there is a good chance that those beasts will get you. I don't care why there are vampires and when they came here. The only thing that matters is that we will outlive them!
Don't think about them in terms of beings. They're nothing than beasts, trust me. They are cunning and deceptive, but still beasts.
Don't fall for their nonsense of being the rulers of the night. There is no dark curse, it was their own choice to become a vampire. They feed on humans because they are placing their own stinking existence above all else, and as I said, this was their own choice.
Vampires came to the mining colony in which I was living with my family. There were many of them, they were clever, they knew how to use magic, and they wielded dangerous weapons. My people had nothing. They killed some to still their thirst for blood, and many just for fun. We fought them in the tunnels, armed only with a few tools. At last we managed to let the tunnel collapse to kill the majority of us. This way they were at least no longer able to use us as source to satisfy their thirst for blood.
It was my curse to survive. It took me three days to dig myself out of the tunnel. Then I was found by the inquisitors that were chasing the vampires. I stayed with them for a while, accompanying them on their vampire hunts. But they were humans and their lives were short, so they attended other matters at some point. I left them and joined other hunters, and travelled the world.
I have killed my share of vampires in all those years, some weak, some strong. I learnt to fight, I learnt to run, I learnt their weaknesses, and I learnt their strengths.
Whenever you think you know all about a trade, you learn something new. If you fail to learn, you'll die. I've known many good people that died while hunting vampires. It took a few hundred years until I considered myself as quite good in this trade.
There is one weakness all vampires have in common: they're cowards. They proved this already when choosing the life of a vampire instead of facing the feared death. They prove this at each sundown when they rise again instead of ending their miserable existence. They prefer to spread their curse than to stop it. Selfishness is their main motive. Even though they form packs just like other beasts, they know no loyalty or support when danger arises.
Listen, I'm supposed to train you in the art of vampire hunting. But that's not how it works. If you are a fool, I cannot train you to be a genius. I suppose you know how to fight, else they would not have sent you. To learn the tricks of my trade, arm yourself with a blessed stake and hunt some vampires. Bring me their dust to prove your worthiness.]] },
		},
	},
	-- bookcase at 32587,31963,7
	{
		itemId = 2440,
		itemPos = { x = 32587, y = 31963, z = 7 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
The Origin of Vampires
Since the vampiric curse is spread through infectious bites, many vampires know only little about the origin of their kind. Then again the longevity or even immortality of vampires makes it possible that they have even existed before the creation of mankind.
Of course such beasts are hard to capture and they do not like to share their knowledge. Even if you are lucky enough to be able to talk to one, you cannot be sure if he is telling the truth. In fact, most questioned subjects were making up stories and boasted about their importance, age and accomplishments.
Lacking historical knowledge, such individuals can usually be cornered by accurate historical questions. This leaves a few sources that can be seen as credible to some extent. Still, their reports are diverse and share only a few facts. These common facts are the most reliable information we have these days.
The vampires claim that the eldest of their kin still remember a time when humankind was still divided in nomadic tribes that suffered in the wars of the gods. Some see this as a reference that the creation of the first vampires took place before the Corpse War.
The majority of vampires agreed that there was only one shrouded forefather vampire, though few mention also a small coven from which the vampire plague was initiated. The most reliable sources tell about some 'lost kingdom' where the first vampires ruled over a herd of humans that they treated like cattle.
At some point in history, the younger vampires rebelled against the elders who suppressed them. Others claim the rebellion took place to gain power in this static aristocracy in which the older vampires would have never made room for the next generation due to being near to immortal. It is unknown which side won. In fact the discrepancies in the single stories are so large that we assume that the vampires themselves are unsure about the happenings in these obviously chaotic days. Some claim the rebels won and chased the aristocracy away, others say the ruling cast won and met the rebels with such brute force that the few survivors could only flee. Then again there are stories that the fight between the vampires awakened something evil which drove the surviving combatants off their once safe haven. A few stories even claim that the humans used this opportunity to rebel against their cruel oppressors.
There are no hints about the location of this lost vampire kingdom. It is assumed that it was somewhere overseas, though. Some historians suggest Edron, but, the ruins in Edron are said to origin from much earlier times. Others assume it might have been on the mysterious continent Darama, either in Drefia or in Ankrahmun. However, the destruction of Drefia took place much later and there were no reports about undead activity, except for the works of several local necromancers, before this time. Ankrahmun, on the other hand, has a very accurate historical library and there is no such thing like a vampire kingdom mentioned at all.]] },
			{ itemId = 2827, -- book
				text = [[
The Blood Curse
Sages claim that we owe vampires to the dark deeds of some gods or demons. Some say, Urgith created them as a new tool for his wars. Others believe that vampires are an undead variation created by some powerful but not godlike being, very likely by one of the Ruthless Seven. Some think vampires are made by the Lord of the undead, other see Verminor as their creator. Again others see vampirism as some kind of curse.
It is said that the first vampire was a powerful warrior king who successfully fought the undead in the Corpse War. Being promised forbidden power and unification with his beloved ones, a once loyal follower of the king became the pawn of the dark powers. He poisoned his liege, probably over several months, using some nasty mixture which was handed to him.
As the king became sick and no one was able to heal him, the traitor stepped forward with a strange medicine. Trusting in his beloved servant, the king drank the medicine which actually was the blood of some servant that had been murdered recently. The medicine seemed to restore the king's strength, so the traitor had no trouble to feed him with more blood. Soon the king's appearance started to change. His aversion to sunlight and his paleness were attributed to his illness, but also the king's temper and behaviour turned more and more violent and aggressive. Nonetheless, the people loved their king and put up with his moods.
The traitor fuelled the king's growing paranoia with lies, so it was easy to convince him to get rid of certain court members. One by one the loyal advisers were removed and replaced with dark cultists. When the king was cut off from any loyal support, they stopped to give him blood and his illness returned, even worse than before. When he convulsed in pain and agony, they presented him a peasant to drain blood from. Almost insane by his ravenous thirst, the king accepted this sinister gift. As soon as he realised what was happening, he went berserk. In a fit of rage, he slaughtered each and every cultist that he encountered, but in the end they trapped him in his castle. The survivors fled with the corpse of the peasant who soon rose as a vampire. They drained him of his dark blood and killed him. Then they drank the blood to become vampires themselves.
The king was finally freed by loyal subjects. He had turned into something he had fought his whole life - an undead. It is said he left his castle in that very night, some say to hunt the traitors, others claim to end his undead life.]] },
			{ itemId = 2824, -- book
				text = [[
The Shadows of the Vampires
The vampire plague had its origin in mortals dabbling with the dark arts.
In the wake of the Corpse War, several humans began practising forms of necromancy for one reason or another.
Some saw the seemingly overwhelming powers of the undead and desired them for themselves. Others desperately tried to discover some countermeasures for the undead threat.
Researching for either good or evil, a small cabal of people studying necromancy became infected or cursed, slowly turning them into ghouls themselves. The change was slow enough for the necromancer fledglings to try to avert this change with any means possible. They came up with several methods, mostly based on alchemy. At long last they turned distilled human blood mixed with several forbidden ingredients of demonic origin into an effective potion. Not only did the potion end the rotting transformation, it also revitalised the drinker, making him feel healthier and stronger than ever before. It seemed to be an immediate success.
After the entire cabal received the 'cure' it quickly became obvious that the success was only temporal at best. Soon they began feeling weak. Human food offered them nourishment no more. Again and again they were forced to revert to their potion. Trying desperately to find a permanent cure, they varied the original formula, to no avail.
Two of the brightest minds of the cabal finally joined efforts in their research, refusing to let others participate. This slowed them down in their experiments. At long last they came up with a theory that the blood of one of their 'kind' just might be the cure they need.
Instead of carefully draining themselves and exchanging the blood, they started an argument over who should be the first to be cured. Soon the argument got out of hand, resulting in a fight about who had made the discovery and who deserved the praise. A fight of words turned into a fight of fists, one of them ended up dead and the unwilling donor of the much needed blood.
The survivor indeed felt cured, even better than before. He disclosed his research to his fellow necromancers, declaring the death of his colleague an accident. The others were too interested in the cure to truly care, eager to be cured themselves. Though blood was gathered and exchanged it did little to cease the transformation, let alone stop it. The 'cured' necromancer soon figured out the blood had to be taken from a living donor in such a mass and speed that the victim would surely die.
Secretly he shared this knowledge with his most trusted brethren. They slew the others by night. After the initial shock the victims fought back. More than half of the cabal met its demise in this fight. Only few escaped, doomed to become nearly mindless ghouls.
The others learnt soon enough that the supposed cure only stabilised their semi-undead state in some way. Though no longer dependent on complicated alchemical potions, they knew that only the blood of the living would quench their thirst. Also, they were able to infect their victims with some strange strain of their own illness, making them the first true vampires with the attributes and vulnerabilities that are known to us today. It was not possible to recreate the original illness or curse that in combination with several not documented potions initially turned the cabal into unliving things.]] },
		},
	},
	-- small bamboo shelf at 32629,32800,7
	{
		itemId = 2464,
		itemPos = { x = 32629, y = 32800, z = 7 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Report 13XAH07

These ape men have been causing turmoil once again. Their raids have become more frequent with each month since the rain season has ended. I guess they don't like showers. Given their savageness and unpredictability it is not easy to come up with a counter strategy. It is obvious that the majority of the apes are trying to distract our guards while others sneak in and steal equipment of all sorts. Some of them are agile like ... well, like monkeys. Hard to catch - and they are sort of escape artists and might hide right under the ceiling. I even had one report of a citizen finding a monkey hiding in his depot box after a raid. Given the number of men at our disposal it is impossible to defend each and every side of the settlement. No sort of barricade would be of any help considering the nature of our attackers.

They get into and out of our fort just as it pleases them, and even the upper levels of the town that have proven to be safe against other beasts of the jungle are no hindrance to them. I see no real option to stop those attacks unless an army is sent here to find the apes' base of operation which seems to be somewhere in the north eastern jungle.]] },
			{ itemId = 2814, -- parchment
				text = [[
Report 67ABFG33

Captains report an increased activity of pirates on the routes from Port Hope to Thais and Venore. I support the traders' demand that the king should intervene. A well armed warship with some experienced fighters would not only secure the routes, but also boost our line of defence in Port Hope. With their support we could fight back such enemies like the ape men - or even capture Trapwood, an area rich in bamboo that is populated by those murderous dworcs.]] },
			{ itemId = 2814, -- parchment
				text = [[
Report 27AAF36

Although offered with the best intentions, the reward the tradesmen from Venore had put on monkey tails was revoked after a while. Even though many adventurers and soldiers of fortune had been able to pick up their rewards, the situation was worse than ever as the ape raids came even more frequently and ferociously. The loss of lives and the senseless destruction of property had increased enormously. Sadly Jorgin Beargin, the spokesman of the Venoran traders, was called back to Venore to report about the recent losses.

The traders are now asking us to keep adventurers from provoking the ape men in any way. I fear we cannot offer much assistance in that matter since those "tail hunters" are numerous and usually well armed but we will try our best.]] },
		},
	},
	-- small bamboo shelf at 32629,32801,7
	{
		itemId = 2464,
		itemPos = { x = 32629, y = 32801, z = 7 },
		contents = {
			{ itemId = 2814, -- parchment
				text = [[
Report 78ACFF04

The usual turmoil when the QUEEN GENOVEVA is in town - the sailors, drunk as always, stood out with their usual misbehaviour with the result that one of them spilled the beer of a local dwarf. In the following fight a lot of property was destroyed and even lives were endangered. I sent word to Thais that such events destroy the peace of our colony and that we would probably do better to rely on the more disciplined seamen of Venore who are more accustomed to the hardships of long journeys than the men of the Thaian marine. A letter written by the local traders strongly supporting my point has been enclosed.]] },
			{ itemId = 2814, -- parchment
				text = [[
Report 67ZUFL90

Death caused by venomous local animals and by enemies using poisonous weapons against us are becoming more and more common. The traders of Venore gladly offered a vast supply of antidotes and suggested forming a monopoly to ensure the quality of the products and to stop scammers before their adulterated potions cause the deaths of innocents.]] },
			{ itemId = 2814, -- parchment
				text = [[
Report 34DFOO12

We still cannot figure out who or what caused the disappearance of Oliver Holmes. Aforesaid mage from the Noodles Academy of Magic Arts came here to study the different cultures of the area. After three days of preparation and planning, his room was found empty. His bed was unused but his clothes lay neatly folded on a chair as if he had undressed. There were no signs of a fight and the door had been locked from within. It is a complete mystery why or how he disappeared.]] },
			{ itemId = 2814, -- parchment
				text = [[
Report 56IOLP56

The respectable mage Borsoz was able to provide us with a cure for the so-called 'jungle fever'. People repeatedly reported some kind of 'out-of-body experience'. While sleeping, they suddenly stood beside their own body and watched over it. The magician proved that the 'fever' actually was caused by a small bug. This bug injects a mildly toxic hallucinogen into the body of a sleeping person causing the mentioned phenomenon. Borsoz developed a paste that, when applied to the walls and the floor, keeps those bugs away. All settlers were provided with the paste and the "fever" has been efficiently eradicated.]] },
		},
	},
	-- bookcase at 32686,31657,7
	{
		itemId = 18485,
		itemPos = { x = 32686, y = 31657, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Elven names are chosen in adulthood. Until they acquire a name, elves are called 'son/daughter of ___' usually naming the parent with the same gender. Upon reaching adulthood, the young elf gets his first name, divined by the elders who know him in dreams. It is merely a single name, a description of the elf in the elven tongue. Usually elves love to add a translation of their name which is often mistaken for a second name by other races. Since the elven language is far more complicated and has thousands of nuances, often elves with the same 'second name' have a different first name, confusing the other races even more.]] },
		},
	},
	-- bookcase at 32688,31656,7
	{
		itemId = 18482,
		itemPos = { x = 32688, y = 31656, z = 7 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
Even before the creation of the humans, there have been several occurrences that can only be interpreted as attacks by demonic armies trying to stop the creation process. Inhuman sources tell of several armies that invaded our world in the course of many centuries.
Most of these invasions could be tracked to some unholy centre of magic. From there immense forces were evoked to open a gate through which the demonic armies entered our world.
The gate was opened, an army passed through, and the gate eventually closed again. The invading armies had no supplies and were finally destroyed. The demonic leaders made only rare appearances on the battlefield, probably summoned by their minions for a while. So contrary to common belief, it seems possible that a large demonic army enters our world if certain conditions are met. It should be our top priority to find out what conditions this may be.]] },
			{ itemId = 2816, -- book
				text = [[
The Deraisim had become homeless in the wars. As nomadic wanderers they hid in the woods, setteling nowhere for a longer time. Their families joined each other to travel together for a while, only to disband again soon whenever an area could not supply them all any longer. Hunted by countless enemies and almost everytime outnumbered when it came to fights with 'neighbours' they retreated into the deepest woods where the greater number of their foes was evened out. There they created encampments they visited now and then. They had contact with many creatures and cultures. They adopted ideas and inventions that suited their nomadic lifestyle and begun even a very cautious trade with other races to aquire things they were not able to build on their own. As the attention of the other races turned more and more away from the elves and wars broke out between them, some of the elves begun to live at their up to then only part time ecampment on a permanent base. Adopting what they had seen from other races and things they vaguely remembered from their own past some trading posts were established in this way. Usually only one to three families lived there. After the reunification with the Cenath the majority of them could be convinced to give a permanent settlement a try and the biggest tradingpost became the settlement Ab'Dendriel. Some families refused to join their brethren and continued to wander the world, only visiting the city now and then, each vistit convincing them more that they have only little in common with the Deraisim anymore. So they begun to see themselves as Abdaisim and continued to be the nomads and restless wanderers of elvenkind.]] },
		},
	},
	-- bookcase at 32689,31656,7
	{
		itemId = 18483,
		itemPos = { x = 32689, y = 31656, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Minotaur society rejects the raging of Blog. In the past, the berserker rage of the minotaurs was feared by all their enemies. But this rage had cost more than one life and some of the most promising warriors died young on the battlefields. Heavy casualties caused their numbers to decrease dramatically. The minotaurs withdrew from the wars, but in a world gone mad, skirmishes with other races were part of their daily routine. The demise of the whole race continued. As the minotaur race became nearly extinct in the fights, they found refuge in caves, adopting a lifestyle much like their ancient enemies the dwarfs.]] },
			{ itemId = 2816, -- book
				text = [[
The only minotaurs reaching old age in these times of war were those who were born with physical disabilities or who were crippled but not killed in battle. This class of minotaurs was the only one who could live long enough to learn skills not directly connected to war. Since they were almost always the only ones who could gather enough experience and wisdom to create new ideas and concepts, the younger warriors begun to look at them as parents and advisors. Slowly these elders were able to change the war culture of the minotaurs. One charismatic minotaur in particular, Akkor, who was born blind, became the founder of the new minotaurian philosophy. He shunned the rage as a curse of the god Blog. Consequently, the minotaurian religion, which due to the extremity of martyrdom and rage never had a real chance to develop, turned away from the raging one. Slowly new concepts were adopted and great efforts were undertaken to hold the rage at bay. Meditation and self-control became the foremost duties of any warrior. The minotaurian ideal turned towards role models who were in control of body and mind. Since fiery rage was in minotaurian nature, young minotaurs were trained from early on to control themselves. It was through meditation that the minotaurs developed art and soon philosophy. Complicated ceremonies for usually simple things of daily life were developed to focus the mind, to be aware of each second of life.]] },
			{ itemId = 2816, -- book
				text = [[
To become an educated warrior-philosopher became the goal of all minotaurkind. Uncontrolled rage was considered to be primitive from then on. A minotaurian warrior is skilled as an artist, often found conentrated drawing, reciting or creating poems and wielding a weapon with awarenes and cold hearted skill. The warriors of the uppermost class are usually so well educated they control some amount of magic, often used to augment their own strength and defense. They are the heroes and role models of the lower class. The minotaurs still have a warrior culture, but the understanding of a true warrior has changed dramatically.

Minotaur cheese is a specialty, often envied by decadent human nobles.]] },
		},
	},
	-- bookcase at 32692,31656,7
	{
		itemId = 18482,
		itemPos = { x = 32692, y = 31656, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Manasphere
by Rail Ashkil

The whole planet is surrounded by an energetic field called "Manasphere", produced by "Mother Nature". Nearly every living being is able to tap it and store a certain amount of this "mana". Even less beings are able to use this energy to produce light etc. In most cases the user will "cast a spell" - but only to concentrate on his natural abbility of mana-using. Some beings, dragons e.g., seem to use the mana more instinctively but nevertheless with great efficiency.]] },
		},
	},
	-- bookcase at 32692,31658,7
	{
		itemId = 18482,
		itemPos = { x = 32692, y = 31658, z = 7 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
I, Vampire
Our race, if my dear reader allows me to use that term, is a rather curious one. One might argue that we are a side strain of humanity. As far as I see it, the human body is all but a catalyst for a most formidable transformation. With the transformation an all new world of opportunities and impressions awaits. It is an awakening. Several things, such as coldness and tiredness cease to exist for a vampire. The focus of existence is no longer bound to tiresome daily routines and can be aimed at something bigger and more important. The weak and fragile mortal body becomes a sophisticated tool that does not lose its function due to illness or old age. Seeing the mortals suffer under such influences alienates a vampire somewhat from humanity and makes it ever more clear that we are different. Humans and vampires are set apart from each other. We remember mortality and see its weaknesses. We mourn the mortals even though our highly evolved existence raises us high above them. The wisdom we gain with our age is great. Freed of the shackles of mortality we have a clearer view of things. Knowing the envious fear with which some greedy and selfish humans view us, we hide from the eyes of overzealous inquisitors and clergymen. Behind the scenes we guide the humans through history, supporting the worthy and eliminating threats to humanity. We are the unseen movers and makers that hold kingdoms together, furthering ideas that improve societies and boosting discoveries. Not for gratitude, but to fulfil the obligation of passing some of our fortune on to those that are not as fortunate. A selected few grasp our status and have the greatness to live with their inferiority. In their own meek way they try to help us in our noble efforts. They are worthy above all others to become one of us one day. We do not take new vampires lightly of course. It can be a challenging and long journey to join our ranks. With diligence and intelligence a human might eventually convince a vampire of his worth.]] },
		},
	},
	-- bookcase at 32693,31656,7
	{
		itemId = 18483,
		itemPos = { x = 32693, y = 31656, z = 7 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
The Blood Curse
Sages claim that we owe vampires to the dark deeds of some gods or demons. Some say, Urgith created them as a new tool for his wars. Others believe that vampires are an undead variation created by some powerful but not godlike being, very likely by one of the Ruthless Seven. Some think vampires are made by the Lord of the undead, other see Verminor as their creator. Again others see vampirism as some kind of curse.
It is said that the first vampire was a powerful warrior king who successfully fought the undead in the Corpse War. Being promised forbidden power and unification with his beloved ones, a once loyal follower of the king became the pawn of the dark powers. He poisoned his liege, probably over several months, using some nasty mixture which was handed to him.
As the king became sick and no one was able to heal him, the traitor stepped forward with a strange medicine. Trusting in his beloved servant, the king drank the medicine which actually was the blood of some servant that had been murdered recently. The medicine seemed to restore the king's strength, so the traitor had no trouble to feed him with more blood. Soon the king's appearance started to change. His aversion to sunlight and his paleness were attributed to his illness, but also the king's temper and behaviour turned more and more violent and aggressive. Nonetheless, the people loved their king and put up with his moods.
The traitor fuelled the king's growing paranoia with lies, so it was easy to convince him to get rid of certain court members. One by one the loyal advisers were removed and replaced with dark cultists. When the king was cut off from any loyal support, they stopped to give him blood and his illness returned, even worse than before. When he convulsed in pain and agony, they presented him a peasant to drain blood from. Almost insane by his ravenous thirst, the king accepted this sinister gift. As soon as he realised what was happening, he went berserk. In a fit of rage, he slaughtered each and every cultist that he encountered, but in the end they trapped him in his castle. The survivors fled with the corpse of the peasant who soon rose as a vampire. They drained him of his dark blood and killed him. Then they drank the blood to become vampires themselves.
The king was finally freed by loyal subjects. He had turned into something he had fought his whole life - an undead. It is said he left his castle in that very night, some say to hunt the traitors, others claim to end his undead life.]] },
		},
	},
	-- bookcase at 32693,31658,7
	{
		itemId = 18483,
		itemPos = { x = 32693, y = 31658, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Like most of the elder races, elves feel used and abandoned by the gods. The only gods some of them worship is Crunor, whom they call the "Treefather" and see him as bringer of life. Some of the elves prefer to pray to the raw elemental powers of earth and air. Mostly in the Kuridai caste the earth cult is more prominent than Crunor, and it is said that their complicated 'prayers' are more like summonings or invocations. It is believed by elvenkind that in their history seven elven lords acquired the status of celestial paladins and therefore are godlike beings. Worshipping them is a very personal matter though. It is certain that different high lords are more prominent in different castes but prayers and interpretation of the high lords is only shared on family level at best, usually each elf finds his own approach to some of the high lords, completely ignoring the other ones.

Mortiur - the ravager, prominent for some sects. The avenger, merciless against friend, foe and himself

Nera - the lady of spring (flowers, growth) completely replacing Crunor for some elves.

Dseyvar - the sworddancer, responsible for the grace of the warrior, elven warriors have to be graceful not chivalrous.

Priyla - the daughter of the stars, mystery and magic

Krynierr - the silver tongue, poetry, love and music

Azmoda - the vieled one, mysterious figure. Mistress of schemes, cunning and deception.

Evicor - the wanderer. Master of the hunt, the explorer]] },
		},
	},
	-- bookcase at 32694,31658,7
	{
		itemId = 18482,
		itemPos = { x = 32694, y = 31658, z = 7 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Seeds of Life
Spring is the time when the powers of the vital force are strongest. It is this time of the year when everything is growing and nature is vibrant of life. But not only nature is growing and giving birth, also the pure force of life is pulsating with energy and the power of creation. This energy often enters in living beings, making them stronger, healthier, and more fertile. Sometimes it enters in seeds of the most diverse plants. No one can tell what kind of plant may grow from these seeds, but many creatures instinctively feel the vital force in the seeds and collect them. Some creatures of nature think of these seeds as holy relics. They cannot stand the thought that those who they regard as defilers of nature could gain possession of such seeds. Therefore, the activity of those who see themselves as preservers of nature is unusually high in spring. Dryads and other creatures of nature who are hardly ever seen for the rest of the year suddenly appear in great numbers and often pose a threat to unwary travellers of the woods. The fact that the powers of the vital force infuse them with additional energy makes matters only worse. For some time, whole forests might be impassable while the trees seem to come alive. Roots try to snare and trap travellers, walls of rapidly growing tendrils and thorns block passages, and dryads and tree spirits ambush exhausted and tired travellers. Still, not all dryads are that hostile. Some of them are even willing to trade these special seeds for other items or help the finder to cultivate the seed into a magnificent plant. Sadly such helpful spirits are rare and as capricious as all dryads. So you never can be sure what exactly to expect from them. Stories are abound in which dryads deal seemingly peacefully with humans only to turn them into trees once they have earned their trust. Other stories tell about dryads that kidnapped humans and took them into their homes in some ancient tree where they had to work as servants forever. There are even stories about people who went to the dryads to trade with them or get some advice, and when they returned from their trips which had only lasted a few days, years or even decades had passed in their hometown. Of course most of these stories are fairy tales, exaggerations or outright lies, but mortals are well-advised to be extremely careful when dealing with dryads.]] },
		},
	},
	-- bag at 32794,32227,7
	{
		itemId = 2853,
		itemPos = { x = 32794, y = 32227, z = 7 },
		contents = {
			{ itemId = 3506, -- stamped letter
				text = [[
Dear son! Don't forget to drink your warm milk if the nights are too cold. And don't trust the one-eyed brutes! Be careful.

With loving Moohs,
your Mom!]] },
		},
	},
	-- bookcase at 32855,32330,7
	{
		itemId = 2435,
		itemPos = { x = 32855, y = 32330, z = 7 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
...
...ut we have to ...
...
Now that the Plains of Havoc are
to dangerous for a safe passage,
we will leave the Isle of the Mists
and abandon this meeting place.
Hopefully we will be able to reclaim
it in better times. If any ...
...]] },
		},
	},
	-- pile of bones at 32898,32791,7
	{
		itemId = 4285,
		itemPos = { x = 32898, y = 32791, z = 7 },
		contents = {
			{ itemId = 641, -- piece of paper
				text = [[
(You see a scrap of torn paper. The writing on it is blood-stained and barely legible)

...evaluation of the variety of local poisons and their medical use.
... dworcs' poison and antidote expertise is unrivalled, but contact ... most inimical due to the dworcs' unfortunate belief that humans taste rather nice.

...Two of our group, the youngest, have been infected by the careless handling of toxin samples from strange flowers, and are hallucinating badly. ... no time to search for an antidote. Still, I owe it young Jenkinson and Abrams to at least try to find some help.
... saw and heard a ritual close by.
... are watched by the dworcs, but so far, they have not attacked. Maybe I can come to some sort of arrangement.
... trapped. It seems part of the ritual to let us anticipate the worst...
Waited for him to die of that slow poison before sacrificing Abrams to whatever god it is they believe in, and his heart is now being devoured by the disgusting ...
... must warn anyone who reads this not to make the same mistake I did. ... too late.]] },
		},
	},
	-- pile of bones at 32949,31810,7
	{
		itemId = 4285,
		itemPos = { x = 32949, y = 31810, z = 7 },
		contents = {
			{ itemId = 25242, -- notes of a poacher
				text = [[
Some days ago I brought down a wolf with three still very young whelps. I didn't kill the puppies because I heard that the orcs are paying a nice little sum for young wolves. They are training them to serve them as war wolves when grown up. Unfortunately one of them escaped and ran into the woods. I didn't go after it, I didn't want to risk losing the others, too. One day later I could spot a female wolf who had adopted the lost puppy. I recognised it by its unusual fur pattern. I didn't chase it because I was short of supplies and thus on my way to Edron. I would have missed my ship. The second whelp died shortly after. Given its weakly condition I assume the orcs wouldn't have paid for it anyway. I skinned it and sold the fur in Venore to a trader who was interested in fabrics and pelts. I can't remember her name but she was quite a poppet. Now I'm on my way to Ulderek's Rock and hopefully will make a mint of money by selling the third puppy to the orcs.]] },
		},
	},
	-- chest at 32962,32429,7
	{
		itemId = 2472,
		itemPos = { x = 32962, y = 32429, z = 7 },
		contents = {
			{ itemId = 3029, count = 1 }, -- small sapphire
			{ itemId = 3031, count = 50 }, -- gold coin
			{ itemId = 2822, -- map
				text = [[
Polly, barmaid in Port Hope (likes shiny things, doesn't like beer)
Sally, seamstress in Venore (never paid for that coat she made)
Dorothy, shipwrecked in Cormaya (cute, naive, definitely waiting)
Angelica, Laguna Island (memo: get my cutlass back from her)
Tricia, Liberty Bay (has an angry brother, bring pistol)
Suzanne, Drefia (tastes of cherry, have to visit again)]] },
			{ itemId = 637, -- document
				text = [[
To Captain Starbird, Port Hope, Juggling Mermaid's Inn.

Rodney, ye hairy ol' walrus, I hope this finds ye in good health and spirits and a fair maiden in each arm, too, I wager.
As we had to scarper from that last and somewhat heated appointment with the fleet, I took the liberty of deducting my travel expenses from the contents of this here treasure chest. Shiver me timbers, what a blow my ol' Red Ruby took! It's three months' repair at least before venturing out for the next likely booty for us.
Well, take the rest for a merry round of quaffing with the boys, and we'll meet at the usual place at the usual time.

Yohoho,

Captain Jack Rumgut]] },
		},
	},
	-- drawers at 33143,32867,7
	{
		itemId = 2434,
		itemPos = { x = 33143, y = 32867, z = 7 },
		contents = {
			{ itemId = 2820, -- sheet of paper
				text = [[
Researchpaper 02-56 A
The work on the cat-eye spell is progressing well. Soon we will be able to reproduce this spell that is used by several of the elder races. Once this has been accomplished we will finally be able to see in the dark without attracting unwanted attention. The problem is to stabilise the spell so it can be maintained during a predictable period of time. Also, the hurtful effect of sudden light to the spell caster must be palliated.]] },
		},
	},
	-- bookcase at 33145,32840,7
	{
		itemId = 2435,
		itemPos = { x = 33145, y = 32840, z = 7 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
The master of the games asked for 'greater challenges'. I cannot help the feeling that the fool is talking about djinns and demons. However, as long as I am chief advisor of the pharaoh this will not happen. If such a creature broke loose in the city, chaos would ensue. It would be a massacre. And I am convinced that certain elements would welcome such a 'misfortune' and even work towards it.]] },
		},
	},
	-- bookcase at 33146,32840,7
	{
		itemId = 2436,
		itemPos = { x = 33146, y = 32840, z = 7 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
In the 23rd year of the reign of Esuph III there was a tax inspector whose greed was unrivalled by any other mortal before or after him. He let the people bleed in the name of the pharaoh and amassed huge amounts of gold, most of which somehow ended up in his own private treasury. But Shehamin, the second wife of the pharaoh, was not a woman to be fooled easily. Using cleverness and charm she brought his schemes to light and told her husband about them. Esuph III was furious, and his verdict on the fraudulent tax inspector was as cruel as it was clever: The screaming tax collector was sunk into a cauldron full of boiling gold. The terribly distorted statue which as the result of this peculiar treatment was put up in the tax office as a grim reminder that fraud can seriously affect your health. The gold that was stolen by the tax collector, however, was never found, and to this day there are many who dream about finding the unfaithful tax collector's hidden treasure.]] },
		},
	},
	-- bookcase at 33147,32840,7
	{
		itemId = 2437,
		itemPos = { x = 33147, y = 32840, z = 7 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Since the contamination of the water reservoirs became more and more of an issue, Pharaoh Unklath ordered that the position of the right honourable excreminator should be founded. This position was decreed to be considered as honourable as that of the royal astrologer or the pharaoh's animal trainer.]] },
		},
	},
	-- bookcase at 33153,32840,7
	{
		itemId = 2435,
		itemPos = { x = 33153, y = 32840, z = 7 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
...we stood on a plank and beneath us was a pit full of hissing snakes. Worse, the plank was pulled back into the wall, and there was no way out. If it hadn't been for our good Alil who had stayed out of that cursed chamber in a rare moment of clear-sightedness, we would all have ended up as snake food. Just how he managed to find that hidden lever on the statue is still beyond me.]] },
		},
	},
	-- bookcase at 33154,32840,7
	{
		itemId = 2436,
		itemPos = { x = 33154, y = 32840, z = 7 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
Will the world never learn?
That pompous coxcomb of an ambassador dared to speak as though his king was equal to our pharaoh! We were shocked by the sheer impertinence of his speech! The fool! How confused he looked when he realised our disapproving silence. I am convinced he had spoken to some of those filthy heretics before he went to see his majesty. I know there are some although none of them would dare to make his blasphemous opinions known in the public. How could the mighty pharaoh not ignore this ambitious fool and his futile plans. How haughtily he walked around in our beautiful Ankrahmun, mocking our true religion with his silly questions. Of course, he got nowhere and he seemed to give up in the end. But did the wisdom offered to him enlighten his blind soul? I think not. So full of himself was he, so firm in his heretic opinions and yet such a slave to his flesh - how could he understand that which is true and holy? People like him are both a curse and a blessing to us, the children of enlightenment. They may insult and provoke us with their ignorance, yet it is when we meet fools like him that we realise the full extent of the glorious state of enlightenment we live in. Far from ascension though we are, we have been granted the opportunity to achieve what will be forever denied to people like him - divinity!]] },
		},
	},
	-- bookcase at 33155,32840,7
	{
		itemId = 2437,
		itemPos = { x = 33155, y = 32840, z = 7 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
Year 10 in the reign of Harrah II
The baker Thahon claimed that the wife of the merchant Habthi was guilty of witchcraft. Thahon could not bring forth convincing proof of her guilt and was sentenced to ten blows on his bare feet. The crafter Ziril claimed that the beggar Aukohl stole a cake from his open window. Although no proof was found there was a general sense of agreement that no proof was necessary since everybody was convinced of the beggar's guilt. In a rare display of mercy the judge sentenced him to a mere three years of work in the salt mines. The widow Zehmahil claimed that the travelling bard Todd Ballory had promised here mariage in
exchange for certain services that have not been further elaborated on in the court's documents. The foreigner was found guilty without trial and sentenced to three years of work in the salt mines. The footsoldier Kamahl claimed his father Indril was guilty of witchcraft. Several obscure texts were found beneath the accused person's bed. Indril was banished from the city and his property was equally divided between the pharaoh and his heirs. The foreigner Todd Ballory was pronounced guilty of killing the overseer Barnak, a father of sixteen children and a respectable member of the local whipcrackers' association. The aforementioned convict was sentenced to a rather spectacular final appearance in the local arena.]] },
			{ itemId = 2821, -- book
				text = [[
After thorough examination the Rathal I Pyramid was officially declared to be free of occult phenomena. The success of the ritual of purification performed by the responsible priests surpassed everybody's expectations, and the rather obstinate evil presence that was clearly the work of a person officially identified as one Ushu the witch by the authorities was dispelled. The suspect was traced to the mountains where she sucessfully hid from the agents of the witchhunting department. She is presently said to produce low-quality love potions in an unknown hideout somewhere in the western jungles.]] },
		},
	},
	-- bamboo shelf at 33254,31126,7
	{
		itemId = 2459,
		itemPos = { x = 33254, y = 31126, z = 7 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
I am nothing than an old lizard and I feel my time is coming. No longer I will shed of my skin, this time it will be my whole body. I was never overly religious but when death is knocking at your door, your attitude is changing and your perspective shifting. I have seen much in my long life. I worked many years as a scribe in the palace of King Tzuzak VII until I fell into disgrace due to an intrigue some higher officials played on each other. In retrospect I think it was for my best. Not only did I find a never known tranquillity and peace in my new life, but I also was spared by the great changes that turned the whole realm upside down. In my seclusion not only the plague passed me without causing any harm, I also missed the arrival and the rise of the dragon kings. Of course there were legends about dragons, but no one had seen any for the last few thousand years. Since their arrival a few years ago, I have only seen a few of them from afar but I can imagine the awe they are causing in each being that faces them. I heard only little about the changes that came along with them. I cannot say it is a bad thing that Tzuzak stepped back for a new ruler. For all I have heard, the dragon kings are not much worse than the bureaucrats that preceded them. What troubles me more is the change of the land that came along. Perhaps you need to be as old as me to notice this change. Each of the youngsters I made aware of some of the changes just shrugged them off. But I can see that they are there. I see that the fields yield less and less each year. Plants and animals grow in strange and unhealthy forms and colours. And it turns worse with every year. The source of this all seems to be somewhere in the north. I fear what the land will look like in a few decades. Alas, I won't be there to witness it.]] },
		},
	},
	-- chest at 33279,32388,7
	{
		itemId = 2472,
		itemPos = { x = 33279, y = 32388, z = 7 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Theory Of Ascension I
The idea of ascension is not one that originated from mankind. Throughout the ages many races have toyed with the idea of ascension, for a number of reasons and with different levels of success. While many human cults argue that it is Banor's godly spark which is in all of humanity that is the key to ascension, the pre-human ascension attempts prove otherwise. Though it may be argued that this godly spark, if it exists at all, might help in an ascension process, it is, depending on the intended course of ascension, no required element. It seems that initial godly energies are inherent to all elements of creation and, as such, could be extracted and concentrated. If such a godly spark in humanity would give humans a head start in ascension, there would have to be more ascended humans than members of other races; but as it is next to impossible to classify or identify an ascended being this is still up for debate. For instance, it can't be verified if the so-called gods of the elves truly exist and if they do, whether they truly were living beings once. It becomes even more obscure in the case of vanished races or those hostile to humanity, where little verifiable information is available.
Another fact complicating the matter is that as numerous as the paths to ascension are, as numerous are the results. As far as humanity can tell, the major gods have been around since the time of creation. There were no additions to their ranks at all. This would leave ascendant beings with only little spheres of influence and question their success altogether. But as we are not familiar with the structure of ascendant beings in general, it is hard to make a qualified statement about their doings at all. As we don't feel the hand of the accepted gods in our daily lives, it might be possible that this is even truer for ascendant beings, and their influence might be extremely subtle. In addition, it is hard to tell if ascension something that immediately sets in. It is entirely possible that ascension makes it necessary to accustom to a new existence and to only gradually tap into the acquired powers. So all we have to work with are claims of ascension or apocryphal texts that might hint at one. Unless we find means to verify an ascended status, it is futile to concentrate any scientific research on this topic. All we can do is to look into the theories and means to achieve an assumed ascension. It is universally agreed in any ascension theory encountered that the most integral (yet not necessarily the first) step is the acquirement of enormous amounts of energy. What kind of energy is needed is already up to debate. Most theories base on the belief that it is a spiritual energy which has to be acquired. How it could be gathered and contained is of course nothing different schools can agree upon. Regardless of this fact, the amount of energy itself has to be enormous.
Though it doesn't seem to be based on any real data, many ascensionists agree upon the fact that not everyone can ascend, but the individual has to be 'awakened'. This universal term has a variety of meanings in the different theories, however. Usually it is connected to some magic ability, where chances of success relate to the raw magic power someone commands. This implies that great mages are the most likely to succeed in ascension.]] },
			{ itemId = 2825, -- book
				text = [[
Theory Of Ascension II
Another school of thought introduced the interesting concept that an ascended being must have some sort of anchor in the material world. Following this theory, an ascended being would enter a new kind of existence so different from what it experienced in life that at first, it would be extremely disoriented and confused, drifting through a sphere of gods and losing contact to creation in the limitless realm, before regaining its senses. However, as with all parts of ascension theories, the structure of such an anchor is hotly debated. Many see the beliefs of people as some sort of anchor, additionally providing some source of constant energy. Some go so far as to postulate that even the gods of creation might need such an anchor, lest they'd drift literally into obscurity. Others claim that the gods are bound to their creation and the part that they incorporate and do not need of other anchors, reasoning that in the beginning there was no one who could have believed in them to begin with. Though many texts assume a quite a rather fast, violent and critical process, others see this kind of transcendence as a gradual process which requires a lot of time but happens in a more natural way. If truly some of the bygone races managed ascension, the lack or loss of their anchor might explain their apparent absence from the affairs of modern mankind. Another part, many of the schools agree upon, is the initial breakthrough. It is assumed that an ascending being has to somehow breach the walls that separate the world of the living from the realm of the gods. Sometimes this act is compared to a bird, hatching from an egg. With the three parts in place we have a rough concept of ascension: the energy, the anchor and the transcendence.
Quite a lot of the recorded attempts of ascension followed this basic concept. Though most seem to be based on a religion forming around the ascensionist, this might only seem to be so because such incidents are better recorded and more obvious.
The few recorded attempts of ascension seem to suggest that the ascensionist, shortly before starting the process, is at the height of his worldly power. At a given point of ascension those beings (who met some form of success) are beyond the powers available to man. Walking gods in their own right, they are no longer fully part of creation and seem less bound to its laws. In the process of transcendence, the entity is extremely powerful but not fully aware of its potential and partly distracted by the ascension itself. This is the moment when the process is in its most fragile state. It is at that stage when most attempts fail, sometimes with catastrophic consequences, depending on the chosen means of ascending.
Though no successful ascension has been verified by science, it is strongly assumed that some ascensionists met with success. Considering that the outcome is likely to be affected by the means of achieving ascension, it is probably only a matter of time until a rather violent and active new god emerges who shuns the subtlety of his predecessors.]] },
		},
	},
	-- bamboo shelf at 33297,31211,7
	{
		itemId = 2459,
		itemPos = { x = 33297, y = 31211, z = 7 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
In the year 21 of the reign of Tzuzak VII, a great plague spread over the land. While the children of the serpent perished by the vile orcs, minotaurs and humans flourished. It did not take long until most of the southern lands was lost to the barbarians. The army was dwindling and civil unrest growing. Even when finally the cure for the plague had been found, the barbarians advanced. Too much territory had already been lost, too many soldiers had fallen victim to the plague and the initial attacks. It seemed as if the plague had clouded the minds of our people. Instead of fighting the common enemy, certain elements conspired against the king and each other. Without unified resistance of our weakened forces, the end of civilisation seemed inevitable. But some lizardmen who no longer listened to the lies of the prophets who believed in false gods started to pray for salvation. And even though they were only a few, they were heard. Our saviours came from the north. They abandoned the paradise that they had ruled to save our kin. On mighty wings they came with the north wind. Their wrath was like fire, they crushed our opponents and sowed fear into their vile hearts. They gathered our troops and led them from victory to victory. They blessed the lizards of true heart and led those lost in the darkness of lies to the light of truth. Those who refused to see the truth were eradicated by cleansing fire. They healed the wounds of the land and the wounds in the heart of our people. They burned the curtain of lies that had prevented our people from seeing the truth for so long. When they saw that the realm was safe once again, they got ready to return to their godly realm of perfect harmony. But the lizard people desperately begged them to stay. They offered them the leadership over the whole nation as they knew they would be unable to rule and secure the realm without the help of the divine dragons. Reluctantly the mighty dragons accepted. They gave up their paradise to save our people and adopted us as their children. The mightiest of them all became the dragon emperor of our realm.]] },
		},
	},
	-- small bamboo shelf at 33332,31685,7
	{
		itemId = 2463,
		itemPos = { x = 33332, y = 31685, z = 7 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The Moonshadow Temple

If some old legends are true, many centuries ago a big temple was built underneath the island of Grimvale. A spacious subterranean building, whose purpose is unknown nowadays. It was incidentally rediscovered a few years back when one of the village children got lost in the tunnels underneath the island, and found the temple ruins. We made some inquiries in the libraries of Edron, Thais and Carlin and found out the following: once this site bore the Name "Moonshadow Temple". It served as a place where, through crevices and by wisely arranged mirrors, the full moon's rays were conducted deep into earth's interior. Whether they served magical or cultic purposes down there or whether the full moon itself was an object of worship, is no longer known. Built of black granite and partly of white marble, the temple is of considerable size. Lately, since the were-sickness plagues Grimvale, the were-creatures have withdrawn to the tunnels and constantly descend down to the old ruins. At the times of the full moon they come up to the surface to haunt men; but more often they dwell inside the old temple ruins. Whether their interest in this site arises from its connection with the full moon or has different reasons remains a secret for now.]] },
		},
	},
	-- pile of bones at 33502,31580,7
	{
		itemId = 4285,
		itemPos = { x = 33502, y = 31580, z = 7 },
		contents = {
			{ itemId = 6096 }, -- pirate hat
			{ itemId = 3273 }, -- sabre
			{ itemId = 2821, -- book
				text = [[
Captain Blackteeth's log, first day of the 345th week of our voyage.

Anchoring some 2° northwest of the 15th latitude of Fafnar. Sea's a bit rough and the wind's choppy. Quite a bit of fog in the morning.

Well, old Jack Rumbone's map seems to be right, there is indeed land here. This island is quite uncharted on any other map I've seen of these seas. But judging by the wrecks I made out along the coast, there's good loot to be made, so I reckon I'm the one who has the last laugh, even if Jack grinned evilly when I won the map off him at the Washed-Up Mermaid.

Tomorrow, we will land and see what there might be worth pillaging. The boys are eager for some celebrating and looting, and so am I.]] },
		},
	},
	-- trunk at 33655,31663,7
	{
		itemId = 12642,
		itemPos = { x = 33655, y = 31663, z = 7 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Geography of Krailos, by Larek the Wayfarer

Krailos is mainly populated by ogres. It is located north of Oramond, bordered by high mountains to the south, a wild sea to the east, huge cacti forests to the west and rocky hills to the north. At the rugged shores of Krailos one may find many shipwrecks, as the area is surrounded by treacherous underwater shelves.

Krailos itself is mainly covered in sandy plains and has a rather hot climate, which has led to a sparsely spread population. This means most of the ogres live in small tent villages. There is just one bigger settlement, which is home to the Bloody Skulls tribe. Also, some ogre tribes still have nomadic tendencies. The country's landscape is harsh: rocky beaches, dried-up salt lakes, rugged rock formations and dry, barren fields number among the reasons why the area is avoided by foreigners. Another reason of course are the ogres themselves.]] },
			{ itemId = 2826, -- book
				text = [[
Upon Ogre Society - An ethnological essay, by Larek the Wayfarer

Built upon the violent battles and wrongdoings of its past, Krailos is now among the most unconnected countries in its corner of the world, characterised by bitter struggles and a harsh environment. The ogres' hunting skills and physical strength are among their current greatest benefits; and the mountains of Krailos hold some rare minerals. On the other hand, Krailos lacks a lot in infrastructure and clean water.

Krailos is a tribal nation, divided into several different clans. Leader of a tribe is usually the strongest male ogre (although in some cases a particularly violent or domineering ogress claims the title). The chieftain is supported by an ogre-shaman. If the shaman is female, the two are often, but not necessarily, a couple. The chieftain is responsible for all decisions concerning the hunt and martial matters while the shaman is responsible for all affairs spiritual and social. Within a tribe, there may be a couple of opposing individuals against the current chieftain, but overt struggles for leadership are rather uncommon. Each tribe is independent of the others, and conflicts between two tribes occur frequently. However, the greatest threat to the ogres actually is the desiccation of the lakes and rivers. But the current chieftains are too preoccupied with their tribal conflicts to seek solutions for this issue.

The ogres are simple, warlike people, more interested in a fight and good food than in politics. Elimination of competitors is an accepted way of moving up in the ogre ranks. Ogres like conflict. They are impulsive, quick to anger and do not hold back their opinions regardless of who might take offense. Ogres prefer to solve conflicts through combat rather than words. Yet, an honorable death is not the highest purpose in an ogre’s life, but rather a fulfilled life, which primarily means enough food and a comfortable hut. Ogres are distrustful towards strangers and tend to welcome them with avoidance in the best case. Lately yet, a tribe called the Bloody Skulls has shown a sort of interest in trade with other peoples.

A kind of spiritual shamanic animism holds a certain importance in the ogres' lives and each tribe’s shamans are always renowned members of the society. The common ogres are moderately spiritual and have rites of passage and annual rites concerning the seasons and certain weather phenomena. Ogres worhip The Great Hunger, a kind of spirit being they believe will eat up the entire world if not fed regularly. Therefore they often perform rites of sacrifice (food but also living creatures) to feed this entity. Otherwise, ogres care only for the here-and-now.

Contrary to common prejudices, ogres are at least a little more than mindless brutes. They possess a talent for animism and have certain artisanal skills. For example they have developed passable methods of curing and tanning hides, so their leatherwork is quite convenient. Despite their great passion for eating the ogres don’t have a reputation as outstanding cooks as their meals seldom match other peoples’ taste. Ogres eat especially meat – of hunted animals but also the meat of humanoids, mainly humans and elves. This is the reason they also are referred to as “maneaters”. It is important to mention that they never give in to cannibalism. Besides meat they also love sweet tasting things, such as honey combs or cakes, although they don’t get the latter too often.]] },
		},
	},
	-- pile of bones at 31974,32907,8
	{
		itemId = 4285,
		itemPos = { x = 31974, y = 32907, z = 8 },
		contents = {
			{ itemId = 2820, -- sheet of paper
				text = [[
I did it! I reached the crystal gardens! What beauty and splendor I have seen down there. Even more: I discovered a small subterranean lake - but Harry was there before me. And he did something strange: He ringed a small, transparent looking bell and immediatly a big whirl appeared in the water. I suppose this is the mysterious way deeper into the caves we sought after for so long. But Harry, the coward, didn't dare to dive into the water. Instead he left the caverns and heeded back to the surface. I have to go after him tomorrow. I must have this bell!]] },
		},
	},
	-- dead human at 32224,32274,8
	{
		itemId = 4311,
		itemPos = { x = 32224, y = 32274, z = 8 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
I've managed to imprison two cyclops in my secret dungeon under the lighthouse. I forced them to create some magic equipment. Soon I will be the mightiest warrior in Tibia.]] },
		},
	},
	-- bookcase at 32309,31777,8
	{
		itemId = 2435,
		itemPos = { x = 32309, y = 31777, z = 8 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Tibiantis
Somewhere to the South of the city which nowadays is known as Carlin, could once be found an isle, believed to be the cradle of human civilisation. Here, the first Tibians saw the light of the two suns and founded the first Kingdom. It grew to be a place of wisdom and wonder. Under the guidance of the Gods, humanity prospered in terms of wealth and knowledge to heights that no other civilisation has reached before or since. This city was called Tibiantis, and it grew beyond the bounderies of the land, spreading into the sea itself. Wonder upon wonder could be found in this city of ivory and gold. Explorers from Tibiantis braved the oceans and built outposts in the farthest reaches of the world. It is said of the denizens of this wonderful city that the elements themselves were at their beck and call and that no foe was strong enough to oppose them. However, they grew complacent and self satisfied, forgetting that everything they were and everything they had built up had been done only because they were favoured of the Gods. Eventually, they forgot their Gods, believing instead that they were the masters of the world. The Gods were saddened as they watched those who had made them so proud turn their backs upon them, and turned their eyes from them. Without the protection of the Gods, the city of Tibiantis was doomed. Its wealth and arrogance made it an irresistable target for the forces of evil. Their day of reckoning came - the Isle was sunk, the beautiful sculptured architecture of the towers of ivory and gold crumbled and the citizens drowned, the achievements and inventions of the civilisation lost forever beneath the waves. Only the highest tip of the highest mountain of the isle remained as a tiny island, a pitiful memory of the greatness that once existed here. Legends state that this isle cannot be reached by normal means. The versions of the legend vary - some claim the isle is inhabited by diabolic creatures ensuring Tibiantis may never rise again and others state that benevolent messengers of the Gods live there and mourn for the lost children and warn others of the fate that threatens those who forget their Gods. The city itself rests on the lowest point of the ocean floor, and those inhabitants who were unfortunate to survive were twisted into abominal sea creatures. The colonies and outposts of Tibiantis did not survive the downfall of their home for long. They fell prey to the numerous enemies their people had made and who no longer feared retaliation. Only a few of their inhabitants survived to found new cities in remote places. Though they forgot their heritage they finally grew in numbers and created new cities and kingdoms, some of which still thrive in the present day.]] },
			{ itemId = 2832, -- book
				text = [[
The Northwood Wolves
The woods north of Carlin were home to numerous wild beasts. Packs of wolves were only one part of the fearsome fauna inhabiting the forests. So when sheep and cattle disappeared, no-one paid too much attention. Hunters were sent and they killed some of the wolves, however, the numbers of livestock stolen did not reduce. However, it was when humans fell victims to the wolf attacks that people turned to the Queen for aid. The conclave of druids, however, intervened and prevented the people from hunting down and killing every last wolf. They promised to take care of the problem themselves. Four of their most knowledgable beastlords were charged with the task of ending the threat. Only one returned, wide-eyed with fear and unable to speak coherently of what he had seen. And now, the true reign of terror began - whole farmsteads were attacked and their inhabitants torn apart and devoured. The druids organised a force of hunters and spellcasters. They fought their way through the woods, facing packs of wolves who seemed to be fighting as organised forces with an almost human intelligence. Despite winning the battle they failed to win the war and the ultimate source of the evil controlling the wolves, and more people fell victim to the wolves' attacks. The following winter a blood smeared adolescent was found, wandering aimlessly through the woods. His name was Charles Farmer. Shaking and half mad, those who found him were able to piece together his confession. He claimed he had killed his mother with a silver candelebra to make the wolf in her stop doing evil things. The boy was given over to the care of the druids, who took him in and protected him and the community from his madness. After this incident, the attacks on the farms and killings in Northwood ceased from one day to the next.]] },
			{ itemId = 2821, -- book
				text = [[
The flying Venorean is a ship that is cursed to sail the seas forever. Allowed to visit land only every seven years, the ghostly captain uses his shore leave to lure clueless sailors into his crew. Everybody that signs the contract becomes cursed like the captain and might only leave the ship if he finds a suitable exchange on one of his shore leaves every seven years.]] },
		},
	},
	-- drawers at 32309,31778,8
	{
		itemId = 2434,
		itemPos = { x = 32309, y = 31778, z = 8 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Nargol the impaler was a disgraced knight of an unimportant noble family. Acts of cowardice and drunken violence had cost him any of the little reputation that his birth right and knighthood had given to him. In times of relative peace his attempts as a sellsword yielded too little money to sustain himself. When he had sunk so low as to have sold most of his family arms and armour he started working as a bruiser for local thugs. His fate turned once again, when he became the bodyguard of a spirit speaker. So he accompanied his employer to the court of king Zelos, who was strongly interested in speaking to the spirits from beyond. He was there when the king consulted the spirits with the help of the medium and witnessed some of the plans that took shape in such seances. Seizing the opportunity in a sober moment, he pledged his sword and service to the king, which the latter accepted. King Zelos had only a few loyal allies and some knight, up to anything the king might command, suited him well enough. Even to his own surprise Nargol proved quite effective and efficient in his new role. Soon he became the chief enforcer of Zelos, who soon would become known as the ghost king. For his faithful service to the king's cause, Nargol was awarded with the best weapons and armour available and even magic items found their way into his possession. With an iron fist and without mercy or remorse, Nargol carried out his king's will, in a mockery of true knighthood. The king liked that Nargol acquired a reputation of needless cruelty and violence. Even the threat of a visit of Nargol and his men brought villages and nobles back to the heel. In service of the ghost king the fallen knight took many injuries and was maimed several times. His king though had him stitched together again and again, sometimes replacing or 'enhancing' whole body parts with gruesome, magical substitutes. Over the years he became more and more a thing than a man. A walking magical construct of its own. In the end he seemed almost mindless. Fused with his armour and weapons. Inactive or lost in the dark abysses of his soul unless called to action. When the ghost king finally perished, Nargol simply stopped to 'function'. He was found standing motionless on his horse that strode into a small village. He was rather stored away at a secret place then properly buried, because it was feared he might rise again.]] },
		},
	},
	-- bookcase at 32309,31780,8
	{
		itemId = 2435,
		itemPos = { x = 32309, y = 31780, z = 8 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Astonishing Fairy Tale of the Little Piglet and the Isle of Evil
Once upon a time there was a little piglet named Ethan. But it was not an ordinary piglet but a piglet that wanted to become a detective. I, the cat Sandy, was his best friend ever and so we decided that his dream should become true. With our friends, Harry the owl and Monty the dog, we founded a detective agency. One day, while playing at the beach, we found some ominous footsteps in the sand. Ethan immediately knew that these were the footsteps of a criminal and we all decided to pursue the trail and catch the villain. After a while we reached a spot where the footsteps vanished in the sea. At first, me and my friends were clueless what to do, but then Harry's keen eyes spotted a harbour not that far away. By chance our old friend Wesley the weasel was working in the harbour and could provide us not only with a boat but also with some good advice. So we finally set sails and used Monty's amazing ability to follow a trail by scent to find our way across the sea. Eventually we reached an island that was thoroughly evil. It took all our courage and bravery to make our way through the dangerous territory to the dominating structure of the evil tower that loomed over the whole isle. We were well aware that the master of that tower had to be the epitome of evil and we had to enter his tower, regardless of the dangers involved. Only few had ever reached the isle and none of them had ever returned to tell the tale. But we were there and knew that it was our destiny to face the master of the isle. Retreat was not an option. We braved all the dangers that the isle seemed to throw against us and finally stood in front of the tower. Who would carry on our work if we failed? We knew if we did not stop the master of this isle then it might take decades until somebody else would find this isle, and then it might be too late to stop the fiendish plot that threatened the whole world. So we made it to the top of the tower and confronted its evil master! To our surprise it was no one else than our old rival Melvin the mouse! He switched on the lights which blinded Harry, threw a stick that Monty was forced to pursue, and then, to my shame, confronted me with a ball of yarn so huge I could not resist but had to play with it. But just as Melvin the mouse laughed evilly, Ethan, with an incredibly effort of will, ignored the mud the cunning mouse had just prepared to distract him and captured the culprit. With Melvin being caught, we others regained our composure and senses and returned to out little ship. We handed Melvin over to his mother and he was not allowed to eat any sweets for two weeks. This is the end of my little story about the isle of evil.]] },
			{ itemId = 2816, -- book
				text = [[
The art of war by Brianna Bonecrusher

To win a war, or even a fight, one has to discard certain ideals of nobility and honour. While honour is a noble concept it is less noble to let your soldiers die because you follow some lofty goal. As a leader it is your foremost duty to ensure that as many of your soldiers as possible return home, unharmed, in tact and preferably victorious. This can't be done by open battles that follow some sort of code. Battles have certain dynamics that makes any code obsolete after the initial clash anyway. Therefore, the surest tactic for success is to weaken the enemy as much as possible before you even think about engaging them in battle at all. A hit and run tactic is a wonderful strategy for achieving this aim. This requires the army to operate in small groups, making the maximum use of the terrain, traps and distance weapons. Let the environment cause as much harm as possible. Force your enemy to seek its way through treacherous countryside, lure them into the lairs of animals and monsters and don't give them the chance to restock supplies. Don't grant them the comfort of an undisturbed rest. Harass and attack them constantly from afar so they never feel safe. Bleed them out and wear them down and don't let them retreat to safety because then they might return, and be better prepared as they are wise to the guerilla tactics you use. The main goal is always to keep your own casualties low. If the enemy has no or little distance attacks you might be able to pick many of his soldiers off without any meaningful retaliation. Let your distance fighters aim for key figures first whenever possible. If you face enemies with numerous distance fighters attack them under cover of night using your own shooters spread out wide and roughly aiming for the enemy's camp. When forced to fight in close quarters, use an ambush strategy whenever possible. If possible, be prepared for a hasty retreat when things turn out nasty. She who fights and runs away will live to fight another day.]] },
		},
	},
	-- drawers at 32309,31781,8
	{
		itemId = 2434,
		itemPos = { x = 32309, y = 31781, z = 8 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Vlarkorth was a wandering hero even in his youth. Heroic quests lead him all over the world and perhaps even beyond. Sometimes in his travels, while he already was a well-known and established knight, he acquired the secret of eternal youth. It is said that it was granted to him as a wish by fairies whom he had helped. Some whisper he had to sacrifice his own heart to acquire this gift. At least all sources agree that he was a changed man in his later live. While friends of old one by one retired and died, loved ones came and went, he grew more and more bitter and jaded. While he perfected his knightly arts more and more over the decades that passed, his views on knightly virtues became cynical at best. He sought out more and more perilous challenges, as they say out of a death wish. Regardless what fighter or menace he challenged, he went out victorious. He begun to let the more promising opponents live, albeit scarred and disfigured by his hand. It was assumed that this was his way to groom new challengers, to endanger his own live to at least sometimes feel some form of thrill. He antagonized the mighty and had only spite for the just and religious. Yet no challenger could match his skills. He fathered many children over the years and raised them with an iron fist, putting them through rigorous trainings and humiliation. That way he was fostering new generations of opponents that might be worthy one day to give him a challenge at last. At last it was his halve-elven daughter that would be his downfall. While she was a promising fighter he mistreated her like he always did with his children. When she dared to question his attitude once he had her mouth stitched shut. When he held a dashing young adventurer captive in his hold, she rescued him and the two fled. Vlarkorth followed them dispassionately. The hunt was just a mild thrill for him but better than nothing. So he chased them from one end of the world to another. Over the course of their adventures the fleeing pair made new friends and gathered a party of merry men and women. Sometimes Vlarkorth caught up but his prey eluded him in the end, albeit not without casualties. At some point the couple decided they could not run any longer. Alongside their allies they made a last stand and faced the heartless Vlarkorth. In a fierce battle one by one of their companions were wounded or killed. In the end only the halve-even maid and her lover stood against the barely wounded Vlarkorth. It was apparent that they both were no match for the ancient knight. As he was about to kill his daughter, the adventurer impaled himself on Vlarkorth 's weapon and weightened it down. The women, using her refined reflexes to honour his sacrifice, dispatched her ruthless father with a swift blow once and for all. Vlarkorth was buried in shame at a remote place.]] },
		},
	},
	-- bookcase at 32310,31777,8
	{
		itemId = 2436,
		itemPos = { x = 32310, y = 31777, z = 8 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Duke Krule was born into a zealous family of thaian nobility. His oppressive and pious upbringing suited him well and from early age he joined an order of knights, dedicated to erase anything they deemed heretic. It was not much a choice of heart but the only sanctioned opportunity to escape the control of his overbearing father. The knights run several campaigns against the orcs and minotaurs mostly. Picking easy targets they were met with little resistance and the already very loose organisation of the order begun to dissipate more and more with the members often following their own petty agendas. Krule lead several raids against renegade orcs and later human bandits. His claiming of the loot did not suit the victims of the robbers well so as an empty gesture towards them, Krule disposed captured criminals in a rather gruesome fashion, claiming his campaigns were rather aimed at discouraging other criminals, then reclaiming stolen goods. With a growing strength and order in the kingdom, his targets became less and less and so he begun campaigns far from the borders to strike any easy target that seemed suitable. Under the pretence of doing the god's work, he begun to plunder ancient ritual sites and burial grounds of what he deemed heathens. Over time he and his war band had degraded into little more than bandits and grave robbers. Although operating far from the realm and not facing imminent threats, his acts of cruelty continued. It's not known if these vile acts lead to some shaman to curse him or if he was cursed in some ancient tomb which treasures he stole. But it's safe to say that his later years were spent in campaigns of slaughter and fire to acquire the means to end at least some form of curse. The nature of the curse could never truly be determined as he and all who accompanied him were slaughtered by an orcish warlord and his army in an ambush. Some brethren of his order later reclaimed his remains and despite his deeds and reputation gave him a proper burial.]] },
			{ itemId = 2816, -- book
				text = [[
The city of Svargrond is not by chance called city of barbarians. It is a city of rough manners, and respect can usually only be earned by displaying strength and endurance. Befriending the citizens is not done easily. Trading with them can often be tiresome and even dangerous when looking at their temper in combination with alcohol. All in all, one could assume that Svargrond is rather an unlikely ally for our respectable Carlin but for strategical and economical reasons it is quite the contrary. Svargrond is one of the cities easily accessible by us that is not under the sway of Thais in some form. A dominance of Thais in Svargrond could severely hamper our seafaring and trade.
The harsh environment of the northern isles makes Svargrond an interesting trading partner from an economical point of view. Many of our goods cannot be created by themselves or would be extremely expensive if they were produced with their own resources. Although the mining operations have not really been running again yet, there is still an abundance of resources that we can trade for our goods as soon as Svargrond's economy has developed somewhat more. For now, we mainly trade amber, ivory, bones, furs, and meat. Later, we hope to be able to trade for ores, gemstones and even shaman-made potions and elixirs. Sadly the cultural differences still pose a severe problem for our trades or the expansion of our post here. Although our fighters gained some respect, the prominence of alcohol in that culture is a constant thorn in our side. Officially it has been declared not to make an issue of this difference, but sometimes this is easier said than done when facing some threatening drunkard. So against earlier plans, we maintain only a minor presence in Svargrond. This tactic seems to work well as he barbarians are not fond of intrusions in their everyday lives. Unfortunately, their constant war with their even less civilized brethren in the south hampers our ambitions to get a hold on the resources of the isles. On the other hand, it makes our wares even more valuable for the besieged people of Svargrond.]] },
		},
	},
	-- bookcase at 32310,31780,8
	{
		itemId = 2436,
		itemPos = { x = 32310, y = 31780, z = 8 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Whatever became of Leetha Arnadette? Volume 2

The editorial team charged with the task of editing Arnadette's writings was hopelessly overwhelmed. Not only did the man write unceasingly himself, he was also capable of dictating three books to scribes at the same time. He rested only to sleep and eat, and that infrequently. His Editor in Chief had the idea of turning to the sorcerer Eclesius to create a Scribe Golem to keep up with the stream of literature. Eclesius found the idea wonderful (and the monetary reward was probably not too unwelcome either) After many false starts and several fatal accidents (not for Eclesius or the Editor, obviously) the Scribe Golem was completed. Not only was this Golem capable of editing and writing down Arnadette's work at the same pace as the author, it was also capable of banding the books, leaving the editorial team with little more to do than distribute the end product to various libraries. (Eclesius also installed some improvements - for instance, pages in Tibian books no longer needed to be turned, the reader simply had to scroll down the text to read what was written, as Eclesius believed page turning to be a waste of energy and an interruption to the flow of a good book.) While this meant that Arnadette's works could finally be recorded without a backlog building up, Arnadette himself began to suffer. Whenever he wished to break to sleep, eat, or anything else, the Golem would go on the rampage screaming "More Books! More Books!" and start destroying the interior furnishings. Eventually, the editorial team left one by one, unable to help Arnadette, and in fear of their lives should he ever cease to produce literature leading to the Golem going fully out of control. Eclesius was also strangely uncontactable. The Editor in Chief stuck with his old master as long as he could, but even he, in his old age was forced to abandon him.
The libraries are still being filled by his books - so which version is true? A man held in thrall by a Golem, forced to write day and night without break for sleep nor rest or are unscrupulous want-to-be writers attempting to make a quick buck off the back of a literary legend? This book is a plea for help! For your childhood memories of good books, the brave adventurers who read this book, please find out whatever became of Leetha Arnadette!]] },
			{ itemId = 2824, -- book
				text = [[
Whatever became of Leetha Arnadette? Volume 1

There is not a Tibian who does not know of Leetha Arnadette, Tibia's most prolific author. He has written books in almost every genre, from horror to history, fact to fiction, children's bedtime stories to university textbooks. Which pupil has not groaned inwardly when told to learn by heart passages from Arnadette's "Tibia - A History" (Or even outwardly groand - an action that cost this humble author three days off school with concussion - how was I to know my teacher was a high ranking paladin and the champion of the Rat Hurling Guild and a deadly shot with a board rubber?) Which babe has not been lulled into sweet dreams by Arnadette's "Nighttime tales for tiny Tibian tots"? Who has not wished to be Gerrick, the hero of "Jungle Adventure", and which adolescent has not been terrified by the story of the "Northwood Wolves"? No tourist in his right mind would consider travelling without Arnadette's "Rough Guide to Tibia" and even some households would be poorer for the lack of "Tibian Cooking Today, 1001 ways to serve Fish."
Many have wondered exactly where he got his inspiration from. His writings cover such a wide range of topics to such depth of expertise, that in his former years he must have been a great explorer and a well read student. However, there are no records of him ever having studied at any academy in Tibia and even grandparent's grandparents talk of him as an old man - which has led to the rumour that elven blood runs in his veins. Those who used to see him on his monthly trips out to the shops in his home town reported that he would often stop dead in his tracks, emit sparks from his beard, then grab a notebook from his robes and scribble frantically. Indeed there is one story that stated that he took three days to make it down the street, and citizens of Carlin took pity on his scribbling form and made sure he had food and drink. It is these rare sightings of Arnadette that led many to believe that he was either blessed (or cursed) with Godly inspiration, that he had been selected by the Gods as their scribe. In a world with so many Gods, this is an unfortunate fate for one man to bear, and also leads to the interesting question of exactly which God was responsible for the book titled "Why Rabbits Should be Blown up on Sight".
Arnadette has not been seen for many years, although he continues to produce books with incredible speed. Rumours had begun to circulate that he was actually dead and other writer's were selling books under his name simply to earn money. However, an old man, apparently his editor, has spoken out, claiming to know the truth about his sad fate. Whether the following fantastic tale is a true confession or the ramblings of a senile man remains to be seen, but it is the author's belief that this story should be brought to the attention of the public, so people braver than I may try to save Arnadette from a fate worse than ... well ... a bad fate.]] },
		},
	},
	-- bookcase at 32311,31777,8
	{
		itemId = 2437,
		itemPos = { x = 32311, y = 31777, z = 8 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The Environment and You]] },
			{ itemId = 2821, -- book
				text = [[
The close relationship with Carlin has served the druids quite well over the years. In Thais, the druids had only a minor role which was always overshadowed by the sorcerer guild and its close ties to the Thaian throne. In Carlin, however, the druids were seen as trusted advisers for the young city. This early cooperation led to the growth of Carlin in a more harmonic and environmental way than any other city. Right from the beginning, druids instructed the people of Carlin in the ways of nature and watched over the city's development. Moreover, there was a constant demand for the druids' help which resulted in the use of druidic powers in some practical ways that were never thought of before. Additionally, the need of the people led to experiments to expand the druidic powers in new ways. This lead to some significant progress of the druids' magic. Although critics call this approach too practical and too less metaphysical, it is undeniable that new magical practices arose in those days that shaped the druidic research significantly. With additional resources and freedom, the druidic art flourished along with the city, and the teachings of the druids reached more people now that they were always present and no longer hid in some distant caves. The dynamic aspect of the process helped both sides and led to a new boom in druidic magic.
Now that some contact with Svargrond was established, there are even new chances to reintegrate what many see as early offshoots of druidism developed through contact with shamans. Even though it is a painfully slow process to leave behind prejudices and cultural differences, it is widely accepted that both traditions can learn from each other. The combination of two branches of the same magical teaching that took different paths for centuries might lead to new and unknown heights of druidism that might even herald in a new age of magic.]] },
			{ itemId = 2816, -- book
				text = [[
The contact with the elves was mainly based on the mutual hatred of orcs and other monsters. In the past, the elves' acceptance of Carlin was founded on the fact that one of them was likely to be the next victim of another orc invasion. With Carlin's strength growing, the elves' opinion began to shift. Some even saw a threat in Carlin's growth, however, most agreed that in the case of an orcish threat both cities forces combined might be able to stop the green flood now. Still, there was only minor trade between Carlin and Ab'Dendriel since both cities strived for independence. Only when the orcish threat decreased and an invasion became unlikely, the trade began to flourish somewhat. Still, the alien culture of the elves makes it hard to have any meaningful negotiations. Particularly the complicated caste system with different leaders makes it very difficult to come to some kind of agreement that would please everyone.]] },
		},
	},
	-- bookcase at 32311,31780,8
	{
		itemId = 2437,
		itemPos = { x = 32311, y = 31780, z = 8 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
Most pirates started their career as smugglers and reavers at the beaches. With the help of small shipping boats, they boarded ships in remote bays where they restocked supplies. Often whole villages made a living from such acts of banditry. At some point they decided that they had become strong enough to take over the ships and raid the seas. Another source of pirates were the mutinous crews that took over ships and who were hunted by the navy anyways.]] },
			{ itemId = 2816, -- book
				text = [[
Since sightings have been reported by many respectable seamen the existance of the golden whale can no longer be dismissed as a fairy tale. It is said that this whale is as huge as an isle and its body is made of purest gold. Even though many of the reports were made by seamen in the southern seas sailors of the north also claim to have seen this creature. All over the world the sighting of the golden whale is seen as a good omen. No one has yet been able to even hurt the beast; however, several inventors and mages have come up with ideas for the creation of a weapon that might pierce its golden body.]] },
			{ itemId = 2832, -- book
				text = [[
The Shattered Isles

Nargor is a hostile rock surrounded by treacherous reefs. Since it is uninhabitable and almost unreachable it is of no interest.

Treasure Island is not only desert-like but also quite deserted. The only people you meet are treasure hunters that travel there occasionally to try their luck.

The inhabitants of the town Liberty Bay live on the numerous plantations. The town has developed into a major trading center in recent years, and is under Thaian rule.

The Forbidden Islands to the north-west are dangerous not only because of the volcanoes that are found there but also due to frequent quara activity. Since there is no real reason to visit these islands, no regular shipping route was ever established.

The Laguna Islands are quite often visited by passing ships to refresh their supply of water and food. Still the isles are too desolate to establish a settlement there. It is rumored that a small tribe of savages calls one of the isles its home.]] },
		},
	},
	-- bookcase at 32313,31777,8
	{
		itemId = 2435,
		itemPos = { x = 32313, y = 31777, z = 8 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Amazons Vol.3

This background of political conflict led to the ascendance of Amaza Saphira, an alchemist with an unusual talent for inspirational speeches and leadership. She claimed to have had visions of Banor and Elaine, informing her of the natural superiority of womankind. Although her political opponents attempted to discredit her, calling her delusional and stating that her visions were the results of noxious fumes concocted in her laboratory, Amaza'S speeches spoke to many people, and her radical viewpoint inspired many to join her cause. It was her belief that men were inferior beings and that Carlin was an acomplishment of womanhood. She wanted to drive all men from the city, or keep them in subjugation serving only in menial positions. She wanted to expand the army to demonstrate the strength of womanhood. Though she gained many followers, her radical position served as an example of the dangers of extremism and finally, the Queen felt pushed into a more moderate way of handling the army and its leadership.

Amaza, however, was not content with the Queen's decision and continued to gather followers amongst the population, many of them in the Queen's own army. What Amaza possessed in charisma and oratory she lacked in subtlety and secrecy. So her plan to overthrow the Queen and become a warrior queen in her place was doomed to failure before it could even begin. Although parts of the army sympathized with her ideas, not all were convinced enough to abandon their duty and betray their oaths to their Queen. Amaza and several of her key-followers were jailed before they could make their move. In the night before their trial Amaza and her allies were freed by some of her remaining followers in the city guard and their escape turned bloody when forces loyal to the Queen intervened.

However, Amaza and her women managed to escape the city. She now turned to the families who lived in the woods and the women who had abandoned the city after the army had been disbanded in search for new followers. These families had, over the years, taken on the structure of nomadic tribes and carried a strong warrior heritage which made them susceptible to Amaza's teachings. Many of the tribeswomen joined Amaza's forces, and over the weeks and months of her exile further recruits from Carlin arrived.

Perhaps, given time, Amaza might have eventually led her forces against Carlin. Perhaps with the help of conspirators within the city her forces might have surprised and overcome the Queen's army. However fate had a different end in store for her. She was killed by an orcish arrow in a night ambush. Even today, there is some speculation as to whether this conveniant solution to Carlin's problems was truly an act of fate, or whether the Queen had a hand in Amaza's death. Other theories state that the Thaian King was more concerned about Amaza's cult threatening the status quo in his city than he was happy about the destabilizing effect it was having on Carlin. A final explanation is that the Druid COuncil itself was responsible for her demise. However, there is precious little proof that the orcish arrow was anything more than an unfortunate series of events that in the long run probably prevented a long, drawn out struggle for the people of Carlin.

Her remaining followers named themselves Amazons in her honour. Though some of them returned to the city, most were too proud for such a move and stayed in the woods. Over the years outcasts from Carlin and desperate or vengeful women joined their ranks. So even when the original group splintered, the several subgroups and tribes managed to survive. Over the years they adopted various codes which can be more or less related to Amaza'S teachings. Those teachings have been passed on by word of mouth and are based on the rather unspecific speeches Amaza made. How much of the current practises of the Amazons is still based on the spirit of their founder is debatable.]] },
			{ itemId = 2816, -- book
				text = [[
The Amazons Vol.2

However, the threat posed by mercenaries loomed over Carlin for some years and the city was never fully able to disband the standing army. The core of the army was formed by the scouts and a city guard. This army was to be reinforced by a highly trained militia in times of need. Through many years, this militia became an effective force, so effective in fact, that as its reputation spread, those soldiers of fortune who may have been tempted to attack a city run by women decided they would be better off seeking their wealth elsewhere. Thus, the need for an army declined, and the cost of maintaining a standing army became too much of a burden for a city which was striving to become a major force in trading.

The army was therefore disbanded, and it was expected of the women that they return to their former occupations. This did not please many of them, who felt that they were being cast off and neglected and accused the Queen and her advisors of being short sighted and ignorant of the dangers to their city. When they failed to find support from the Queen they abandoned the city, setting up outposts in the woods to protect the militant way of life to which they had become accustomed.

Several years had passed after the death of Bella Bonecrusher, the valiant warrior who had roused the womenfolk of Carlin to protect themselves against the orcs, when the future direction of the army became a focal point for political conflict within the court of Carlin. Several conflicting groups jostled to influence the Queen in order to follow their own agendas, attempting to manipulate the army, its size, its composition and its aims for the furtherance of their own interests.]] },
			{ itemId = 2816, -- book
				text = [[
The Amazons Vol.1

When Carlin was freed from the shackles of Thaian oppression, the imminent threat of attempts to recapture the city loomed over the weary populace. Some families left the city to hide in the woods. Those who remained immediately began with the construction of fortifications. With the assistance of druids and helpful elves some of the younger women were trained as scouts and roamed the surrounding woods to warn the city in the case of an advancing army.

However, it was at this time unknown to the people of Carlin that Thais was no longer in a position to launch another campaign to recapture the city. With the destruction of its biggest and best legion, the threat of rebellion loomed within the city's walls and advancing monsters at its borders were more than the remaining forces could handle. Still, Thais held on to its claim to the Carlinian lands and tried to incite mercenary bands with bounties to move against Carlin. Unfortunately for Thais, the lawlessness that had overtaken the countryside as a direct result of the conflict between the cities meant that the mercenaries found much more lucrative employment protecting merchant caravans and the homes of wealthy Tibians who chose to live outside the safety of the cities. Further, there was much speculation that the coffers of the Thaian King had been drained in the struggle with Carlin, and the mercenaries severely doubted Thais ability to pay up. However, there were still those mercenaries desperate enough for money, who were unable to find employment protecting trade caravans because their reputations as bandits rather than mercenaries preceded them. This motley bunch readily believed the stories about a defenceless city of weak women whose menfolk had been massacred by raiding orcs. However, these bands of so-called mercenaries were unable to organise themselves into a larger group. Unwilling to share the rewards from such easy pickings, the bands of mercenaries travelling to the North fought each other whenever they met.

At the same time as the mercenary bands were fighting each other on their way to the North, the scouts of Carlin encountered the remnants of the orcish invasion force that still roamed the woods. More often than not, the badly organised bands of orcs would be put to the sword and arrow and killed by the scouts. However, the orcs soon grew wise to these attacks and formed themselves into a larger group, posing a significant threat too large to be dealt with by the scouting parties alone.

It was Bella Bonecrusher, a young warrior, who saw the potential of the threat and, in a rousing speech, stirred the remaining women of the city to join with the scouts and fight the menace posed by the growing organisation of the orcs. Emissaries were sent to the Elves at Ab'Dendriel to alarm them of the danger that the orcs also posed to their borders. While diplomatic discussions were underway, the newly recruited warriors were armed with equipment salvaged from the battlefields and were hastily trained by the scouts. When the Elven reinforcements arrived in Carlin they were greeted by a ragtag army of untried women. Despite their lack of experience in the battlefield, this army faced the orcs and won against the odds. Soon, the woods were cleared of orcs. Bella Bonecrusher argued that in these troubled times a standing army would be a necessity, others pointed out that everyone was needed to rebuild the city and work on the fields. The discussions turned moot when the scouts reported the advancing war bands of mercenaries from the south. The new army was sent to intercept the advancing forces. The mercenaries, separated in several groups, never high in morale and heavily outnumbered were soundly defeated by the Carlinian forces whose losses were negligible, thanks to the healing magic of the druids.]] },
		},
	},
	-- bookcase at 32314,31777,8
	{
		itemId = 2436,
		itemPos = { x = 32314, y = 31777, z = 8 },
		contents = {
			{ itemId = 2824, -- book
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
			{ itemId = 2826, -- book
				text = [[
Tibiantis: Fact and Fiction

In the light of progress made my modern science the tales of Tibiantis can be cheerfully disregarded as blatant myths. The author of this questionable history merely drew upon several myths and mixed them together to create a tale plausible to those given to believe such romantic nonsense. The recently discovered, or more accurately, recently rediscovered, city of Yalahar is very obviously a major inspiration for the story of Tibiantis. Aspects of the story can be found in actual fact in Yalahar - the city itself is huge, and also extended its borders beyond the land into the sea, and judging from what can be found there, was most definitely at some point in its past a city that was home to great wonders, whose inhabitants were in possession of great knowledge. However, one of the great mysteries of Yalahar is whether in actual fact those that live there are even human or another race, until recently unknown amongst the Tibian civilisations. The aspect of the story of Tibiantis referring to the downfall of a civilisation could be influenced by many different myths. One such source could be based upon the discoveries made far to the North of Tibia which suggest the possibility of a civilisation that was wiped out by an as yet unknown catastrophe of cataclysmic proportions. Equally, to the extreme south of Tibia can be found the Shattered Isles. These Isles were so named with good reason - geological studies conducted by the Explorers' Society reveal that these isles did not so much sink but were blasted by a phenomenal explosion of some kind. Relics found upon the Isles also hint that they were once populated by a great and most likely advanced civilisation. It is the sad fate of these isles to be the home of the infamous Quara. It is these twisted creatures who probably provide the origin of the myth's fish people. In summary, I believe I have gathered enough proof here to dispell any reason for believing the tale of Tibiantis, and have proven it to be nothing but a conglomeration of ancient stories and legends which an overly ambitious and half informed so-called historian has put together into a new myth of his own making, in order to gain cheap fame by hoodwinking a gullible and uninformed public.]] },
		},
	},
	-- bookcase at 32314,32260,8
	{
		itemId = 2438,
		itemPos = { x = 32314, y = 32260, z = 8 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
We have learnt from captured demon servants that the Ruthless Seven have occupied some new base and are preparing some kind of doomsday device there. It seems to be their intention to attack one of the major cities and to turn it into hell on earth.
Our sources are highly reliable. The Ruthless Seven have deployed some of their most powerful lieutenants to ensure the success of their mission. Strangely, the things we read in the minds of these lieutenants did not point to the Plains of Havoc as expected but to the remote isle of Edron.
We are aware that there are some ancient ruins north of Edron. Orshabaal, who is a powerful servant of the Ruthless Seven, might appear in this area to scare people away and to distract any attention.
Our main task is to find this secret place of the Ruthless Seven and to kill the lieutenants there. Finally, the doomsday device has to be destroyed.]] },
			{ itemId = 2827, -- book
				text = [[
Enemies of the True Faith
First of all there are the heretics. Those are probably the most dangerous enemies because you hardly notice them. They undermine our society and the belief in the gods by their actions and their words. Some of them are crazy enough to think that they are true believers themselves. Their words erode the fundamentals of faith. They must be eliminated from our society.
As practitioners of dark and forbidden arts, witches are dangerous enemies as well. They must be avoided by all virtuous people that swore faithfulness to the gods. Witches are godless beings that even sacrifice evil creatures to get hold of their dark magic.
Then there are the damned, the undead. There are two types of them - ghosts and the walking dead. Both are insults to the teachings of the gods, and both were denied eternal peace, surely for a good reason. They try to kill all living beings. They must be destroyed on sight.
The worst enemies are demons. They are malicious creatures of immense power that plot the downfall of mankind. With all our power and might we have to oppose these servants of the dark one.
All of these enemies pose a threat on their own. We have to be aware of all their evil intrigues to be able to protect our souls. Only a devout and brave heart can triumph over their dark temptations. Those who fail and stumble, even only once, are at risk to become heretics themselves. Therefore we must not only watch ourselves but also our brethren and sisters to see if they might have fallen and turned into enemies.
The best weapons to fight evil are bravery and faith. They are not only the best available arms but also the prerequisite to fight evil at all. Brave followers of the true faith might of course arm themselves with additional weapons. A vial of holy water often works wonders when it comes to clean desecrated places and to drive out unholy entities. Often, a believer needs nothing than a holy symbol combined with his unwavering faith to ward off some of the less powerful evil beings.
The holy ground of temples dedicated to the good gods is a safe haven for everyone as it cannot be entered by the servants of evil. Certain holy relics in the possession of these temples are able to harm or even to defeat the mightiest servants of darkness.
We are all sinners and we should neither be proud of our faith nor be smug about it as pride and vanity are the first steps to heresy. We should be aware of our failures and plead for forgiveness every day.]] },
		},
	},
	-- bookcase at 32314,32261,8
	{
		itemId = 2439,
		itemPos = { x = 32314, y = 32261, z = 8 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The captured vampires were quite young, only a few nights old. They were of no value concerning information about their secret society.
Nonetheless two of them were given to the torturers.
As expected nothing useful could be learnt, even though the vampiric regeneration could once again be observed.
Given the need for information on how to torture the creatures effectively, should a more valuable specimen fall into our hands, several new techniques were tried out. Most proved to be unsuccessful. Eventually both probands died at intended points of the experiment.
The other four were subjected to a series of experiments in order to learn more about the nature of the beasts.
As expected sunlight had an effect on the creatures though not as severe and effective as one might wish.
The vampires showed an incredible fear and aversion to it. Sure enough the tested specimens began to show an actual reaction to the sunlight. Sadly the reaction started off quite slow and later than expected. It took about half a minute before the vampires' skin turned reddish and began to peal off. Another half a minute later their bodies began to smoke, parts of the skin turning to ash. The process continued for another minute before they completely turned to dust.
One specimen was lost in that experiment. The others were salvaged in different states of sunburn and began to regenerate.
As with other tests it could be observed that the vampires have the ability of regeneration but not of regrowth.
The regeneration of those wounded worst took significantly longer than that of the lesser wounded. Adding blood improved the regeneration process considerably.
It is to be assumed that human blood would have had additional effects.
The worst burnt vampire took two weeks to regenerate, needing a considerable amount of blood.
The vampiric body proved highly resistant to cuts and slashes inflicted by magic weapons. Silver lowered that resistance considerably.
Fire and acid proved to be quite effective, contrary to this all administered poisons did not have any discernible effect.
Stakes made of various materials were tested. While some merely immobilized the creatures, blessed stakes eventually turned them into dust.
Their strengths and senses were also evaluated. Even the young vampires were extremely strong, matching the strength of three or four grown men.
They were all able to see in the dark. At least half of them seemed to have increased hearing capabilities. None of them, neither well fed nor under the threat of death could turn into a bat or a wolf.
In conclusion we can assume that the traditional means at our disposal are sufficient to eliminate any vampires we might encounter.
To ensure that they will not rise again, the use of a blessed stake is mandatory.
We have to assume that the abilities and reactions of older vampires differ, either being increased or reduced.]] },
			{ itemId = 2821, -- book
				text = [[
The principle of opening a gate for a demonic army is the same as summoning a demon. You need to accumulate some critical mass of synergistic energy and open a rift between the worlds. The needed ingredients consist of some of the negative energy that is similar to the essence of the demonic realm. The first part of the summoning ritual opens only a small rift to the demonic realm. Through this rift demonic energy enters into our world infiltrating into the ingredients and filling them with more power. With stronger ingredients, the ritual opens a larger rift this time, letting more demonic energy in to strengthen the ingredients. This ritual is repeated over and over again until the ingredients are strong enough to open a portal through which the demons can pass. This ritual can also be initiated from the demon side. Sightings of Orshabaal and similar entities clearly show all characteristics common for such rituals. Once the gate is open, demonic minions appear and boost the negative energy of the place by their sheer presence. Later, the demonic master is following. His appearance causes a drop of the negative energy as the demon lord is feeding on it to sustain his existence in our realm. As long as there are enough minions to boost the negative energy of a place, demons can exist for a very long time in our realm. So in theory, it would also be possible that the gate between the two realms is kept open, allowing more and more demons to enter our world that can easily form a demonic army causing mayhem and havoc. The archdemon Shervad the Destroyer wore an armor made of an unknown material that allowed him to stay in our realm for at least three centuries. In his last battle, he lost his strength, even though he was not physically hurt - his enemies had destroyed his armor. It is said that the armor was made by some ore found in the old mines.]] },
			{ itemId = 2824, -- book
				text = [[
We confirm that the Ruthless Seven have occupied the place which is known as Pits of Inferno. With the help of divination, we were able to see that they channelled their dark essence to some remote place in our world for unknown reasons. We could not figure out this place, though. It cannot be emphasised enough that it is extremely important to find this place and if possible, to destroy it.

It is certain that the gate from our world to the demon realm, which is situated somewhere in the pits, is currently inactive. It works similar like a volcano. Sometimes there is some activity there, most of the time nothing happens at all, but occasionally there is a tremendous eruption.
We assume that the last major eruption coincided with the destruction of the Nightmare Knights. Several earlier reports of increased demonic activity overlap with eruptions, too.
Three things can be concluded from our observations: Firstly, the demons have no control over these eruptions, though they try to be as active as possible whenever an eruption occurs.
Secondly, the demons cannot foresee the dates of these eruptions. For this reason, coordinated efforts to make use of the eruptions are delayed.
Thirdly, eruptions are not stable enough to support a longer campaign without risking the stranding of many powerful demons in our world like fish on dry land.
The worst thing that could happen is that a large amount of less powerful demons is breaching into our world to stay here permanently. They will have some guidance by their leaders as long as the eruption lasts. Once the eruption comes to an end, the demonic leaders will retreat to their realm, leaving a chaotic and rampaging demon army in our world.
As long as the pits were defended by the Nightmare Knights, who must have known previously when an eruption would occur, the demons could be fought back while they were still materialising and thus, most vulnerable. Now that the pits are lost and overrun by demonic hordes, an attack becomes more and more likely.

There was no massive demonic invasion in the past, and probably there won't by any in the future. If the demons had had such a possibility, they would have used it. At least some archdemons would have grabbed the chance, and a cabal such as the Ruthless Seven surely has the power to attack our world while defending its position in its own realm. It is surely no lack of ambition that keeps the demons from raiding us, there must be other forces that have prevented such an attack so far.

Even before the creation of the humans, there have been several occurrences that can only be interpreted as attacks by demonic armies trying to stop the creation process. Inhuman sources tell of several armies that invaded our world in the course of many centuries.
Most of these invasions could be tracked to some unholy centre of magic. From there immense forces were evoked to open a gate through which the demonic armies entered our world.
The gate was opened, an army passed through, and the gate eventually closed again. The invading armies had no supplies and were finally destroyed. The demonic leaders made only rare appearances on the battlefield, probably summoned by their minions for a while. So contrary to common belief, it seems possible that a large demonic army enters our world if certain conditions are met. It should be our top priority to find out what conditions this may be.]] },
		},
	},
	-- bookcase at 32314,32262,8
	{
		itemId = 2439,
		itemPos = { x = 32314, y = 32262, z = 8 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Beholder Threat IV
The braindeaths, whose own minds had suffered considerably through years of isolation and of unholy experiments, were enraged by this decision. They openly defied the scientists and even the high council. When the elders issued an ultimatum and threatened to destroy the undead by force, the braindeaths rebelled. A war ensued that was short, but vicious. Both sides fought without mercy, using any weapon at their disposal. The braindeaths were eventually overwhelmed and killed, but not without unleashing their undead menagerie. The beholders pursued them without mercy, but some of the undead, who were well capable of sentient thinking, escaped by blending in with the regular undead that employed in the city.
Today, it is impossible to work out how many of those creatures escaped. However, it is safe to say that the powers they reportedly possessed are strikingly similar to those that are characteristic for vampires. For this reason it is safe to say that at least one of those creatures must have managed to escape from its subterranean prison. The beholders, however, destroyed the remaining laboratories. It is even said that the remaining scientists that had been sent to assess the braindeaths' experiments eventually asked to be executed, as their analyses had tainted their minds in a way that only beholders could understand. Their requests were granted. They were collectively put to death, taking their knowledge about the vile experiments to their graves. Today, nothing but speculation remains.]] },
			{ itemId = 2816, -- book
				text = [[
The Beholder Threat III
The beholders had learnt the bitter lessons from the gruesome wars that had led them to the brink of extinction. They had realised the limitations of their race, and they decided to work on their weaknesses. They found that they had relied too heavily on their intuitive powers in the past, and they decided to improve their innate powers through research and experiments. The dark art of necromancy seemed especially promising, so a group of beholders, which eventually became known as bone lords, concentrated all their efforts towards improving their powers to master the undead. 
These efforts met with a first, important success when the bone lords managed to create a new kind of undead minion that was capable of acting on its own, without direct control by a bone master. Unfortunately, these minions still lacked intelligence, and although they were unwaveringly loyal they were of little use to their vile masters. And so it came that the bone lords continued their horrible experiments on living and dead ... They stole souls and implanted them, they switched minds and bodies between the dead and the living, but none of the gruesome experiments ever produced the kind of monstrosity they had in mind. 
Eventually they started exposing undead bodies to evil energies and merging them with living beings into massive undead monstrosities, which, however, withered and died almost as soon as they were created. After some experiments that failed in an particularly spectacular manner, the bone lords were forced to abandon their experiments. Soon, their gruesome experiments faded from memory. They had been all but forgotten when a number of braindeath emerged in a remote beholder city, claiming to have achieved a decisive breakthrough in the field of necromancy. The high council of the beholder elders reluctantly sent a number of scientists down to the laboratories to examine the results. The undead creatures they found were so hideous and degenerated that the scientists flatly declared that these experiments that led their creation contradicted the very principles of beholderkin. All undead were to be destroyed and the experiments were to be abolished once and for all.]] },
			{ itemId = 2816, -- book
				text = [[
The Beholder Threat II
It seemed like the beholderkin, which was created by the gods as a counterweight to another race that preceded them in the god wars, was unstoppable. But, alas! In the end, they shared the same fate that most other races suffered during the god wars: Yet another race appeared on the scene which proved to be even mightier. They were well protected against the beholders' magical arsenal, and so it was only a question of time before the beholders' empire collapsed. The beholders were replaced by a succession of other races that were chosen by the dark gods to champion their cause. One race followed another, sometimes even before the previous race had become extinct. All the while, the beholders fared better than most of their successors: Owing to the fact that they had once conquered the whole world, small areas of their civilisation remained even while their once mighty cities disappeared and their mysterious pyramids crumbled to dust. Many beholders chose to hide below the surface of the world, fighting fierce underground wars to win supremacy over the other races that had fled the surface where the god wars raged on. Their successes were limited, but at least the beholders managed to establish a number of new subterranean bases, which were safe even though they lacked the grandeur of the beholders former cities.]] },
			{ itemId = 2816, -- book
				text = [[
The Beholder Threat I
Once in the olden days, the beholderkin numbered among the most powerful races of the world. Their mighty cities, which characteristically contained ominous dark pyramids, could be found all over the world. The beholders erected them using the same innate form of telekinesis which lets their bodies float in the air. However, they could not do completely without hands and arms that did their bidding. For this reason they relied on another innate power of their race - the dark power of necromancy. Thanks to the magical abilities of their eye stalks, which are capable of producing various powerful kinds of magic to an extent that is denied to other races unless they study for many decades, the beholders also knew how to command the dead. As a result, they used a monstrous strategy: Whenever they conquered an area they turned their unfortunate victims into undead slaves. Using these undead legions as their shock troops, the beholders went from victory to victory. They built a huge fortress that served as their power base, and from there they went to conquer the world.]] },
		},
	},
	-- bookcase at 32314,32263,8
	{
		itemId = 2440,
		itemPos = { x = 32314, y = 32263, z = 8 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
We confirm that the Ruthless Seven have occupied the place which is known as Pits of Inferno. With the help of divination, we were able to see that they channelled their dark essence to some remote place in our world for unknown reasons. We could not figure out this place, though. It cannot be emphasised enough that it is extremely important to find this place and if possible, to destroy it.

It is certain that the gate from our world to the demon realm, which is situated somewhere in the pits, is currently inactive. It works similar like a volcano. Sometimes there is some activity there, most of the time nothing happens at all, but occasionally there is a tremendous eruption. 
We assume that the last major eruption coincided with the destruction of the Nightmare Knights. Several earlier reports of increased demonic activity overlap with eruptions, too. 
Three things can be concluded from our observations: Firstly, the demons have no control over these eruptions, though they try to be as active as possible whenever an eruption occurs. 
Secondly, the demons cannot foresee the dates of these eruptions. For this reason, coordinated efforts to make use of the eruptions are delayed. 
Thirdly, eruptions are not stable enough to support a longer campaign without risking the stranding of many powerful demons in our world like fish on dry land. 
The worst thing that could happen is that a large amount of less powerful demons is breaching into our world to stay here permanently. They will have some guidance by their leaders as long as the eruption lasts. Once the eruption comes to an end, the demonic leaders will retreat to their realm, leaving a chaotic and rampaging demon army in our world. 
As long as the pits were defended by the Nightmare Knights, who must have known previously when an eruption would occur, the demons could be fought back while they were still materialising and thus, most vulnerable. Now that the pits are lost and overrun by demonic hordes, an attack becomes more and more likely. 

There was no massive demonic invasion in the past, and probably there won't by any in the future. If the demons had had such a possibility, they would have used it. At least some archdemons would have grabbed the chance, and a cabal such as the Ruthless Seven surely has the power to attack our world while defending its position in its own realm. It is surely no lack of ambition that keeps the demons from raiding us, there must be other forces that have prevented such an attack so far. 

Even before the creation of the humans, there have been several occurrences that can only be interpreted as attacks by demonic armies trying to stop the creation process. Inhuman sources tell of several armies that invaded our world in the course of many centuries.
Most of these invasions could be tracked to some unholy centre of magic. From there immense forces were evoked to open a gate through which the demonic armies entered our world.
The gate was opened, an army passed through, and the gate eventually closed again. The invading armies had no supplies and were finally destroyed. The demonic leaders made only rare appearances on the battlefield, probably summoned by their minions for a while. So contrary to common belief, it seems possible that a large demonic army enters our world if certain conditions are met. It should be our top priority to find out what conditions this may be.]] },
			{ itemId = 2824, -- book
				text = [[
The principle of opening a gate for a demonic army is the same as summoning a demon. You need to accumulate some critical mass of synergistic energy and open a rift between the worlds. The needed ingredients consist of some of the negative energy that is similar to the essence of the demonic realm.
The first part of the summoning ritual opens only a small rift to the demonic realm. Through this rift demonic energy enters into our world infiltrating into the ingredients and filling them with more power. With stronger ingredients, the ritual opens a larger rift this time, letting more demonic energy in to strengthen the ingredients. This ritual is repeated over and over again until the ingredients are strong enough to open a portal through which the demons can pass.
This ritual can also be initiated from the demon side. Sightings of Orshabaal and similar entities clearly show all characteristics common for such rituals.
Once the gate is open, demonic minions appear and boost the negative energy of the place by their sheer presence. Later, the demonic master is following. His appearance causes a drop of the negative energy as the demon lord is feeding on it to sustain his existence in our realm.
As long as there are enough minions to boost the negative energy of a place, demons can exist for a very long time in our realm. So in theory, it would also be possible that the gate between the two realms is kept open, allowing more and more demons to enter our world that can easily form a demonic army causing mayhem and havoc.
The archdemon Shervad the Destroyer wore an armor made of an unknown material that allowed him to stay in our realm for at least three centuries. In his last battle, he lost his strength, even though he was not physically hurt - his enemies had destroyed his armor. It is said that the armor was made by some ore found in the old mines.]] },
			{ itemId = 2831, -- book
				text = [[
Only the most pious are allowed to join our ranks. The churches support the inquisition in their efforts to get rid of heretics that try to undermine our society. They are an illness and we are the cure. If we don't cut off the rotten parts, the illness will spread and eventually contaminate us all. If someone joins our ranks, he will start off as an investigator. He will have to prove his worthiness by diligent work and pious deeds. He will have to face traitors and monsters and kill them.]] },
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
		},
	},
	-- bookcase at 32315,31777,8
	{
		itemId = 2437,
		itemPos = { x = 32315, y = 31777, z = 8 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Biographies of the Rich and Infamous
Dustbeard the Pirate Vol. 2

Those crewmen who were capable of realising that what they had seen was not a drink induced mass hallucination, believed Brian dead, but soon thereafter a second flash of lightning revealed his seemingly unconscious body floating in the water. They were able to retrieve Brian, more dead than alive from the waves. Over the next few days, it became clear that Brian's brush with the lightning had not left him unchanged. His hair was completely statically charged and reacted to any contact with metal with violent sparks of lightning, and any contact with others led to them getting slight electric shocks. Brian reacted rather stoically and refrained from shaving his beard and cutting his hair. The static charge meant that his hair attracted dust - thus giving him the nickname of Dustbeard. When Jolly Jack went into retirement, Dustbeard's characteristic appearance, his golden tongue, his skills as a seaman and liberal amounts of homebrewed alcohol led him to be the natural choice of the crew as captain.

Upon becoming captain he remembered his old grudge towards his hometown and began to harass the coastal towns of Carlin. When Carlin re-established contact to the town of Svargrond, Dustbeard was there to threaten the new shipping lines. Dustbeard and his men might not be the most skilled pirates but they are known to attack ships against all odds when they are drunk enough. Their unpredictability in battle often gives them the element of surprise, and often their victims are so astonished at the sight of the drunken pirates with their manically haired Captain, that Dustbeard's men more often than not meet with success. It is only a question of time though, before this kind of behaviour will lead to their demise.]] },
			{ itemId = 2826, -- book
				text = [[
Biographies of the Rich and Infamous
Dustbeard the Pirate Vol. 1

This is the sensational story behind one of our most notorious pirates, whose hairstyle has sparked a veritable fashion amongst the more rebellious Tibian nobility! It is the story of (who else could it be?) Dustbeard, the infamous and follicly advantaged Pirate! Dustbeard was born under the unassuming name of Brian Eagleston in the City of Carlin. Even in his youth he made a name for himself with the town's authorities, getting involved in brawls in taverns and vandalising public property. He was among the first to be banned from Karl's pub in Carlin. Before he could even grow the beard that was to become his trademark he was involved in the illegal production and trade of alcohol. After some of his customers suffered severe illnesses (hallucinations, memory loss, blindness) he was arrested and sentenced to forced labour in the woods and docks. It was in this milieu that he reinvented himself as a political activist and freedom fighter, demonstrating the skills in leadership and oratory that were to serve him so well in his later career. He convinced his inmates that his trade in alcohol was in fact a form of rebellion. He was not even 20 years of age when he led his fellow prisoners in a revolt in which they captured the ship they had just helped to build and set sail for Thais. Unfortunately, none of his followers were proficient in sailing or navigation, and his first outing as a pirate was doomed to end in failure. The ship was wrecked on a reef while they were trying to reach a village to pilfer food and water. However, he and his men made it to the shore, where they proceeded to relieve the terrified villagers of their food, while faithfully promising that they would be repaid for the loss in due course in the name of the Thaian King. This procedure turned commonplace - he and his crew roamed the wilderness, harassing towns, knowing full well that this questionable course would provoke and bring them into conflict with the authorities, should they ever show up in Thais.

However, this career of pillaging villages and coastal towns was fated to meet an end when he attempted to capture the cargo of a trade ship docked in the harbour of a sleepy coastal town. The Pirate Jolly Jack and his men had beaten them to the town and in the ensuing battle the majority of Brian's men were killed or fled, and Brian, a survivor as always, surrendered. The survivors were given the choice to join Jolly Jack's crew or be left to face the fury of the townsfolk. Of course, Brian and his remaining men chose to join the pirates. The following years saw Brian bloom into a capable seaman and pirate. His popularity amongst his pirate brethren was assured by his skill in brewing alcohol from anything and everything which he could get his hands on. However, it was his brewing skills that once again get him into trouble. A storm struck the ship after a night of particularly heavy drinking from a particularly heavy brew - half of the crew was unconscious and the other half were feeding the fishes. It was on this evening that an air elemental chose to attack the ship. It focused its attacks upon the sails of the ship, hoping to break the mast and drown the drunken sailors. Brian, more drunk than sober, climbed the mast and challenged the elemental fiend. Although it is unlikely that the elemental understood the curses and insults hurled at it by the drunken Brian, it was angered enough to attack him. It left off trying to drown the crew, and focussed instead upon the hapless Brian. It grabbed him and carried him high up into the air, where they were struck by lightning.]] },
		},
	},
	-- bookcase at 32317,31777,8
	{
		itemId = 2435,
		itemPos = { x = 32317, y = 31777, z = 8 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
The Silent War

It is no secret that Thais has always looked to our fair city of Carlin with envious eyes, claiming it as its own. It is also well known that, as the years have proceeded, and Carlin has gone from strength to strength that Thaian claims on Carlin's territory have become nominal, at best. Although the Thaian Royal line and the Thaian nobility are linked with some of the bloodlines of Carlinian families, the times of open hostilities are part of the past, to the benefit of both cities. The only reason that Thais has not discarded its claims on Carlin is merely that such a move on behalf of the royal house would be viewed as weakness.

But, I hear you ask, if this is so, why are we still suffering under unfair trade barriers? Why does Thais still use its not inconsiderable political power to hinder Carlin's growth and prosperity?

The answer, my fellow Carlinians and concerned merchants, lies in Venore. Reliable sources who do not wish to be named for obvious reasons, who have contact with the highest officials of Thais, have revealed that the Thaian manouvering to infringe our rights and growth originates with the Trade Barons of Venore. The profit motivated Venoreans use their influence, propaganda and wealth to influence decisions made in Thais to the detriment of their greatest competitor - Carlin. Venorean agents are known to hinder Carlin's expansion through any means possible, be it bribery, threats, lies, blackmail or intrigue. Although this maouvering has mainly been covert, the success they have met with is making them more brash and confident and their intrigues are becoming more open and apparent. There is little doubt that they would go to any length to harm us. In fact, Venore is like a spider, waiting to pounce on us should we show any sign of weakness! However, Venore is still too cunning or too cowardly to act openly against our city. Theirs is not the way of open and honourable confrontation, rather, they prefer to let others do their dirty work for them. Thais is merely a tool for them to achieve their devious aims, while we, my friends, concentrate our suspicions upon Thais. By so doing, we are playing directly into their hands!

Thais may still pose the actual threat, but they are not the source of the evil. Should any of you still doubt the truth of my words, then the final, irrefutable proof of the Venorean Trade Barons'ambitions can be seen in the fact that they intentionally undercut our prices, ban our wares from the markets they control and they are the key agents for smuggling contraband into our city, undermining our profit margins and aiding the growth of the black market. It can be assumed that Carlins Girls' Brigade (CGB) has gathered files about Venorean activities and it is a shame that such information is not made public.

Next issue: The CGB - Has it been Infiltrated?]] },
			{ itemId = 2821, -- book
				text = [[
Marcia Rugby's travels in the north

Marcia Rugby was the youngest of three daughters of a Trading house in Carlin. Her family was heavily involved in the establishment of a trading outpost at Svargrond before the years of the plague of sea serpents. Marcia was entrusted with the tiresome negotiations with the barbarians of the north. To gain their trust she had to pass the infamous barbarian rite of passage and lived with the shamans on the Isle of Okolnir. Her determination, her iron will and her willingness to adapt and learn their culture duly impressed the barbarians. It was during the time that she spent with the shamans that a growing threat raised its ugly head - the threat of the sea serpents. Although messengers sent by her anxious family reached her in time, informing her that the last ships were about to leave for Carlin, she made the fateful decision to stay with the shamans, in accordance with her agreement with them.

Upon her return to Svargond the majority of the people from Carlin had left, unwilling to risk getting stranded away from their homes and families. It was apparent that the sea serpents were not a passing threat. Marcia, however, was the daughter of a Trading House, and not one to sit around and wait for fortune to turn. She took her fate into her own hands and continued with her family's aim of setting up the trading outpost, ready for when the sea routes would become safe for ships once more. In order to make her venture a success she decided to explore the icy lands to find out more about the natural resources to be found there and what goods could be traded with the natives. She ventured far and wide, amassing a great deal of knowledge. However, it was during one of her more ambitious forays into the wilderness that she was captured by barbarian raider tribes. Her fluent use of the native tongue which belied her foreign appearance amazed her captors and she managed to negotiate to meet their leader. She was taken before one of the tribe's ice witches. Once more, her considerable skills in negotiation enabled her to convince the witch that she had to see the high ice witch Yakchal herself.

Marcia so fascinated Yakchal with her stories from different lands and their wonders that she kept her interested enough to not be killed. She even managed to gain her trust enough to live in relative luxury in her captivity. Although it is unclear exactly how many years Marcia was in captivity, she was there long enough for the sea serpents to have been driven from the waters around Svargond. Rumours of the reopening of the trade channels reached Marcia, even in the isolated camp where she was held. In order to escape, she disguised herself as an ice witch and left Yakchal's hideout without rousing suspicion. Her long internment in the camp and her contact with the barbarians had taught her the necessary skills for survival in that unforgiving wilderness and finally she reached Svargond. It was here that she was reunited with her sisters, who had given her up for dead. She left with them to Carlin, but, too long used to a life of travel, she was unable to settle for long before wanderlust overcame her.

She decided to set out on an expedition to the Shattered Isles - an expedition from which she never returned. Her family waited in vain for news of her and were left to speculate whether her ship had fallen prey to one of the vicious and sudden storms known to haunt that region, whether it had fallen foul of pirates or whether it had been the victim of a Quara attack. Although the rest of Carlin presumed Marcia dead, her sisters continued to light a candle in Marcia's room, in the hope that she would, one day, return.]] },
		},
	},
	-- bookcase at 32318,31777,8
	{
		itemId = 2436,
		itemPos = { x = 32318, y = 31777, z = 8 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The folly of man volume V]] },
			{ itemId = 2825, -- book
				text = [[
The folly of man volume IV]] },
			{ itemId = 2825, -- book
				text = [[
The folly of man volume III]] },
			{ itemId = 2825, -- book
				text = [[
The folly of man volume II]] },
			{ itemId = 2825, -- book
				text = [[
The folly of man volume I]] },
		},
	},
	-- bookcase at 32319,31777,8
	{
		itemId = 2437,
		itemPos = { x = 32319, y = 31777, z = 8 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The druids of Carlin are closely affiliated to the city and its leadership. From the earliest days of the fledgling city, when the druids helped to provide food and shelter, to the days of prosperity and stability when they offered guidance and healing, they have been a constant in Carlin's history. Because the druids have been rewarded with great respect and considerable influence as a result of their engagement in the city and their decisive role in its success, many druids have moved to Carlin. This has had the consequence that over time, Carlin has become a centre of druidic magic and teaching.

When the looming threat of the Ghostlands was discovered it was the local druids who helped to erect a barrier that warded off the undead and the ghostly inhabitants. The prominence of druidic magic in Carlin has led to somewhat restrained relations with the Sorcerers' Guild that has close ties to Thais as is evident by the funding of the Edron academy. Over the course of time the more rigid guild members of the Sorcerers' Guild withdrew from Carlin and were replaced by freelancers and freethinkers with only loose ties to the Thaian guild so that over the years a form of acceptance between the local guilds was formed. The druids continue to be part of the everyday life of Carlin and heavily influence the culture and philosophy there.]] },
			{ itemId = 2824, -- book
				text = [[
The songs of Azaram were numerous and several of them lived on to be still sung in our days. His chivalrous exploits were the base of many modern fairy tales and three of the lections of the art of fighting still bear his name. All the more his fall from grace was more than tragic. It's a bitter and sad tale, recounted numerous times in different ways. Most of this tale still romanticise what has happened. Historical records thankfully give us a more precise picture. In one of his chivalric journeys he met a damsel of incredible beauty. Yet she was engaged to another, much older knight for political reasons. What exactly transpired is still disputed. Though the historical texts give us some plain fact. It cannot be ruled out that his love was indeed the result of a curse of a swamp witch coven. Azaram had certainly participated in several witch-hunts, albeit not in a more active way then his compatriots. It is still possible that he, as a prominent figure was chosen for a curse, to have a greater impact. Also it can't be ruled out, that the damsel in question had a more active and sinister role in the things that transpired. Though the stage play 'The poisoned love of noble Azaram' depicts her as an evil schemer there is little factual evidence to support that claim. Indeed though, she took an unusual road for her travel to her fiance and certainly not in a time that was suited to traveling. But the assumption she orchestrated the attack on her company and the timely rescue by Azaram seems a bit farfetched. For sure it's recorded that he accompanied her on her way from there on. What transpired on their trip together no historian can tell. When they arrived at the home of her fiance, Azaram stayed as honoured guest. When the wedding drew near he was more and more often found in a drunken stupor and susceptible to fits of rage. In the evening before the wedding, the groom took offence of his behaviour and scolded Azaram, reminding him of the knightly virtues. This lead to an outburst of Azaram in which he drew his weapon and swiftly slew his offender. Sobered up by the shock of his own action, he grabbed the maid and forced their way out of the castle, leaving several men at arms dead. The nightly chase lead them to the swamp. Perhaps he wasn't aware where he was riding or perhaps he hoped to lose the pursuers in the marsh under cover of darkness. When the hunters arrived they only saw a gnarled, armoured fist raising from the swamp. when they managed to retrieve the body, OOO was dead. The maid was nowhere to be found, supposedly resting in the swamp for eternity.]] },
		},
	},
	-- chest at 32384,32153,8
	{
		itemId = 2472,
		itemPos = { x = 32384, y = 32153, z = 8 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Alistair Cropwell's Travel Notes

...strange things I saw today! A mighty city, inhabited with fearsome beings. Dark rituals, the reason of which I could not discern. Are these people friend or foe? I do not know. I remain in hiding and observe.. and what is the meaning of this strange talisman that I found? The symbol appears everywhere, I fear it may have powers that could cause damage in the wrong hands.

I have been travelling so long, I can hardly remember the features of my beloved ones. Will they recognise, will they remember me? What will they make of my tales? Oh, that I be back with them, walk the city again...]] },
		},
	},
	-- chest at 32384,32155,8
	{
		itemId = 2472,
		itemPos = { x = 32384, y = 32155, z = 8 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Isaac Brewton, 908 pg


On the movement of objects
As everyone knows many objects do not remain static all the time. But what causes them to move? In some cases this is clear, if I punch a ball I am the cause of the movement, but whatabout an object falling?

Falling objects head downwards, but what is "down", what is below us? The answer is simple: Hell! And who rules hell? Satan! So, obviously Satan is the cause of these movements, Satan is among us all the time. But if he causes these objects to fall, what reason is there that he should not be the cause of all other movements?]] },
		},
	},
	-- bookcase at 32677,31645,8
	{
		itemId = 2435,
		itemPos = { x = 32677, y = 31645, z = 8 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The Bonelord Threat I
Once in the olden days, the bonelords numbered among the most powerful races of the world. Their mighty cities, which characteristically contained ominous dark pyramids, could be found all over the world. The bonelords erected them using the same innate form of telekinesis which lets their bodies float in the air. However, they could not do completely without hands and arms that did their bidding. For this reason they relied on another innate power of their race - the dark power of necromancy. Thanks to the magical abilities of their tentacles, which are capable of producing various powerful kinds of magic to an extent that is denied to other races unless they study for many decades, the bonelords also knew how to command the dead. As a result, they used a monstrous strategy: Whenever they conquered an area they turned their unfortunate victims into undead slaves. Using these undead legions as their shock troops, the bonelords went from victory to victory. They built a huge fortress that served as their power base, and from there they went to conquer the world.]] },
		},
	},
	-- bookcase at 32679,31647,8
	{
		itemId = 2437,
		itemPos = { x = 32679, y = 31647, z = 8 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Kuridai took refuge in a volcanic area, inhabited by vile monsters and ravaged by the eruptions of the mountains. Stripped of almost any possesions, they hid in the caves and learned to become very secretive. They had to work very hard, had to fight for almost any goods with nature and ferocious beasts. Most beasts that could live in such livethreatening circumstances were that powerfull that direct attacks proved to be futile. So the elves begun to develop a more devious way to fight, with assaults, traps and hit and run tactics. After over hundred years they had enough resources to leave the burning lands and adopted their way of live to their new enviroment. So they became the secretive people under the hills. They were fierce fighters whenever their new home was threatened. Some hundred years they fought off all intruders until their explorers made contact with the other remaining elven casts. Under the growing pressure of the more and more powerful waves of orcish attacks they left their homes to join forces with the other elves in an uneasy alliance. Their apperance had changed to a even more slender Version of the normal elves. Their skin is very pale, their hair pure white or pitch black. The younger members of that cast often color strands of their hair in unusual clors like red, blue or purple. Red, albinotic eyes are common, but in general all kinds of eyecolors are existent.]] },
		},
	},
	-- bookcase at 32681,31647,8
	{
		itemId = 2435,
		itemPos = { x = 32681, y = 31647, z = 8 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Dwarven report XII
Enemy territory and settlements

Our scouts recently discovered a great number of elven hideouts within the "deeper woodlands". They also have a great city, comparable to a capital, there, which is called Ab'Dendriel, and is mainly inhabitated by Deraisim and Cenath. The defenses are rather weak, and it seems like a lot of nomads and wanderers pass through the region.

We also found ruins within the hidden mystic valley, the structure of the buildings is typically elven. The ruins seem to be the result of a harsh thunderstorm of magic, but it was too long ago for us to find closer traces.

More interesting should be the fact, that the volcanic regions beyond the thundery mountains seem to be colonised by the elves as well. There dwells a race called Kuridai, and they seem to be the most aggressive and militant elves we encountered yet.

Suggestions about possible assault targets if war will be at hand are envoiced in sub-report EY-01.]] },
			{ itemId = 2816, -- book
				text = [[
We could not confirm the extinction of the Chelabdil. On the other hand we found no living beeing in the area. We met strong orcish presence there. Some of the orcs we killed had elvish items on them so it might be possible that all of the so called Chelabdil were wiped out by the orcish hords. One proof more our way is the right one.]] },
		},
	},
	-- bookcase at 32681,31649,8
	{
		itemId = 2435,
		itemPos = { x = 32681, y = 31649, z = 8 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
We confirm that the Ruthless Seven have occupied the place which is known as Pits of Inferno. With the help of divination, we were able to see that they channelled their dark essence to some remote place in our world for unknown reasons. We could not figure out this place, though. It cannot be emphasised enough that it is extremely important to find this place and if possible, to destroy it.]] },
		},
	},
	-- bookcase at 32682,31647,8
	{
		itemId = 2436,
		itemPos = { x = 32682, y = 31647, z = 8 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The 5th elven cultural group are the Chelabdil. Their role in the war and their fate is yet unclear, but they have few contact with the other elven casts. They are usually a bit taller and stronger than elves of the other races, and there skin is silvery-white or in blue to greenish tones. Their eyes are often pale blue or green, sometimes a faint yellow. They have long black hair, or sometimes dark brown. They seem to live nowadays in the region northwest of Carlin and are seen quite often there. They have the keenest eyes of the elves, and the weapons of their choice are spears, knives and sometimes the short bow. They are fine hunters and sometimes trade furs, but the main part of their life remains yet uncertain.]] },
		},
	},
	-- bookcase at 32682,31649,8
	{
		itemId = 2436,
		itemPos = { x = 32682, y = 31649, z = 8 },
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
	-- box at 32711,31629,8
	{
		itemId = 2473,
		itemPos = { x = 32711, y = 31629, z = 8 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The story of old Dragons mountain...
Author: Anonymous

It is said, that near the swamp of the damned there is supposed to be a dragons lair in the mountains north of it. Legends speak about dragons with red scales and a fiery breath, which store great amounts of treasure in their lair. But since nobody will have the courage to go there, it will never be known, if the legends are true.]] },
		},
	},
	-- box at 33076,31158,8
	{
		itemId = 2469,
		itemPos = { x = 33076, y = 31158, z = 8 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Blight and sickness are spreading. The great plague has not been forgotten yet and so sickness is something people are accustomed to. But I can sense the taint that is spreading, and the spirits of earth, water, and wind tell me about some presence that is poisoning the soil and the springs. I can feel it also when I am fully attuned to the land. The new regime does not like if people talk about such things, and I was removed from my position in the ministry of agriculture. My abilities made me a precious member of the order and I used to be influential and respected. And now they strip me off like an old skin. I don't understand what is happening and the spirits can offer me little help in this matter. I retreated to my old home, banned from the gardens I loved so much. The spirits are still with me but my lifetime achievement was taken away from me. I could have understood the decision if I had supported the resistance in the civil war in any way but I was never a politician and did not take part in that rebellion. What is wrong about warning people of something bad that is happening? The dragon kings can't see that as an act of rebellion or spread of unrest. I just want to help with all my power. Why would they want to keep such a blight a secret? Is it perhaps their fault in some way? I fear the worst. I have talked to several of my old friends about that issue and they just won't listen. Even the most open-minded seem to have changed since some time. It is almost as if they were replaced by someone else. All they say is 'the dragon kings want this ...', ' the dragon kings want that ...' as if that were the only thing that is of importance to them. Perhaps I was too reclusive, too absorbed with talking to the spirits, and I don't understand my fellow lizards anymore. But there is still hope. I was called to the court of one of the dragon kings. I will probably speak to one of his highest ranking followers. I guess they have heard about my concerns and will give me an opportunity to speak about my concerns. Surely they will finally recognise the importance of my observations. Perhaps I will regain my old position and will soon have access to the gardens again.]] },
			{ itemId = 2821, -- book
				text = [[
Only parts of the military are willing to support us. Their spirit was broken long ago in the fights against the orcs. Our once proud army was reduced to an inflexible behemoth that reacted sluggish to any problem. And this behemoth was beaten into shambles by the orcish hordes. Only the dragons' interference turned the tides of war. Now most generals fear what would happen if this support were withdrawn. Could we repel another attack of the orcs? Would a civil war not only make us more vulnerable with no winner at all? I fully understand and share these views. Still, it is our only hope. If we bow to the dragons now, they will rule us once and for all. We have to act here and now. Yet, I am afraid not many will join us and the temptation to betray our cause for some better position in the hierarchy is a constant danger. Our best hope is to form a resistance in secret and then strike at the dragon kings at once. None of them shall survive and we have to avoid fighting other parts of the army. We must save every strength that is left for the time ahead, for a time when the dragon kings are gone. With a beheading strike we will free our nation.]] },
			{ itemId = 2821, -- book
				text = [[
The treatment of sick peasants has lost more and more importance in the recent years. The local governors have grown accustomed to rather shunt infected people into the provinces of their rivals than to pay for their treatment. People are cheap and plenty, medication is not. As a physician I cannot agree to such an attitude, but I am in the employ of a governor and have little influence on his decisions, and even less on those of others. The nobility in turn values its health quite much. Even the most minor symptoms have to be treated with the most expensive and powerful potions at our disposal.]] },
			{ itemId = 2821, -- book
				text = [[
I have been informed by the local governors of the north that they will not be able to send any additional troops to help out with our orc problem. They claim that the diseased are threatening to invade their fortresses in the hope of finding some cure or nourishment there. Therefore, they need every men at their disposal. I will gather the local guards that are now on their way to stop the spread of the plague by burning infected villages and join them with my remaining soldiers. Considering our might and expertise, the orcish raiders are of course no threat. I will take the rejection of support as an opportunity to prove my superior strategical and logistical skills. There has not been any glorious battle for decades. Even though I fear that the reports of panicked peasants exaggerate the number of the orcs, there is still hope that they will be enough to give my soldiers some exercise. The captain of the local border patrol has remained silent for quite a while now. I assume he is still figuring out how to explain that he had let slip some of the orcs. I will not accept the decimation of his ranks due to the plague as an excuse. The plague is something we all have to deal with. It is even possible that one of my rivals has paid him for his inattention in the hope to disrupt my control of my province in these hard times. I think it will be the wisest decision to have said captain executed as soon as I have dealt with the orcs.]] },
			{ itemId = 2828, -- book
				text = [[
With the orcish hordes in our lands, many of my colleagues have recalled their troops from the borders and patrol duties to fortify their cities. Only me and a few others still maintain some form of patrols. It seems that due to the lack of resistance, the orcs roam quite freely in our lands. Ironically the calling back of troops seems to have brought the plague into the fortresses. So the reinforcement actually turned into weakening the positions. When the emperor learns about this, I am sure some heads will roll. Without any force to restrict them, hordes of infected peasants flee their villages and spread the plague further. From all what I can tell, the plague has spread everywhere by now and even the fortresses are no longer safe. I think once the orcs retreat, we will have a big task of rebuilding at hand. With the obvious failure of certain governors, I will gain more power and influence. Perhaps I can even convince the emperor to merge some of the bordering provinces with mine.]] },
			{ itemId = 2821, -- book
				text = [[
The plague is not much different from those we have encountered before. In fact in ancient texts I found a report of an occurrence some generations ago with almost identical symptoms. The plague of these times was only local. The village was put under quarantine and the best physicians and supplies were sent. Over the course of a month, the plague had passed through and from over 100 infected less then 20 had died. It seems the plague in our days was ignored by the authorities for quite a while. Later a local governor tried to cover up this mistake and kept the plague secret. To ensure that, he chose a rather aggressive approach and had the village burnt down with all its inhabitants. It seems that some of the villagers had escaped though and fled to relatives in neighbouring villages. As the word of the extermination of the village spread, many peasants fled their villages as soon as the first symptoms of the plague showed up. Still, it seems the plague is hitting the peasantry harder than it had in the past. I think I will have to investigate their living conditions to get a better insight.]] },
		},
	},
	-- bamboo shelf at 33080,31217,8
	{
		itemId = 2459,
		itemPos = { x = 33080, y = 31217, z = 8 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The farmer Zuan was found guilty of heresy for speaking bad words about a spawn of the great snake that has crossed his field. He was sentenced to death and his tongue was cut out. The tongue will not be given a proper burial but will be thrown into the sea. The village has to pay the temple 20 sacks of their finest rice as compensation. Praised be the great snake.]] },
			{ itemId = 2816, -- book
				text = [[
The governor Tazar was found guilty of treason in three cases and was executed at sundown. He was found guilty to have withhold money from the local taxes to fund a rather dubious private army of mercenaries. Secondly, he had used said mercenaries to sabotage the property of a neighbouring governor. Further, he was found guilty of belonging to a cabal of three governors of his family line that planned to assassinate the emperor and to replace his house in regency. His belongings were confiscated and his family was dispossessed, his co-conspirators were arrested.]] },
		},
	},
	-- bookcase at 33188,32849,8
	{
		itemId = 2438,
		itemPos = { x = 33188, y = 32849, z = 8 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
The Akh'rah Uthun is the unity of that which cannot be united. The flawed Akh, which is our anchor to this mundane world, is generally weak. By giving in to the needs of the physical Akh, the Rah and the Uthun become enslaved to this world, even though their potential is such that they could transcend the physical world. However, the greatest flaw the Akh suffers from is its mortality. Why should we seek to satisfy its puny needs and its trivial urges if we know it is doomed to die? Yet this is how the Akh holds our spirit captive. It slowly poisons both the Rah as well as the Uthun.]] },
		},
	},
	-- bookcase at 33188,32850,8
	{
		itemId = 2439,
		itemPos = { x = 33188, y = 32850, z = 8 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
So the seven were banished to the depths of seven cursed tombs. There they are waiting, imprisoned for eternity.
One was buried outside the city in the shadows of the south-eastern tower, close to the pharaoh yet forever banished from his grace.
One was buried in the ancient ruins far to the north, a tribute to her love for all that is old.
One was buried at the tar pits. Blackness engulfed his withering heart, and blackness shall engulf his final demise.
One was buried in the fields of stone. His will was as hard as a rock, so lifeless stone will cause his fall.
One was buried near the Mountain, between its eternal body and a small stony hill, so that his rest may be eternal and unrelenting like the mountain he loved so much.
One was buried somewhere on the peninsula to the south, so that his restless slumber might be soothed by the murmuring of the waves.
One was buried not far to the north of the oasis. He was the one who found it most difficult to part from this world.
The sands of the desert swallowed them all and sealed their fate. They are lost and yet they are denied the peace of true death.
This is the fate of those who draw the wrath of the pharaoh on themselves.]] },
		},
	},
	-- bookcase at 33188,32854,8
	{
		itemId = 2439,
		itemPos = { x = 33188, y = 32854, z = 8 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
The Uthun, formed from our memories, is especially vulnerable to the Akh's dominion. It is always its first victim, the first to fall for its pathetic needs and its badly-chosen priorities. And so the Uthun falls prey to the Akh's temptations. Once the Uthun is tainted the Akh is sure to come next. The Akh is inadequately translated as 'soul' into this language. It is the unseen spiritual centre hidden deep in all that is alive, and it is each living creature's most prized possession. It is the very essence of being. And it is our most vulnerable part.]] },
		},
	},
	-- bookcase at 33199,32849,8
	{
		itemId = 2438,
		itemPos = { x = 33199, y = 32849, z = 8 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
By the powers that remain and the powers of old,
by the wisdom of the scarab and the kiss of the scorpion,
by the infinity of the sand and the eternity of the mountains,
by the life-giving powers of water and air,
by the death-bringing powers of fire and lightning,
by the blessing of death and the revelations of undeath,
this corpse shall rise from the grave,
this corpse shall break the shackles of life,
this corpse shall seek wisdom,
this corpse shall serve the one.
Praised be our pharaoh!]] },
		},
	},
}
