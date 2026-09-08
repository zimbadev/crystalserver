--[[
	Bookcases, shelves and corpses holding a book or a scroll (part 4 of 4) -- 90 containers.

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

MapContainersBooks4 = {
	-- bookcase at 32421,31598,14
	{
		itemId = 2439,
		itemPos = { x = 32421, y = 31598, z = 14 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The formulas of Titaina
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32421,31599,14
	{
		itemId = 2439,
		itemPos = { x = 32421, y = 31599, z = 14 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The formulas of Urina
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32421,31600,14
	{
		itemId = 2439,
		itemPos = { x = 32421, y = 31600, z = 14 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The formulas of Dokia
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32421,31602,14
	{
		itemId = 2439,
		itemPos = { x = 32421, y = 31602, z = 14 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The formulas of Lexis - Energyflow of the life rings
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32421,31603,14
	{
		itemId = 2439,
		itemPos = { x = 32421, y = 31603, z = 14 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The formulas of Lexis - Energyflow of the death rings
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32424,31590,14
	{
		itemId = 2435,
		itemPos = { x = 32424, y = 31590, z = 14 },
		contents = {
			{ itemId = 2830, -- book
				text = [[
The magic web - Maps - Book 1
Written by Cartikus

*You can see several maps of Tibia with red lines and golden points on it*]] },
		},
	},
	-- bookcase at 32425,31590,14
	{
		itemId = 2436,
		itemPos = { x = 32425, y = 31590, z = 14 },
		contents = {
			{ itemId = 2830, -- book
				text = [[
The magic web - Maps - Book 2
Written by Cartikus

*You can see several maps of Tibia with red lines and golden points on it.*]] },
		},
	},
	-- bookcase at 32427,31590,14
	{
		itemId = 2436,
		itemPos = { x = 32427, y = 31590, z = 14 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
The formulas of Janias
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32428,31590,14
	{
		itemId = 2436,
		itemPos = { x = 32428, y = 31590, z = 14 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
The formulas of Konios
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32429,31590,14
	{
		itemId = 2436,
		itemPos = { x = 32429, y = 31590, z = 14 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
The formulas of Loxenos
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32430,31590,14
	{
		itemId = 2436,
		itemPos = { x = 32430, y = 31590, z = 14 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
The formulas of Minaja
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32435,31594,14
	{
		itemId = 2438,
		itemPos = { x = 32435, y = 31594, z = 14 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The formulas of Lineos
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32435,31595,14
	{
		itemId = 2439,
		itemPos = { x = 32435, y = 31595, z = 14 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The formulas of Geran
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32435,31597,14
	{
		itemId = 2439,
		itemPos = { x = 32435, y = 31597, z = 14 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The formulas of Lexis - Energyflow of the time rings
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32435,31598,14
	{
		itemId = 2439,
		itemPos = { x = 32435, y = 31598, z = 14 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The formulas of Lexis - Energyflow of the time rings
Book 2
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32435,31599,14
	{
		itemId = 2439,
		itemPos = { x = 32435, y = 31599, z = 14 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The formulas of Lexis - Energyflow of the time rings
Book 3
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32435,31600,14
	{
		itemId = 2439,
		itemPos = { x = 32435, y = 31600, z = 14 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
The formulas of Lexis - Energyflow of the time rings
Book 4
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32435,31603,14
	{
		itemId = 2439,
		itemPos = { x = 32435, y = 31603, z = 14 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
1001 ways to use energy beams.
Written by Hrmumundus Grofrukle

*After reading the whole book (which takes you almost an hour) you suffer from headaches. You remember only one thing and have to laugh as the memory returns. It's the 647th. way to use an energy beam: a venerable wizard who grills meat with his deadly spell.*]] },
			{ itemId = 3577, count = 3 }, -- meat
		},
	},
	-- strong wooden gable at 32472,32553,14
	{
		itemId = 28274,
		itemPos = { x = 32472, y = 32553, z = 14 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Ruthless Seven
by unknown

This confusing text seems to
describe the demonic rulers
of a place called the Pits
of Inferno.]] },
		},
	},
	-- strong wooden gable at 32472,32556,14
	{
		itemId = 28274,
		itemPos = { x = 32472, y = 32556, z = 14 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Immortality Made Easy]] },
		},
	},
	-- strong wooden gable at 32472,32563,14
	{
		itemId = 28274,
		itemPos = { x = 32472, y = 32563, z = 14 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
Secrets of Zathroth
The Forbidden Book!]] },
		},
	},
	-- strong wooden gable at 32472,32566,14
	{
		itemId = 28274,
		itemPos = { x = 32472, y = 32566, z = 14 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Tales from the Crypt
by an unknown necromancer.]] },
		},
	},
	-- strong wooden gable at 32472,32569,14
	{
		itemId = 28274,
		itemPos = { x = 32472, y = 32569, z = 14 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
50 Shades Of Dark Magic]] },
		},
	},
	-- strong wooden gable at 32476,32553,14
	{
		itemId = 28274,
		itemPos = { x = 32476, y = 32553, z = 14 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
The Mysteries Of Yal'Rath Thah]] },
		},
	},
	-- strong wooden gable at 32476,32556,14
	{
		itemId = 28274,
		itemPos = { x = 32476, y = 32556, z = 14 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
How To Become A God In 50 Comprehensive Steps - A Beginners Guide]] },
		},
	},
	-- strong wooden gable at 32476,32563,14
	{
		itemId = 28274,
		itemPos = { x = 32476, y = 32563, z = 14 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The Ultimate Truth of Ascencion]] },
		},
	},
	-- strong wooden gable at 32476,32566,14
	{
		itemId = 28274,
		itemPos = { x = 32476, y = 32566, z = 14 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Willpower, the Greatest Weapon]] },
		},
	},
	-- strong wooden gable at 32476,32569,14
	{
		itemId = 28274,
		itemPos = { x = 32476, y = 32569, z = 14 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
A treatise on cosmic entitys]] },
		},
	},
	-- strong wooden gable at 32480,32553,14
	{
		itemId = 28274,
		itemPos = { x = 32480, y = 32553, z = 14 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
How to Pick Up Demons]] },
		},
	},
	-- strong wooden gable at 32480,32556,14
	{
		itemId = 28274,
		itemPos = { x = 32480, y = 32556, z = 14 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
The Magic of the Ghouls
by Paramor.]] },
		},
	},
	-- strong wooden gable at 32480,32563,14
	{
		itemId = 28274,
		itemPos = { x = 32480, y = 32563, z = 14 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
I, Ferumbras]] },
		},
	},
	-- strong wooden gable at 32480,32566,14
	{
		itemId = 28274,
		itemPos = { x = 32480, y = 32566, z = 14 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Travels Through The Dreamworld]] },
		},
	},
	-- strong wooden gable at 32480,32569,14
	{
		itemId = 28274,
		itemPos = { x = 32480, y = 32569, z = 14 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
How To Beat Dark Souls]] },
		},
	},
	-- strong wooden gable at 32484,32553,14
	{
		itemId = 28274,
		itemPos = { x = 32484, y = 32553, z = 14 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
Beyond the Veils of Sanity]] },
		},
	},
	-- strong wooden gable at 32484,32556,14
	{
		itemId = 28274,
		itemPos = { x = 32484, y = 32556, z = 14 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Forbidden Secrets of Magic!]] },
		},
	},
	-- strong wooden gable at 32484,32563,14
	{
		itemId = 28274,
		itemPos = { x = 32484, y = 32563, z = 14 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Death of the Gods]] },
		},
	},
	-- strong wooden gable at 32484,32566,14
	{
		itemId = 28274,
		itemPos = { x = 32484, y = 32566, z = 14 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
Negation Of The Impossible]] },
		},
	},
	-- strong wooden gable at 32484,32569,14
	{
		itemId = 28274,
		itemPos = { x = 32484, y = 32569, z = 14 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Minions of Morgulah]] },
		},
	},
	-- strong wooden gable at 32488,32553,14
	{
		itemId = 28274,
		itemPos = { x = 32488, y = 32553, z = 14 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
How To Cook For Forty Humans]] },
		},
	},
	-- strong wooden gable at 32488,32556,14
	{
		itemId = 28274,
		itemPos = { x = 32488, y = 32556, z = 14 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
Hitchhikers Guide To The Planes]] },
		},
	},
	-- strong wooden gable at 32488,32563,14
	{
		itemId = 28274,
		itemPos = { x = 32488, y = 32563, z = 14 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
Demons
Book X.]] },
		},
	},
	-- strong wooden gable at 32488,32566,14
	{
		itemId = 28274,
		itemPos = { x = 32488, y = 32566, z = 14 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Secret Of Mana]] },
		},
	},
	-- strong wooden gable at 32488,32569,14
	{
		itemId = 28274,
		itemPos = { x = 32488, y = 32569, z = 14 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The Rise of the Seven]] },
		},
	},
	-- bookcase at 32573,32195,14
	{
		itemId = 2435,
		itemPos = { x = 32573, y = 32195, z = 14 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
If you want to enter the crypt of a great mage, you should seek the answers to some of these questions.

What was his name?
How old was he?
Which color had his hat?
What was his banner?
What was the name of his favourite dragon?
Who was his assistant?
Which spell killed him?
In which city he was born?]] },
		},
	},
	-- bookcase at 32576,32195,14
	{
		itemId = 2435,
		itemPos = { x = 32576, y = 32195, z = 14 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The most perplexed and purple way to see your world Tibia
by Perplex

...]] },
			{ itemId = 2819, -- parchment
				text = [[
<you cant read this strange glyphs>]] },
		},
	},
	-- bookcase at 32577,32195,14
	{
		itemId = 2436,
		itemPos = { x = 32577, y = 32195, z = 14 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Don´t be surprised!
You could also use a bow instead of runes.
by Galadriel

...]] },
			{ itemId = 2815, -- scroll
				text = [[
The rune "sudden death" - how to put it in which bag? - how powerful is it really? - And how to fire it as quick as possible?
by Medrok]] },
		},
	},
	-- box at 32674,31989,14
	{
		itemId = 2469,
		itemPos = { x = 32674, y = 31989, z = 14 },
		contents = {
			{ itemId = 641, -- piece of paper
				text = [[
Eventually we reached an island that was thoroughly evil. It took all our courage and bravery to make our way through the dangerous territory to the dominating structure of the evil tower that loomed over the whole isle. We were well aware that the master of that tower had to be the epitome of evil and we had to enter his tower, regardless of the dangers involved. Only few had ever reached the isle and none of them had ever returned to tell the tale. But we were there and knew that it was our destiny to face the master of the isle. Retreat was not an option. We braved all the dangers that the isle seemed to throw against us and finally stood in front of the tower. Who would carry on our work if we failed? We knew if we did not stop the master of this isle, it might take decades until somebody else would find this isle and then it might be too late to stop the fiendish plot that threatened the whole world.]] },
		},
	},
	-- bookcase at 32844,32226,14
	{
		itemId = 2435,
		itemPos = { x = 32844, y = 32226, z = 14 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
What Dreams Are Made Of]] },
			{ itemId = 2816, -- book
				text = [[
What an irony, the necromancers' nectar is the key to our doom and to our victory. Only he who feeds those in need will gain entrance, which is ironic too, because the forces of evil will never consider to do such a thing, no matter how gruesome it truly is. There is no way that the entrance is revealed but by treachery. Therefore, we have to keep the number of people who know about the secret as low as possible. Only the most trusted members will learn about the ritual. I can only hope there is no other high ranking traitor like Goshnar.]] },
			{ itemId = 2816, -- book
				text = [[
In the realm of dream, dreams literally can become true. So mind your thoughts when entering the dream realm. A uncontrolled thought can easily bring disaster upon you. Self-control is most important for any dreamwalker. Calmness and clear thought will guide and shield the dreamer. You will encounter in the dreams what you take in there with you. Don't try to enforce a prophecy, it won't work. Wander the dreams and if a prophecy comes to you, take it as a gift.]] },
			{ itemId = 2821, -- book
				text = [[
Sleepwalking for fools]] },
			{ itemId = 2821, -- book
				text = [[
Dreamwalking for Beginners]] },
			{ itemId = 2821, -- book
				text = [[
Dreamwalking for Experts]] },
		},
	},
	-- bookcase at 32845,32226,14
	{
		itemId = 2436,
		itemPos = { x = 32845, y = 32226, z = 14 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Some of he ancients formed realms in the dreamland. They build mighty fortresses to seize control of everything that walks in the dreamland, conscious or not. It was then, when the mysterious Lord of Dreams revealed himself. His anger shook the foundation of the dreamland. Dreamers all over the world awakened screaming in fear and pain. When the void came to a rest and the first dreamwalkers returned to the dreamlands, the fortresses were gone - all of them and with them all the ancients who manned them. The Shaig'laar lost their best men in these days and never recovered from the loss. So weak, they became an easy prey for the other ancients and so the period of the first dream masters had come to an end. From this time on, all dreamwalkers manipulate the dreamland as little as possible, only as much as it is needed to fit their needs. Also they never use their power to endanger others in their dreams. Dreams are meant to be an instrument of self-finding and prophecy, not a weapon.]] },
			{ itemId = 2821, -- book
				text = [[
When they killed the youngster I didn't help him because I didn't know him.
When they killed the young knight I didn't help him because I had not much in common with that guy.
When they killed the local hero I didn't help him because it was his business, not mine.
When they killed the monk, who just lived to help others, I didn't help him because he should have been more warily.
When they killed my friend I didn't help him because I thought I should not risk my life for him.
When they killed my brother I didn't help him because I hoped they would at least spare me for not interfering with their business.
When they killed me, there was no one left alive who could help me.]] },
			{ itemId = 2821, -- book
				text = [[
Evil often seems invincible, but even the longest journey begins with a first little step. It is up to us to say 'NO' to evil and to deny it the space it needs to blossom. We might fear it, but it cannot scare us. We might be weaker, but in the end evil will lose. Evil is hollow and self-consuming. Nothing can warm up the cold hearts of evil beings, nothing can fill the loneliness. A life so centred on itself cannot be shared with others. If you do not share your life, you deny it. Life is sharing. No one can cope with life alone. You have to share your life to give birth. You have to share to feel your life. Evil beings do not feel life, so they destroy it. Evil cannot understand life, and things that cannot be understood are feared.]] },
			{ itemId = 2816, -- book
				text = [[
Greed, selfishness and hate are the soil that gives birth to evil. You can't neglect these feelings since they are part of you. But you can understand them. To understand why you hate someone will give you a deeper understanding how to cease to hate. Sometimes, you may have to kill someone. Do never kill somebody out of hate. Only kill to prevent a greater evil. You also have to understand your positive feelings. They are your shield to protect you from the assaults of negative emotions. They are the blanket that keeps you warm in desperate times. As long as you follow the path that these positive emotions show you, there is nothing that can harm YOU. They can hurt your body but your immortal soul is beyond their grasp.]] },
			{ itemId = 2816, -- book
				text = [[
It is important for a dreamwalker not to get lost in his dreams. To accomplish that you have to train your senses. You must become aware that you are dreaming without waking up. To train this, get accustomed to asking yourself : 'Am I awake?' Do this at daytime as often as possible. But be careful! Do not conclude too quickly that you are awake. Try to 'fly' just on your thoughts, try to change the world around you by sheer imagination. Take some time to test reality. At some point of that training you will use this routine in your sleep as well. Then it is essential to come to the conclusion that you are asleep! If you have accomplished that, you will have a hard time to balance between dreaming and awakening. At first you will often slip back in the dream state but that will change quickly. Then you can begin the art of dreamwalking.]] },
			{ itemId = 2816, -- book
				text = [[
Nightmares are not your enemies. Make them to your teachers. Learn about them. Understand them. If it is a repeated nightmare, think about it while awake. Think about a good ending for that dream, imagine this ending again and again, feel comfortable with this happy ending. Enjoy it. Have fun with it and the nightmare will lose its sting. This way you can train yourself to dream the positive ending.
Sometimes it is helpful to write your dreams down. Don't try to analyse them. You will get used to understand them just by reading and reliving them. It's not necessary to force something. This could even be harmful! Understand them as a nice story someone told you. Enjoy them and think about how they could continue. Imagine what would have happened if something like this happens in real life. Your dreams are your friends. All of them!]] },
		},
	},
	-- bookcase at 32846,32226,14
	{
		itemId = 2437,
		itemPos = { x = 32846, y = 32226, z = 14 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The weapon was hidden well. We ensured that only a hero of courage and an unstained soul can find it.
The unholy place will be guarded by our order. If its necessary, we will guard it eternally. No magic will be able to discover the secrets now.
We used powerful enchantments and all the tricks our brightest minds have came up with. There will be no way to trick our wards or to disenchant them. I am confident that, combined with the riddles and traps, our forces will fight back all evil that might challenge us. Even the Ruthless Seven themselves if necessary.]] },
			{ itemId = 2816, -- book
				text = [[
When the tower falls,
when the cold loses its sting,
when the small walks the halls of the great,
when the lord of murder loses his nobility,
when the ice kisses the fire,
when the arrow will not fly twice,
when the thunder silences the mute,
when the red meets the green on golden ground,
when the ivory is broken by the blood-stained hand,
when the dead walk on earth and laugh at the gods,
when the names will be erased and the vanished return,
when the forbidden twin no longer exists,
when the one-eyed king dies in fire,
when the traitor meets his fate,
then excalibug will be reborn in the flame of justice.]] },
			{ itemId = 2816, -- book
				text = [[
He, who commands those who should have left the world, will come and claim the lives of those who walk two worlds. The twice fallen will fall a last time to seal the secrets and the imminent doom. Evil beings will feast on weak ones, not knowing that this is just the beginning of their own destruction.
Those that are sleeping will be awakened to dream again.
Those that are dead will live longer than the killers do.
Many eyes will see the coming of the light in the thickest darkness and the fisher will be the king.
The unborn will cheer for the reborn. Where no way exists, the heroes must fall. Where blood runs red, destiny awaits the wanderer. Where many ways are obviously, the wise chooses another one. Where one falls, four are victorious. Where the forces meet, the path will be revealed. Hope only arises from the highs and lows of the true path and the warrior will die in agony.]] },
			{ itemId = 2821, -- book
				text = [[
The Nightmare Chronicles Volume VII

... and when the dead feast at midnight
the ancient enemy will no longer guard
the place of his unlucky heir and the
living will walk the paths of the old way.
Death awaits the greedy and the brave
alike and many will be mourned until
the long lost treasure is unearthed...]] },
			{ itemId = 2821, -- book
				text = [[
What an irony, the necromancers' nectar is the key to our doom and to our victory. Only he who feeds those in need will gain entrance, which is ironic too, because the forces of evil will never consider to do such a thing, no matter how gruesome it truly is. There is no way that the entrance is revealed but by treachery. Therefore, we have to keep the number of people who know about the secret as low as possible. Only the most trusted members will learn about the ritual. I can only hope there is no other high ranking traitor like Goshnar.]] },
			{ itemId = 2821, -- book
				text = [[
Today the last of the elves returned to their home town. They left us alone to battle the undead hordes. What a cowardly race! Without their aid, many of our best men will die. I don't understand these sages that asked me to see also the elves' point of view. All I see are the the mothers and fathers that will ask me where their children are when they have died in the upcoming battle. It is almost certain that our messenger, who was sent to the dwarfs and the king, is dead. There will be no reinforcements. We will have to fight on our own. I am sure we will win, but at what cost?]] },
		},
	},
	-- chest at 32846,32285,14
	{
		itemId = 2472,
		itemPos = { x = 32846, y = 32285, z = 14 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
I wonder how Ronur is doing. I miss him.
But its my duty as sorceress of the nightmare knights to protect our bases here far away from home. Soon I will visit him and we will be reunited again. If all works like planned our marriage will take place in the end to this year.
I hope this bitch Shandra will be kept busy by her studies in the mage guild and does not try to use my absence for one of her dirty tricks. She does not deserve a man like Ronur.]] },
			{ itemId = 2821, -- book
				text = [[
... we see the transplaner semimatter is polymorph and the time constant is a contradiction in cases of subliminal manafocusing of the first grade. This implies that the vector of interisomatic transfixture has a mana to semimatter ratio of t*m-RM. So if the hyperelasticity of NM is defined as shown in previous volumes, we derive a transpeherical aethertransfixion of t-RU. This is no surprise to even the most simple minded rune user but the real implication of this is ...]] },
		},
	},
	-- chest at 32846,32288,14
	{
		itemId = 2472,
		itemPos = { x = 32846, y = 32288, z = 14 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Coalblack and the Seven Elves.
Once upon a time, there lived a beautiful dwarven girl in a humble settlement. The girl was called Coalblack. She was so pretty that seven elven men travelled to the settlement to see her beauty. But the girl feared that the elves just wanted to steal her underwear to dance around in it in the morning mists. So she asked her friend, a big wolf, to help her. The wolf put on boots and a red cape and ate some chalk to smooth his voice. Impersonating little Coalblack, he lured the elves into the darkest woods. But the elves dropped their clothes in the woods to be able to trace back the way they had taken. In the middle of the forest the elves found a magic mirror. They asked the mirror: 'Mirror, mirror in the forest, tell us whom you most adorest' And the mirror spoke 'You naked elves are pathetic!' The elves turned around and were deeply offended. 'What a bunch of incredible bums!' the mirror said. The stupid elves misunderstood the mirror and felt so flattered and cajoled that they built a gingerbread house around it and lived there happily ever after.]] },
		},
	},
	-- chest at 32848,32285,14
	{
		itemId = 2472,
		itemPos = { x = 32848, y = 32285, z = 14 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Roll, roll, roll the barrel
gently down the road!
Drinking, drinking, drinking, drinking,
drink until you're bloat.]] },
			{ itemId = 2816, -- book
				text = [[
Banor bless me with deafness!
This snoring dwarf is driving me nuts. Will this ever stop? One day, I will kill either him or myself. I can't believe the others can sleep, dream training or not!
I wonder if I would become deaf by putting my head in a cauldron and using an explosion rune. Then again, I should perhaps put HIM in a cauldron and use some explosions ...
I am sure he will lure a dragon here that thinks this awful noise is a mating call.
Tomorrow, I will try to get an assignment at Knightwatch Tower. Even that windy hole is better than THIS!]] },
		},
	},
	-- chest at 32856,32285,14
	{
		itemId = 2472,
		itemPos = { x = 32856, y = 32285, z = 14 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
... we see the transplaner semimatter is polymorph and the time constant is a contradiction in cases of subliminal manafocusing of the first grade. This implies that the vector of interisomatic transfixture has a mana to semimatter ratio of t*m-RM. So if the hyperelasticity of NM is defined as shown in previous volumes, we derive a transpeherical aethertransfixion of t-RU. This is no surprise to even the most simple minded rune user but the real implication of this is ...]] },
			{ itemId = 2821, -- book
				text = [[
How to Seduce Women in Seven Steps

Chapter One:
How to Become a Member of a Young Male Bard Group.]] },
		},
	},
	-- chest at 32858,32285,14
	{
		itemId = 2472,
		itemPos = { x = 32858, y = 32285, z = 14 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
... we see the transplaner semimatter is polymorph and the time constant is a contradiction in cases of subliminal manafocusing of the first grade. This implies that the vector of interisomatic transfixture has a mana to semimatter ratio of t*m-RM. So if the hyperelasticity of NM is defined as shown in previous volumes, we derive a transpeherical aethertransfixion of t-RU. This is no surprise to even the most simple minded rune user but the real implication of this is ...]] },
			{ itemId = 3506, -- stamped letter
				text = [[
Telmur

If you don't repay your debts 'something bad'
will happen to your family.

D.]] },
		},
	},
	-- seashell bookcase at 33454,31188,14
	{
		itemId = 14069,
		itemPos = { x = 33454, y = 31188, z = 14 },
		contents = {
			{ itemId = 14015, -- seashell book
				text = [[
Exercises, Chapter II: Basic Vocabulary 1 (A-D)

Additional notes: Most complex words are constructed of smaller basic vocabulary. For example: 'surface' ('gouthn') consists of 'over/up' ('gou') and 'face' ('thn'). Ligatures appear as consonants only as in 'Qjell' ('Qjell'). An 'i' at the end of a word will always be pronounced as 'ee'. A verb is negated if it is followed by 'ro'. For example: 'lume' ('reach') followed by 'ro' ('not') means 'not to reach'.

alive/life=kejh
and=ut
armed=tanakk
ascend=forfai
be/is/was=en
bed=meh
before=kon
black=flou
book=giot
bow=ly
bring=bur
bringer=buron
colour=yill
coming/arrival/come=jarkh
creature=corej
death=brok
deep/depth/profound=nja
deepling=njey
defend=obu
destruction/destroy=jakhn
do=lh
down=osk
dweller/dwell=naumpi]] },
		},
	},
	-- seashell bookcase at 33459,31186,14
	{
		itemId = 14066,
		itemPos = { x = 33459, y = 31186, z = 14 },
		contents = {
			{ itemId = 14015, -- seashell book
				text = [[
The Book of Qjell, The First Coming

Edition II, Translation from 'Jekhr' (language of the Deeplings)
By Lagatos, Chronicler and Scholar

When the creatures of the deep were born under the eternal suns, a great evil befell the seas. An evil never described in writing nor mentioned by a scholar for it was blackness incarnate. Chaos and darkness reigned and the deep suffered direly. For centuries our world was shattered and occluded from light and warmth. Those born under a weak tide were abducted, captured, eaten by fiends of the void. The strongest would prevail, but their numbers were small. Our race was facing extinction before they were touched by even a single beam of light. It was in these darkest of nights and the deepest of depths that a Deepling would rise to face the unlight. It was Qjell who was the first, the one to stand against these vile odds. He lived as one of us, he suffered among us. He reached for the surface and brought the light, his gift, to undo the deeds of the wicked. To cleanse the deep and to wash our faces for we were to expect the twin suns. And he drove away the evil and was light incarnate. This was the time known as the First Coming. We shall await the Second Coming. And for we are given time on this world, we shall use it to erect walls and pillars, temples and towers, gardens and cities. For we shall prosper and grow to await the Coming of our God King Qjell.]] },
		},
	},
	-- bookcase at 33595,30991,14
	{
		itemId = 2438,
		itemPos = { x = 33595, y = 30991, z = 14 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
My memoires as dictated by the First Dragon:
When I arrived in the lands of the scaleless, I already had a life of adventures and excitement behind me and so I was looking for a cosy play to stay. Eventually I found a little cave that had just the right size to serve as a small but decent hoard. Also the cave's acoustic would enhance the screams of my victims in a most pleasing way. Young dragons usually prefer a volcanic and hot environment. At my age, however, the heat is relatively harmful for my scales and the sulphuric fumes may lead to spontaneous stomach combustions. The new cave, though, had all the gloom and dankness an old dragon could wish for. Despite the cave's closeness to one of the few human towns that awakened in these days, the younger dragons had passed on because the town lacked a princess who could be kidnapped for amusement. Since I had no nerves for weeping, screaming and sad love stories anyway, the cave was the perfect choice for me, and quite a bargain, I might add.
Being a good neighbour, I refrained from burning and plundering the city. However, anyone who entered my lair was fair game of course. Oh and they came! At first there were only a few. The first ones were some farmers looking for a lost chicken. What an irony - they tasted just the same. In my eagerness for a meal I have to admit I behaved like some newt. I had completely forgotten about my manners and let no one escape. Of course that way no one could spread the word and so it took a while until the next humans stumbled into my realm. Soon a healthy ritual established in which I pretended they had some chance to slay me - then I ate them, occasionally letting escape one.
Whenever I recognised the flow of adventurers was waning, I invented a new vulnerability to give them some hope. In the years to come I pretended all kinds of things, something amusing like not being able to see through their laughable invisibility spells, something more desperate like pretending to be afraid of flowers or parcels, up to the absurd like acting that I was unable to walk through fire. My human admirers believed it all. They were all great sports and tasted quite well. The surprise on the face of those invisible sorcerers when I finally turned towards them to roast them for dinner - just priceless. You must have been there to fully appreciate it.
However, too much tin food, like we call those armour-clad humans, is not very healthy for a dragon in the long run. Yes, it's temptingly delicious and easily prepared but molten cheap metal does not go well with stomach acid. Moreover, we all know that one gets fat while being on a human diet.
And fat I got and the stomach problems started. Also my hoard had grown so much that it did not fit into my humble lair anymore. Moreover, all the fights had lost their fun and turned into a tedious chore. So I made up my mind and started looking for a retirement home. A former pal of mine hinted me at an affordable island cave - that was just the place I was looking for.
I felt bad for my humans, though. Whom should they feed all those pesky heroes to when I was gone? So I asked a dragon clan to move into my cave when I was gone. Only later I learnt that they did a very lousy job. One by one they got killed. Well, the damage was done and it did not really bother me much.
Since then I've been living a life in peace on a strict no-human diet and I feel healthy and energetic to last for several more centuries.]] },
		},
	},
	-- bookcase at 33737,32157,14
	{
		itemId = 2438,
		itemPos = { x = 33737, y = 32157, z = 14 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
Report

The dwarves did not heed our advice and headed straight into the danger we warned them about. They did surprisingly well - until they got into the inevitable mess we expected. Since they stubbornly insisted to remain in the midst of trouble, we had to come to their rescue of course. The dwarves proved astonishingly capable in fighting the threat but in the long run they would have succumbed to the constant onslaught unless we brought in our ingenuity and expertise. Since the dwarves were somewhat reluctant to let go of their proven tactics, we had to figure out how to reinforce them in the best way possible. Naturally we came up with some solutions that fused our expertise and equipment with those of the dwarves to a solid defence. Now we seem somewhat stuck in the fight, no side gaining the upper hand. Experience tells us, however, that those below won't be idle for long and the next waves of attacks will be more fierce and long. Eventually even the best defences will wear off.
Furthermore, our sources tell us that the real threat is even more sinister. We located several sources of tremendous heat in the depths. We encountered something like that some time before: it always preceded the rise and eruption of large lava steams into a confined cave system. It seems that our old enemy is using old tricks once again. The location of the heat sources seems easy enough, yet to get to them and possibly destroy the mechanisms they use to raise the lava is the hard part.
We do agree with the dwarves that only swift and decisive action can win the day. We have to strike at the heart of the invasion force.]] },
		},
	},
	-- bookcase at 33737,32158,14
	{
		itemId = 2438,
		itemPos = { x = 33737, y = 32158, z = 14 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Those Below, What We Know (III)

The only enemies that could be captured and questioned were some of the lost. They displayed a tremendous pain tolerance and lack of fear but their intelligence levels seemed seemingly frighteningly low. With limited vocabulary and interaction it seemed that they see 'those below' rather as some form of primal gods of fire and pain than as creatures. It seems likely they never saw or interacted with them directly.
Conquered territory saw an increase of heat levels. This went hand in hand with the level of occupation of the territory. Where they could be repelled, the heat level did not rise significantly, so a natural cause can be ruled out. What is unknown is if the heat comes with the presence of those below or they need it to move into an area and raise it in some way.

The nature of 'those below' still remains an enigma. From the little we know only some assumptions can be made. They seem to need or enjoy extreme heat levels and they actively expand their territory, not accepting or attempting any form of negotiation. Their minions behave and communicate (as little it may be) in an entirely enigmatic and alien way so that the reasoning and thinking of 'those below' can't easily be predicted.
The need to spread their territory hints at a rather numerous race that constantly needs more room or resources.

The dominance over powerful beings they employ as generals points at an immense personal power level of the individuals or the race as a whole.
They can manipulate and transform individual beings somehow, perhaps even for breeding those transformations into species.
Their minions, like the lost, require crude, self-made weapons that rather rely on the little skill that race has left than outside sources. Other forms of equipment, as few as have been found so far, hint at even more alien origins and are dissimilar to commonly known tools or machinery. Even those objects, however, might be the remainder of a craft that one of their subjugated minion races once possessed and is probably only a mere shadow of the craftsmanship those races were previously capable of.

Their forces show no regard to themselves or others. A retreat can only be enforced when they deem an effort no longer viable. What is viable or not follows no discernible pattern. Whereas sometimes a brimming ore mine was left in peace after a rag and tag band of defenders fended off some invaders, they sacrificed legions of minions to conquer some abandoned cave, far away from anything of importance.
In this state of the war it has to be mentioned that 'those below', their origin, their look and their motives continue to be an enigma. As their attacks and the pressure they put on other races rises, the importance of such information becomes more and more a priority. How this information can be acquired though, is still something that is desperately debated upon.]] },
		},
	},
	-- bookcase at 33751,32142,14
	{
		itemId = 2435,
		itemPos = { x = 33751, y = 32142, z = 14 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Research Notes of Dolis, Headmaster of the Planegazers

(the paper seems to be extremely old and some parts are hard to read)

We successfully sped up the process, disregarding the council's suggestions. I ordered my team to focus on the places we already know as being visited by the Planestrider. The original sites of its arrival are probably the most visited, yet not very well documented. If we find the origin of the cubes, we find the origin of this being itself. Yet all the cubes we found so far seem incomplete.

(extensive maps may have been drawn here, time has rendered them completely unreadable, what is still there seems to not make much sense)

Comments on active projects:

(the first 20 or so notes are mostly uninteresting and common observations)

#26: Dimensional Beings
We found evidence of what we assume to be visitors from another dimension. A whole race of interdimensional beings has been traced to an uncharted and unexplored content approximately far to the north-east. Travellers have confirmed sightings of hideous creatures with multiple lags, mouths and eyes, devouring or carrying large amounts of energy. All reports described very unnatural beings appearing out of nowhere.

#26/2,addendum: Successful Capture
One specimen was found bound and half-dead on a ship. The captain abandoned the remainder of his crew on this floating coffin only shortly after it arrived in the Venore harbour so we do not know who captured it or how it got onto the ship. It must have been a truly daunting task, however, for as we tried to pull it out of the ship's hold, it came alive and started attacking us immediately, causing a lot of damage. We managed to contain it using one of the advanced holding cells our craftsmen designed. Studying this thing may bring us one step closer to the truth. What are these things and are they the origin of all this?

#26/3,addendum: One Step Back
While we can confirm the specimen from 26/2 is not from our dimension, it is not in any way connected to the being we're after. I conclude that the Planestrider may not even be a "being" in the actual sense. All things considered it may be more of a "concept" but to what end? What is the purpose and why this trail of unmistakable evidence on its existence? The words it offers us are a part of something it wants us to know. It must all be connected to form a meaning, a message. It is clear that we are close to decipher it but what if it is not even in our hands anymore, what if it never was? Note: I should keep trivial or personal thoughts in a diary or something, I will leave these in here for now.]] },
			{ itemId = 2832, -- book
				text = [[
Research Notes of Dolis (#28-#54), Headmaster of the Planegazers

(the paper seems to be extremely old and some parts are hard to read)

Comments on active projects:

#28: Uncovered Planestrider Site
Investigating every old hag's tale, local folklore and thread of sailor's yarn we could find has finally paid off: we found at least one site of the Planestrider's presence underwater in what appears to be a sunken city or temple (reference area 28/VI). It was completely empty but we cannot deem it safe as we had only very limited time to explore the area. Note to the craftsmen: we NEED to find a way to stay underwater for a longer time-span. Any progress on this issue is paramount.

#28/2,addendum: Aquatic Danger
Trying to dive deeper into the sunken area has lead us to heavy restistance. We expected some form of resistance but weren't prepared to encounter intelligent beings with weapons. One specimen could be injured and was successfully captured. All further excursions have been withdrawn until we have recovered from this skirmish. Work on analysing the creature and adding to our existing research continues in the safety of our laboratories. Note: this is quite a collection now, I will order some of these species to be transferred soon.

(the next entry is full of personal notes and many parts are underlined)

#29: The Cubes
All cubes seem to be imperfect. I have yet to find a complete exemplar. They MUST be the key. One of my coadjutors assumes it is some kind of map, I would say it is a weapon but it may also be a key. If the map theory is true, however, there could be a way to get to the origin, we just have to look hard enough for a complete cube. An incomplete cube seems to not have any function at all.

#29/2, addendum: Missing Pieces We cannot find a complete exemplar. In a joint effort we managed to secure several more cubes to analyse but not a single one was perfect. I ordered every cube that is discovered to be brought directly to me. I keep one cube with me all the time now. We have (the writings go on about the necessity of a breakthrough and the cube's potential).

(all other entries are studies of the cubes, all reaching the same conclusions)]] },
			{ itemId = 2816, -- book
				text = [[
Those Below, What We Know (I)

Since the enemy that we know as 'those below' seem to only act through vassals, it is hard to say when they were encountered first. Seemingly random events in the past might have been more or less their doing unbeknown to anyone. In the light of recent events theories have spread that link disasters of the past and monster incursions to the doings of 'those below'. In fact, since no one was expecting a guiding hand behind those events, there is no evidence to support that. The great cave-in of the starsilver claim is cited the most amongst such instances. Indeed the few tunnels that remain from these mines are overrun by creatures that are counted to the forces of those below. Still, it's possible that they are simply lured by seismic activity and just moved in. The gnomes were the first to make out patterns in certain events and attacks on their deepest hold. When their counter efforts were met in kind and often countered, they began to suspect a guiding force behind all of this. Their concentrated efforts were answered by massive counterblows that required massive coordination and logistics, not available to the mostly primitive creatures they fought. Even countermeasures against cave-ins and volcanic activity were sabotaged. Despite all gnomish efforts the enemy activity just grew until the gnomes had to pull back when the effort and casualties were no longer worth the gain from those bases. At first only random holds in the deepest of regions were lost. The frequency of occurrences did rise and at some point establishing new outposts did no longer cover up the losses. The gnomes retreated from the deeper areas and put more efforts into new bases closer to the surface to compensate. With their somewhat nomadic lifestyle the gnomes were able to handle the new situation quite well but since the threat is spreading more and more, they see themselves under pressure. With the deep mining on the rise for the last several hundred years, the dwarfish forces on the other hand are beginning to encounter more and more of the minions from below on their own. Mining technology that was safe and reliable for millennia have started to fail, due to the unnatural seismic activity and rise of lava levels.]] },
			{ itemId = 2821, -- book
				text = [[
Those Below, What We Know (II)

With all the efforts to scout the enemy, little could be learned. Especially since behind the enemy's frontline the earth temperature is rising at an alarming rate and former deep territory that was once settled by gnomes is now immersed by lava. It seems that whatever is leading the attacks is living behind or even in that lava.
We do know that the enemy makes use of numerous creatures. Often the creatures they control are commonly dangerous but rare and display far less aggressive behaviour. They don't gather in hordes, let alone they'd attack with any coordination or in league with other creatures. It is unknown how exactly those creatures are controlled or guided but there seems to be a connection to the mighty leader-like creatures they employ amongst their minions. If they are eliminated, coordination and aggressiveness levels drop almost immediately.
The fact that a lost tribe of dwarves has been enslaved and bred for war purposes hints how they might have attained control over other subterranean races, sentient or not. There is strong evidence that they actually breed their minions actively and there is some sort of indoctrination involved. Given that they breed the lost dwarves to creatures of low intelligence and high aggressiveness, it is likely they have similar procedures for other creatures as well.
Their choice of generals gives other hints abut heir nature. In at least one case they employ the assistance of a fallen gnome. His mind and body were heavily altered in unknown ways. Though in charge of leading their troops he displayed behaviour that usually would be considered mad. Also even he was somehow linked to the coordination of the hostile forces. Although as a gnome he didn't previously display any kind of telepathic ability. So it can be assumed that the other so called generals they employ are also heavily altered specimens of their kind. They probably don't resemble the appearance of 'those below' which leaves us with no clue how they look.]] },
		},
	},
	-- bookcase at 32402,31630,15
	{
		itemId = 2439,
		itemPos = { x = 32402, y = 31630, z = 15 },
		contents = {
			{ itemId = 2830, -- book
				text = [[
Maps of the magic web
Written by Gargail

*You see several maps with red lines and golden points on them*]] },
		},
	},
	-- bookcase at 32402,31645,15
	{
		itemId = 2439,
		itemPos = { x = 32402, y = 31645, z = 15 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
Battletactics for Mages [IV]
by Zun Su

*The last Book of Zun Su's famous Battletactics for Mages deals with the combination of field runes, offensiv runes and spontanous spells (both offensive and defensive). All known spells which could (at least theoretically) be learnt by a mage are listed at the end of the book.*]] },
		},
	},
	-- bookcase at 32415,31647,15
	{
		itemId = 2439,
		itemPos = { x = 32415, y = 31647, z = 15 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
Battletactics for Mages [II]
by Zun Su

*It deals with the proper usage of offensive runes like magic missiles, all kinds of fireballs, explosion or the mighty sudden death rune. It shows how to aim and fire at a quick rate. As usual it has an appendix where all the mentioned runes are listed with detailed description.*]] },
		},
	},
	-- bookcase at 32415,31648,15
	{
		itemId = 2440,
		itemPos = { x = 32415, y = 31648, z = 15 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
Battletactics for Mages [III]
by Zun Su

*The book is about the various spontanous spells. It deals mostly with the destructive spells like fire wave, energy beam and the deadly energy wave. It shows how to hit a moving target with high precision. The various healing spells and the importance of the magic shield are also mentioned. It also has an appendix.*]] },
		},
	},
	-- bookcase at 32420,31630,15
	{
		itemId = 2439,
		itemPos = { x = 32420, y = 31630, z = 15 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The formulas of Lexis - Energyflow of the time rings
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32420,31631,15
	{
		itemId = 2440,
		itemPos = { x = 32420, y = 31631, z = 15 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The formulas of Lexis - Energyflow of the time rings
Book 3
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32421,31593,15
	{
		itemId = 2438,
		itemPos = { x = 32421, y = 31593, z = 15 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Coordinates for the area around Dianscher
Written by Mathemicus

I think I found out some coordinates for the Island Dianscher.
p3,q9,0o and p3,23,0t.

Yet, we must wait until we can control the destination gates and open them without problems.]] },
		},
	},
	-- bookcase at 32421,31596,15
	{
		itemId = 2439,
		itemPos = { x = 32421, y = 31596, z = 15 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
A teleportation through the magic web
Written by Zuania

I was one of the first who was allowed to teleport through the magic web.

I could easily open the gate with the power of my will. But after I was in the magic web I lost control. So I came out near Carlin although I wanted to come out near the east gate of Thais.
All others made the same experience.

It went all so quickly when I was in the magic web. I could only see a red light and some other gates far away for some seconds. And then I was already in Carlin.
Maybe one day we can just teleport into the magic web and stay there. I would love to investigate it.]] },
		},
	},
	-- bookcase at 32421,31597,15
	{
		itemId = 2439,
		itemPos = { x = 32421, y = 31597, z = 15 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
The magic city Demona
Written by Danae, historian of the warlocks
Part3

In the beginning, our ancients lived in total isolation. They thought, that they can survive down here without any contact to the outside world.

But after some years they realised that they cant cast enough food and water for all warlocks.
They also realised, that it was necessary to be under the free sky to cast some spells (Like the spell "Path of the Stars", that only works if the caster can see the stars in the night).

So they made a direct tunnel to the surface.
All seem to work well. But after some years new problems appeared.

<More on book Part4>]] },
		},
	},
	-- bookcase at 32421,31598,15
	{
		itemId = 2439,
		itemPos = { x = 32421, y = 31598, z = 15 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Dragonlords of Tibia
Written by Tekvorian, Knight of Tibia

We dont know much about the mighty leaders of the dragons. But we found out that they love mushrooms of all kind. Maybe the old dragonlord on Dracona can tell us more.

Furthermore, we found out that many Dragonlords carry this strange book (with the big T on it) with them. We dont know why,yet, but we are working on it.]] },
		},
	},
	-- bookcase at 32421,31599,15
	{
		itemId = 2439,
		itemPos = { x = 32421, y = 31599, z = 15 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
How to control the lava
By Jonea, ancient council of the warlocks

The lava was since the beginning our friend.
We always possessed the power to "talk" to the lava and to form/move it for our purposes.
But this ritual requires complete concentration and only with many warlocks it was possible to build this city out of the lava.

Here is how it works:

*The rest sheets of the book were pulled out.*]] },
		},
	},
	-- bookcase at 32421,31600,15
	{
		itemId = 2439,
		itemPos = { x = 32421, y = 31600, z = 15 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
The magic city Demona
Written by Danae, historian of the warlocks
Part2

Our world of Tibia is filled with various kinds of magic. Until now, we dont know much about this magic. Only a small part of the whole magic power is under our control.

Our goal is to research into the magic web of our world and to control it, so we can finally reach our purpose: the immortality.

But before we could start with the research, our ancients had many problems to solve.

<More on book Part3>]] },
		},
	},
	-- bookcase at 32421,31601,15
	{
		itemId = 2440,
		itemPos = { x = 32421, y = 31601, z = 15 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
The magic city Demona
Written by Danae, historian of the warlocks
Part1

We dont know exactly when this city was build.
But it must have been centuries ago.
I have collected the few information we have from the past and tried to reconstruate the birth of this city:

Our ancients used their mighty magical power to control the lava down here. With the help of our loyal trolls, they somehow build this city.

A city only for serving one goal: The investigation of the magic in our world Tibia!

<More on book Part2>]] },
		},
	},
	-- bookcase at 32422,32144,15
	{
		itemId = 2436,
		itemPos = { x = 32422, y = 32144, z = 15 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Chronicle of Mintwallin - the city of the Minotaurs
written by Markwin, king of all Minotaurs

Volume IV

Our excursion is at the end. Today many of our best warriors died. Palkar encountered a dragon that killed many of my minos. It was Palkars fault. He will never lead an army again. And I will never see the light again.

I can't calm Palkar. He is full of energy. And I can't calm my own people. Many don't listen to me but to him. He wants to fight.

A human made his way through the labyrinth! How could he find us? I wanted to get that out of him - but I could not understand him. I have thrown him in the jail. He will never come out of it!

The black day of out chronicle. We had a fight within the walls of my beloved city. Minotaurs fought against Minotaurs - brothers against brothers - sisters against sisters. Palkar and his knights nearly won. But me and some others were able to defeat him. Now, he and his men are outcasts.

Day of sorrow.

The outcasts stole the key to our secret laboratory! That is worst of all. Now we can't make our milk, the source of our power.

I managed to bring a dragon from the dragon-pit at the outer entrance of our secret lab to guard it. He hurt me very hard. I needed much more power than I had. I am deadly injured. I hope this coughing will have an end.

The orcs and trolls conquered some caves back. Dammit! We are too weak now. We can´t defend ourselves. And my coughing gets worse and worse.

Some of my men blocked the way from the secret lab to my chambers with a big rock. I think we are safe now.

The outcasts made an alliance with a tribe of cyclops. Now our former brothers are our worst enemies. They are hiding somewhere in the labyrinth.

The oldest Minotaur of the city told me that my written words have many mistakes and that I would write in a terrible form. I killed him. I am a fighter - not a teacher!]] },
		},
	},
	-- bookcase at 32426,31591,15
	{
		itemId = 2436,
		itemPos = { x = 32426, y = 31591, z = 15 },
		contents = {
			{ itemId = 2830, -- book
				text = [[
*You see a collection of maps in this big book. Some have strange red lines on them. 
You can read the words
"known parts of the magic web in red and known gates in gold" 
at the bottom of those pages*]] },
		},
	},
	-- bookcase at 32430,31591,15
	{
		itemId = 2436,
		itemPos = { x = 32430, y = 31591, z = 15 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
The magic web around our world
Written by Heronias

For centuries we have been doing research into this magic web in our world of Tibia. And the more we try to understand how it works the more I think that we will never solve its mysteries.
But we havent give up hope yet. Maybe we will find somehow someday by chance a key element that will help us to open many doors in the magic web.
Until then we will keep on trying to solve as many riddles as we can.]] },
		},
	},
	-- bookcase at 32431,31591,15
	{
		itemId = 2436,
		itemPos = { x = 32431, y = 31591, z = 15 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
Information about the might rings
Written by Doneos

Our ancients got somehow some might rings.
The magic power of those rings is incredible.
We must be very careful while we investigate those rings.
If we release the power of the might rings without being able to control it, then this power will destroy our whole city immediatly.

But the progress goes well. Soon we will be able to control the power. And we will be then one step closer to our main goal.]] },
		},
	},
	-- bookcase at 32432,31591,15
	{
		itemId = 2437,
		itemPos = { x = 32432, y = 31591, z = 15 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The teleporter to the surface
Written by Zhandramon

Greetings brothers and sisters!

Two centuries ago, I created this teleporter so that we can do our experiments much more faster.

In the old days we had to walk all the way back out of the maze and then in again.
Now you only step in the teleporter, that is located near the resting rooms and you will be teleported on the surface.

Of course we cant risk to build a teleporter on the surface because of our enemies. So you have to walk the way back through the maze. But since you know the right way it shouldnt take very long.

Good luck!]] },
		},
	},
	-- bookcase at 32473,31614,15
	{
		itemId = 2439,
		itemPos = { x = 32473, y = 31614, z = 15 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
History of the ancients
Book 5
Written by Zhandramon

*You try to read and understand the words but it is written in an unknown strange language. Seems that this language is very very old.*]] },
		},
	},
	-- bookcase at 32473,31615,15
	{
		itemId = 2439,
		itemPos = { x = 32473, y = 31615, z = 15 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
History of the ancients
Book 4
Written by Zhandramon

*You try to read and understand the words but it is written in an unknown strange language. Seems that this language is very very old.*]] },
		},
	},
	-- bookcase at 32473,31616,15
	{
		itemId = 2439,
		itemPos = { x = 32473, y = 31616, z = 15 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
History of the ancients
Book 3
Written by Zhandramon

*You try to read and understand the words but it is written in an unknown strange language. Seems that this language is very very old.*]] },
		},
	},
	-- bookcase at 32473,31617,15
	{
		itemId = 2439,
		itemPos = { x = 32473, y = 31617, z = 15 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
History of the ancients
Book 2
Written by Zhandramon

*You try to read and understand the words but it is written in an unknown strange language. Seems that this language is very very old.*]] },
		},
	},
	-- bookcase at 32473,31618,15
	{
		itemId = 2439,
		itemPos = { x = 32473, y = 31618, z = 15 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
History of the ancients
Written by Zhandramon

*You try to read and understand the words but it is written in an unknown strange language. Seems that this language is very very old.*]] },
		},
	},
	-- bookcase at 32487,31615,15
	{
		itemId = 2439,
		itemPos = { x = 32487, y = 31615, z = 15 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Battle tactics for Demona - Mazeforces
Written by Zhandramon

*This book is......EMPTY! All sheets are blank!
But you can feel a strange energy flowing through the book.*]] },
		},
	},
	-- bookcase at 32487,31616,15
	{
		itemId = 2439,
		itemPos = { x = 32487, y = 31616, z = 15 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Battle tactics for Demona
Written by Zhandramon

*This book is......EMPTY! All sheets are blank!
But you can feel a strange energy flowing through the book.*]] },
		},
	},
	-- bookcase at 32487,31617,15
	{
		itemId = 2439,
		itemPos = { x = 32487, y = 31617, z = 15 },
		contents = {
			{ itemId = 2830, -- book
				text = [[
Maps of the maze
Written by Zhandramon

*You can see some maps of the maze. But unluckily you cant see the right way through it. Furthermore, the maps are incomplete. So it is impossible to make a whole map of the maze out of all small maps.*]] },
		},
	},
	-- bookcase at 32487,31619,15
	{
		itemId = 2440,
		itemPos = { x = 32487, y = 31619, z = 15 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
*This book is made out of an odd leather and it's covered with strange symbols. You are not able to decipher the title but according to the pictures you guess it is about summoning creatures.*]] },
		},
	},
	-- bookcase at 32578,32177,15
	{
		itemId = 2435,
		itemPos = { x = 32578, y = 32177, z = 15 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Alatar´s world of pure magic - the arcanic power.

...]] },
			{ itemId = 2821, -- book
				text = [[
How to combine your magic power with the sword?
Ten ways to use the spell "invisibility"
by Cipreii

...]] },
			{ itemId = 2821, -- book
				text = [[
How to conjure monsters that you don't need?
by Prophet

...]] },
		},
	},
	-- bookcase at 32580,32177,15
	{
		itemId = 2437,
		itemPos = { x = 32580, y = 32177, z = 15 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The riddle

Once upon a time, there have been a knight, a druid, a paladin and a sorcerer that survived the great battle upon the fields of glory. Some of them were wounded, some not. All were deadly tired. They had to escape from a hord of orcs, a whole tribe with more then 35 fighters. Late in the night, they came to a huge bridge, or at least the rest of a once mighty bridge. It was small and seemed to be not very save. The sorcerer screamed some loud and mighty words and for a second the bridge glew in a blue light.
"I see" the sorcerer said, "that this bridge will break down and fall into the water within 60 minutes. So we have to hurry up. It will only hold two of us at the same time and it is a long bridge. The wounded knight will need 25 minutes to go over the bridge, and it will take me 20. The paladin can go faster, so he will be on the other side within 10 minutes."
Pointing at the druid he said: "And you can use your spell to move faster. You will need only 5 minutes."
"Ok then, let´s go! Don´t waste time" shouted the knight and started to go. But then he stopped. "I can´t see anything. The bridge is dangerous. We will need your magic light wand to cross it. Without light we will fall down in the cold and deep water. So always someone has to return to bring back the wand of light to the others."
"What shall we do now?" asked the paladin "How can we all reach the other side before the evil orcs will get us? I have no arrow left and we can´t fight them! In which order we have to pass the bridge? Who should go first?" The druid started to grumbel: "Let me say k for knight, d for druid, s for sorcerer, p for paladin. hmmm.... and now let me thing:

dk-d-dp-

and hmmmm nonono.

Hmmmmmmmmmmmmmmmmmmm."
"Got it!" the sorcerer screamed. "Let´s run!"]] },
		},
	},
}
