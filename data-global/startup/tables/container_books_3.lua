--[[
	Bookcases, shelves and corpses holding a book or a scroll (part 3 of 4) -- 200 containers.

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

MapContainersBooks3 = {
	-- bookcase at 33199,32850,8
	{
		itemId = 2440,
		itemPos = { x = 33199, y = 32850, z = 8 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
Cursed be the Akh, for it diverts our attention to things that are but trivial and transitory! Too many fail in their quests for ascension because they give in to their akhs' temptations. If only they knew that ascension holds the key to all our grievances! Only by ascending can we redeem the akh from its mortal bounds and free the Rah and the Uthun to strive for divinity. For each mortal creature holds the key to divinity, to be a god of his own right.
Unfortunately, the so-called gods are jealous. They do not want the mortals to take what they think is rightfully theirs. It is because of this that they have instructed their followers to condemn the sacred state which they call undead. Brothers and sisters, unite! See through the deceptions of the akh! Shed your mortal shells and embrace the death-that-is-not-death! Ascend and be reborn!]] },
		},
	},
	-- bookcase at 33199,32852,8
	{
		itemId = 2438,
		itemPos = { x = 33199, y = 32852, z = 8 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Time is of no importance to the dead. To understand the concept of time is to understand the cruel trick the gods played on all mortals. Just because it pleased them to do so they stripped all living creatures of their immortality, thus turning anything they hope to achieve into futile ambition. For what is left to hope for if you know the sands of time are moving relentlessly in your hourglass, and that death will be the end of all? Whatever a mortal can hope to achieve time will take from him eventually, and all his hardships and his glorious achievements will be just a distant memory in an indifferent world.]] },
		},
	},
	-- box at 33268,31850,8
	{
		itemId = 2469,
		itemPos = { x = 33268, y = 31850, z = 8 },
		contents = {
			{ itemId = 27370, -- hastily scribbled note
				text = [=[
How to increase the potency of herbal substances - basic thoughts and notes potentiator - reagent (herbal or chemical) that enhances the efficacy of a substance potentiation - must take place at any part of the distillation process reagent - substance or compound added to a system to cause a chemical reaction Use the following reagents - [Underneath the last article, you spot two hastily drawn symbols: a crescent moon and a circle with a dot in its centre. "In powder form!" is scribbled underneath the symbols. Besides those two symbols you can read the word "Shadow Bite".]]=] },
		},
	},
	-- trunk at 33324,31941,8
	{
		itemId = 12643,
		itemPos = { x = 33324, y = 31941, z = 8 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
How To Make Trees Come Alive

(Browsing through the pages filled with strange symbols, you get a dizzying feeling that your bark should burst, your branches snap and refold, and your roots retract... you close the book with a snap.)]] },
		},
	},
	-- chest at 33369,31343,8
	{
		itemId = 2472,
		itemPos = { x = 33369, y = 31343, z = 8 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The Grand Master of Verbal Debate IX

Receiving a doubtful word of wisdom, your riposte:
"Dare strike up a Minnesang and you will receive your last accolade!"]] },
		},
	},
	-- box at 33555,31241,8
	{
		itemId = 2473,
		itemPos = { x = 33555, y = 31241, z = 8 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
... The journey has been uneventful so far and the weather is fine. Faltugios suggested to run the ship with full power but I decided it is better not to take even the slightest risk on our mission. I am still convinced that IT will not allow us that easily to continue with our plans. Admittedly, I am extremely nervous, but this is no surprise considering the circumstances. Our knowledge is a burden not easy to bear. Therefore I keep these notes, knowing I'll have to destroy them when the time has come. I'm a bit nervous but I'm also anxious to learn what we will be able to do for the best of the world. Time will tell. ... A sea serpent has attacked our ship. Could it be IT's doing? Though the serpent was quite huge, it was no match for our ship's weaponry. Still, could IT know our power? Or the strength of IT's tools? Even if IT is not working consciously against our efforts, it might be an instinctive reflex like an animal that flicks flies. If it was an effort to stop us, it would mean that IT is aware of our movements. Could it be? We still know so little about this enemy, which ironically is also our only defence and hope. Faltugios should be glad that the circle spared him of the tainted knowledge. Of course he is not and blames me for holding back information. If he only knew what a gift his ignorance is. ... Today we had to sink two Treluvian ships which attacked us. They still hold a grudge against us for not supplying them with weapons, but they really should have known better. Still, I felt uncomfortable ordering their destruction. On the other hand, knowing what I know, to bother about it is pointless. They'd be dead, one way or the other, anyway. ... It is hard to let no word slip my lips by accident. They do not have to know what I know. Actually they probably already know too much for their own good. Or the good of the world that is. I try to blend out my knowledge as good as I can. Can IT perhaps hear my thoughts about IT somehow? The thing is that we know that there is some kind of dependency. But knowing about it only makes things work. I get a headache just thinking about it or even trying not to think about it. ... With the weather that bad and several people seasick, I finally get some rest from their constant demands. ... The weather gets better and the demands and hidden accusations are already increasing again. I was not prepared for such a thing. I am accustomed to my own studies in loneliness and not to care for the needs of several spoilt and eccentric scientists. I wonder if I was a good choice for that position. But now I have no choice. ... The closer we come to the isle, the more it becomes clear what a responsibility lies on me. Sometimes when I try to sleep, I can feel it like a stone on my breast. What if the others refuse to work if they do not learn more about our agenda? What if we run into unexpected complications? What if we find out, our project is going to be a failure? What if IT knows more about us and our world than we assume? There are so many things that need to be considered. Would a good leader be as nervous as I am?]] },
			{ itemId = 2832, -- book
				text = [[
... We have finally arrived. The isle is dull and barren but this fits our plan. The members of the expedition are anxious to learn more about our mission. As ordered I will present them the version of the secret research facility for biological experiments. Of course they will see through the obvious ruse. The morale is not that good anyway, with this half-hearted excuse it will only get worse. I wonder if IT will use this to our disadvantage. IT might try to influence the behaviour of the team members and pit them against each other. We can only assume what IT has learnt about the psyche of the inhabitants of our world. But I should not allow myself to get distracted from the goal. 'If' and 'when' do not help here. Our only hope is the outcome of our mission - even though it means our annihilation. ... The lack of comfort allows tensions to grow. I have to admit, I am glad when they fight each other and leave me alone for a while. When they come to me for a decision, though, and both parties want me to decide in their favour, things become complicated. I wish we could concentrate on our research instead. If only the base were ready. ... The worker golems have finally built a rudimentary base. Our priority is research and not comfort. There is still some unrest amongst the members of the expedition. They vent their anger about the obvious lie in complaints about the lack of comfort. Sometimes they slack in their work and are far too unenthusiastic in their researches. They are like spoilt children. I know they could do better but they are sabotaging our efforts by intentional laziness. I wish I could tell them. Then again I wish I would not know. What if IT uses the dissatisfaction of a researcher to sabotage our work? What if IT's agent is working right now while I am writings this? ... Today the base was under attack. Not that this handful of sea dwellers posed a threat, but alone the fact that there was an attack at this remote isle makes me wonder if it was a coincidence or IT's work. I ordered to strengthen our defences and had some of the golems reconfigured for war purposes to boost our defence forces. That reminds me about the recent malfunctions of golems though. Although it is nothing extraordinary to have such a quota of malfunctions. I keep telling myself that such a rate is not unusual, not even in Yalahar and our golems here are working under less than optimal conditions. Yet, it might be that this subtlety is a trick of IT. Perhaps he is eroding our mission from many vantage points. All for itself might be of little interest and waved aside, but aren't that IT's fingerprints? Isn't that what we should expect from such an opponent? I will have to remain vigilant. I will register the slightest imperfections in our mission and analyse them thoroughly. I will not allow IT to triumph. ... Several members of the expedition seem suspicious to me. Faltugios is the most vocal of them of course. He was criticising me right from the start and I wonder if he is an unwilling - or perhaps even a willing - tool of IT. Yes, perhaps some of them know more than they admit. It has been always our nature to be inquisitive and sceptical. What if one of them has learnt more than he was meant to know? What if he'd become tainted by the knowledge and perhaps was seduced with lies and promises? Well, I should probably not assume too much. Such things, though not unthinkable, have never occurred before. As far as we know, IT has no allies in this world, so my speculations regarding this are probably pointless. Yet, on the other hand, the responsibility for this expedition rests on my shoulders. So shouldn't I be prepared for the worst? However, I will have to improve the discipline somehow. I will grant privileges to some of the more cooperative ones and put restrictions on those who oppose me.]] },
			{ itemId = 2832, -- book
				text = [[
... The fishmen have attacked again. This time with a significant force and quite coordinated. I can't say I'm sad that their attack had cost the lives of Dregiz and Jurkoa. They have been consorts of Faltugios from the start and were causing more trouble than their research had helped us. Yet, the attack has proven we are in danger and I have called for reinforcements. Though the fish creatures were no match for our weapons and magic, our defence is too weak and we have too few capable fighters in the expedition team. Until the reinforcements arrive, I have to apply a more strict regime in the base. I can't allow my authority to be undermined. Our project is too important. After all, it is not some fancy research but the only hope for this world to survive. At least sort of. But I should not doubt our plan. This would only play in IT's hands for sure. ... The attacks of the fishmen continue. The more we kill, the more they seem to call from the depths of the sea for their next attack. This can't be a coincidence anymore. It has to be IT's work. Nothing else makes any sense. Faltugios suggested to capture the creatures to try to communicate with them to learn their motivation. But this can't be allowed. If they do IT's bidding, they might know too much and their knowledge might taint the researchers. Also, regardless of their reasons, we cannot give in anyway. The first specimens are growing and show promise. We can't allow to be distracted. ... The reinforcements still did not arrive. Actually, they were not even sent. I wonder what is happening in Yalahar. I heard about some quarrels in the circle and civil unrest. All foreigners are put under greater surveillance and the defences are strengthened against an attack that the circle can not specify to the masses. The tension in the city is growing and I fear that we might have to wait for reinforcements for quite a while. I have to issue stricter rules for the base, even if this will alienate some of the researchers even more. I'm sure the majority will understand that it is for the greater good. ... No reinforcements and the attacks become more and more frequent. The situation is far from desperate but our efforts are hampered so much that we have almost no progress. Distractions, distractions, always distractions. I hardly get any sleep with all this responsibility lying on my shoulders. Faltugios is a constant thorn in my side. All of his actions seem to aim at undermining my position. This can no longer be seen as a coincidence considering the things I know. He must be a, probably unknowing, pawn of IT. Regardless if he knows what he is doing or not, he is a threat that has to be eliminated for the best of all. It would be best if the fishmen got him. ... Finally word arrived that a small military force will be sent to assist us. We had another casualty in the fight against the fishmen. Not to mention the golems we have lost or those who were left running only with rudimentary functions. Most of us are great in wielding magic but none of us has any prior experience in battle. Still, our equipment and magic is ridiculously overpowering those primitives. I knew we were powerful compared to other races but I did not truly understand it until I saw the hordes of fishmen perish at our meagre defences. What could we have done for our world? But our days are numbered. Our existence will come to an end and with the great cleansing we will allow the world a new beginning. This is what IT fears and this is why IT throws us these hindrances in our way. IT has minions, I am sure of that now. Faltugios is but one of them. The fishmen are others. Who knows who is working for IT?]] },
			{ itemId = 2832, -- book
				text = [[
... The military expedition has finally arrived. They brought two of the newest heavy war golems and about a dozen ordinary war golems. With them commander Traks and two scholars from the exalted college of magic arrived. This Traks seems to assume he is responsible for the base from now on but I cannot allow some clueless strongman to endanger our efforts with his ignorance. We need to get a definite decision from the circle in that matter. Given the unrest in Yalahar, it might take a while to hear from them. This might be another plot of IT to stop us, to stop ME! What if IT is aware of me, because I am aware of IT? That is the way it works, right? That is the whole idea behind the great cleansing. IT is probably aware of me and plots my demise! ... I knew it! Traks and Faltugios are becoming closer and closer every day. Although the attacks of the fishmen could be stopped and now our forces are pressing to the inland of the isle to route out the creatures, the knowledge that two of IT's pawns are operating right under my nose is an insult. I am responsible for this base. I am responsible for the experiments. I am responsible for the fate of the world! ... IT is plotting. IT's minions are stalking me. The experiments finally make progress and show some promising results concerning all those disgusting creepers, but I know that IT is observing that, too, and IT is preparing to strike. Traks and Faltugios are avoiding me. My suspicions have long become a certainty. They are traitors of the world. It is my duty to stop them before they stop us. The unrest in Yalahar is growing. I am on my own. I wonder if there are contingency plans? Am I expendable? Is my project already deemed a failure due to the whisperings of IT? I cannot allow them to succeed. It is up to me to stop them. I alone can do it, stop them. I will save the world! ... It is done! I locked up Faltugios and that stupid brute in a chamber and let some of the experimental specimens free. As expected the creatures perished, but they distracted this duo of traitors long enough to flood the room with gas. The others seem shocked by 'the accident'. If they only knew! If they only knew! But only I know it, know about IT. ... What have I done? What if I was wrong? What if Faltugios and Traks were innocent. No, no, I was right. They were in liege with IT. Certainly even knowingly. But even if not, I had no choice. I have the responsibility. Only I know! This burden. It haunts me in my dreams. I hear their cries. Could I have stopped this from happening? Pointless. I have to do what I have to do. Everything else is pointless. Only the mission is important. If the mission succeeds, we'll be dead soon anyway. If not, we'll wish we were and the two should be grateful that I spared them this fate. I haven't done anything wrong. The lives of a few does not matter. They, no we, are dead already, but only I bear the burden to know this. ... Can't sleep. Another night without sleep. At least it keeps the nightmares away. The scholars report that the fishmen seem to dwell in some caves on the isles. Though I fancy the idea to drown them in acid or something like that, it would require too much effort and resources. I hope they have been scared enough to stop their attacks. The blood toll they have paid is enormous. Yet, they did not stop. This should be prove enough that they are doing IT's work. Faltugios had some obscure theories about holy places and such. I know not much about this foolish religion stuff. We had abandoned the so-called gods for a good reason after all. I doubt, though, that they would be willing to sacrifice themselves for some imagined hex or charm. No, there must have been some power that forced them to die for IT. This is prove that IT's grasp on the world is growing and we have to stop IT.]] },
			{ itemId = 2832, -- book
				text = [[
... It seems, the attacks of the fishmen have finally ceased. The blood toll has only to be high enough, so that even those primitives notice that they are no match for the power of the Yalahari. Enlightenment due to pain and suffering. I feel a bit sad that I have not learnt about these aspects earlier. Perhaps I could have convinced the circle to change their approach to spread enlightenment. There is so much I could have taught the world! ... As the book of Dgjuna teaches us, I have put my new insights into good use. I use the war golems and some fishmen we have captured from the caves to improve our experiments. The idea is as simple as brilliant. The newly bred creatures are pitted against the fishmen or the war golems. If they fail, they are killed and fed to the other experiments. If they show at least some success, we try to improve them further. I will outsmart IT! My weapon will break IT's grasp on this world. I will send IT tumbling back into the abyss it came from. I will teach IT fear. Yet - am I truly safe? What if there are other conspirators around? The scholars could be some of them. They ask curious questions about the death of Traks. IT is probably whispering to them. IT tries to use them against me. ... The scholars behave more and more suspicious. Sometimes I see them watching me. I know they talk about me. Of course I could be wrong. But why take the risk? They will die anyway as we all will. Why not getting rid of them? The project - it is more important than them. Their need is expended. I will take care that nothing stops me from rescuing the world. ... Faltugios is alive!!! He sneaked into my room while I was sleeping and whispered something into my ears. I can't recall what. When I switched on the light, he was gone. Perhaps IT has saved him and granted him ghostly powers. Or was it his ghost? Has IT turned him into a ghost? I am so shaken, so tired. I don't understand. We have some apparatus that should prove effective against ghosts. Tomorrow, I will set some of them up. ... The others are eyeing me suspiciously. I know I look tired and act nervously but perhaps they know what I have done. Perhaps the ghost of Faltugios talked to them. Or he is truly alive. I have activated some ghost traps but with no success. Still, I am sure I can see him sometimes just vanishing when I focus my sight on him. But regardless of these attacks on my resolve, we make some progress. We established six stable species of the creepers. Now we can begin to add the suitable traits to them as planned. Later we will breed those species together to a single new race. My creatures will become our final weapon. ... I shouldn't have done this. Or I should have left as ... I don't know. Now I'm in it and can't get out. It is up to me to finish this experiment. Yalahar is in uproar. I think the knowledge is spreading somehow, making things only worse. I have spoken to Tjule of the circle and he claimed to have no knowledge at all about my mission. What is happening here? Is it not the will of the circle what we are doing here but the work of a splinter group? Whatever! The plan is right. It is our only hope. It doesn't matter who came up with the plan. The crawler army is the only way to stop IT once and for all.]] },
			{ itemId = 2832, -- book
				text = [[
... The creatures are growing stronger and stronger. Finally we see some success. Still, we are far from a breakthrough. To achieve our goal, the crawlers have to become unstoppable. Though we breed them to sustain themselves with almost any matter available and gave them a reproduction rate that pales those of any known crawlers, the rate of reproduction will not be sufficient to endure the final battle. And though they are more resilient and stronger as it should be physically possible, they are still not the ultimate tool they were meant to be. It will require some hard work and effort to improve them further. If I could only concentrate better. But they are haunting me. It is not only him but also others. Or is it him taking other forms? Some faces of my past, some faces I don't even know. I see them in the corners of my eye, only to vanish when I look at them. ... They are after me. The ghosts and the others. I sent the scholars into the fish caves again and again but they do not die. They even brought me a living fishman as I requested. Now I have this creature here in my laboratory and it seems, it is eyeing me, too. Does it know it is only the pawn of a power it can't nor shouldn't comprehend? But strangely enough, his presence seems to keep the ghosts away. Or does it only distract me from the ghosts? Could it be that it was only my imagination that played tricks on me? No, I am too tired for these “ifs” and “whens”. I have to stay focused on my tasks. The breeding goes fine, yet, the creatures lack the desired abilities. We have set some of them free on the isle to see how they can cope with the environment. ... Our creatures do quite well in the wilderness. Some of the researchers suggested to breed some additional traits into the creatures. At least I think they did. It is hard for me to concentrate these days. All the stress, the strain, never some peace, no solace. I am talking to the fish-thing in the cage quite often as if it could understand me. It curiously watches me while I am experimenting with the magic of the chrimaerogizer. I find it amusing how the thing sometimes mimics my gestures and even moves it's lips as if it could speak. Or should I rate this as creepy? The thing that does not understand me has become my only confidant. When I am amongst others, I usually lose track of what they are telling me and I start to see things. Faces, people, suspicious shadows. It has to be my tiredness. It must be. There are no ghosts that could have escaped my traps. I must try to sleep more. ... The situation in Yalahar seems chaotic. I can't talk to any of the higher ranking members of the circle or the Jagadah. The only ones I can reach are clueless foreign henchmen. It seems they recruited a lot of them since we have left. The others want to leave and look after their families and friends. The scholars are heavy supporters of this idea. Why can't they just die? As if there weren't enough trouble and problems already. We are so close to another breakthrough. Just recently one of the researchers bred an astonishing new ability into the crawlers. Before, they were able to produce certain organic material. Now he added a trait that allows special workers to melt with the material and give it some living and perhaps sentient abilities. But if we stopped here and now, everything would be lost. The perfect tool for the plan is so close. I cannot allow IT to triumph. IT tries to beat me and to stop the project. I know it all too well, I am IT's foremost enemy in the world. It is a battle between us. Between my resolve and IT's hunger.]] },
			{ itemId = 2832, -- book
				text = [[
... The unrest is growing. Now that I can see possible progress at all fronts, they want to abandon me? The traitorous scum is doing IT's will without knowing it. Or do they know? I need time. I need to forge the crawlers into the weapons that we need. They will have to purge the world. Without anything that could know about IT, IT will lose its grasp on the world and the world will be free of IT's influence once and for all. It was our fault to have lured IT here and it will be our glory to defeat IT! Sacrifice is necessary, that is how the world works. Sacrifice. I will have to stop them from leaving, somehow. Yes, this is my task. ... What have I done? The sabotage of the ship went horribly wrong. Instead of not working at all, the ship left the isle. I was desperate when I found out that my tinkering with the engine had not worked as planned, but I was horrified as the ship exploded shortly after it left. There were no survivors. But I had no choice. They forced me to do it. It was their fault, not mine. It is IT's fault. I will have my revenge. I will avenge those who died today! I will continue with the experiments. ... Only two others decided to stay here with me to continue the experiments. But I think they are suspicious now after the accident. I will have to be very careful. The ghosts have returned in the night, now joined by those who died on the ship. They are accusing me, mocking me. I must continue, though. I must succeed or everything was in vain. ... The experiments with the creatures have become more random, less planned. The others stick to the original plans, but with the lack of resources, I have to take chances. Perhaps we will randomly get an advance that would have cost us years of planed breeding. Experiments we see as failures are released into the wilderness. Hopefully this will keep the fishmen away. ... We are short of food. I will have to rely on eating dead experiments. ... Rehus was attacked and killed by one of his experiments today. My only concern upon learning this was that he might join the ghosts that haunt me. The captured fishmen seems to be mocking me, too. I know what he is thinking. He thinks that my experiments will fail, that I have been unsuitable to lead such an expedition at all. He seems motionless and untouched when I yell at him, but I know he is snickering when I leave. ... Failure after failure. ... No one here to take care of the machines. No one here. ... Tired. So tired. No idea what Hiona is doing. We rarely speak. I wish she had left with the others. No word from Yalahar. The others. They are dead, aren't they? Something with the ship.]] },
			{ itemId = 2832, -- book
				text = [[
... Breeding new queens. ... Today the last worker golem stopped to function. Things are complicated. ... Hiona is gone. No idea when I last saw her. Was it yesterday? Has it been a week ago? A month? The fish-thing is gone, too. Its prison must have been cracked as I threw things at him in a fit of rage. Now I am alone? No, I have been alone since the beginning. The fate of the world upon my shoulders. A silent war between IT and me. ... When something happens to Yalahar, then I am the only creature with an intellect worth to mention that is left on this world. ... So alone. Only the ghosts to torment me. My crawlers are with me. Mindless as machines but they are mine. A great destiny awaits them. ... Why did everyone leave me alone? ... They have to kill everything. That is the plan. Still they are so weak. Nothing should be able to stop them though. ... So little time left. ... I feel weak, sick, old. I hope Faltugios or Ramiar take care of the labs for a while. ... Hungry. Where are the others? They left me? It's so hard to remember. So hard to concentrate. ... I am the creator of a new race. Does this make me a god? ... The others are dead I think. ... I create life and fight an evil entity for the fate of the world. I am the only sentient being on this world. ... I am alone and the guardian of the world. I am a god. A god does not have to explain his actions. A god knows no guilt. I know what's best. Yes, that's good. ... So many crawlers on the loose. They attacked me. Me, their creator! I will strike them down with my godly wrath and the chorus of ghosts that accompanies me will sing a hymn of my vengeance! All will die. I will cleanse this rotten world and create a new one! ... I am dying. They wounded me. But this is fine. When they can kill a god, they are strong enough. In the end I succeeded. But will the world not end when I die? I am the creator, the centre. Time will tell.]] },
		},
	},
	-- bookcase at 32335,32259,9
	{
		itemId = 2435,
		itemPos = { x = 32335, y = 32259, z = 9 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
Nictros and Baeloc Blackwood were the greatest knights of their time. Even in their youth, their exploits have been impressive. The siblings were motivated by their competition towards each other. Whatever one of them achieved, the other tried to outdo. They excelled in the athletic arts and it is said that they surpassed their combat instructors constantly soon after they were replaced by more competent ones. They achieved knighthood in an early age and joined the army in numerous campaigns against the orcs and fought valiantly in the outlaw wars. As times of peace didn't suit them well, they went on daring quests and pitted themselves against some of the most fearsome monsters of the land. They killed the two-sided hydra, the three headed dragon of Cormaya, the ancient vampire of Senja and the abominable beast of Guddenwood. On tourneys they were only bested by each other, with either brother claiming similarly frequent victories. Legend has it that their excellence lead to a great deal of vanity with a hint of cruelty. Though they acquired many admirers, they rarely made friends. Their casual cruelty and insulting arrogance caused wounds and created trenches over the years. But the brothers did not care. It seemed they needed only each other and despised the company or even presence of strangers. According to the laws of those days they had a certain leeway how to handle the affairs of their estates and legend tells that they were cruel masters whose subjects often were left dead or maimed for the slightest failures. The treatment of their subjects lead to many wanting to flee their lands to which the bothers responded with a peculiar death penalty for anyone caught in the act. They did not outright kill them, but made them target of a hunt in which they were chased down without having a true chance to escape. Over the years the number of their enemies and contenders swell. One day when they were on their way home from a victory feast, still halve drunk and spent from their previous battle, they were waylaid by a coalition of their enemies and their forces. Although the brothers fought even long after their whole retinue had been slaughtered, eventually weariness took its toll and one of the brothers slipped on the floor that had long turned into bloody mud. Immediately his opponents were upon him and took his life. The other brother went into a frenzy, fighting like a madman. It is said, he might even have won the battle against all odds had he not in the end allowed his dying foes to stab him, for he lost his reason to live.]] },
			{ itemId = 2826, -- book
				text = [[
The Shiron'Fal is an organization that seems to predate the dawn of mankind. A time of constant strife and warfare gave birth to a fledgling organisation of dishevelled but powerful individuals. The original purpose of this pact was probably as mundane as pooling resources for survival but it soon became something more meaningful and sinister. The first members seem to have been some of the last remnants of their race that perished in the god wars. Each of them brought a unique set of skills and talents that quickly added up in power. With the imminent danger of annihilation averted, the group soon consolidated it's power and reasserted their goals. They were probably genuinely surprised by the success their alliance has had and began to hunger for more. Inspired by the synergy their diversity created, they began to look for individuals of power that could provide something beneficial to the group. Over the centuries the scope of their ambitions broadened. They began not only to acquire new members but also powerful artifacts and minions. All the while they operated in the shadows. Making their hidden moves, manipulating people and events, taking whatever they needed to increase their power. Their agents travelled the world in many forms and disguises, looking for relics and recruits. If a target was identified, a powerful member of the Shiron'Fal made its move with deadly efficiency. What could not be taken by guile was taken by force. For the most parts of history, though, the organisation seemed more like a sleeping giant. Waking up now and then, making some devastating moves, only to vanish into obscurity once again. During the last centuries the actions of the pact have become more consistent and frequent. Why there was this increase in activity is yet to be determined. What can be said, however, is that their process of recruitment has been broadened and now also aims at the most powerful specimens of certain races or supernatural beings. Sometimes the organisation has plotted to pit such individuals against perilous odds to determine their worth.
In the most recent history they can be made responsible for events like the discovery of several powerful vampires and the rise of werekin activity on Feyrist. A more personal action of the legion was the presence of one of their members in Rathelton, seeking for an object of power and the attempt to subvert the elven courts of summer and winter to free and recruit or enslave the nightmare beast that was bound by them.
The ancient term Shiron'Fal roughly translates in something along the lines of "dread legion" or "army of the last days". More literal the words translate into "numerous, military organisation" and vaguely describe a special time of reckoning. This might give a hint of their ultimate purpose. Some assume all their efforts are aimed at a final battle for all of creation. Others think it rather hints at the ultimate goal to conquer or destroy everything as soon as they accumulated enough power. Some even claim a renewal of the god wars is their ultimate goal.
Yet most about the Shiron'Fal is shrouded in mystery. Even the most basic information like a base of operation, the number of members or even the names from more than a few of them are unknown. Not even the structure of organisation is apparent, although there are strong hints that an enigmatic single entity is in lead of the legion.]] },
		},
	},
	-- bookcase at 32335,32263,9
	{
		itemId = 2438,
		itemPos = { x = 32335, y = 32263, z = 9 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The family line of the Antarel family was tainted with orcish blood since generations. A shameful secret hidden from the public. Though thought to have thinned out enough to no longer pose a threat, this assumption was disproven by the birth of Marik. Born with obviously orcish features he was hidden away and declared a miscarriage. While he was raised by an elderly couple in service of the baron as their own, three years later a brother, Gisbar, was born by the barons wife, who was declared the official heir. The baron, perhaps out of a feeling of guilt, chose young Marik to be raised as one of his squires. Marik proved extremely skilled in the art of battle. Growing almost disturbingly fast in size and strength, with 14 years he could go toe to toe with the best of the barons knights. Yet due to his heritage knighthood remained beyond his grasp. After the baron died by a riding accident when Marik was 17 years old, he became the squire of his younger brother, without either of them knowing about their relationship. Albeit Marik was known for his fits of rage and shunned by others for his brutish looks, the two became good friends and were nigh inseparable. While Marik fell in love to the fair maid Marisha it was his brother who would court and marry her in the end. When Gisbar officially became the baron, he ignored the traditions and knighted his friend and squire. This didn't suit the other knights and nobles well and what has been hidden mockery in the past became open provocation of Marik. The hot headed Marik duelled three of the nobles, maiming them badly, until baron Gisbar had to order him to stop this behaviour. Not much later though, the anger over insults overwhelmed Marik again, and this time he slew his opponent without any declaration of a duel. Gisbar had to judge over this case and in an effort to save his friend and former squire, he settled to banish Marik from the realm. Marik lived a while as a mercenary in foreign lands, always longing for the place he once called home. When he learned that his 'father' was in his death bed and Gisbar and Marisha were expecting their first child, he decided to return home in disguise. His dying father confessed to Marik the circumstances of his birth and heritage. Marik was devastated on many levels. Without any idea how to react or what to do, he attended the feast for the barons new-born in disguise. Wine and beer were served freely and like everyone else in the feast ccc became drunk. When the jesters and musicians entertained the crowd, one particular ugly and disfigured jester caught the attention of the equally drunk Marisha. She pointed at the poor creature and yelled that he almost looked as ugly as that oaf Marik. The whole drunken crowd joined her in laughter. This was when Marik drew his weapon. With fury and madness he slaughtered not only his brother and his wife but the whole entourage. With the help of his mercenary comrades he held the barony for a few months, even petitioning the king with his plight. In the end though an army was sent to bring him to justice. Before they arrived, ccc took his own life and the mercenaries took him with them to give him a proper burial.]] },
			{ itemId = 2825, -- book
				text = [[
Baron Eserak was the spiritual leader of a knightly order, devoted to the service of the gods. As a gathering of philosophical and pious men and women, the order often met in debates on spiritual matters. Often such debates lead to heated argument because most members were extremely set in their opinions and points of view in religious matters. Over the time two fractions arose that at least vaguely agreed on crucial points to which the other faction strongly disagreed. Heated debates led to violent arguments and over the time this bred an atmosphere of hatred. When Eserak learned that the opposing faction secretly planned to split he saw his grand plan in danger. He gathered his most loyal and devoted members and lead them in a violent purge of the dissenters. The once wise and serene man had become infuriated about what he saw as the ultimate betrayal and he was not willing to show any mercy. But even after the purge of the order he would not find his peace. The shock of the defection by so many of his former brethren and sisters left him paranoiac. Seeing traitors everywhere he lead several more purges and was driven so far as to burn several of his loyal friends on the base of dubious suspicions. Listening to false advisors his harsh actions lead to the loss of many members, either because they were killed as heretics or because they left the order in disgust. Since the knights of the order hailed from some of the most powerful families of the realm, the schism spilled over into a civil war. The weakened order and their supporters were greatly outnumbered and to restore peace even the crown sided with its enemies. Unwilling to be brought to an - in his eyes heretic - trial, he took his own live before he could be arrested.]] },
		},
	},
	-- bookcase at 32335,32264,9
	{
		itemId = 2440,
		itemPos = { x = 32335, y = 32264, z = 9 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Vlarkorth was a wandering hero even in his youth. Heroic quests lead him all over the world and perhaps even beyond. Sometimes in his travels, while he already was a well-known and established knight, he acquired the secret of eternal youth. It is said that it was granted to him as a wish by fairies whom he had helped. Some whisper he had to sacrifice his own heart to acquire this gift. At least all sources agree that he was a changed man in his later live. While friends of old one by one retired and died, loved ones came and went, he grew more and more bitter and jaded. While he perfected his knightly arts more and more over the decades that passed, his views on knightly virtues became cynical at best. He sought out more and more perilous challenges, as they say out of a death wish. Regardless what fighter or menace he challenged, he went out victorious. He begun to let the more promising opponents live, albeit scarred and disfigured by his hand. It was assumed that this was his way to groom new challengers, to endanger his own live to at least sometimes feel some form of thrill. He antagonized the mighty and had only spite for the just and religious. Yet no challenger could match his skills. He fathered many children over the years and raised them with an iron fist, putting them through rigorous trainings and humiliation. That way he was fostering new generations of opponents that might be worthy one day to give him a challenge at last. At last it was his halve-elven daughter that would be his downfall. While she was a promising fighter he mistreated her like he always did with his children. When she dared to question his attitude once he had her mouth stitched shut. When he held a dashing young adventurer captive in his hold, she rescued him and the two fled. Vlarkorth followed them dispassionately. The hunt was just a mild thrill for him but better than nothing. So he chased them from one end of the world to another. Over the course of their adventures the fleeing pair made new friends and gathered a party of merry men and women. Sometimes Vlarkorth caught up but his prey eluded him in the end, albeit not without casualties. At some point the couple decided they could not run any longer. Alongside their allies they made a last stand and faced the heartless Vlarkorth. In a fierce battle one by one of their companions were wounded or killed. In the end only the halve-even maid and her lover stood against the barely wounded Vlarkorth. It was apparent that they both were no match for the ancient knight. As he was about to kill his daughter, the adventurer impaled himself on Vlarkorth 's weapon and weightened it down. The women, using her refined reflexes to honour his sacrifice, dispatched her ruthless father with a swift blow once and for all. Vlarkorth was buried in shame at a remote place.]] },
			{ itemId = 2816, -- book
				text = [[
The first of the legion of slaughter were some of the unique creations of the gods. For not only races were created in the god wars but also individuals of power. Though most of these loners followed the path that the gods had planned for them, some lacking restraint and company became driven made by their loneliness. Crazed they defied the gods and banded together, accumulating an army of the mad and the lost. This army they lead onto a rampage through the battlefields of their days. They caused havoc and destruction on both sides but ultimately they were crushed and thought dead. But some of them survived, hidden at unholy places and feeding on them. In time they grew in power and when they arose again they were horrible to behold. Their rise fell into a time of relative peace, after the reawakening and those relics of war disdained what they saw. Where others saw harmony they saw weakness. Where others saw love, they saw a lack of ambition. They renewed their old bonds and looked for fallen allies of days long past. They reformed the legion, which was a mockery of the power of the past. Yet their madness, hatred and ambition drove them forward. They began to look for the guidable, the power-hungry and baited them with poisoned promises. They are still out there, scheming, manipulating, looking to increase their power in clear defiance of all gods.]] },
		},
	},
	-- bookcase at 32336,32259,9
	{
		itemId = 2436,
		itemPos = { x = 32336, y = 32259, z = 9 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
The songs of Azaram were numerous and several of them lived on to be still sung in our days. His chivalrous exploits were the base of many modern fairy tales and three of the lections of the art of fighting still bear his name. All the more his fall from grace was more than tragic. It's a bitter and sad tale, recounted numerous times in different ways. Most of this tale still romanticise what has happened. Historical records thankfully give us a more precise picture. In one of his chivalric journeys he met a damsel of incredible beauty. Yet she was engaged to another, much older knight for political reasons. What exactly transpired is still disputed. Though the historical texts give us some plain fact. It cannot be ruled out that his love was indeed the result of a curse of a swamp witch coven. Azaram had certainly participated in several witch-hunts, albeit not in a more active way then his compatriots. It is still possible that he, as a prominent figure was chosen for a curse, to have a greater impact. Also it can't be ruled out, that the damsel in question had a more active and sinister role in the things that transpired. Though the stage play 'The poisoned love of noble Azaram' depicts her as an evil schemer there is little factual evidence to support that claim. Indeed though, she took an unusual road for her travel to her fiance and certainly not in a time that was suited to traveling. But the assumption she orchestrated the attack on her company and the timely rescue by Azaram seems a bit farfetched. For sure it's recorded that he accompanied her on her way from there on. What transpired on their trip together no historian can tell. When they arrived at the home of her fiance, Azaram stayed as honoured guest. When the wedding drew near he was more and more often found in a drunken stupor and susceptible to fits of rage. In the evening before the wedding, the groom took offence of his behaviour and scolded Azaram, reminding him of the knightly virtues. This lead to an outburst of Azaram in which he drew his weapon and swiftly slew his offender. Sobered up by the shock of his own action, he grabbed the maid and forced their way out of the castle, leaving several men at arms dead. The nightly chase lead them to the swamp. Perhaps he wasn't aware where he was riding or perhaps he hoped to lose the pursuers in the marsh under cover of darkness. When the hunters arrived they only saw a gnarled, armoured fist raising from the swamp. when they managed to retrieve the body, OOO was dead. The maid was nowhere to be found, supposedly resting in the swamp for eternity.]] },
		},
	},
	-- bookcase at 32337,32259,9
	{
		itemId = 2436,
		itemPos = { x = 32337, y = 32259, z = 9 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The assumption that the organisation Shiron'Fal had a hand in the exposure and ultimately destruction of two members of the triangle of terror seems rather unlikely. The effective elimination of the cabal had only strengthened the ruthless seven. There is no clue why they should assist a probably rivalling faction. It is by far more likely, that said exposure was orchestrated by the seven or by their last remaining member Zoralurk. It seems proven, however, that 'someone' had been acquiring assets that formerly belonged to the fallen demons. Though here also Zoralurk and one or more of the seven are likely suspects, it is still entirely possible but unlikely, that another party - namely the Shiron'Fal - was involved. Who ultimately managed to acquire an advantage in this matter is entirely unknown, though.]] },
			{ itemId = 2828, -- book
				text = [[
The Shiron'Fal is as old as creation itself. When the first creatures came to be, some of them immediately understood the ultimate paradigm of survival of the fittest. Only the strong shall survive and harvest the resources whereas the weak have to be culled and destroyed. This is the core philosophy of the order. The first practitioners met in combat and acknowledged the strength of each other. They formed mutual bonds over their philosophy and banded together to further their course in unison. They did not participate in the god wars on either side but challenged the champions to bring them into their fold when worthy or crush them when not. Over the centuries it was them who cut away the weaknesses that were hindering progress. They rewarded the strong and taught them their ways. They punished the weak and sent them into oblivion. Only through their actions the civilisations evolved into something stronger and better. Some gods on both sides saw the greatness of their purpose and secretly furthered their course. Mankind is still in the process of being reviewed by the Shiron'Fall. If we are unworthy we will be wiped out and forgotten for the greater good.]] },
			{ itemId = 2820, -- sheet of paper
				text = [[
Shiron'Fal
Ancient organisation.
Several powerful individuals as members.
Unknown leader.
Unknown number and strength of members.
Unknown number and strength of minions.
Unknown base of operations.
Unknown agenda.
Status: dangerous and hostile.]] },
		},
	},
	-- bookcase at 32337,32263,9
	{
		itemId = 2435,
		itemPos = { x = 32337, y = 32263, z = 9 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Sir Necaran was a scientist first and a knight only second. He has always been fascinated by animals like snakes, spiders and even the fabled basilisks. So over the course of his studies he became a master of poisons. He developed the philosophy that only the weak would succumb to the power of the poison while the strong would not only survive but eventually become stronger by the ordeal. To overcome weakness one had to overcome the various poisons. Therefore he applied all kinds of poisons to himself, to become immune to them over the cause of time. Several of the poisons though induced hallucinations and emotional instabilities. Some of the poisons even had an addictive potential. Oblivious to such dangers Sir Necaran continued his Quest. He acquired the poisons of some of the most deadly beasts of the known world and despite setbacks he seemingly overcame them all. He even begun to see the hallucinations as divine signs that he tried to interpret in his feverish mind. More and more he turned to the poisons that granted him the most intense vision. In one of these poison induced trips, however, he went on a rampage. Seeing demonic monsters everywhere, he slew several of his unsuspecting friends on a minor slight. After the poisons effect waned away he recognized in horror what he had done. He fled civilisation to live in the remote wilderness. But the longing for more visions and stronger poisons endured. With a makeshift laboratory he begun to extract poisons again. Ultimately little of the man that he once had been remained and he completely succumbed to his addiction. The forest that he lived in became feared for the mad man that haunted it. No sane person travelled there anymore without dire need and in the villages around the forest wanderers were warned and children were scared with the man of the forest. Now and then a lost wanderer made his way into the forest. It's said that it was as likely to be met with hospitality and aid as to meet ones end at the hands of a ravening berserker. Over time the person of Sir Necaran slipped into obscurity and only the legend remained. After several years though members of Necarans former order searched the woods, not even sure what they were expecting to find or certain how to handle this situation. They only to find his corpse in a cave that he seemingly had called home for the last years. It is said the body was in a bad shape and the knights were unable or unwilling to learn the cause of his death. It was brought home for a proper funeral.]] },
			{ itemId = 2816, -- book
				text = [[
Magnor Mournbringer was more a mystic and philosopher than a knight. It is said he was forced into knighthood by his father, albeit himself aspiring to become a sorcerer. He was more a man of the books than of the sword, more often found in the study then on a jousting field. He was permanently banished from tournaments for the usage of alchemical concoctions. Still obligated to fight in battles on behalf of his king he relied more on sorcery then on his physical prowess. He enchanted and inscribed first his armour and weapons, later even his own body. He enhanced his skill and fortitude through powerful potions and brought his enemies down with runes and spells. The other knights shunned him but the 'witch-knight', as they called him, had his uses for the king. Giving little for chivalrous staples and being very pragmatic, the witch-knight was the one that the king called upon, when a dirty deed had to be done, something sinister to be accomplished. As times were dark and dire, the call for his skill was frequent. His fame and notoriety grew. On the height of his might and favour of the king he was nigh untouchable, reigning freely in his realm. Dubious visitors from all corners of the world frequented him. Rumours grew even more then his legend. When his patron, the king surprisingly died and not his sickly child was crowned but his pious cousin was made regent of the realm, his enemies made their complaints heard loudly. Soon the inquisition investigated in the case and it came to a direct confrontation when they tried to size Magnor's vast library for examination. Blows were traded and in the end the keep of Magnor was besieged by the regents army. With no other way to escape, the witch-knight summoned winged demons to carry him into safety. But the priests, accompanying the army, banished the creatures and Magnor fell to his death. When the regency ended and the king's son became ruler, Magnors honor was reinstated to some extent in memory of the dead king that cherished him. So he was given a proper funeral.]] },
		},
	},
	-- bookcase at 32338,32259,9
	{
		itemId = 2436,
		itemPos = { x = 32338, y = 32259, z = 9 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The red knight was born into the ancient noble house of Gorlar. Though never numerous, the Gorlar were always in a position of privilege and power. Unbeknownst to the rest of the world though, house Gorlar was still ruled by its founder Count Boras Gorlar, who was a powerful vampire. Under his iron rule the mortal Gorlars made their political moves and decisions. The mortals of the family were his mere puppets, allowed to live and serve as he deemed it fit. Now and then he would 'cull' the herd of his family by claiming the life and blood of a descendant he was as unfit or just useless for his plans. He kept the number of the family members small to better keep them in check. Generations of Gorlars provided him with victims amongst their serfs. Although Boras sometimes promised to raise a worthy descendant as a vampire, he never felt like allowing anyone else this amount of power. The red knight was like other of his family shrewd and ambitious. But his skill and cunning impressed even the old Boras. The red knight not only fulfilled the requests of his ancestor, he often improved the plans on his own and met even more spectacular success than expected. Though Boras tried to tempt the red knight with promises of immortality the latter was well aware that this would never come to pass. So he secretly sent his spies to find him another vampire, to acquire the vampire power on his own. What he found, however, was an old alchemist who was well versed in the lore of vampires. With his potions, ointments and toxins he planned a coup to overthrow and capture his ancestor. On the longest day of the year, when vampires are at their weakest, he and his men overpowered the vampire and bound him in chains. With exotic ingredients, the blood of the ancient vampire and the blood of many innocent victims they distilled an elixir that would grant them longlivety. Over the decades the need for more and more frequent applications of the elixir became necessary and more and more people lost their lives over this unholy quest. In the end the alchemist succumbed to old age and the red knight became more desperate. In a finally gambit he drained Boras of all of his blood and tried to become a vampire on his own by dark and unholy rites. The rites failed him though and with the last source of the elixir gone he shrivelled and aged within an hour after the new dawn.]] },
		},
	},
	-- bookcase at 32338,32261,9
	{
		itemId = 2435,
		itemPos = { x = 32338, y = 32261, z = 9 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Duke Krule was born into a zealous family of thaian nobility. His oppressive and pious upbringing suited him well and from early age he joined an order of knights, dedicated to erase anything they deemed heretic. It was not much a choice of heart but the only sanctioned opportunity to escape the control of his overbearing father. The knights run several campaigns against the orcs and minotaurs mostly. Picking easy targets they were met with little resistance and the already very loose organisation of the order begun to dissipate more and more with the members often following their own petty agendas. Krule lead several raids against renegade orcs and later human bandits. His claiming of the loot did not suit the victims of the robbers well so as an empty gesture towards them, Krule disposed captured criminals in a rather gruesome fashion, claiming his campaigns were rather aimed at discouraging other criminals, then reclaiming stolen goods. With a growing strength and order in the kingdom, his targets became less and less and so he begun campaigns far from the borders to strike any easy target that seemed suitable. Under the pretence of doing the god's work, he begun to plunder ancient ritual sites and burial grounds of what he deemed heathens. Over time he and his war band had degraded into little more than bandits and grave robbers. Although operating far from the realm and not facing imminent threats, his acts of cruelty continued. It's not known if these vile acts lead to some shaman to curse him or if he was cursed in some ancient tomb which treasures he stole. But it's safe to say that his later years were spent in campaigns of slaughter and fire to acquire the means to end at least some form of curse. The nature of the curse could never truly be determined as he and all who accompanied him were slaughtered by an orcish warlord and his army in an ambush. Some brethren of his order later reclaimed his remains and despite his deeds and reputation gave him a proper burial.]] },
			{ itemId = 635, -- parchment
				text = [[
A page of Goshnars manifest:
As shown, in theory there are many ways to imbue a dead creature with immense power (see chapters 22 to 24). When one combines sorcerous and spiritual means the result should be extraordinary. The idea here is, that you can use sorcery to turn a suitable being into a lich-like being under your control (see lich-thralls, chapter 15). If such a creature is already imbued with some kind of spirituality (that is: in the process of ascending, as shown in chapter 7) both powers would add up. While this is a neat little parlour trick, it's more for prestige then for power, since the subject, though formidable, won't be able to access its spiritual potential at all. Here is the catch, however. Due to the law of transcended identity, several such creatures could be used to focus their powers into a higher, slightly more spiritually potent being of the same kind. In layman's terms you could say, you bundle their power into one recipient. If this bundled power reaches a certain threshold, the metaphysical adaption actually burns a new spiritual power level into the recipient. We have seen such acts in which mass sacrifices of fanatic cult followers helped certain leaders to ascend to some degree. For the purposes of necromancy it means we could easily bundle the power of several lesser undead into one of greater power. Now this comes with several problems though. Raw power isn't transferred well. It simply overrides former power levels. So while you could create one decent zombie by sacrificing a hoard of zombies, it would still be a zombie, fragile and weak. The sorcerous levels at least somewhat add up. So if you create several lich-thralls (see chapter 15) you can combine them into one with more sorcerous power than the individuals have. Now the spirituality comes into play. The spiritual level is in reality a level of ascension (see chapter 7). The problem is, normal ascension is bound to the soul rather than to the body. Since we have created lich-thralls, we have no real souls at our disposal but are dealing with false-souls (see chapter 13). They lack any level of spirituality at all. Yet there is a way the ascension is residual in a dead body, when said person was immensely revered or feared in life. This non-native ascension isn't inherent to the soul but to the person of the recipient, in this case the bodily remains. So a person that was revered in life has some remainder of ascension left in the body. If it was famous and well-remembered the energy lingers on for longer. This leads to the possibility of creating lich-thralls based on heroes of legend. While a single one would have only the powers as to be expected from such a creature, you can now combine them into another, greater hero (a transfer to a lesser level of ascension would simply not work). With the fusion of spirituality in this creature, a new level of ascension would be created. Mind you, it's not a true ascension and although there is an immense increase in personal power, it's actually just tricking some laws of nature. A true and ultimate ascension is not possible by such means. But for the purpose of a potentially immensely powerful thrall, this is ideal of course. However you will need quite a lot of such semi ascended heroes. Experiments showed that the critical mass for the ascension fusion is rather high. Too many sources, however, create an incompatibility loop, that usually destroys all subjects involved. So you have to aim at a decent number of properly powerfully imbued individuals. Even with great heroes you need at least four sources and things start to go awry at about 12 individual sources. The sweet spot seems to be using 7 subjects. That lowers the possibility of the fusion and introduces negative effects due to incompatilities.]] },
			{ itemId = 2816, -- book
				text = [[
The assumption that the organisation Shiron'Fal had a hand in the exposure and ultimately destruction of two members of the triangle of terror seems rather unlikely. The effective elimination of the cabal had only strengthened the ruthless seven. There is no clue why they should assist a probably rivalling faction. It is by far more likely, that said exposure was orchestrated by the seven or by their last remaining member Zoralurk. It seems proven, however, that 'someone' had been acquiring assets that formerly belonged to the fallen demons. Though here also Zoralurk and one or more of the seven are likely suspects, it is still entirely possible but unlikely, that another party - namely the Shiron'Fal - was involved. Who ultimately managed to acquire an advantage in this matter is entirely unknown, though.]] },
		},
	},
	-- bookcase at 32339,32259,9
	{
		itemId = 2437,
		itemPos = { x = 32339, y = 32259, z = 9 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Ilos was a dashing hero and a ladies man. His exploits and adventures inspired many bards even during his lifetime. No beast was too fierce, no demon too intimidating for Ilos to avoid them. He became a living legend and paragon of all that was considered knightly. In one of his adventures he and his friends cleansed a crypt of a long extinct race from its evil. The deeper they went, the more unnatural and twisted their enemies became. Level after level was cleansed by the fighters and priests yet the catacombs seemed to stretch on an on into the darkest depths of the world. The deeper they went, the more the rune-engraved walls began to shift and whisper as if they had a live on their own. One by one, the party became separated and lost. Only for Ilos the way seemed to open as if something or someone was guiding him to a special place deep within. Determined but confused by constant whispers in unknown languages Ilos continued. It did not even occur to him that he was all on his own by that point. So strong was his urge to move on, to face and overcome the darkness that had taken refuge there. After a journey that might have lasted hours or days he arrived at a huge chamber whose geometry mocked the laws of nature. It was barren but for a single colossal throne in its centre. On this throne of greyish stone sat a regal but horrible figure of nonhuman origin. The mummified thing had multiple arms and an elongated skull with shark-like teeth. When Ilos approached it, he felt that this had to be the source of the catacomb's evil. His sword drawn he stepped closer. And the thing arose. Then it was all dust and blades. A fight of epic proportions erupted. The unnatural entities seemed to have all advantages on its side yet Ilos was determined and had faced other evils before. In the end the exhausted Ilos stood over the broken body of his enemy. In the heap of dust and bones Ilos spotted an amulet that he hadn't noticed before. The gleaming jewel emanated power and as the victor, Ilos claimed it for his own. The catacombs seemingly had lost their magic and though he was unable to find any of his lost companions, Ilos returned to the light of the suns. From this day on Ilos and the amulet became inseparable. He never ever parted with it, even when sorcerers in his circle of friends requested to examine it. He still travelled the land and fought in many valiant quests. But less and less he consorted with other people and he became a loner. With worry his distanced friends saw Ilos staring at the jewel or even sometimes whispering to it. At some point a couple of his friends decided they had to get rid of the amulet to free their friend from its seeming influence. When Ilos was asleep three former companions snuck into his dark room and with the help of some sorcery managed to take the amulet from him. In that moment the amulet bursted into a glowing light and burned the hand of its thief to ashes. Ilos now wide awake swiftly slew the intruders, not even bothering who they were. In a hurry and convinced that he had to protect his amulet he fled the castle where they resided. In the years to come Ilos no longer went on quests. When he was sighted it usually lead to bloodshed by his hand for he had become a bitter and easy to anger man that seemingly was looking for trouble. Eventually he gathered a band of bandits and outcasts from various races and begun plundering the lands. always on the move as if looking for something. The cruelty of his campaign mocked all that was once dear and valuable to him. Eventually his horde was cornered by a superior force and utterly crushed. In the aftermath of the battle Ilos' body was recovered. The mysterious amulet though, was nowhere to be found.]] },
			{ itemId = 2826, -- book
				text = [[
The family line of the Antarel family was tainted with orcish blood since generations. A shameful secret hidden from the public. Though thought to have thinned out enough to no longer pose a threat, this assumption was disproven by the birth of Marik. Born with obviously orcish features he was hidden away and declared a miscarriage. While he was raised by an elderly couple in service of the baron as their own, three years later a brother, Gisbar, was born by the barons wife, who was declared the official heir. The baron, perhaps out of a feeling of guilt, chose young Marik to be raised as one of his squires. Marik proved extremely skilled in the art of battle. Growing almost disturbingly fast in size and strength, with 14 years he could go toe to toe with the best of the barons knights. Yet due to his heritage knighthood remained beyond his grasp. After the baron died by a riding accident when Marik was 17 years old, he became the squire of his younger brother, without either of them knowing about their relationship. Albeit Marik was known for his fits of rage and shunned by others for his brutish looks, the two became good friends and were nigh inseparable. While Marik fell in love to the fair maid Marisha it was his brother who would court and marry her in the end. When Gisbar officially became the baron, he ignored the traditions and knighted his friend and squire. This didn't suit the other knights and nobles well and what has been hidden mockery in the past became open provocation of Marik. The hot headed Marik duelled three of the nobles, maiming them badly, until baron Gisbar had to order him to stop this behaviour. Not much later though, the anger over insults overwhelmed Marik again, and this time he slew his opponent without any declaration of a duel. Gisbar had to judge over this case and in an effort to save his friend and former squire, he settled to banish Marik from the realm. Marik lived a while as a mercenary in foreign lands, always longing for the place he once called home. When he learned that his 'father' was in his death bed and Gisbar and Marisha were expecting their first child, he decided to return home in disguise. His dying father confessed to Marik the circumstances of his birth and heritage. Marik was devastated on many levels. Without any idea how to react or what to do, he attended the feast for the barons new-born in disguise. Wine and beer were served freely and like everyone else in the feast ccc became drunk. When the jesters and musicians entertained the crowd, one particular ugly and disfigured jester caught the attention of the equally drunk Marisha. She pointed at the poor creature and yelled that he almost looked as ugly as that oaf Marik. The whole drunken crowd joined her in laughter. This was when Marik drew his weapon. With fury and madness he slaughtered not only his brother and his wife but the whole entourage. With the help of his mercenary comrades he held the barony for a few months, even petitioning the king with his plight. In the end though an army was sent to bring him to justice. Before they arrived, ccc took his own life and the mercenaries took him with them to give him a proper burial.]] },
		},
	},
	-- bookcase at 32339,32261,9
	{
		itemId = 2437,
		itemPos = { x = 32339, y = 32261, z = 9 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The individual that was researching vampire lore and especially the whereabouts of possible vampires or their remains was NOT acting on behalf of the inquisition. In the light of warnings about some shadow organisation that is known as "army of the grave" and other similar names, it has to be assumed said person might have been one of their agents. Even more so, since all of a sudden this person, using the name Luthgar Decars, switched subjects of his research. His new agenda seemed to be to learn about famous knights of the past and lore about their time. Since it seems unlikely, that all of those knights were cursed with vampirism, the sudden change of fields of interest seems odd. Even more since this person used forged documents to access restricted information. It seems likely that this person had malevolent intentions.]] },
			{ itemId = 2825, -- book
				text = [[
Nargol the impaler was a disgraced knight of an unimportant noble family. Acts of cowardice and drunken violence had cost him any of the little reputation that his birth right and knighthood had given to him. In times of relative peace his attempts as a sellsword yielded too little money to sustain himself. When he had sunk so low as to have sold most of his family arms and armour he started working as a bruiser for local thugs. His fate turned once again, when he became the bodyguard of a spirit speaker. So he accompanied his employer to the court of king Zelos, who was strongly interested in speaking to the spirits from beyond. He was there when the king consulted the spirits with the help of the medium and witnessed some of the plans that took shape in such seances. Seizing the opportunity in a sober moment, he pledged his sword and service to the king, which the latter accepted. King Zelos had only a few loyal allies and some knight, up to anything the king might command, suited him well enough. Even to his own surprise Nargol proved quite effective and efficient in his new role. Soon he became the chief enforcer of Zelos, who soon would become known as the ghost king. For his faithful service to the king's cause, Nargol was awarded with the best weapons and armour available and even magic items found their way into his possession. With an iron fist and without mercy or remorse, Nargol carried out his king's will, in a mockery of true knighthood. The king liked that Nargol acquired a reputation of needless cruelty and violence. Even the threat of a visit of Nargol and his men brought villages and nobles back to the heel. In service of the ghost king the fallen knight took many injuries and was maimed several times. His king though had him stitched together again and again, sometimes replacing or 'enhancing' whole body parts with gruesome, magical substitutes. Over the years he became more and more a thing than a man. A walking magical construct of its own. In the end he seemed almost mindless. Fused with his armour and weapons. Inactive or lost in the dark abysses of his soul unless called to action. When the ghost king finally perished, Nargol simply stopped to 'function'. He was found standing motionless on his horse that strode into a small village. He was rather stored away at a secret place then properly buried, because it was feared he might rise again.]] },
		},
	},
	-- bookcase at 32339,32263,9
	{
		itemId = 2435,
		itemPos = { x = 32339, y = 32263, z = 9 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
After the rise of mankind the Shiron'Fal was founded by envious members of more ancient races, like the elves, dwarfs and minotaurs, to sabotage humanitys gods given ascension to power. From poisoning of wells to assassination of key members of human society, this shadow organisation did anything petty and spiteful they could to harm mankind and defy the will of the gods. Obviously they try to shroud their true intentions with lies and deception but to the true believer their schemes are laid bare by the gods like a rotting carcas in the sun. And though they deny it, all non-humans have some knowledge of the Shiron'Fal and support them at least by denying their existence. Thus, the true believer will never trust the words of a non-human. See their deceitful and treacherous ways. Strike them down with holy fury and let these heretics feel the wrath of the true gods, whose teachings they reject. Since the Shiron'Fall dig their vile and treacherous root deep into the hearts and minds of the non-humans, only their extermination can eradicate this threat to humanity.]] },
			{ itemId = 2820, -- sheet of paper
				text = [[
The information that could be gathered about the legion is rather meagre.
In Rathleton one of the Shiron'Fal agents unleashed one of its minions, a mummy called the Ravager, to cover his tracks.
The individual itself could not be identified but several sources refer to him as a 'death priest'.
This, in tandem with his mummy minion, might hint at someone with powerful necromantic abilities, possibly with ties to Urgith.
He seems to have been looking for an artifact of corrupting powers with some relation to blood.
It seems that said artifact was not recovered or was not existent at all.
For all we know the death priest retreated with empty hands though this might be a ruse.
As recommended agents were deployed to look further into the rumours about said artifact.
Parts of the ravager could be acquired for further studies.]] },
			{ itemId = 2821, -- book
				text = [[
Rewar the bloody was a petty man of intrigue with the aspiration to become king. Through manipulation and deception he acquired a great deal of power. To raise his status he claimed several heroic deeds of others as his own. Though he silenced anyone who could put his exploits into question, suspicions amongst his knightly peers begun to rise. When he claimed the dragon slaying by a shepherd, who was assumed to have died in the fight, as his own, another knight confronted him with a wounded but alive shepherd and called his bluff. Rewar, seemingly infuriated, demanded a trial by combat, thinking that he would easily best a mere herder of sheep, unskilled in the use of arms. When he learned that not the shepherd but the accusing knight would be his opponent he fled the court the night before the trial and hid in a remote castle at the border. There he lead a life as a robber baron for a while until a force of the realm drove him out. He became a traveller, visiting many wonders of the known world and beyond. He served as a sword for hire for some time, but serving did not suit him well and he abandoned his employers often in the time of greatest peril. Often he did so, with a good part of the employers wealth. Some he betrayed for gold, others out of spite. With his reputation ruined his traveling intensified. As an old man he returned to the realm and bought himself a pardon by a young, new king with his ill-gotten wealth. While a few old knights who remembered him and his misdeeds tried to put him on trial again, through intrigue and bribery he dogged their accusations until he finally died of old age.]] },
			{ itemId = 2821, -- book
				text = [[
The Shiron'Fal was created while the god wars were most intense. It was a gathering of generals that oversaw the course of battle. Each of them a mastermind of immense power. Yet even they were unable to turn the tides of war to their favour. Their armies perished sooner as they could be replaced. Race after race was thrown into battle, only to become annihilated. Despising such a waste of resources the generals begun to hold back the finest specimens of the races and formed a personal retinue out of them. When the god wars came to a halt, they had accumulated considerable power for their own purposes. Yet they decided not to waste their armies in futile bits for temporary power but stayed their hand for times yet to come. Over the ages they worked behind the scenes and continue to recruit and muster. Their endless army is swelling and growing. They know that the god wars are not over yet and they will be prepared when the battle rages again.]] },
		},
	},
	-- chest at 32357,32131,9
	{
		itemId = 2472,
		itemPos = { x = 32357, y = 32131, z = 9 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
We have destroyed the key. It is of no use now.]] },
		},
	},
	-- chest at 32614,32131,9
	{
		itemId = 2472,
		itemPos = { x = 32614, y = 32131, z = 9 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Armaments, Chapter Two, Verses Nine to Twenty-One.

And the Lord spake, saying:
"First shalt thou take out the Holy Pin. Then, shalt thou count to three, no more, no less. Three shall be the number thou shalt count, and the number of the counting shalt be three. Four shalt thou not count, nor either count thou two, excepting that thou then proceed to three. Five is right out. Once the number three, being the third number, be reached, then lobbest thou thy Holy Hand Grenade of Antioch towards thou foe, who being naughty in my sight, shall snuff it."]] },
		},
	},
	-- bookcase at 32617,32390,9
	{
		itemId = 2435,
		itemPos = { x = 32617, y = 32390, z = 9 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
1001 Usages of Poison]] },
			{ itemId = 2821, -- book
				text = [[
Sabotage Made Easy]] },
			{ itemId = 2821, -- book
				text = [[
The Lie and You]] },
		},
	},
	-- bookcase at 32618,32390,9
	{
		itemId = 2437,
		itemPos = { x = 32618, y = 32390, z = 9 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Close Combat for Experts]] },
			{ itemId = 2816, -- book
				text = [[
User Guide of Concealed Weapons]] },
			{ itemId = 2816, -- book
				text = [[
Spycraft Guide Vol. 007]] },
		},
	},
	-- bookcase at 32619,32390,9
	{
		itemId = 2436,
		itemPos = { x = 32619, y = 32390, z = 9 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Assassination for Dummies]] },
			{ itemId = 2816, -- book
				text = [[
Assassination of Dummies]] },
		},
	},
	-- bookcase at 32620,32390,9
	{
		itemId = 2437,
		itemPos = { x = 32620, y = 32390, z = 9 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
How to Scam People]] },
		},
	},
	-- bookcase at 32989,32419,9
	{
		itemId = 2438,
		itemPos = { x = 32989, y = 32419, z = 9 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Incantations yesterday and tomorrow - a comparative study on the evolution of rituals. Revised 155th edition with a preface by His Dark Excellency, Tarkeolos Blacksand.]] },
		},
	},
	-- bookcase at 32989,32420,9
	{
		itemId = 2440,
		itemPos = { x = 32989, y = 32420, z = 9 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Vampires can be immobilised, for a very long time, if the right method is used. If their physical body takes too much damage, it will go down. Sunlight will dry them out and even turn them into dust. If you drive a wooden object into the heart of a vampire, the flow of the vampire's tainted blood is stopped, leaving him completely helpless. It should be mentioned, though, that if the heart is partly missed or if the object is not large enough, the vampire might still be able to move.
Since a vampire is dead anyway, none of these methods allows to destroy a vampire for good. With enough time and blood, a vampire can recover from any of those seeming deaths. The only known way to permanently defeat a vampire is to kill him with a blessed stake. A blessed stake, however, is a rare object that cannot be obtained easily.]] },
		},
	},
	-- bookcase at 32994,32412,9
	{
		itemId = 2435,
		itemPos = { x = 32994, y = 32412, z = 9 },
		contents = {
			{ itemId = 635, -- parchment
				text = [[
Comparative Notes on the different uses of human earwax for the Dark Rites. (This seems to be an ancient memo from a student)]] },
		},
	},
	-- bookcase at 32995,32412,9
	{
		itemId = 2437,
		itemPos = { x = 32995, y = 32412, z = 9 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Brat Smoker: "Jugular". A novel. (This book seems to have been read multiple times)]] },
		},
	},
	-- bamboo shelf at 33210,31048,9
	{
		itemId = 2459,
		itemPos = { x = 33210, y = 31048, z = 9 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Only parts of the military are willing to support us. Their spirit was broken long ago in the fights against the orcs. Our once proud army was reduced to an inflexible behemoth that reacted sluggish to any problem. And this behemoth was beaten into shambles by the orcish hordes. Only the dragons' interference turned the tides of war. Now most generals fear what would happen if this support were withdrawn. Could we repel another attack of the orcs? Would a civil war not only make us more vulnerable with no winner at all? I fully understand and share these views. Still, it is our only hope. If we bow to the dragons now, they will rule us once and for all. We have to act here and now. Yet, I am afraid not many will join us and the temptation to betray our cause for some better position in the hierarchy is a constant danger. Our best hope is to form a resistance in secret and then strike at the dragon kings at once. None of them shall survive and we have to avoid fighting other parts of the army. We must save every strength that is left for the time ahead, for a time when the dragon kings are gone. With a beheading strike we will free our nation.]] },
			{ itemId = 2816, -- book
				text = [[
The treatment of sick peasants has lost more and more importance in the recent years. The local governors have grown accustomed to rather shunt infected people into the provinces of their rivals than to pay for their treatment. People are cheap and plenty, medication is not. As a physician I cannot agree to such an attitude, but I am in the employ of a governor and have little influence on his decisions, and even less on those of others. The nobility in turn values its health quite much. Even the most minor symptoms have to be treated with the most expensive and powerful potions at our disposal.]] },
			{ itemId = 2825, -- book
				text = [[
I have been informed by the local governors of the north that they will not be able to send any additional troops to help out with our orc problem. They claim that the diseased are threatening to invade their fortresses in the hope of finding some cure or nourishment there. Therefore, they need every men at their disposal. I will gather the local guards that are now on their way to stop the spread of the plague by burning infected villages and join them with my remaining soldiers. Considering our might and expertise, the orcish raiders are of course no threat. I will take the rejection of support as an opportunity to prove my superior strategical and logistical skills. There has not been any glorious battle for decades. Even though I fear that the reports of panicked peasants exaggerate the number of the orcs, there is still hope that they will be enough to give my soldiers some exercise. The captain of the local border patrol has remained silent for quite a while now. I assume he is still figuring out how to explain that he had let slip some of the orcs. I will not accept the decimation of his ranks due to the plague as an excuse. The plague is something we all have to deal with. It is even possible that one of my rivals has paid him for his inattention in the hope to disrupt my control of my province in these hard times. I think it will be the wisest decision to have said captain executed as soon as I have dealt with the orcs.]] },
			{ itemId = 2825, -- book
				text = [[
The plague is not much different from those we have encountered before. In fact in ancient texts I found a report of an occurrence some generations ago with almost identical symptoms. The plague of these times was only local. The village was put under quarantine and the best physicians and supplies were sent. Over the course of a month, the plague had passed through and from over 100 infected less then 20 had died. It seems the plague in our days was ignored by the authorities for quite a while. Later a local governor tried to cover up this mistake and kept the plague secret. To ensure that, he chose a rather aggressive approach and had the village burnt down with all its inhabitants. It seems that some of the villagers had escaped though and fled to relatives in neighbouring villages. As the word of the extermination of the village spread, many peasants fled their villages as soon as the first symptoms of the plague showed up. Still, it seems the plague is hitting the peasantry harder than it had in the past. I think I will have to investigate their living conditions to get a better insight.]] },
		},
	},
	-- bamboo shelf at 33216,31055,9
	{
		itemId = 2459,
		itemPos = { x = 33216, y = 31055, z = 9 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The few remaining priests of the great snake try to gather some form of resistance to overthrow the new rulers. I was never a religious lizard. With my grandfather being a geomancer, my family followed older teachings about spirits and ancestors and did not feel that the fanaticism that most followers of the snake god displayed was appropriate. I even doubted some of their essential doctrines and I remember tales from the dawn of time that made no reference to a great snake at all. Yet, those priests might be our last hope to get rid of the new rulers. The priests did not like my independence in the past, though, and I am not sure if I am welcome in their ranks. Together we might stand a chance.]] },
			{ itemId = 2824, -- book
				text = [[
The treatment of sick peasants has lost more and more importance in the recent years. The local governors have grown accustomed to rather shunt infected people into the provinces of their rivals than to pay for their treatment. People are cheap and plenty, medication is not. As a physician I cannot agree to such an attitude, but I am in the employ of a governor and have little influence on his decisions, and even less on those of others. The nobility in turn values its health quite much. Even the most minor symptoms have to be treated with the most expensive and powerful potions at our disposal.]] },
		},
	},
	-- bookcase at 33286,31521,9
	{
		itemId = 2435,
		itemPos = { x = 33286, y = 31521, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 2821, -- book
				text = [[
Heroic Tal... ...]] },
		},
	},
	-- bookcase at 33288,31528,9
	{
		itemId = 2435,
		itemPos = { x = 33288, y = 31528, z = 9 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Tactics handbook - Use training ... advantage. Avoid fighting ... enemy at ... ...ing an enemy, you might get hurt by his allies or other monsters and can't defend yourself while trageting him. Target only the closest ene... ... confused and might not be able to defend yourself against other attacks. Different enemies require different ... in an ag... way, you should encounter others in a defensive way. Choosing between your attack styles also depends from your equipment - if you have ... your disposal, there is likely no point in fighting defensively and ...]] },
			{ itemId = 3124, count = 1 }, -- burnt scroll
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33289,31524,9
	{
		itemId = 2436,
		itemPos = { x = 33289, y = 31524, z = 9 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The principle of opening a gate for a dem... ... ...u need to accumulate some critical mass of synergistic energy and open a rift between the worlds. The needed ingredients consist of some of the negative ... similar to the essence of th... ... The first part of the summoning ritual opens onl... ... ...h this rift demonic energy enters into our world ... ...e power. With stronger ingredients, the ritual opens a larger rift ... energy in to strengthen the ingredients. This ritual is repeated over and over again until the ingredients are strong enough to open a portal through ... can pass. This ritual can also be initiated ... and similar entities clearly show all characteristics common for such rituals. Once the gate is open ... the place by their sheer presence. ... demonic master ... negative energy as the demon ... his existence in our realm. As long as th... ... energy of a place, demons can exist for a very long time in our realm. So in theory, it would also be possible that ... the two realms ... allowing more and more demons to enter our world that ... demonic army causing mayhem and havoc. The archdemon Shervad the De... ... armor made of an unknown material that ... realm for at least three centuries. In his last battle, he lost ... he was not physically hurt - his enemies had destroyed his armor. It is said that the armor was made by ... mines.]] },
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33289,31528,9
	{
		itemId = 2436,
		itemPos = { x = 33289, y = 31528, z = 9 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Her... ... Vol. IV]] },
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33290,31524,9
	{
		itemId = 2436,
		itemPos = { x = 33290, y = 31524, z = 9 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Modern architect...]] },
		},
	},
	-- bookcase at 33290,31528,9
	{
		itemId = 2436,
		itemPos = { x = 33290, y = 31528, z = 9 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
...
Trihd and the Dragon
Part 1

Once upon a time, in a land far, far away, there lived a young boy. This young ... wander about the countryside, day and night. ... (if you were so inclined to make judgements on others) call "curious".

One day, ... a not overly sm... ... the rocky side of a hill. Under Normal circum... ... would no... ... ...bout wandering ... place, but as luck ... in spite ... have it, there was a ... in the entr... ... a few steps inside.

So upo... ... ...st coin he hea... ... from further ... and the conversation that ensued was something like ...

Dragon (for it was a dragon in the cave): Who goes there?

Trihd: I ... he takes a few more steps inside and ... gold coin, and spots several more ...]] },
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33295,31524,9
	{
		itemId = 2435,
		itemPos = { x = 33295, y = 31524, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 2816, -- book
				text = [[
... ...ses
Volume VII
The Cycl... ... Pt.1

Time and fo... ... ...d, known by some as the "godsslayer", known by all as a ... reknown and told to children as a bedtime ... as in many things, ... is founded in fact.

Who's to say whether the old ... of the origins of this sword are t... ... ...lse? Not you or I for sure. All we know ... when the sword ... ...se many many years late... ... ...ot found, ... and given by the ... a virtuous warrior, ... knowledge and skill.

This man, ... skilled ... lost ... the land, treasured this sword, as any would. But whethe... ... of knowing the sword would not be best served in his care, or foretelling of the curse, or fea... ... power, or perhaps even greed, he decide... ... relinquish his claim on the blade. ... ...les, villains, and wise men alike all ... sword. For the power it could bring or for the fame it would sing, ... as few things in this world have been.

In the end i... ... together two who would otherwise be the bitterest of ene... ... pooled their resources, where apart they would neither one ... to ransom this weapon, together they outbid their competition. Ill-gotten gains and righteous loo... ... as one and more was borrowed, but at last the bounty was high ... that the owner agreed to hand over t... ...

Since none ... ...olved felt any of the others were to be ... when throwing their lots in together to buy the sword, the... ... ...hat another party should combine the wealth and chaperone the trans... ... task they chose the most vaunted merchant in all the lands.]] },
		},
	},
	-- bookcase at 33296,31528,9
	{
		itemId = 2436,
		itemPos = { x = 33296, y = 31528, z = 9 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
The Mooh'Tah
In our days the minotau... ... ...y known as a warrior cult of some sort. This is of course incorrect. Although the Mooh'Tah ce... ... ...tion and the minotaurean Mooh'Tah masters are feared warriors and for many the epitome of skilled fighting Mooh'Tah is more! Its ... or at least ... ...ic, may it be cooking, may it be poetry, may it be war. Secondly its about seeing the perfection in ... master might spend hours in looking at a flo... ... ...ery and it's likely he writes a poem or song about it, only to walk into a battle minutes later. ... assumed that you can condense the philosophy into ... See perfection! And: Try to achieve perfection!]] },
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33297,31524,9
	{
		itemId = 2436,
		itemPos = { x = 33297, y = 31524, z = 9 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Manasphere? by Othis Et...
I don't want to minimize the value of ... But to me it lacks any proof! Thus Ashkil's ... ...he idea that the beings are producing the mana ... the "planet is surrounded"-statement? How should he know ... this planet? Either there's another (now lost) book that deals with the experiments ... the whole "manasphere" is only an unp... ...ry!]] },
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- bookcase at 33298,31521,9
	{
		itemId = 2435,
		itemPos = { x = 33298, y = 31521, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 2821, -- book
				text = [[
The Witch... ...
On a remote isle in the South there is ... together to celebrate som... ... year. They teach each other new ... other beings. The legend goes that everybody that dares to disturb them ... death or ... death. But if you manage ... the ceremony, the witches have to fulfil you a wish.]] },
		},
	},
	-- bookcase at 33299,31528,9
	{
		itemId = 2437,
		itemPos = { x = 33299, y = 31528, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 2821, -- book
				text = [[
Extended Vision
Most dwarves have a exc... ... ...t even in dark env... ... one day allow you to see nearly twice as far as you currently do. What's needed is the fire of a fire element, the head of a ghoul,the essence of a red royal blossom, so... ... Bay and the laugh of a mute sinner. Light a fire with the flame of the fire element. Pour the water ... place it over the fire. Throw in the head of the ghoul and ... Blossom and mix it ... Take some of the potion and mix it with the laugh while cooling it. Now we only need to find out the mis... ... magic words to imbue it with energy.]] },
			{ itemId = 2824, -- book
				text = [[
Puldraks wisd... ... 4
The Cenath were the luckiest of th... ... in a hidden valley, far away from the rages of war. As things turned bad for the elv... ... artwork and books were brought to these cities. Life went on as usual for some time, the elves minding only their own ... war at all. Of course the war found them at last. In an frantic attempt to rescue their lives and even their ... elves begun to weave powerful spells. Many of their best magici... ... succeeded. The whole valley was torn out of the ... ...rld that was only stormy darkness around the elven valley. They created an artificial light and even created weather. There they lived for hundreds o... ... ...gic, mainly to manipulate and reproduce the effects of nature to enhance their lives.]] },
		},
	},
	-- bookcase at 33301,31521,9
	{
		itemId = 2437,
		itemPos = { x = 33301, y = 31521, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 2827, -- book
				text = [[
The Fi... ... ...OK ONE

Zathroth ... ...ial, which Fafnar showed, and he looked upon her with delight. He flattered her ... succeeded in seducing her. Thus they conceived ... fiery raging berserker. Brog possessed only little of his fathers wisdom, and the heat of his mother bu... ... ...im. There however the fire became more ravaging and more hurting, and ... the elements were shaken. Inexpressible pain troubled him, until the blocheaded Brog compacted his magical powers and hurled a maj... ... ...nt to cool down, however immediately the ... Garsharak, rose and he bore many further lower ... centuries from his fire and his magic ...]] },
			{ itemId = 2824, -- book
				text = [[
Fartuvions Gui... ... The Unknown]] },
		},
	},
	-- bookcase at 33304,31524,9
	{
		itemId = 2436,
		itemPos = { x = 33304, y = 31524, z = 9 },
		contents = {
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 2825, -- book
				text = [[
... full of dangerous creatures ... We constructed this sea based Outpost in the hopes to use the water as natural barrier and first line of defence. The Base has it's own seaside harbour so we could be resupplied easily. It was seen as a blessing that we found a natural cave system which we used to build a fast system of catacombs with little ... chosen badly. Storm and sea are taking their toll on the fortifications and it seems inevitable ... especially the winter storms are p... ... ...astern tower collapsed ... ...aps cursed like some of the me... ... ...sticious, but certain ... sabotage ruled out. ... some kind of ... in the west ... sent parties to investigate ... packed with monsters ... ...n demon invested ar... ... and manifestations. ... strange summoning circ... ... ...cians ... ...oerful demonic ent... ... ...hles seven. ... true, we are in ... Daniel has proven his ... ...s second in command. He and a handful of men have ventured f... ...then anyone else before. They found ... south west ... he insi... ... better spot ... mountain. I have to admit the cost and effort to maintain this struct... ... ...ive in the future. I ... ...ishment of a secondary base ... ...lit forc... ... ...nhealthy fascination. ... bothers me ... to return to the continent in this vital times. ... gods deci... ... health failing ... in Daniels hand. I'm confident he'll ... I'm worried ab... ... rebellious elem... ... check.]] },
		},
	},
	-- bookcase at 33309,31521,9
	{
		itemId = 2437,
		itemPos = { x = 33309, y = 31521, z = 9 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Some of the ancient races that ... the wars of the gods were incredible powerful compared to modern mankind. Only tales of surviving ancients tell us about ... the S'vir who travelled the sky in their cloud ships; beings like the elephant men ... ...inary speech were words of magic that formed reality around them. Then there were the Tur'o... ... ...eating runes as big as a ship; or the unnamed ... the forces of ice and coldness to serve them; not to for... ... ...onelords who could raise whole armies of undead in a blink and summon abominations of decay an... ... ...ces had ancestors which were far more powerful than their kin today. As the war continued and the bitterness grew, less and les... ... ...id that humans and orcs were the least and the last of the races created.]] },
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
			{ itemId = 3121, count = 1 }, -- torn book
		},
	},
	-- drawers at 32105,31123,10
	{
		itemId = 2433,
		itemPos = { x = 32105, y = 31123, z = 10 },
		contents = {
			{ itemId = 2820, -- sheet of paper
				text = [[
A ship from Carlin confirmed our assumptions. The ship was also attacked by sea serpents and only managed to arrive here badly damaged. We have no clue why those vile beasts are even here in the northern seas. They usually live in the South and are never seen in such great numbers. If the presence of the sea serpents persists, we can do little but to give up our mining operations here. We have lost too much already and there seems to be no way to fight the serpents effectively.]] },
			{ itemId = 2820, -- sheet of paper
				text = [[
I think we could make out the reason for the missing ships. A lone survivor almost frozen to death was rescued by a local fisherman. He reported the ship was attacked and sunk by two giant sea serpents. I think we can say we certainty that the other ships met the same fate.]] },
			{ itemId = 2820, -- sheet of paper
				text = [[
The mining operations are progressing promisingly. Regular shipments to Carlin are established and we get along with the locals decently. Some of the northmen are still opposing our presence but most are supportive and appreciate the wares that our agreement brings to their lands. The small landing place for our ships has grown into a small settlement and I think we can pride ourselves on being witnesses of the birth of a town.]] },
		},
	},
	-- dead human at 32342,32125,10
	{
		itemId = 4240,
		itemPos = { x = 32342, y = 32125, z = 10 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
So many evil creatures!
I'm heavily injured.
These are my last words ...
Revenge my death!

Gygil]] },
		},
	},
	-- bookcase at 32596,32382,10
	{
		itemId = 2438,
		itemPos = { x = 32596, y = 32382, z = 10 },
		contents = {
			{ itemId = 2814, -- parchment
				text = [[
The plans are making good process. The method of indoctrination and disinformation is very successful. Each week we can send out new students to further our course. Caution is still needed of course. Our enemies are numerous and powerful. Should they ever learn about our plans and this facility, the whole project would be endangered. It is far too early to go public with our plans. Therefore I suggest to build a second base at some remote place. It is important that we have an emergency backup, regardless of the resources it would take.]] },
			{ itemId = 2814, -- parchment
				text = [[
That captured priest should be eliminated as soon as possible. It is far too dangerous to hold her captive for several reasons. I understand that the headquarter wants her interrogated but I am sure we did our best and this woman knows nothing of value. Regardless of my superiors' fears, I am convinced that she was investigating on her own here and not on some mission for our enemies.]] },
			{ itemId = 2814, -- parchment
				text = [[
The attempt to place a mole in the Brotherhood of Bones has not been successful yet. The major problem is that the brotherhood usually contacts promising candidates itself and not the other way around. The only success in arousing their interest led to the elimination of our hired necromancer by some local heroes. Seemingly the brotherhood stole the corpse later and reanimated it. I hope they did nothing with his spirit, else unwanted information might have leaked to them.]] },
		},
	},
	-- bookcase at 32596,32383,10
	{
		itemId = 2439,
		itemPos = { x = 32596, y = 32383, z = 10 },
		contents = {
			{ itemId = 2814, -- parchment
				text = [[
Our fake priests were able to discourage another troop of adventurers from entering the ruins. Although the efficiency of this outpost is admirable, I somewhat regret that my students did not get a little training in disposing of these curious nuisances.]] },
			{ itemId = 2814, -- parchment
				text = [[
The recent accident in the laboratories did not interrupt the poison brewing in a considerable way. The loss of the head alchemist makes it necessary to ask for a replacement though. Although the remaining alchemists have to work twice as hard as before, everything went fine so far. Still, I have to admit that working overtime makes new accidents more likely, but I decided to take that risk until a replacement arrives.]] },
			{ itemId = 2814, -- parchment
				text = [[
The so-called tradition among the students to send a newly promoted assassin on some foolish quest has taken another life. The young Roland fell to death while trying to steal the flag from the Thaian castle. Not only that we lost the time and effort we put into his education, the whole affair did draw some unwanted attention on our organisation. It is quite certain that the young fool used some of our highly specialised equipment in his silly stunt. As far as we know the whole affair is still under observation by the local authorities. We have to find a way to draw their attention in another direction before too many questions are asked. I had two of the senior students eliminated to make an example for the future. Such occurrences must stop once for all but I fear the harm has been already done and is irrevocable.]] },
			{ itemId = 2814, -- parchment
				text = [[
Our contact in Port Hope claims that he has not yet been able to make contact with the dworcs. I bet this coward has not even tried it. For the sheer distance it is not possible to punish him in an appropriate manner. If we would send a specialist, he could take care of that dworc contact. On the other hand, a local helper who is familiar with the jungle would probably prove more valuable than sending one of our assassins to a likely death by the hands of those cannibals.]] },
		},
	},
	-- bookcase at 32596,32384,10
	{
		itemId = 2439,
		itemPos = { x = 32596, y = 32384, z = 10 },
		contents = {
			{ itemId = 2814, -- parchment
				text = [[
I had Malicious eliminate this thrice cursed agitator that let himself been scammed by some con artist. He wasted our money supporting a fake revolution. I can't belive this stupidity, a scammer scammed! Malicious was ordered back for more important business though and lower ranking operatives consigned to find the scammer.]] },
			{ itemId = 2814, -- parchment
				text = [[
The TBI knows about our mole. It is quite certain that some recent actions and disinformation was only to bait him. He is now in some hiding place and I'm afraid he we will not be of much use for us in spying on the TBI's activities for a while.]] },
			{ itemId = 2821, -- book
				text = [[
We have to find a better way to resupply us. The smugglers are unreliable and it takes far too long until an order of goods even gets into their hands. Let alone how long it takes until they finally deliver it here. I am aware that a supply route via land is no option but there has to be some magical way to keep up our contact with the smugglers. However, they must be severely controlled by a handful of specialists with some skill in 'convincing'. I am aware of the smugglers' usefulness and their role in our plans, but their unreliability is a constant threat to us. Of course they have no idea what we are doing here but they are curious and would sell their own grandmother for a mug of ale. Perhaps we could simply replace them with more trustworthy followers. Not all are that suitable as asassins or agitators but all of them are able to follow orders and how difficult can it be to do some smuggling. Yet, the superiors insist that their contacts are needed. Although nothing like this was mentioned, I am sure that they serve as a connection to certain pirates but I have not the slightest idea what their role in the big plan could be.]] },
		},
	},
	-- bookcase at 32596,32385,10
	{
		itemId = 2439,
		itemPos = { x = 32596, y = 32385, z = 10 },
		contents = {
			{ itemId = 3506, -- stamped letter
				text = [[
Dear master,
I write to inform you that the targets were eliminated as requested. I still regret that you decided to entrust that mercenary Ned Noxiuos with the task and I was only a mere spectator. Although efficiently done, there was no finesse or skill displayed in their elimination. The fallen paladin Ned Noxious simply provoked the said individuals in a tavern. As soon as one of them was stupid enough to draw a weapon, they were disposed by a combination of energy bombs and fireballs. Of course the authorities did little about it since the tavern's patrons did swear the others attacked first. It seems unlikely that Noxious has those abilities in stealthiness and subtle assassination that the stories grant him.]] },
			{ itemId = 2821, -- book
				text = [[
TBI File 006ZAH8
Name: Ned Noxious
Real Name: Unknown
Occupation: Former Paladin, Assassin
Place of Birth: Unknown
Residence: Unkown, seems to travel from city to city
Affiliation: None

It seems Ned Noxious has appeared out of nowhere. The first reports about his activities date back to the pirate conflict that threatened the Venore merchants council. Noxious obviously was hired along with other mercenaries to get rid of some pirate captains that held the usually unorganised pirates under their control. Altough there are no specifics about the affair, Ned Noxious was the only one, out of of the twelve hired mercenaries, that returned to claim his reward. Afterwards he was employed by different persons or groups for undocumented and rather insignificant jobs. His next notable apperance was the elimination of the bandit queen Leerah within her own camp full of renegade amazons. It is assumed that Noxious used invisibility to get to her and quickly killed her before any guards could react.

Further accomplishments that are probably related to him:
The assassination of the last Thaian mayor of Venore.
The assassination of the mage Haramun in Darashia.
The assassination of the Mixton Family.
The sabotage of the 'Queen Torviva' in the harbor of Carlin.
The poisoning of the Edron wells which led to five deaths.
The killing of at least six noblemen in provoked duels.
We cannot be sure for which felonies he was paid by an unknown party and which of these acts he fulfilled out of sheer morbid pleasure. Still the lack of any proof makes it impossible to punish him adequately.
At least three assassination attempts on him have already failed.]] },
		},
	},
	-- bookcase at 32596,32386,10
	{
		itemId = 2440,
		itemPos = { x = 32596, y = 32386, z = 10 },
		contents = {
			{ itemId = 3506, -- stamped letter
				text = [[
Concerning your suggestion to train our agitators at a different place to ensure your safety: We have discussed the pros and cons and came to the conclusion that it would be inefficient in the current state of the project. If we spread our risk, we would also spread our resources. The agitators, as you call them, are only useful if also trained as assassins. It is more useful to pick some promising students and teach them elocution and manipulation. If someone proves unsuitable, we can simply put him back into normal training. If we had two bases, the risk that possible captives know about them both is high enough to diminish the advantage of another base to zero. Rest assured that we are aware of the danger of the base being assaulted. You know that in such a case it is your job to destroy anything that could point to us and escape on your own. Those whose training was good enough to be of any value for us will be able to escape on their own and will be contacted and informed at places that were allotted to them for cases of emergeny.]] },
			{ itemId = 3506, -- stamped letter
				text = [[
We were pleased to learn about the untimely death of the merchant mentioned in our last letter. Your operative proved to be cunning and skilled in arranging this little accident in the harbour. Send him our best regards. We are sure we will hear more about him in the future.]] },
			{ itemId = 3506, -- stamped letter
				text = [[
It is sad that you had to inform us that the individual known as Ned Noxious wants only to cooperate with us as a freelancer. We do not suggest his elimination. He has proven his usefulness in the past and I fear even your pet assassin Malicious is far from having acquired the skills that Noxious possesses. Noxious is efficient yet expensive, but if it comes to really important missions, money matters little. Still, it is a sad thing to see that a freelancer outclasses the specialists who we invested a great deal of money in to train. Take Ned Noxious not as an obstacle but as a touchstone.]] },
		},
	},
	-- bookcase at 32624,32083,10
	{
		itemId = 2435,
		itemPos = { x = 32624, y = 32083, z = 10 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
Dangers of Adventures
by Netlios

Volume I

An adventure is an exciting thing to do. Nevertheless it might be rather dangerous,
one may even die during his journeys through the lands!
I wrote the following books in order to show the fates of 5 men who devoted themselves
to discover new parts of Tibia. Each of them was a brave warrior and a superior explorer
and they all went through exciting adventures. Their journeys were of different duration -
one ended after 66 days, another after 100 days. Each journey ended in a very dangerous
situation; one situation even ended deadly!]] },
		},
	},
	-- bookcase at 32624,32085,10
	{
		itemId = 2435,
		itemPos = { x = 32624, y = 32085, z = 10 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
... Five days in this city and under these people, and I'm still not able to communicate with them.
But I do not resign - on the contrary, I get more and more interested in the language. I found out some more words, for example how they count: "umog" seems to be "one", and for each number more, they just put a "tu-" in front of "umog". Thus, five would be called "tutututumog". It doesn't seem to me as if they would have highly developed mathematics, but the way to count seems sufficient for them. I wonder, how they were able to build this town...?
Maybe an answer is, that they do not speak about numbers, but have short signs for writing them down.
It was surprising for me to find out they have a word for "zero", namely "mog". I hope to find out more in the next days.
Strangely, they use words for numbers in each context they use numbers. So, "umog" stands for one, but also for "once", "one time", "first", ...]] },
		},
	},
	-- bookcase at 32624,32089,10
	{
		itemId = 2435,
		itemPos = { x = 32624, y = 32089, z = 10 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
How to mix magical potions

Potion of demonic transformation

Take good care of this potion. It is very dangerous, since it transforms anyone who drinks it into a demon!
This transformation isn't reversible...
The ingredients are:
a potion of red slime
the eye of a demon
a piece of paper with a footprint of a demon.
Now put the eye and the slime on the piece of paper and wrap it. Cast the words "urtuo sinium" on it.
Take this object and place it for 24 hours next to any drink. Afterwards, this drink will transform the
one who drinks it into a demon.
I again warn you: It might happen that you accidently swallow this drink yourself!]] },
		},
	},
	-- bookcase at 32624,32091,10
	{
		itemId = 2435,
		itemPos = { x = 32624, y = 32091, z = 10 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
"On different Fluids, 5th publication"
by Arisophlus

Blood and a revitalising fluid are the two kinds of known red fluids. Blood, the "fluid of life", is a strange thing. Everyone will agree with me, that it is the "fluid of life", even though there are numerous living forms which do not have blood! Instead they seem to use some kind of slime (have a look the corresponding chapter to find out more about it). The life-restoring fluid is a strange fluid, too. I never was able to find out if it works on humans and on animals. I tried more than hundred times to heal my dog with it - but he does not want to drink it. As it seems, it only works for humans...
Last but not least, there exists one single white fluid in our world: People call it "milk".
There are rumours that it might increase one's magical abilties if swallowed - I never could verify this claim. As it seems, someone had dreamt about it and afterwards wasn't able to distinguish between reality and dreams...]] },
		},
	},
	-- bookcase at 32625,32083,10
	{
		itemId = 2436,
		itemPos = { x = 32625, y = 32083, z = 10 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Book review of Netlios opus:
"Dangers of Adventures"
by Adrenius

A lot of people have read, and of course will read in the future, Netlios popular series of Books "Adventurers Guide Through Tibia. I-VI". But could this book really be a guide for adventurers? I am not quite sure. It is rather confusing to read these books. A lot of stories were told, but do these stories really belong to each other? Could these people really exist? I doubt it! Once a traveller came to me, who wanted to convince me that Netlios stories are real. I asked him to tell me the names (in alphabetical order), the ages, the reasons why they stopped their journeys and the length of their adventures.
At the beginning, I wanted him to give me the first name, his reasons and all this.
He wispered:
"Anaso, 38, troll attacked, 66 days".
I asked him to tell me about the next person:
"Elaeus, 40, steped into fire, 100 days".
I also asked him about the last three persons, and he gave me his answers.
At the beginning, his words seemed plausible to me. But after thinking about it and reading parts of Netlios' stories again, I noticed, that this can't be true.
A lot of people came to me, bringing "their" versions of (wrong) solutions to my questions. There was never someone, who was able to give me a correct answer...
Does an answer exist? If it does: How does it look like?
I decided to give a reward to the first one, who is able to tell me the correct answer.]] },
		},
	},
	-- bookcase at 32625,32085,10
	{
		itemId = 2436,
		itemPos = { x = 32625, y = 32085, z = 10 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Adventurers Guide Through Tibia.
by Netlios

Volume I

An adventure is an exiting thing to do. Nevertheless it might be rather dangerous, one may even die during his journeys through the lands! I wrote the following books in order to show the fates of 5 men who devoted themselves to discover new parts of Tibia. Each of them was a brave worrier and a superior explorer and they all went through exciting adventures. Their journeys were of different duration - one ended after 66 days, another after 100 days. Each journey ended in a very dangerous situation; one situation even ended deadly!]] },
			{ itemId = 2825, -- book
				text = [[
Dangers of Adventures
by Netlios

Volume III

The first potential source of danger I want to discuss is fire! Of course fire is necessary to survife wilderness - to cook our food, to have light, to warm ourselves in a cold and dark night ... But always take care: fire doesn't help us all time! Let me give you an example: One of our explorers was wounded badly, because he steped into an open fire he made himself to cook some fish he just cought in the nearby river. Of course, this was the end of his journey; it was shorter than the travelings of the joungest among the five adventurers.]] },
		},
	},
	-- bookcase at 32625,32087,10
	{
		itemId = 2436,
		itemPos = { x = 32625, y = 32087, z = 10 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
Notes about gharonk language

... It's now the forth day here in this town. I wasn't able to find out, how the town is called, but that doesn't seem important to me. More important seems to me to find out more details of gharonk language. I found out that they use some words for some different but similar expressions. Gharonk doesn't seem to distinguish between the word for "I" (nag) and the words for "mine", "my", "me", and so on. That makes the language more simple, and I think it's always clear what it means from the context. Of course, that are only speculations, I'm not quite sure about it at all...]] },
			{ itemId = 2824, -- book
				text = [[
... It's now my last day of the first week here. From day to day, I am able to talk more and better with the people living here. I like it, the people are nice, I get food and drink. The king, or I'd better say their leader, showed me his "throne". It's more like a place on the floor, where he sits when talking to his people. He pointed with his finger at this place, saying: "Nag mogurz, nag mogurz". I guess, it means something like "my place, my place". I found out many other words, I wrote them all down in a table. Maybe I'll teach this language one day to someone, who is interested in....]] },
		},
	},
	-- bookcase at 32625,32089,10
	{
		itemId = 2436,
		itemPos = { x = 32625, y = 32089, z = 10 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
Notes about gharonk language

... On my journeys, one day I found a nice, little city. Not too many people lived there, and they spoke a strange language.
After trying to speak to some of it's inhabitants, I found out, that they call this language "gharonk".
In the next days, I will try to figure out, how this language works - I really wish I would understand what they try to tell me!]] },
		},
	},
	-- bookcase at 32625,32091,10
	{
		itemId = 2436,
		itemPos = { x = 32625, y = 32091, z = 10 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
How to mix magical potions

Potion of recall

Once you forgot the recipe of this potion, it's hard to remember. To remember it, you should drink this potion, which of course could cause problems if you haven't something of it left or you forgot that it was this potion.

All you need for this potion is:
a dead rat
23 pieces of gold
a rose
a fishbone
a watch
a peel of a banana
and, of course,
a rapier to stir with
and finaly a pot to cook in.
Throw the ingredients together into the pot and cook it for 28 minutes. After that, cast the magical words "murana nur" on it. Drink it, and you will gain your full memory again.
BEWARE: This potion does not help undeads. In order to work, this spell needs a brain in the concerning body. Without a brain, it's useless.
It also should be mentioned, that this potion only brings back one's memories for a short period of time. It does NOT last very long....
Good luck and happy cooking!]] },
		},
	},
	-- bookcase at 32626,32083,10
	{
		itemId = 2437,
		itemPos = { x = 32626, y = 32083, z = 10 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
The Origin of Species by Means of Natural Selection
by Dave Charlwin

After years of research, I believe I have found the origin of of any living creature that exists in our dimensions. First,
shortly after our world was created, the were just stones and earth. There were small stones, big stones, gray and brown
stones, sharp and round stones. Some of these stones looked very much like today's seeds; that isn't just per chance.
Obviously, some of the round, small, brown stones,which were somehow placed some fingerlength deep in the earth, started
growing in the directions of the sun - in the opposite direction of hell. That is how plants and trees were created
- big trees came out of big stones, small plants out of small stones.

Now one may ask oneself (or me): How did animals come into the world?
I thought really long about this question, and I obviously found the correct answer.

Once there were plants existing they started "mixing" with stones:
Plants are living objects (just like
animals are), but they can't move very fast (animals move fast). Stones on the other hand do not live, but they can
move very fast (think about stones falling down a mountain).

That's how animals and monsters started to exist.]] },
		},
	},
	-- bookcase at 32626,32085,10
	{
		itemId = 2437,
		itemPos = { x = 32626, y = 32085, z = 10 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
How to mix magical potions

Potion of fast movement

This potion makes the user run faster than the fastest known creature. It is not known, if there is a brake once the effect disappears.

You will need the following things:
a tail of a very fast creature
some mud
a piece of wood
a flower
and, of course,
a rapier to stir with
and finally a pot to cook in it.
Cook this fluid for 9 minutes and cast the words "rurnum maelis" in the direction of the cooking fluid. Put a drop of it on each shoe you wear and run!
Good luck, happy cooking and beware of obstacles!]] },
		},
	},
	-- bookcase at 32626,32087,10
	{
		itemId = 2437,
		itemPos = { x = 32626, y = 32087, z = 10 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
How to mix magical potions

Potion of halluzination

This potion causes the user to get different halluzinations. The nature of these halluzinations is regulated by different quantities of the ingredients:
1-5 eyes of a demon
2-5 hairs of a dead human
a potion of green slime
4-5 potions of beer
4-5 potions of wine
Mix these ingredients together, and just drink it. No need for cooking or casting spells...
May the halluzinations be nice!]] },
		},
	},
	-- bookcase at 32626,32089,10
	{
		itemId = 2437,
		itemPos = { x = 32626, y = 32089, z = 10 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
"On different Fluids, 2nd publication, part one"
by Arisophlus

The second kind of fluids are brown. There are several types of brown fluids.
The first one is called "beer". It is, to say, one of the real bad substances in our known world: It is tasty, it smells well and everyone likes it. But beware! It makes addicted! Once you drank a potion of it you won't be able to control your senses anymore!
You won't even be able to walk on a line! So, if possible, avoid this fluid. Just imagine you were hunting and your life depends on your reaction, on your movement, and on your visual impressions!]] },
		},
	},
	-- bookcase at 32626,32091,10
	{
		itemId = 2437,
		itemPos = { x = 32626, y = 32091, z = 10 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
How to mix magical potions

Potion of future-vision

Once drunk, this potion allows you to see the future for some time. Since this potion is so mighty and powerful, the ingredients are very rare and therefore difficult to get.
You'll need at least the following things:
2 potions of clear water
a teardrop of a demon
fire from a dragons breath
a sting of a wasp
some hair of a gigantic spider
a nail of a finger of a king's child
the nose of a royal rat.
This potion is cooked in a golden pot and stired with a heroic sword. It needs to be cooked for two hours and a half, and you have to cast the words "murman thusis nalbo" on it.
Good luck and happy cooking!]] },
		},
	},
	-- bookcase at 32627,32083,10
	{
		itemId = 2435,
		itemPos = { x = 32627, y = 32083, z = 10 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
The Adventurer's Guide To The Dungeons.

Troll: Trolls are some kind of strange monsters. They run around without having a target, telling stories no one can understand because of their unclear pronunciation (which results from the fact, that trolls do not have teeth at all). Trolls can easily be identified by their appearance: red skin, not too big, mostly in groups, often carrying a spear and a wooden shield to fight (of course, they do not know how to use these things properly...). Some Trolls (they are supposed to be the leaders of troll-groups) carry ropes and money with them - reasons are not known, but it is believed that they use ropes to climb down wells, what does surely not explain why trolls need money...]] },
		},
	},
	-- bookcase at 32628,32083,10
	{
		itemId = 2436,
		itemPos = { x = 32628, y = 32083, z = 10 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
How to mix magical potions

Potion of Invisibility

This potion is one of the most difficult potions to mix. Besides you need lots of time, you also need great magical abilties.
The ingredients you should have are:
a rat's tail
2 teeth of a dead troll
a piece of a ghouls robe
2 ghoul-breads
a dragon's eye
green slime
Put these things together in a pot and cook it about 25 minutes. Afterwards, speak the magical words: "Munga Mungos" towards the pot.
Now the potion is ready for use. Good luck and happy cooking!]] },
		},
	},
	-- bookcase at 32629,32083,10
	{
		itemId = 2437,
		itemPos = { x = 32629, y = 32083, z = 10 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
On mixing potions.

Now, being a really old magician, I decided to write down some of the formulas of potions I invented during my lifetime. First I thought it will be best to give clear advices for everyone to mix them. But after some days of crucial thinking I had a vision - everyone would be able to mix these powerful but dangerous potions within minutes without being aware of the consequences! It needs lot of wisdom and willpower to become a experienced and responsible magician. This doesn't mean to be cowardish - it means that you know your powers and that you exactly know your limits!
So, to prevent misuse of this knowledge i will write down these formulas in ****, a very old language only known by the wisest sorcerers.]] },
			{ itemId = 2829, -- book
				text = [[
Important facts from galactic history, number two
(reproduced from the "Sideral Daily Mentioner's Book Of Popular Galactic History")

Since this galaxy began, vast civilisations have risen and fallen, risen and fallen, risen and fallen, that it's quite tempting to think, life in the galaxy must be (a) something akin to seasick -- space-sick, time-sick, history-sick or some such thing or (b) stupid.]] },
		},
	},
	-- bookcase at 32630,32083,10
	{
		itemId = 2435,
		itemPos = { x = 32630, y = 32083, z = 10 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
How to mix magical potions

Potion of Happiness

This potion causes the user to become as happy as he never was before. Mix the following things:
a stamped letter
a dead fish
a bone
a diamond
an inkwell
You'll also need an empty potion to throw these things in.
Speak out the magical words: "Lomba Niff" and drink the fluid, and you get your happiness again!]] },
			{ itemId = 2828, -- book
				text = [[
How to mix magical potions

Potion of Flight

Drink this potion and fly like a bird! All you need is listed below:
two wings of a wasp
an eye of a dead body
a rope
a potion of lemonade
a watch
and, of course,
a rapier to stir with
and finally a pot to cook in it.
Put all things except the watch into the pot and cook it for 24 minutes. Cast the spell "Flifli Bor" on it and drink it.
Don't forget to have an eye at the time! This fluid lasts for 12 minutes.
Once the time is over, you are not able to fly anymore... you'll fall down like a stone.
Therefore, never forget the time and always wear a watch when using the "potion of flight"!
Good luck and may the birds be with you!]] },
		},
	},
	-- bookcase at 32631,32083,10
	{
		itemId = 2436,
		itemPos = { x = 32631, y = 32083, z = 10 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Dangers of Adventures
by Netlios

Volume IV

The important topic I will now examine is: How can I be sure to drink enough? Where do I get a drink? Well, there are not very many sources of drinks: First, you can take some potions of water with you. Second, you can "find" something on your way. For example, you might cross a river or perhaps it might rain one day or the other. And maybe you can even find drinks on your way, but be careful! You never know what is inside the potion you find. Let me again give you an example to illustrate this:
One of our five men travelling through Tibia (his name was longer than the name of the adventurer, who was attacked by a troll and therefore had to stop his exploration) one day found a filled potion on his way. He was very thursty, and so he drank the liquid inside. He didn't know (how should he?) that it was poisoned. After some moments he noticed, that he felt worse and worse. At this moment, he had to stop and return to his house. By the way, the name of this man (the poisoned one) was shorter than the name of the man, whose journey was over after 83 days.]] },
		},
	},
	-- bookcase at 32633,32083,10
	{
		itemId = 2435,
		itemPos = { x = 32633, y = 32083, z = 10 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
"On different Fluids, 2nd publication, part one"
by Arisophlus

The second kind of fluids are brown. There are several types of brown fluids.
The first one is called "beer". It is, to say, one of the real bad substances in our known world: It is tasty, it smells well and everyone likes it. But beware! It makes addicted! Once you drank a potion of it you won't be able to control your senses anymore!
You won't even be able to walk on a line! So, if possible, avoid this fluid. Just imagine you were hunting and your life depends on your reaction, on your movement, and on your visual impressions!]] },
		},
	},
	-- bookcase at 32633,32085,10
	{
		itemId = 2435,
		itemPos = { x = 32633, y = 32085, z = 10 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Notes about gharonk language

... On my second day here, I found out, that this language isn't that difficult to learn. The grammar seems to be a simplified but quite usual grammar. I try to find out some of the words. One day, after killing a lion, one of the inhabitants of the town returned, telling everyone: "Nag narat umog yargoth!" I tried to figure out, what the single words mean, but I had not enough time. Maybe I can do that later on...]] },
		},
	},
	-- bookcase at 32633,32087,10
	{
		itemId = 2435,
		itemPos = { x = 32633, y = 32087, z = 10 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
How to mix magical potions Potion of regained vision Drinking this will give you back the abilty to see for some time. It does not last too long... All you need is: a roll flour dough a rose a cherry. Put all these ingredients into a mug and heat it for 31 minutes. Speak out the words "nalus murtu" to finish the potion. Now drink it. You will see again - and you will be able to read this book! May the world become clearer!]] },
		},
	},
	-- bookcase at 32633,32089,10
	{
		itemId = 2435,
		itemPos = { x = 32633, y = 32089, z = 10 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
The Adventurer's Guide To The Dungeons.

Rope: A rope is a long thing in most cases. It is useful to climb up holes and to pull up heavy objects, such as dragons, empty potions or spiders. Sometimes, in special cases, it is used to pull up demons or giant spiders. A rope consists of many rat-tails tied together. Such a thing should not be missing in an adventurer's backpack!
It is not known, how it works in some cases - for example, no one found out until now, why one has to put a rope on the floor in order to climb UP a hole. Especially it is strange, that this rope does not get lost, but is found in the backpack of the adventurer again...]] },
		},
	},
	-- bookcase at 32633,32091,10
	{
		itemId = 2435,
		itemPos = { x = 32633, y = 32091, z = 10 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
The Adventurer's Guide To The Dungeons. Dragon: This is a well known species in our lands. Dragons once were very shy and there didn't exist many of them. And there's the paradox thing about it: Because they were hunted more and more, and more and more of them got killed, the dragons population increased! It's a very mysterious thing, that a species's population increases the more they are killed, but it's what happend with dragons... So the conclusion is obvious, that many monsters want human population to increase and therefore try to kill as many of them as possible!]] },
		},
	},
	-- bookcase at 32634,32083,10
	{
		itemId = 2436,
		itemPos = { x = 32634, y = 32083, z = 10 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Dangers of Adventures
by Netlios

Volume II

The adventurers, whom we will have a look at, were all born in different years and were therefore all of different ages when they started their travelings through Tibia. The oldest among these men was aged 42; the youngest was 38, when he started to discover new areas of our land. None the five was as old as anyone else of them. One journey ended after 83 days, one after 117 and finally one after 134 days. Anaso, one of the explorers, was a very brave sword-fighter. His brother Elaeus, who started an expedition just like his brother, never wanted to use a sword - instead he was an excellent magician. Hestus, another explorer whom i will tell about, always wore green trousers, so no-one saw how dirty it was and he never had to wash it.]] },
		},
	},
	-- bookcase at 32634,32085,10
	{
		itemId = 2436,
		itemPos = { x = 32634, y = 32085, z = 10 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Dangers of Adventures
by Netlios

Volume II

The adventurers, whom we will have a look at, were all born in different years and were therefore all of different ages when they started their travelings through Tibia. The oldest among these men was aged 42; the youngest was 38, when he started to discover new areas of our land. None the five was as old as anyone else of them. One journey ended after 83 days, one after 117 and finally one after 134 days. Anaso, one of the explorers, was a very brave sword-fighter. His brother Elaeus, who started an expedition just like his brother, never wanted to use a sword - instead he was an excellent magician. Hestus, another explorer whom i will tell about, always wore green trousers, so no-one saw how dirty it was and he never had to wash it.]] },
		},
	},
	-- bookcase at 32634,32087,10
	{
		itemId = 2436,
		itemPos = { x = 32634, y = 32087, z = 10 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Important facts from galactic history, number one (reproduced from the "Sideral Daily Mentioner's Book Of Popular Galactic History") The night-sky of the planet Krikkit is the least interesting sight in the entire universe.]] },
		},
	},
	-- bookcase at 32634,32089,10
	{
		itemId = 2436,
		itemPos = { x = 32634, y = 32089, z = 10 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
"On different Fluids, 2nd publication, part two"

by Arisophlus

I am not quite sure, but I suppose, this "beer" does not have human root. No one is able to produce it. Nevertheless, there are hundreds, thousands of potions arround this world? Where do they come from? Who is interested in drunken hunters? The answer is quite obvious: The demon! Beer is an invention of the demon!

There is another very mysterious fluid here in Tibia. People tend to call it "oil". I really don't know what to do with it. It smells strange; if you know how to put it on fire, it burns quite fine (it's not easy, but once it burns it is very hot!).

Avoid steping on a pool of oil - it's very slippery. That leads me to an idea: My watch doesn't work anymore since yesterday - maybe I should try to throw it in a glass filled with oil? If I succeed, I will write another book on this topic.

The last known brown fluid is "mud". It is a very familiar fluid; it doesn't smell, but it is dirty. I do not know, how this mud fits into our world, but it is just here. Nobody knows where it came from, nobody knows its use...]] },
		},
	},
	-- bookcase at 32634,32091,10
	{
		itemId = 2436,
		itemPos = { x = 32634, y = 32091, z = 10 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
Dangers of Adventures
by Netlios

Volume I

An adventure is an exciting thing to do. Nevertheless it might be rather dangerous,
one may even die during his journeys through the lands!
I wrote the following books in order to show the fates of 5 men who devoted themselves
to discover new parts of Tibia. Each of them was a brave warrior and a superior explorer
and they all went through exciting adventures. Their journeys were of different duration -
one ended after 66 days, another after 100 days. Each journey ended in a very dangerous
situation; one situation even ended deadly!]] },
		},
	},
	-- bookcase at 32635,32083,10
	{
		itemId = 2437,
		itemPos = { x = 32635, y = 32083, z = 10 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
How to mix magical potions

Potion of Silence

Do you have friends, who are nice but who can't stop talking and talking and talking....?
Make them stop it by drinking this potion!
The ingredients are as follows:
a dead spider
a potion of wine
a potion of beer
two cans of water
a piece of gold (silence is golden!)
an apple
and, of course,
a rapier to stir with
and finally a can to put it in.
You don't have to cook it (unless you want to serve it as a hot drink); you just need to cast: "Silentiam" on it.
Your friends will love the taste of this mixture, and they will be silent for a greater
amount of time. We suggest, that the reader himself does not drink this fluid, too.
Good luck and enjoy the silence!]] },
			{ itemId = 2826, -- book
				text = [[
Notes about gharonk language

... On the third day in this city, an adventurer came back from his travellings. He looked like he hadn't had something to drink for days; his cloth were dusty and full of sand. I can only guess, what happened to him or which places he visited during the last days.
As soon as I saw him (I was the first to find him - what a luck, what a honor! Without my help, I think he would have died of thirst!) I tried to communicate with him, but he always just repeated the words:
"Orzog! Nag Orzog! Atul! Atul! Nag mob mula! Atul!"
I didn't know, what he meant, but it wasn't of importance at this moment.
After giving him something to drink, he recovered quickly. Maybe I try to talk to him again tomorrow...]] },
		},
	},
	-- bookcase at 32635,32085,10
	{
		itemId = 2437,
		itemPos = { x = 32635, y = 32085, z = 10 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
"On different Fluids, 4th publication"
by Arisophlus

Next, I will write about pink fluids. There are two kinds of pink fluids: wine and mysterious mana-regenerating fluid. What I told before about beer is exactly the same for wine. The other pink fluid seems to be very magical. Some people are able to produce this liquid; what a pity, all of these people sell it for horrendous prices!]] },
		},
	},
	-- bookcase at 32635,32087,10
	{
		itemId = 2437,
		itemPos = { x = 32635, y = 32087, z = 10 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
On the game "tibiaball".

Here are some secret rules you should consider when you think about playing a match.

1. Grow at least three extra legs. You won't need them, but it keeps the crowds amused.
2. Find one good Brockian Ultra-Cricked player. Clone him a few times. This saves an enormous amount of tendious selection and training.
3. Put your team and the opposite team in a large field and build a high wall around them.
(The reason for this is that, although the game is a major spectator sport, the frustration experienced by the audience at not actually being able to see what's going on leads them to imagine that it's just a lot more exciting than it really is. A crowed that has just watched a rather humdrum game experiences far less life-affirmation than a crowd that believes it has just missed the most dramatic event in sporting history.
4. Throw lots of assorted equipment over the wall for the players. Anything will do -- cricket bats, basecube bats, tennis rackets, skis, anything you can get a good swing with.
5. The players should now lay about themselves for all they are worth with whatever they find to hand.
Whenever a player scores a 'hit' on another player he should immediately run away and apologize from a save distance. Apologies should be concise, sincere, and, for maximum clarity and points, delivered through a megaphone.
6. The winning team should be the first team that wins.]] },
		},
	},
	-- bookcase at 32635,32089,10
	{
		itemId = 2437,
		itemPos = { x = 32635, y = 32089, z = 10 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
"On different Fluids, 3rd publication"
by Arisophlus

The most common fluid is water. It's a blue and opaque, you can't miss it. you can drink it, usualy it does not have any affections on the human body, but if the water comes from a very special place it is said to have healing powers!]] },
			{ itemId = 2828, -- book
				text = [[
How to mix magical potions

Potion of Flight

Drink this potion and fly like a bird! All you need is listed below:
two wings of a wasp
an eye of a dead body
a rope
a potion of lemonade
a watch
and, of course,
a rapier to stir with
and finally a pot to cook in it.
Put all things except the watch into the pot and cook it for 24 minutes. Cast the spell "Flifli Bor" on it and drink it.
Don't forget to have an eye at the time! This fluid lasts for 12 minutes.
Once the time is over, you are not able to fly anymore... you'll fall down like a stone.
Therefore, never forget the time and always wear a watch when using the "potion of flight"!
Good luck and may the birds be with you!]] },
		},
	},
	-- bookcase at 32635,32091,10
	{
		itemId = 2437,
		itemPos = { x = 32635, y = 32091, z = 10 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
About strange mechanisms

In the last few years, people began to use strange mechanisms to do different kinds of things. For example it is popular nowadays, to open or unlock doors by switches. However, there are different ways to realize such a switch, e.g. by using hydraulic pressure. Only a few persons have the knowledge to construct such switches.]] },
		},
	},
	-- bookcase at 32795,32369,10
	{
		itemId = 2439,
		itemPos = { x = 32795, y = 32369, z = 10 },
		contents = {
			{ itemId = 21378 }, -- torn log book
			{ itemId = 2816, -- book
				text = [[
....... set up the traps and hid the path to the vaults and the seven pits ...... dragons ..... undead ..... death to ..... they can never again retake .... vortexes of negative energy .....]] },
		},
	},
	-- bookcase at 32795,32370,10
	{
		itemId = 2439,
		itemPos = { x = 32795, y = 32370, z = 10 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Know this traveller:
Before you rest, you
have to find the place
where you can open
the path.]] },
		},
	},
	-- bookcase at 32795,32371,10
	{
		itemId = 2440,
		itemPos = { x = 32795, y = 32371, z = 10 },
		contents = {
			{ itemId = 21378 }, -- torn log book
			{ itemId = 21378 }, -- torn log book
			{ itemId = 2816, -- book
				text = [[
... figure out who built the Shrine of Wonders. It seems older than anything else here and has powerful protection against evil .... those holding a Tible ca...]] },
		},
	},
	-- bookcase at 32985,32399,10
	{
		itemId = 2439,
		itemPos = { x = 32985, y = 32399, z = 10 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
Encyclopedia Necronomica, Mor-Ti
Morbid - Titillation]] },
		},
	},
	-- bookcase at 32985,32400,10
	{
		itemId = 2438,
		itemPos = { x = 32985, y = 32400, z = 10 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
Encyclopedia Necronomica, Ab-Er
Aberration - Error
Abnormal
Abraxys]] },
		},
	},
	-- bookcase at 32985,32403,10
	{
		itemId = 2438,
		itemPos = { x = 32985, y = 32403, z = 10 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
Anatomical Chart of the Human Body

(The paintings in this book are of such macabre detail that you slam it shut after a horrified glance.)]] },
			{ itemId = 2819, -- parchment
				text = [[
Tableau of the constellations of the stars and planets

(A long spreadsheet, closely written with numbers and unfamiliar names.)]] },
		},
	},
	-- bookcase at 32985,32404,10
	{
		itemId = 2438,
		itemPos = { x = 32985, y = 32404, z = 10 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
Study trips to Ankrahmun, by Imdi Joons]] },
			{ itemId = 2824, -- book
				text = [[
Historic Sites underneath the Plains of Havoc, by Imdi Joons]] },
		},
	},
	-- bookcase at 32985,32406,10
	{
		itemId = 2439,
		itemPos = { x = 32985, y = 32406, z = 10 },
		contents = {
			{ itemId = 2826, -- book
				text = [[
Relics of unholy power, an archeological expedition, by Imdi Joons]] },
			{ itemId = 2821, -- book
				text = [[
Incantations of the Dead, Dark Rituals and Danses Macabres, by Arch Priestess Lenora Ovarra]] },
		},
	},
	-- bookcase at 32985,32408,10
	{
		itemId = 2438,
		itemPos = { x = 32985, y = 32408, z = 10 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
From the Annals of the Priestess of the Dark Lands: Rats are the Dark Lord's most favoured pets. These holy dark creatures must not be touched upon lest we incur the wrath of the Dark Lord. Sisters, do not let unholy creatures touch upon these, and always perform the Rites of Midnight, Blood Chains and Skull Music at their specified times.]] },
			{ itemId = 2826, -- book
				text = [[
On the Practical Use of Ouiya planes, atmospheric bells and wind chimes to summon ghosts, by Achirro de Alba]] },
		},
	},
	-- bookcase at 32985,32410,10
	{
		itemId = 2439,
		itemPos = { x = 32985, y = 32410, z = 10 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
(This book looks like a torn diary. Most pages are torn out, the whole document is blotched and stained, as though through fire, blood and gore. Only a page from an early chapter is still legible, but large spaces are blotted out by diverse stains.)

 forays found Darashia to be fertile and full of animal life, even if a little hostile. Settlers were sent to establish a colony welcoming people of all cultures and beliefs, Drefia was wild with new and unheard-of ideas, and a haven for all sorts of strangers, wanderers, outcasts, all mingling
... especially in its first days constantly plagued and raided by nomads and barbarian hordes living in the surrounding wilderlands. The neighbouring Djinn in Darama proved to be
another substantial, and even graver, threat to the city  sworn to extinguish human life, but I believe that it is
 Now, it is rumoured that in order to defy and overcome this formidable enemy, the local government invited subjects of bad reputation come to the city some say they were n   began investigating all means of ending or prolonging life, studying 
 spying out the djinns.  Some say that secret, evil pacts were made with the djinns to grab the power over the city, but we cannot rely on
 still a young man when a morbid spell seemed to have been cast over the city, and the original families perished or vanished, one by one. I lost my. I decided to hunt down the cause of the mysterious . Revealed dangerous, but I persevered cult, blood is their fresh corpses underground, large premises were constantly need supplies of living
 Like a drawn-out death rattle, the city bled dry only the most obscure folk
Like the furtive figures I hunt, I stay and skulk in the onetime splendor of the wide palaces and high houses of my family now haunted by living dead and ghastly creatures that should not be named in daylight. I will end this, I

(Here the texts ends with a black stain)]] },
		},
	},
	-- bookcase at 32985,32411,10
	{
		itemId = 2440,
		itemPos = { x = 32985, y = 32411, z = 10 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
Places and times of power in the cycle of life and death]] },
		},
	},
	-- bookcase at 32985,32412,10
	{
		itemId = 2438,
		itemPos = { x = 32985, y = 32412, z = 10 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
On the Nature of the Undead, Vol. 1

Preface
There are several forms of the so-called "undead". Indeed, it is a most natural phenomenon, and we have to discern thusly between the natural undead, appearing out of a natural course, e.g., out of some supreme will inherent to the late inhabitant of our world of the living; and between the scientific method of inducing undeath , and creating undead through an outside, e.g. OUR, will. Of the natural undead, little use can be made, for they obey their own strong will and will not be bended or made to pursue more noble fashions after our own will; so the most noble art of a necromancer lies in besting the natural course, indeed, in perfectioning it, and in bringing back life in death, and creating able-bodied subjects to carry out the most noble purposes of our order.]] },
			{ itemId = 2824, -- book
				text = [[
On the Nature of the Undead, Vol. 2
Chapter 1
The first category, the natural undead like ghosts and vampires, having been breached upon in the first chapter, we will now proceed to discuss and classify the categories and uses of the technical undead.
The second category, that of the induced undead and practicable servants, is, at the moment, unfortunately still somewhat smaller, and it remains to unearth the undeathly secrets of practical necromancy by our most ingenious student corpus. Much still is to be explored in the realm of necromancy, and undoubtedly, future generations will bring more practical and skilled specimen to light. It remains the task of the excellent professoral body to already lay the foundations for this grand undertaking and helping science along.
To the category of the technical undead, we will count the following:
1. skeletons
2. lich
3. zombies
4. undead beasts of the animal persuasion
a) canines
b) felines
c) bats
5. Hybrids:
a) ghouls
b) mummies]] },
			{ itemId = 2825, -- book
				text = [[
On the Nature of the Undead, Vol. 1
Vol. I, Chapter 1
As I have said in my preface, we have to discern between two main categories of undead: the "natural" and the "technical" undead. The natural undead make up for most of the undead types; and we have but to wonder at the mean understanding of the outsiders to our art not seeing this. I will begin my dissertation with categorizing the undead, beginning with the natural undead in this first chapter, followed by a categorization of the technical undead in the second chapter. The means of resurrecting the undead will be studied and an ample introduction be given by my honoured colleague, professor rer. mort. Arrazul Alhazri in his book "An Initiation to Practical Necromancy".
Thus, to return to our study: the nature of the undead. The natural undead, like ghosts and vampires, are indeed abundant on this world. Many have been spotted in the different locations in Tibia, and all seem to pursue a singular goal, which they have been denied in life and which they therefore seek to achieve in undeath. As many of the lesser mortals that inhabit the lands of Tibia are not able to reach their goals in life, one must not wonder at the abundancy of the natural undead.
To the natural undead, we count the following specimen with their sub-classifications:
1. Ghosts:
a) spectres
b) spirits
c) phantasms
d) apparitions
2. banshees
3. reapers
4. vampires
a) vampire bats
b) vampire brides
c) vampire lords
5. Special consideration must be given to the hybrid classes:
a) lesser forms of demon spirits
b) Ghouls
c) mummies]] },
		},
	},
	-- bookcase at 32985,32413,10
	{
		itemId = 2439,
		itemPos = { x = 32985, y = 32413, z = 10 },
		contents = {
			{ itemId = 401, -- book
				text = [[
Blood - the vital essence, by Prof. Dr. Dr. Horr. Med. Noc. Tis. Sang.]] },
		},
	},
	-- bookcase at 32985,32414,10
	{
		itemId = 2438,
		itemPos = { x = 32985, y = 32414, z = 10 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
Body fluids and their uses, by Prof. Dr. Dr. Horr. Med. Noc. Tis. Sang.]] },
			{ itemId = 2829, -- book
				text = [[
Gods, demons and famous black magi - a reference guide]] },
		},
	},
	-- bookcase at 32992,32412,10
	{
		itemId = 2435,
		itemPos = { x = 32992, y = 32412, z = 10 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Incantation to summon Asdphodelic, the lesser two-headed Hound of the Night
(The symbols and words, imbued with dark meaning, writhe and dance before your eyes. Your eyes begin to water,  you have to close the book.)
]] },
		},
	},
	-- bookcase at 32993,32397,10
	{
		itemId = 2437,
		itemPos = { x = 32993, y = 32397, z = 10 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
1001 Recipes Against Sweaty Hands]] },
		},
	},
	-- bookcase at 32993,32412,10
	{
		itemId = 2435,
		itemPos = { x = 32993, y = 32412, z = 10 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
Incantations yesterday and tomorrow - a comparative study on the evolution of rituals]] },
		},
	},
	-- bookcase at 32995,32397,10
	{
		itemId = 2437,
		itemPos = { x = 32995, y = 32397, z = 10 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
1001 Recipes Against Sweaty Hands]] },
		},
	},
	-- bookcase at 32995,32405,10
	{
		itemId = 2435,
		itemPos = { x = 32995, y = 32405, z = 10 },
		contents = {
			{ itemId = 2824, -- book
				text = [[
Elements of Tibia and their alchemical order

(A  spreadsheet densely covered with strange symbols, numbers and signs that do not make any sense to you)
]] },
		},
	},
	-- bookcase at 32995,32412,10
	{
		itemId = 2436,
		itemPos = { x = 32995, y = 32412, z = 10 },
		contents = {
			{ itemId = 2817, -- blank parchment
				text = [[
Embalming fluid, chants and holy preparations required to guide the spirit to the next world and preserve his body in the intermediate world, by Rames-Seni  Osi-Atun-Ra-Heton, enlightened embalmer and humble servant of the Lord of the Seven Sandy Seas, may his spirit rule in the afterlife forever.]] },
			{ itemId = 2831, -- book
				text = [[
Mumification, a case study]] },
		},
	},
	-- bookcase at 32995,32420,10
	{
		itemId = 2435,
		itemPos = { x = 32995, y = 32420, z = 10 },
		contents = {
			{ itemId = 2819, -- parchment
				text = [[
Necromancy, a Philosophical Essay, by the Dark Brother Alonso de Iverra

Brothers, why does the ignorant world still consider death their enemy and end of life? It is not folly? Death is but the portal, not the end; it is but an artificial hindrance to ward off the lesser spirits from the realm of the mighty; and the gods put it up to prevent us Chosen from ascension to their own powers, and threaten their dominion. These shackles to our existence are unnatural; but it is natural to rebel and to seek power, yes, to gain power, to exert power! Brothers, we must overcome this hindrance set up by the jealous gods and claim our rightful place! We are the masters of the living and undead, the true lords of the created, and nothing shall stop us from achieving what we seek. 
]] },
		},
	},
	-- bookcase at 32996,32405,10
	{
		itemId = 2435,
		itemPos = { x = 32996, y = 32405, z = 10 },
		nth = 1, -- container number 1 with this id on the tile
		contents = {
			{ itemId = 2832, -- book
				text = [[
Pentagram-drawing, a beginner's guide

Required  items: 
magic chalk (charm it with the spell of spirit-binding first!)
Optional:
blood tincture for an incantation
5 human tallow candles
]] },
		},
	},
	-- bookcase at 32996,32405,10
	{
		itemId = 2435,
		itemPos = { x = 32996, y = 32405, z = 10 },
		nth = 2, -- container number 2 with this id on the tile
		contents = {
			{ itemId = 2832, -- book
				text = [[
Pentagram-drawing, a beginner's guide

Required items:
magic chalk (charm it with the spell of spirit-binding first!)
Optional:
blood tincture for an incantation
5 human tallow candles]] },
		},
	},
	-- chest at 32138,32103,11
	{
		itemId = 2472,
		itemPos = { x = 32138, y = 32103, z = 11 },
		contents = {
			{ itemId = 2816, -- book
				text = [[
5 5 5 5 2 charcha
5 burka
5 burka bata
2 batuk
5 1 aka bora 
3 tulak bora 
]] },
			{ itemId = 2816, -- book
				text = [[
taka arash ouk karak minotaur 
batash ferut ouk taka 
minotaur karakim kiskesh 
ORC BUTA BANA 
BUTA BANA]] },
			{ itemId = 2816, -- book
				text = [[
Omark ikem goshak ba batuk 
Booz karek utash gort mora 
ouk bota bana ikem]] },
		},
	},
	-- bookcase at 32170,31069,11
	{
		itemId = 2435,
		itemPos = { x = 32170, y = 31069, z = 11 },
		contents = {
			{ itemId = 2820, -- sheet of paper
				text = [[
Dear brother,
your additional resources have been granted. All resources of the cult are at your disposal to ensure the success of this critical operation.
Praised be the Triangle.]] },
			{ itemId = 2820, -- sheet of paper
				text = [[
Dear brother,
we are glad to hear that our plan was a success. On the other hand, considering how many resources of the cult this venture has taken, failure was not an option of course. The master will be pleased that you could take over the mines of these barbarians. The powers the master grant us make us invincible indeed. It's not surprising that you faced no retaliation of the barbarians. Their superstitions keep them from fighting for a place like the mines. Surprisingly that they took the effort to capture it in the first place. With the forces you already freed from the ice, you will be more than prepared for any attempt to retake the mines. However, keep a low profile there. We need a considerable army before we do anything. If the followers of good learn too early about our plans, everything would be put at stake. The master needs a great army, truly worth to fight for him and able to help him to fulfil his plan. Rest assured the master himself will see after you now and then, even if its just to keep all those demons in line. The lord of blades will soon unleash his anger upon the world and it will be us that raise out of the ashes of mankind as the rulers of a new age.
Praised be the Triangle.]] },
		},
	},
	-- bookcase at 32171,31069,11
	{
		itemId = 2436,
		itemPos = { x = 32171, y = 31069, z = 11 },
		contents = {
			{ itemId = 2820, -- sheet of paper
				text = [[
Dear brother,
we are not pleased about your progress. The reports about 'the ice working against you' are pathetic.
Don't disappoint our masters, I warn you. Instead of embattling a veritable army, you just freed some minor troops - by far not sufficient for the plans of our master. With the growing presence of Orshabaal in the realm of mankind, it is likely the seven will make their move soon. We must do everything to be faster. This army is pivotal for our success. For this reason you were chosen to lead the operation. However, everything you achieved in the past will mean nothing if you fail now. Make sure the lord of blades won't decide on his next visit that it is time for an ... extraordinary punishment.
Praised be the Triangle.]] },
		},
	},
	-- bookcase at 32172,31069,11
	{
		itemId = 2437,
		itemPos = { x = 32172, y = 31069, z = 11 },
		contents = {
			{ itemId = 2820, -- sheet of paper
				text = [[
Dear brother,
it's a good thing that you were able to build a base in the mountains. Don't worry, the passing of you and your followers did not raise too much suspicions. Our agents in Carlin made sure to distract all attention and whatever the barbarians in Svargrond might think is of no importance. We managed to acquire a ship which we will be sent with reinforcements to the meeting point, remote enough from all possible observers. I expect that the camp is prepared and the area scouted at the time our forces arrive. The master expects a swift and precise strike to take over the mines. The fools in Svargrond will probably not even notice the change there since they are busy to be wary of the other barbarians. Our agent in Svargrond will do what is possible to further divert any attention. As soon as the mines are taken you will begin to defrost our new allies. Make sure they learn whom they owe their freedom.
Praised be the Triangle.]] },
		},
	},
	-- bookcase at 32410,32772,11
	{
		itemId = 2435,
		itemPos = { x = 32410, y = 32772, z = 11 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The Animal Kings
In ancient times the Shattered Isles used to be one huge isle. A peaceful and highly advanced civilisation prospered there. With the help of magic and breeding, they refined the very essence of all creatures on the isle. So even the animals became incredibly healthy and practically perfect beings of their species. They even acquired some intelligence that improved from generation to generation. After a catastrophe that destroyed the whole island, only a few of those animals survived. Over the years, other animals added to these special creatures, and soon only a fraction of the animals still had the attributes of their ancestors.
These noble animals chose one of their kind as their king and with the knowledge of their ancestors they acquired immortality. Nowadays, those animal kings still live at remote places, though some of them might have left the isles for more hospitable areas.
If someone succeeds in catching one of them, he might learn their secret of immortality along with other secrets that were thought to be lost with the destruction of the isle.]] },
			{ itemId = 2821, -- book
				text = [[
The Demon Fiddler A legend tells about a man, a sinister traveller that booked a passage on a ship. In a stormy night he began to play a ghostly tune on his fiddle. The tune drove the helpless sailors into madness and forced them to sail their ship laughing on the next reef. The traveller though had vanished.]] },
			{ itemId = 2826, -- book
				text = [[
The Fire Walkers
On one of the isles I witnessed an utmost unusual occurrence. The natives gathered to some festivity. After some singing, dancing and drinking, they started to jump through some of the bonfires. They started screaming insanely and then started to walk over glowing logs of wood. I am wondering if this has something to do with the stuff they are drinking. It would be interesting to see if it can be used to cross lava streams.]] },
			{ itemId = 2824, -- book
				text = [[
The flying Venorean is a ship that is cursed to sail the seas forever. Allowed to visit land only every seven years, the ghostly captain uses his shore leave to lure clueless sailors into his crew. Everybody that signs the contract becomes cursed like the captain and might only leave the ship if he finds a suitable exchange on one of his shore leaves every seven years.]] },
			{ itemId = 2821, -- book
				text = [[
The Ghost Ship]] },
			{ itemId = 2826, -- book
				text = [[
The Great Sea Serpents

The Sea Serpent is as huge as a house and can swallow a small ship in one bite. Its scales are almost impenetrable and its teeth, which are as big as a cyclops, are coated with a corrosive poison that will dissolve human flesh on touch. In their undersea lairs they hoard treasures that would make a dragons hoard look miserable.]] },
		},
	},
	-- bookcase at 32412,32772,11
	{
		itemId = 2436,
		itemPos = { x = 32412, y = 32772, z = 11 },
		contents = {
			{ itemId = 401, -- book
				text = [[
The Klabautermen
The klabautermen are a race of impish, mischievous beings that live on ships. Using invisibility and other magic, they remain unseen most of the time. But be warned, if you antagonise the klabauterman of a ship, his harmless pranks will turn dangerous.
In general it is a smart move to keep your klabauterman happy with little presents
and a lot of rum.]] },
			{ itemId = 2829, -- book
				text = [[
The Lighthouse in the Middle of Nowhere
Sailors claim to have travelled as far as the end of the world where the water pours down into nothingness. Although it is easily recognizable during daylight it poses a special threat at night. To make matters worse, a spooky lighthouse sometimes appears out of nowhere to lure ships over the edge of the world. Whether it is really a lighthouse or some other source of light differs from story to story and remains to be determined.]] },
			{ itemId = 2829, -- book
				text = [[
The maze of the lost souls

Centuries ago, our ancients build this maze to protect our city Demona from bandits and warriors.
With the help of our loyal trolls they finished this giant maze within 1 month!

This maze has been protecting us for centuries and we hope that it will be the same for many following centuries too.]] },
			{ itemId = 2826, -- book
				text = [[
As long as the four guardians are alive, the door that leads to the inner sanctum won't open. Only the blood of the guardians opens the lock. The crucial point is to locate the guardians. They are hidden at spots where no one would suspect them, disguised as ordinary creatures that inhabit this world. The Eye of Xandalos might be of help to locate and identify them.
If close enough to the guardians, it works like the "find person" spell. Considering the cost of its usage, it is out of question to use it without further thought. The construction of an Eye of Xandalos is an entirely other issue though.]] },
			{ itemId = 2824, -- book
				text = [[
The Shattered Isles

Nargor is a hostile rock surrounded by treacherous reefs. Since it is uninhabitable and almost unreachable it is of no interest.

Treasure Island is not only desert-like but also quite deserted. The only people you meet are treasure hunters that travel there occasionally to try their luck.

The inhabitants of the town Liberty Bay live on the numerous plantations. The town has developed into a major trading center in recent years, and is under Thaian rule.

The Forbidden Islands to the north-west are dangerous not only because of the volcanoes that are found there but also due to frequent quara activity. Since there is no real reason to visit these islands, no regular shipping route was ever established.

The Laguna Islands are quite often visited by passing ships to refresh their supply of water and food. Still the isles are too desolate to establish a settlement there. It is rumored that a small tribe of savages calls one of the isles its home.]] },
		},
	},
	-- dead human at 32661,32120,11
	{
		itemId = 4240,
		itemPos = { x = 32661, y = 32120, z = 11 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
On Netlios VI books about adventurers

I think Netlios is a liar. I followed all tips given by him in his books, but i didn't become a great adventurer.
I really don't know what to do - but I think, becoming a farmer instead of an adventurer is a good choice. Sheeps are not as dangerous as dragons are, and it's better to drink a glass of milk than a glass of green slime!
Maybe it would help to find the last two parts of "Dangers of Adventures", because i only read the first four parts... the others are vanished a long time ago... if I could only find them, but how should I without being an adventurer? I need the books to be an adventurer, and to get the books, I need to be an adventurer!
Being a farmer is really better for my nerves...]] },
		},
	},
	-- dead human at 32797,32334,11
	{
		itemId = 4247,
		itemPos = { x = 32797, y = 32334, z = 11 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
All is lost!
Porgol assassinated my beloved husband. I could flee him here using my secret knowledge of the entrance. The lever is crusted with rust and does not work, but if I return Porgol's undead will rip me into pieces. May the gods forgive me, what I will do now. At least I will be reunited with Arcian soon.]] },
		},
	},
	-- bookcase at 32992,32443,11
	{
		itemId = 6367,
		itemPos = { x = 32992, y = 32443, z = 11 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
Phases of the Moon and their Influences on Living Organisms, by Dark Priestess Antirra Grayhound.]] },
			{ itemId = 637, -- document
				text = [[
Though it is very subtly done, I am being observed, I know it. I know whom to suspect, as well, and he will pay for this. He and his gang! This aberration in our ranks must stop. However, still all is proceeding as planned. The new projects develop well, and when I have finished my plans for... (the text ends suddenly)]] },
			{ itemId = 2832, -- book
				text = [[
The Means of Renewable Youth. Fact and Fiction.]] },
		},
	},
	-- bookcase at 32996,32450,11
	{
		itemId = 6368,
		itemPos = { x = 32996, y = 32450, z = 11 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
Research on the various Disorders of the Heart]] },
		},
	},
	-- bookcase at 32997,32450,11
	{
		itemId = 6368,
		itemPos = { x = 32997, y = 32450, z = 11 },
		contents = {
			{ itemId = 2829, -- book
				text = [[
On the Nervous System.]] },
			{ itemId = 2828, -- book
				text = [[
Channeling Lightning and Other Natural Magic]] },
		},
	},
	-- seashell bookcase at 33445,31174,11
	{
		itemId = 14066,
		itemPos = { x = 33445, y = 31174, z = 11 },
		contents = {
			{ itemId = 14016, -- seashell book
				text = [[
~-"+, )^|J-| "J^° LO"

-( <OB-J LO J-L "J^ )O"~^+L J-L B^C J^B+L J-L LO" J|"J^ -" J-L =(^L LO ~-"+, )^|J-| "J^° -( J-L JC>" LO B^C J^B+L )JOC, +C (O")-| JL(| CUL- 8(|-° BOC" +C (C8J- J-L UOL, +O(+ LO BOQOL" -" (OC)JOL <- J-L J^(O| JL(|° +C >O(UOL J-L +U-|J CL ~OJ^( J-L B^C J^B+L° J-\ (\ LO "^ CU ^BJ^+ ~-"+, )^|J-| "J^°]] },
			{ itemId = 14014, -- seashell book
				text = [[
The Swimmer Part I
Translation from 'Jekhr' (language of the Deeplings)
By Lagatos, Chronicler and Scholar

And when the Swimmer reached the bottom of the sea, he was enlightened by the beauty of the deep. The lively cities of the Deeplings greeted him from the bosom of the ocean. Drowning in colour and light, the Swimmer reached the sea's moist bed, surrounded by guardians of the deep. But their welcome was of little warmth. They did not see a foreigner nor a stranger, not a visitor but a threat.]] },
		},
	},
	-- seashell bookcase at 33446,31174,11
	{
		itemId = 14067,
		itemPos = { x = 33446, y = 31174, z = 11 },
		contents = {
			{ itemId = 14014, -- seashell book
				text = [[
The Deepling Language, Volume I: Basics
By Lagatos, Chronicler and Scholar

To begin studying the language of the deep, one should start with learning the characters and practice basic vocabulary. The first volume of this work will address the former.

Alphabet of the Njey

A ^
B V
C <
D )
E -
F =
G 8
H T
I |
J J
K X
L (
M W
N "
O O
P ]
Q Q
R B
S ~
T L
U C
V >
W U
X +
Y \
Z /

Fullstop/Exclamation Mark = °
Question Mark = :

Note that when spoken aloud, a 'T' (as in 'h' or 'H') will be pronounced 'aa'. It is only pronounced 'h' if at the beginning of a word. The word 'jakhn' (to destroy/destruction) will be pronounced: "jakaan"]] },
		},
	},
	-- seashell bookcase at 33449,31174,11
	{
		itemId = 14066,
		itemPos = { x = 33449, y = 31174, z = 11 },
		contents = {
			{ itemId = 14016, -- seashell book
				text = [[
The Deepling Language, Volume II: Exercises
By Lagatos, Chronicler and Scholar

Exercises, Chapter II: Advanced Vocabulary 1

boil/boiling=jaloi
by=ce
carcass/cadaver=kolk
dawn=flah
embrace=donsakh
ever=teth
flame=jalan
gift=jinja
ground=moh
herald/heralded=sojal
into=umte
invasor=daijei
nonbeliever/not obeying=roqohn
pave/paved=bolmoh
swallow=loudjou
tide=jubn
touch/touched=lugje
turn/turned=londei
way=kweij
were=en
where/wherever=roun]] },
			{ itemId = 14015, -- seashell book
				text = [[
TO" (T "^ QOT": QJ-((°
TO" "^ J-\: QJ-((°
QJ-(( VCBO" =|-°]] },
		},
	},
	-- seashell bookcase at 33451,31174,11
	{
		itemId = 14067,
		itemPos = { x = 33451, y = 31174, z = 11 },
		contents = {
			{ itemId = 14015, -- seashell book
				text = [[
The Swimmer Part II
Translation from 'Jekhr' (language of the Deeplings)
By Lagatos, Chronicler and Scholar

Held captive for two lifetimes he became one with the stone and coral that bound him. He longed for the world above. Wandering the skies again in broad daylight. Roaming the deserts, mountains and vast plains of the world like he used to. Floating a drop above the rain and dodging beams of the twin suns, he would embrace the disembodied freedom of his true self.

He was a spirit and a ghost. His soul moved into the very walls and fences of every house and court. Claiming the very foundations of this watery city as his own.

The Swimmer now lingers in shadowy corners, damp and dark and hollow. Chasing flickers of light touching the ground like a cat born of fog. When the creatures of the deep fell for the first visitor, he mourned the loss of the good in their souls. When the colour finally fled from its last enclave, he longed for redemption.

What is left of the light once brought to us, what remains of the fires once thriving us, it is he.]] },
		},
	},
	-- seashell bookcase at 33452,31174,11
	{
		itemId = 14068,
		itemPos = { x = 33452, y = 31174, z = 11 },
		contents = {
			{ itemId = 14015, -- seashell book
				text = [[
CL QJ-(( =OB=^| "J^° CL QJ-(( WOLOW J-T 8OCLT"° CL QJ-(( VCB J-T =|-° (OBXC(T CW VBOX° CL QJ-(( XBCW <|-° J-T B^C J^BXT -" BO==°

Rough English Translation:
AND QJELL ASCEND DEEP! AND QJELL WALK THE SURFACE! AND QJELL BRING THE LIGHT! PERSERVERANCE IN DEATH! AND QJELL WILL RISE! THE SECOND COMING IS HAND!]] },
		},
	},
	-- seashell bookcase at 33455,31174,11
	{
		itemId = 14067,
		itemPos = { x = 33455, y = 31174, z = 11 },
		contents = {
			{ itemId = 14014, -- seashell book
				text = [[
~-"+, )^|J-| "J^° B^C

^=^B J-\ +CL L-LO" 8|LL"° J^(8| J-\ +CL LOC"LL CL 8(|-° LO" -"|J-" >^\( CU ^BJ^+° +C O(J-"L J-\O" 8BCU LO J-)O B-\+L" QJ-((° +C -" J-)O "^++ CU J-L =^OL|° L|)OB LO OB)-B CL BC"JL° LO>^J +-"L CL "C|J^" J-L O~+|J^L°]] },
		},
	},
	-- seashell bookcase at 33456,31174,11
	{
		itemId = 14066,
		itemPos = { x = 33456, y = 31174, z = 11 },
		contents = {
			{ itemId = 14016, -- seashell book
				text = [[
~O(-~L-T°

<OB-J J^BXT TO 8OC° J-T 8OCLT" J^BXT CW )|>|)-J° J-\ JC( XC (T° XC -" VCT-(° CL QJ-(( ~O(-~L-T°]] },
		},
	},
	-- seashell bookcase at 33457,31174,11
	{
		itemId = 14068,
		itemPos = { x = 33457, y = 31174, z = 11 },
		contents = {
			{ itemId = 14016, -- seashell book
				text = [[
~-"+, )^|J-| "J^° LO"

-( <OB-J LO J-L "J^ )O"~^+L J-L B^C J^B+L J-L LO" J|"J^ -" J-L =(^L LO ~-"+, )^|J-| "J^° -( J-L JC>" LO B^C J^B+L )JOC, +C (O")-| JL(| CUL- 8(|-° BOC" +C (C8J- J-L UOL, +O(+ LO BOQOL" -" (OC)JOL <- J-L J^(O| JL(|° +C >O(UOL J-L +U-|J CL ~OJ^( J-L B^C J^B+L° J-\ (\ LO "^ CU ^BJ^+ ~-"+, )^|J-| "J^°]] },
		},
	},
	-- seashell bookcase at 33461,31174,11
	{
		itemId = 14068,
		itemPos = { x = 33461, y = 31174, z = 11 },
		contents = {
			{ itemId = 14014, -- seashell book
				text = [[
The Swimmer Part I
Translation from 'Jekhr' (language of the Deeplings)
By Lagatos, Chronicler and Scholar

And when the Swimmer reached the bottom of the sea, he was enlightened by the beauty of the deep. The lively cities of the Deeplings greeted him from the bosom of the ocean. Drowning in colour and light, the Swimmer reached the sea's moist bed, surrounded by guardians of the deep. But their welcome was of little warmth. They did not see a foreigner nor a stranger, not a visitor but a threat.]] },
		},
	},
	-- seashell bookcase at 33462,31174,11
	{
		itemId = 14067,
		itemPos = { x = 33462, y = 31174, z = 11 },
		contents = {
			{ itemId = 14014, -- seashell book
				text = [[
L^"J|~ L^"^XX TO "J^ CL QJ-(( ^=^B°
OVCJO~ OVC TO "J^ CL QJ-(( (T"J-|°
J^C( J^C TO "J^ CL QJ-(( ~O(-~L-T°]] },
		},
	},
	-- seashell bookcase at 33470,31174,11
	{
		itemId = 14067,
		itemPos = { x = 33470, y = 31174, z = 11 },
		contents = {
			{ itemId = 14016, -- seashell book
				text = [[
The Drowned Library
Personal notes of Lagatos, Chronicler and Scholar

The once bright centre of the Deepling community has been given up ever since the days of the Second Coming. After their leaders were convinced that their future lied above sea level, more and more of them stopped maintaining the archives and tending for the books. With the Deeplings rallying for war, the great halls of the library were soon abandoned. The culture of these creatures is complex enough to produce a significant amount of literature. I have found several works about sea animals, food, architecture and even early philosophical theories. However, progression of the Deepling culture in this direction has long been abandoned in favour of war preparations or social oppression of lower castes.]] },
		},
	},
	-- seashell bookcase at 33473,31174,11
	{
		itemId = 14066,
		itemPos = { x = 33473, y = 31174, z = 11 },
		contents = {
			{ itemId = 14014, -- seashell book
				text = [[
The Swimmer Part II
Translation from 'Jekhr' (language of the Deeplings)
By Lagatos, Chronicler and Scholar

Held captive for two lifetimes he became one with the stone and coral that bound him. He longed for the world above. Wandering the skies again in broad daylight. Roaming the deserts, mountains and vast plains of the world like he used to. Floating a drop above the rain and dodging beams of the twin suns, he would embrace the disembodied freedom of his true self.

He was a spirit and a ghost. His soul moved into the very walls and fences of every house and court. Claiming the very foundations of this watery city as his own.

The Swimmer now lingers in shadowy corners, damp and dark and hollow. Chasing flickers of light touching the ground like a cat born of fog. When the creatures of the deep fell for the first visitor, he mourned the loss of the good in their souls. When the colour finally fled from its last enclave, he longed for redemption.

What is left of the light once brought to us, what remains of the fires once thriving us, it is he.]] },
		},
	},
	-- seashell bookcase at 33475,31174,11
	{
		itemId = 14068,
		itemPos = { x = 33475, y = 31174, z = 11 },
		contents = {
			{ itemId = 14015, -- seashell book
				text = [[
The Deepling Language, Volume II: Exercises
By Lagatos, Chronicler and Scholar

Exercises, Chapter II: Advanced Vocabulary 2

all=jeyon
avenge/avenging/avenger=nuijan
balance=runjh
battle=arjak
blind/blinding=jalgi
courage=hounth
dark=faoti
defy/defies=oljent
enemy/enemies=grum
fallen=oskijah
fame=glie
gaze=githn
god-king=reykhn
keeper=hidor
master=bayl
order=qna
our=jedo
repulse/repulsing=tobaj
strike/struck=djou
solitary=tehon
supreme=enijen
to=dh
weapon=nakk
with=kut]] },
		},
	},
	-- seashell bookcase at 33480,31174,11
	{
		itemId = 14067,
		itemPos = { x = 33480, y = 31174, z = 11 },
		contents = {
			{ itemId = 14015, -- seashell book
				text = [[
The Deepling Language, Volume II: Exercises
By Lagatos, Chronicler and Scholar

Exercises, Chapter II: Advanced Vocabulary 1

boil/boiling=jaloi
by=ce
carcass/cadaver=kolk
dawn=flah
embrace=donsakh
ever=teth
flame=jalan
gift=jinja
ground=moh
herald/heralded=sojal
into=umte
invasor=daijei
nonbeliever/not obeying=roqohn
pave/paved=bolmoh
swallow=loudjou
tide=jubn
touch/touched=lugje
turn/turned=londei
way=kweij
were=en
where/wherever=roun]] },
		},
	},
	-- seashell bookcase at 33481,31174,11
	{
		itemId = 14068,
		itemPos = { x = 33481, y = 31174, z = 11 },
		contents = {
			{ itemId = 14015, -- seashell book
				text = [[
~-"+, )^|J-| "J^° B^C

^=^B J-\ +CL L-LO" 8|LL"° J^(8| J-\ +CL LOC"LL CL 8(|-° LO" -"|J-" >^\( CU ^BJ^+° +C O(J-"L J-\O" 8BCU LO J-)O B-\+L" QJ-((° +C -" J-)O "^++ CU J-L =^OL|° L|)OB LO OB)-B CL BC"JL° LO>^J +-"L CL "C|J^" J-L O~+|J^L°]] },
		},
	},
	-- bookcase at 33636,32035,11
	{
		itemId = 2435,
		itemPos = { x = 33636, y = 32035, z = 11 },
		contents = {
			{ itemId = 2819, -- parchment
				text = [[
My esteemed colleague,

we are very pleased to hear that your activities near Rathleton are flourishing. To be honest, at first we were more than suspicious as we learned that you are hiring a gang of criminals and have them do the more inconvenient tasks for you. But seemingly you are able to keep away from them the important information about your actual goals and intentions. Furthermore your succes in establishing a makeshift laboratory in the tunnels under Rathleton and even acquiring some novel glooth based weaponry speaks for itself. The mutated glooth you mentioned in your last letter is an interesting matter. Perhaps it is useable in an arcane way to enhance spells or improve potions. Even the creation of yet unknown artefacts could be possible. We think your endeavours are taking a good path.

With best regards
Uquora the High-Handed of the Circle of the Black Sphinx]] },
		},
	},
	-- dead human at 32354,32153,12
	{
		itemId = 4240,
		itemPos = { x = 32354, y = 32153, z = 12 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
I won't manage to climb up the hole, because my legs are broken. But I hope someone will read this. While the rotworms were asleep, I searched the ground to find something of value. And suddenly I stepped on a hidden button. A trapdoor slided open and I felt to the floor. And so I'm sitting injured at this corner waiting for help.

I write this because I think that I must die now. A dim light comes up this tunnel. And I hear loud noise.

Oh my god, I can't ...

(The book is full of green slime)]] },
		},
	},
	-- basket at 32397,31708,12
	{
		itemId = 2855,
		itemPos = { x = 32397, y = 31708, z = 12 },
		contents = {
			{ itemId = 2815, -- scroll
				text = [[
Play a flute to master the snakes.]] },
		},
	},
	-- dead human at 32627,32118,12
	{
		itemId = 4240,
		itemPos = { x = 32627, y = 32118, z = 12 },
		contents = {
			{ itemId = 2841, -- book
				text = [[
Diary of Morrin

It seems, I found the entrance to the library. Unfortunately the door is closed, but somehow i have to get in. I searched around, but everyone I met claimed he hasn't got the key... I believe this guy with the red shoes and the blue trousers, who eats rolls with ham all day long, has it; he seems suspicious to me... he didn't seem to trust me, and I think, that is the reason why I didn't get the key. Maybe somehow I can show him, that he can trust me...

YEAH! I got it! I got the key to the library, and I hope, I can find a solution for my problems there! Somehow I convinced the old man to trust me, and finally we were real good friends! What a pity, I had to leave the library before dawn...]] },
		},
	},
	-- dead human at 32654,32121,12
	{
		itemId = 4240,
		itemPos = { x = 32654, y = 32121, z = 12 },
		contents = {
			{ itemId = 2814, -- parchment
				text = [[
Seems I can't get up the stairs, because I broke my leg. Even worse a scorpion has stung me and I feel my strength failing me. What have I done to deserve this? What?]] },
		},
	},
	-- dead human at 32824,32239,12
	{
		itemId = 4240,
		itemPos = { x = 32824, y = 32239, z = 12 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
We failed!!!
We thought us lucky, that we had not to fight the ruthless seven face to face, but their traps and minions killed nearly all knights of our squad. We made it not even to one of the thrones. I will send the survivors to one of our remaining castles to save the key. I ordered them to let me die here in dishonor, since i failed my order!

Taciror,
the last highlord of the nightmare knights.]] },
		},
	},
	-- bookcase at 33070,32442,12
	{
		itemId = 2438,
		itemPos = { x = 33070, y = 32442, z = 12 },
		contents = {
			{ itemId = 2827, -- book
				text = [[
The Fountain of Youth. An excursion, by Imdi Joons.]] },
		},
	},
	-- seashell bookcase at 33447,31196,12
	{
		itemId = 14069,
		itemPos = { x = 33447, y = 31196, z = 12 },
		contents = {
			{ itemId = 14015, -- seashell book
				text = [[
The Book of Qjell, The Second Coming

Edition II, Translation from 'Jekhr' (language of the Deeplings)
By Lagatos, Chronicler and Scholar

Note: The texts I discovered that deal with the time after the First Coming seem to be in a younger tongue and written entirely different from the older works. The newer passages are more like chants to be recited and memorised.

And Qjell rose and brought light.
And Qjell conquered and became light.
And we awaited the return of our God King Qjell.
And in the darkest of nights,
in the twin sun's nadir,
their touch fading from the ocean's bed,
He returned.

This time shall be known as the Second Coming.

And Qjell spread word of the light.
And Qjell pointed upward beyond.
And Qjell united us to obey.
And Qjell marched onward.
And follow we will.]] },
		},
	},
	-- dead human at 33564,32020,12
	{
		itemId = 4240,
		itemPos = { x = 33564, y = 32020, z = 12 },
		contents = {
			{ itemId = 641, -- piece of paper
				text = [[
I discovered a buried temple or shrine, that must once have been part of a much bigger complex. I don't know what ancient culture could have built this nor whether it was a sanctuary, palace or something completely different. The main part of these ruins is a small place, accurately built of black and white tiles. In the centre is a big black stone figure, surrounded by four different statues. Each of them has an inscription, which gives a hint on what the statue wishes. I assume if one can fulfil all four wishes, something will happen, yet I don't know what this 'something' could be. I also noticed that the inscription on one of the statues became unreadable over time. Based on an old legend I assume, the last request could be: 'Adorn me.']] },
		},
	},
	-- bookcase at 33578,31859,12
	{
		itemId = 6370,
		itemPos = { x = 33578, y = 31859, z = 12 },
		contents = {
			{ itemId = 2832, -- book
				text = [[
Runes and Spells, an Introduction for the Practical Mage. By Professor Mordecai Stanton.]] },
			{ itemId = 2821, -- book
				text = [[
The Uses and Possibilities of Glooth - by Dr Henry Merlay]] },
			{ itemId = 2827, -- book
				text = [[
A Short Introduction to the Foundations and Principles of Slime Science, by Baribar Glooth]] },
		},
	},
	-- bookcase at 33579,31859,12
	{
		itemId = 6370,
		itemPos = { x = 33579, y = 31859, z = 12 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The elements and their impact on the manipulation of glooth, by Robert Macrenelle.]] },
			{ itemId = 2821, -- book
				text = [[
Satirical notes on the hierarchy and traditions of Oramond and Rathleton, by Rodoy F.]] },
			{ itemId = 2822, -- map
				text = [[
Map of the old sewers of Rathleton, by Jules Fortescue]] },
		},
	},
	-- bookcase at 33580,31859,12
	{
		itemId = 6370,
		itemPos = { x = 33580, y = 31859, z = 12 },
		contents = {
			{ itemId = 401, -- book
				text = [[
The Rare Fauna and Flora of Oramond, Vol. III, by Alaistar Stanton.]] },
			{ itemId = 641, -- piece of paper
				text = [[
Salves and balms for inflammation of the skin, druidic soothing rites and meditational music, by Azalea of the Red Root.]] },
		},
	},
	-- chest at 32038,32121,13
	{
		itemId = 2472,
		itemPos = { x = 32038, y = 32121, z = 13 },
		contents = {
			{ itemId = 3506, -- stamped letter
				text = [[
Treasure of Captain Iglue]] },
			{ itemId = 3579, count = 4 }, -- salmon
			{ itemId = 3579, count = 4 }, -- salmon
			{ itemId = 3579, count = 4 }, -- salmon
		},
	},
	-- drawers at 32658,31852,13
	{
		itemId = 2433,
		itemPos = { x = 32658, y = 31852, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Dear diary,
my son Kruzak is constantly nagging me to resign as emperor and pass the leadership to him. What does this youngster of a few hundreds years think?
I rather shave my beard then to step back!]] },
		},
	},
	-- bookcase at 32779,31684,13
	{
		itemId = 2438,
		itemPos = { x = 32779, y = 31684, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
956151353478019288952160199364672431427894315191186512819118003561
147261164671364646121978585765197292197278167054671180014015255175
191180189445]] },
			{ itemId = 2821, -- book
				text = [[
229534527446472611451451948561145190830457651228217735084348562847
70908895243485611216480065]] },
			{ itemId = 2821, -- book
				text = [[
867563561145191991180036468895219911036512889672127788943887215128
895219618003114572785726118576421970968057963661252757058452176521
972783046487651595646114145198899751121615180]] },
		},
	},
	-- bookcase at 32779,31685,13
	{
		itemId = 2439,
		itemPos = { x = 32779, y = 31685, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
781670512164800658611431288950036249684756019965855064996704672611
458003690422046484519118895219771288952195945765523646721191180035
75765460]] },
			{ itemId = 2821, -- book
				text = [[
945765599670467261145805121648006586114312889500362496847560190323
646721191781219771288952195180035757654606709658550646904220464845
19118895]] },
		},
	},
	-- bookcase at 32779,31688,13
	{
		itemId = 2439,
		itemPos = { x = 32779, y = 31688, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
275857651972788943887215128895219618003114572785726118576421970968
057963661252757058452176521972783046487651595646114145198899751121
615180059537243485625108114636467243534515860421585774454519045042
159561513534780192889521601993646724314278943151911865128191180035
611472611]] },
			{ itemId = 2821, -- book
				text = [[
304648435345158604215765159564619018655953724348562510814504215956
151353478019288911519141451988997146364672857751121615180067243142
7894314454552160199364128191180035611472611]] },
			{ itemId = 2821, -- book
				text = [[
843534515867511216761062514081595347801928891151914145198899714636
4751352854215765159564619018655953724385]] },
		},
	},
	-- bookcase at 32779,31691,13
	{
		itemId = 2439,
		itemPos = { x = 32779, y = 31691, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
464726114514519485611451908304576512282177350843485627563561145191
991180036468895219911843508124348561145191211288830464679727831601
74648349434354521972127]] },
			{ itemId = 2821, -- book
				text = [[
585765197278894388721512889521961800311457278572611857642197096805
796366125275705845217652197278304648765159564611414519889975112161
518005953724348562510811463646724353451586042158577445451904504215
956151353478019288952160199364672431427894315191186512819118003561
147261164671364646121978036512]] },
		},
	},
	-- bookcase at 32779,31692,13
	{
		itemId = 2440,
		itemPos = { x = 32779, y = 31692, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
042159561513534780192889521601993646724314278943151911865128191180
035611472611646713646461219785857651972921972781670546711800140152
551751911801894452295345274464726114514519485611451908304576512282
177350843485628477090889524348561121648006586756356114519199118003
64688952199110365]] },
			{ itemId = 2821, -- book
				text = [[
792827843508195372434856251081146364672435546003614519121128883046
467972783160134515860421585774454519045042159561513534780192889521
60199]] },
		},
	},
	-- bookcase at 32780,31681,13
	{
		itemId = 2436,
		itemPos = { x = 32780, y = 31681, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
561145727857261185764364672435345275601928895219735364672496847560
199684770908895219727816705121648561145191991180036468895219911800
65128]] },
			{ itemId = 2821, -- book
				text = [[
180036468895219911800651288952364672119118003576513534783046467972
783967340579282758576512527570584521765219727830464876515956461141
451988997]] },
			{ itemId = 2821, -- book
				text = [[
783020311806571918943434646518009114646003646712888191180035611472
611646713646461219780364647261145145194856114519042159560421585765
2]] },
		},
	},
	-- bookcase at 32781,31681,13
	{
		itemId = 2436,
		itemPos = { x = 32781, y = 31681, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
727894315191185191180189445219727889438343508124348561145191216704
672611458003690422046484519114521972712889521959457651288950036215
12889521961]] },
			{ itemId = 2821, -- book
				text = [[
383435081243485611451912167046726114580036904220464845191145219727
128895219594576512889500362151288952196114364585611451904509118003
158604215857651288724348561145196726114519]] },
		},
	},
	-- bookcase at 32781,31689,13
	{
		itemId = 2439,
		itemPos = { x = 32781, y = 31689, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
781670574770909612164800658611431288950036249684756019965855064996
704672611458003690422046484519118895219771288952195945765523646721
191180035757654600364671180014015255175191180189445229534527347092
012857197278304042158576594344215956042183020311806571918943434646
5180099673]] },
		},
	},
	-- bookcase at 32781,31690,13
	{
		itemId = 2439,
		itemPos = { x = 32781, y = 31690, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
978585765197292197278167054671180014015255175191180350843485628477
090889524348561121648006586]] },
			{ itemId = 2821, -- book
				text = [[
756356114519199118003646889521991103345274464726114514519485611451
908304576512282177451904504215956151353478019288952160199364672]] },
		},
	},
	-- bookcase at 32782,31681,13
	{
		itemId = 2436,
		itemPos = { x = 32782, y = 31681, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
017464834943435282177830457651288952197251081658550649911800364]] },
			{ itemId = 2821, -- book
				text = [[
508434856114572785726118576436467243534527560192889521973536467249
684756019968477090889521972781670512164856114519199118003646889521
99118006512889523646721191180035765135347830]] },
		},
	},
	-- bookcase at 32783,31686,13
	{
		itemId = 2436,
		itemPos = { x = 32783, y = 31686, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
651288967212778894388721512889521961800311457278572611857642197096
805796366125275705845217652197278304648765159564611414519889975112
16151]] },
		},
	},
	-- bookcase at 32783,31691,13
	{
		itemId = 2439,
		itemPos = { x = 32783, y = 31691, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
219605796366125275889031176515956461141451988997511216151808675635
611451919911800364688952199113887215127788945036457512889672127058
452176521972783046481802785726118576421970968]] },
		},
	},
	-- bookcase at 32784,31681,13
	{
		itemId = 2436,
		itemPos = { x = 32784, y = 31681, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
572785726118576436467243534527560192856114519199118003646889521991
18006512889523646721191180035765135347830508434856114]] },
			{ itemId = 2821, -- book
				text = [[
21972789431519118519118018944521972]] },
			{ itemId = 2821, -- book
				text = [[
404215857651216151800943435084348561145727857261185764364672435345
275601928895219735364672496847560199684770908895219727816705121648
56114519199118003646889521991180065128]] },
		},
	},
	-- bookcase at 32785,31686,13
	{
		itemId = 2436,
		itemPos = { x = 32785, y = 31686, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
534527446472611451451948561145190830457651228217735084348562847709
0889524348561121648006586756356114519199118003646889521991]] },
		},
	},
	-- bookcase at 32785,31688,13
	{
		itemId = 2436,
		itemPos = { x = 32785, y = 31688, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
118576421970968057963661252757058452176521972783046487651595646114
145198899751121615180054585611973536467243485611451967261145190311
80657191894343]] },
			{ itemId = 2821, -- book
				text = [[
114312889500362496847560199658550649967046726114580036904220464845
191188952197712889521959457655236467211911800357576746483494343545
2177090967347092012]] },
		},
	},
	-- bookcase at 32786,31681,13
	{
		itemId = 2436,
		itemPos = { x = 32786, y = 31681, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
094343508434856118003641973536467249684756019968477090889521688952
199118006512814572785726118576436467243534527560192889529727816705
121648561145191991]] },
		},
	},
	-- bookcase at 32786,31686,13
	{
		itemId = 2436,
		itemPos = { x = 32786, y = 31686, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
534527446190830457651228217735084348562847709088952439911800364688
952199153452744647261145145194856114506586756356114519199118003646
889521991261145145194856114519083045765122821773508434856284748561
12164804770908895243485611216480065867563561145191]] },
		},
	},
	-- bookcase at 32786,31689,13
	{
		itemId = 2438,
		itemPos = { x = 32786, y = 31689, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
651800996734057928278435081953724348562510811463646724355460036145
191211288830464679727831601345158604215857744545190450421595615135
34780]] },
			{ itemId = 2821, -- book
				text = [[
192889521601993646724314278943151911865128191180035611472611646713
646461219785857651972921972781670546711800140152551751911801894452
29]] },
		},
	},
	-- bookcase at 32786,31690,13
	{
		itemId = 2439,
		itemPos = { x = 32786, y = 31690, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
467252197752364672119118003575765460036467118001401525522012889521
959175191180189445229534526114580036904457654648451911889]] },
		},
	},
	-- bookcase at 32786,31691,13
	{
		itemId = 2440,
		itemPos = { x = 32786, y = 31691, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
451904504215956151353478019288952160199364672431427894315191186512
819118003561147261164671364646121978585765197292197278167054671180
014015255175191180189445229534527446472611451451948561145190830457
651228217735084348562847709088952434856112164800658675635611451919
9118003646889521991103]] },
		},
	},
	-- bookcase at 32787,31686,13
	{
		itemId = 2437,
		itemPos = { x = 32787, y = 31686, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
69666699 69996696 69966969 69966669 69996966 69966969 66966666 69999669 69969999 69996969 69996696 66966666 69966669 69966699 69966699 69969999 69996969 69969996 69996966 66966666 69996966 69969999 69966966 69966669 69999669 66966666 69966669 69996966 66999696 66669696 69969666 69996966 69996966 69996666 69996699 66999696 66969999 66969999 69996966 69969669 69966696 69969669 69966669 69996966 69966669 69969966 69966969 69996699 66969996 69966699 69969999 69969969 66669696 69969666 69996966 69996966 69996666 69996699 66999696 66969999 66969999 69996696 69969999 69969999 69969699 69966999 69966669 69966669 69996696 69966966 69996966 69966669 69969966 69966969 69996699 66969996 69966699 69969999 69969969]] },
		},
	},
	-- bookcase at 32787,31688,13
	{
		itemId = 2436,
		itemPos = { x = 32787, y = 31688, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
843508192159561513679727831601345158604215857744545190450453478019
288952160199792827537243485625108114636467243554600361451912112888
30464]] },
		},
	},
	-- bookcase at 32788,31688,13
	{
		itemId = 2436,
		itemPos = { x = 32788, y = 31688, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
519118651281911800356114726116467136464612197803646472611451451948
561145190830457651228217735084348562756356114519199118003646889521
9911843508124348561145191211]] },
		},
	},
	-- bookcase at 32789,31681,13
	{
		itemId = 2436,
		itemPos = { x = 32789, y = 31681, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
236467211911800357651353478304646797278396734057928275857651252757
058452176521972783046487651595646114145198899751595372434856127830
20]] },
			{ itemId = 2821, -- book
				text = [[
57652197278943151911851911801894452197278894383435081243485]] },
		},
	},
	-- bookcase at 32789,31688,13
	{
		itemId = 2437,
		itemPos = { x = 32789, y = 31688, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
855064996704672611458003690422046484519118895219771288952195945765
523646721191180035757674648349434354521770909673470920128571972783
0404215857659]] },
		},
	},
	-- bookcase at 32790,31685,13
	{
		itemId = 2438,
		itemPos = { x = 32790, y = 31685, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
857744545190450421595615135347801928895216019936467243142789431519
118651281911800356114726116467186418005458561197353646724348561145
196726114519031180657191894343180014]] },
			{ itemId = 2821, -- book
				text = [[
015255175191180189452176521972783046487651595646114145452295345274
464726114514519485611451908304576512282177350843485623646461219785
8576]] },
			{ itemId = 2821, -- book
				text = [[
519729219727816705467184770908895243485611216480065867563561145191
991180036466612527570581988952199110365128896721277889438872151288
9521961800311457278572611857642197096805796389975112115]] },
		},
	},
	-- bookcase at 32790,31686,13
	{
		itemId = 2439,
		itemPos = { x = 32790, y = 31686, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
819537243485625108114636467243554600361451912112888304646797278316
013451586042158577445451904504215956151353478019288952160199364672
431427894]] },
		},
	},
	-- bookcase at 32790,31687,13
	{
		itemId = 2439,
		itemPos = { x = 32790, y = 31687, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
219727816705121648006586114312889500362496847560199658550649967046
726114580036904220464845191188952197712889521959457655236467]] },
			{ itemId = 2821, -- book
				text = [[
211911800357576546003646711800140152551751911801894452295345274770
909673470920128571972783040421585765943442159560421830203118065719
18943434646518009]] },
		},
	},
	-- bookcase at 32790,31688,13
	{
		itemId = 2439,
		itemPos = { x = 32790, y = 31688, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
118001401525517519118018944522953452747709096734709201285719727830
404215857659434421595604218302031180657191894343464651800996734057
928275857651972788943887215128895219618003114572785726118576421970
9680579636612527570584521765219727830464876515956461141]] },
			{ itemId = 2821, -- book
				text = [[
451988997511216151800595372434856251081146364672435345158604215857
744545190450421595615135347801928895216019936467243142789431]] },
		},
	},
	-- bookcase at 32790,31689,13
	{
		itemId = 2439,
		itemPos = { x = 32790, y = 31689, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
952196180031145727857261185764219709680579636612527570584521765219
727830464876515956461141451988997511216151800545856119735364672434
8561145196726114519031180657191894343]] },
		},
	},
	-- bookcase at 32790,31690,13
	{
		itemId = 2439,
		itemPos = { x = 32790, y = 31690, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
679757714458316013274519351586042158577445831601345158604215086042
1584515860421585774451601345154504838577445860134]] },
		},
	},
	-- bookcase at 32790,31692,13
	{
		itemId = 2440,
		itemPos = { x = 32790, y = 31692, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
800595372434856251081146364672435345158604215857744545190450421595
615135347801928895216019936467243142789431519118651281911800356114
726116467]] },
			{ itemId = 2821, -- book
				text = [[
546003646711800140152551751911801894452295345274770909673470920128
571972783040421585765943442159560421830203118065719189434346465180
099673405792827585765197278894388721512889521961800311457278572611
857642197096805796366125275705845217652197278304648765159564611414
5198]] },
			{ itemId = 2821, -- book
				text = [[
895219727816705121648006586114312889500362496847560199658550649967
046726114580036904220464845191188952197712889521959457655236467211
91180]] },
			{ itemId = 2821, -- book
				text = [[
180189445229534527477090967347092012857197278304042158576594344215
956042183020311806571918943434646518009967340579282758576519727889
438872151288952196180031145727857261185764219709680579636612527570
584521765219727830464876515956461141451988997511216151800595372434
8562510]] },
		},
	},
	-- bookcase at 32791,31681,13
	{
		itemId = 2436,
		itemPos = { x = 32791, y = 31681, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
435282177830457651288952197251081658550649911800364672431]] },
			{ itemId = 2821, -- book
				text = [[
945765128895065128895003621512889521961143645856114519045091180031
50362151288952196114364585611451904509118003159457]] },
			{ itemId = 2821, -- book
				text = [[
651288952364672119118003576513534783046456019968477090889521972781
670512164834350843485611457278572611857643646724353452756019288679
727839946895219911800673405792827585765125275705845217652197278304
648765159564611414519889975146724968479521973535611451919911800364
68]] },
		},
	},
	-- bookcase at 32791,31683,13
	{
		itemId = 2436,
		itemPos = { x = 32791, y = 31683, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
180036468895219912611451451985611451908304576512282177350843485628
474688980521036499159911867451946889521991534527446472611451451948
561145065534527446472611451451948561145065635611451986756356114519
19911800364688952199126114511991]] },
		},
	},
	-- bookcase at 32793,31684,13
	{
		itemId = 2438,
		itemPos = { x = 32793, y = 31684, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
857659434421595604218302464651800996734057928278435081953724348562
510811463646724355460036145191211288830464679727831601345158604215
857744545190450421595615135347801928895216019936467243142789431519
118651281911800356114726116467136464612197858576519729219727816705
46711800]] },
			{ itemId = 2821, -- book
				text = [[
819537243485625108114636467243554600361451912112888304646797278316
013451586042158577445451904504215956151353478019288952160199364672
431427894857659434421595604218302464651800996734057928278435031519
118651281911800356114726116467136464612197858576519729219727816705
46711800]] },
		},
	},
	-- bookcase at 32793,31685,13
	{
		itemId = 2439,
		itemPos = { x = 32793, y = 31685, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
974648349472783040421585765943442159560421830203118065719189434521
991184350812434856114519121128883046467972783160134354521972127770
9096734709201285719]] },
		},
	},
	-- bookcase at 32793,31686,13
	{
		itemId = 2439,
		itemPos = { x = 32793, y = 31686, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
855064996704672611458003690422046484519118895219771288952195945765
523646721191180035757674648349434354521770909673470920128571972783
0404215857659]] },
		},
	},
	-- bookcase at 32793,31687,13
	{
		itemId = 2439,
		itemPos = { x = 32793, y = 31687, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
480065861143128895003624968475601996585506499670467261145800369042
204648451911889521977128895219594576552364672119118003575765]] },
			{ itemId = 2821, -- book
				text = [[
460036467118001401525517519118018944522953452744647261145145194856
114519083045765122821773508434856275635611451919911800364688]] },
			{ itemId = 2821, -- book
				text = [[
952199118435081243485611451912112888304646797278316017464834943435
452197212777090967347092012857197278304042158576594344215956042183
0203118065719189434]] },
		},
	},
	-- bookcase at 32793,31688,13
	{
		itemId = 2439,
		itemPos = { x = 32793, y = 31688, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
965855064996704672611458003690422046484519118895219771288952195945
765523646721191180035757674648349434354521770909673470920128571972
7830404215857659434421595604218302464]] },
		},
	},
	-- bookcase at 32793,31689,13
	{
		itemId = 2439,
		itemPos = { x = 32793, y = 31689, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
042159561513534780192889521601993646724314278943151911865128191180
035611472611646713646461219785857651972921972781670546711800140152
551751911801894452295345274464726114514519485611451908304576512282
177350843485]] },
			{ itemId = 2821, -- book
				text = [[
628477090889524348561121648006586756356114519199118003646889521991
10365128896721277889438872151288]] },
		},
	},
	-- bookcase at 32794,31681,13
	{
		itemId = 2437,
		itemPos = { x = 32794, y = 31681, z = 13 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
611431288950036249684756019965855064996704672611458003690422046484
519118895219771288952195945765523646721191180035757654600364671180
01401525517]] },
			{ itemId = 2821, -- book
				text = [[
348562510811463646724353451586042158577445451904504215956151353478
019288952160199364672431427894315191186512819118003561147261164671
36464612]] },
		},
	},
	-- sarcophagus at 33386,31711,13
	{
		itemId = 1992,
		itemPos = { x = 33386, y = 31711, z = 13 },
		contents = {
			{ itemId = 2831, -- book
				text = [[
Mahatheb was the greatest vizier the city of Ankrahmun had ever seen. His counsel was prized and his wisdom legendary. He served the pharaoh Ashmunrah dutifully and faithfully. The wise Mahatheb had ever been wary of the studies of the pharaoh’s dark son, Arkhotep. But Arkhothep whispered lies into the ears of the pharaoh and poisoned his mind and heart. In his wisdom, Mahatheb saw the futility of his attempts to destroy the mists of treachery that clouded the pharaoh’s vision. Instead, he planned to help his liege in another way. Knowing that Arkhothep was using dark sorcery to gain power, he decided to gather more might himself in order to fight him. Being no sorcerer, the vizier looked to the powers of the legendary djinn, and studied ways to bind them to his will. After long research, he learned that even the djinn had to bow to someone who knew their true name. He pondered his options, when seemingly fate smiled upon him and provided him with an opportunity too good to pass it by. The well-known king of thieves, Qual'Jehari, had fallen in love with Xetharis, the beautiful daughter of the vizier. When he asked for her hand in marriage, Mahatheb presented him with a condition: to steal the true names of the djinn and give them to him. Qual'Jehari, love-stricken and blinded by arrogance, accepted without hesitation. He left the court at once, promising to return soon. Years passed, and the thief was not seen or heard again, while the vile Arkhotep grew in power and assembled his co-conspirators. Running out of time and options, the vizier tried other ways to stop the pharaoh’s son, but to no avail. When Mahatheb was desperate and almost ready for a deed of desperation, a ragged pauper appeared in his chambers. The vizier was about to call the guards when the pauper revealed himself to be no other than Qual'Jehari. He was gaunt and marked by his quest, having lost both his eyes and his youth. With shaking hands he presented Mahatheb some scrolls of paper that had the names of numerous djinn written upon them. But the vizier’s joy was cut short when he recognised that in truth only a tiny fraction of all the djinn names had been acquired. In his anger he had the thief flogged and thrown out on the streets. He studied the names of the djinn he had acquired and wondered how to put them to best use. But luck is a treacherous lover, and it had already betrayed the good Mahatheb. The thief had withheld one of the djinn names, and used that djinn to steal the beloved daughter of Mahatheb. This caused so much attention that the evil Arkhothep became aware of the vizier’s actions and put his own plans into motion. Mahatheb however was wise enough to see the threat coming, and used the powers of the djinn to flee Ankrahmun, to a foreign land, taking all of his servants and riches with him. But he had underestimated the great heights of power that Arkhothep had already climbed to. The vile prince used his sorcerous might to cast a death curse on him, and all the might of Mahatheb’s bound djinn was not powerful enough to protect him. All he could do was to prolong the inevitable. He used his remaining might not to build himself a palace as he had intended, but a tomb in which he planned to endure the passing of time until the one day he would rise again. His djinn erected the tomb, and Mahatheb was embalmed by his servants, who were then put to death by the djinn so they could join their master in the afterlife. Only I, his chronicler, was allowed to live a little longer to tell his tale. When this book is finished, I too will drink the poisoned wine that the guarding djinn will serve me to fulfil my destiny. May we all one days rise again by the power of the wise Mahatheb.]] },
		},
	},
	-- seashell bookcase at 33455,31341,13
	{
		itemId = 14067,
		itemPos = { x = 33455, y = 31341, z = 13 },
		contents = {
			{ itemId = 14014, -- seashell book
				text = [[
The Swimmer Part I
Translation from 'Jekhr' (language of the Deeplings)
By Lagatos, Chronicler and Scholar

And when the Swimmer reached the bottom of the sea, he was enlightened by the beauty of the deep. The lively cities of the Deeplings greeted him from the bosom of the ocean. Drowning in colour and light, the Swimmer reached the sea's moist bed, surrounded by guardians of the deep. But their welcome was of little warmth. They did not see a foreigner nor a stranger, not a visitor but a threat.]] },
			{ itemId = 14015, -- seashell book
				text = [[
The Heart of the Sea
By Lagatos, Chronicler and Scholar

The Deeplings seem to be fond of the colour red. Otherwise, I cannot explain their obsessive dedication to mine and process rubies while widely ignoring the other gems that can be found in the rocks and cliffs of this subaquarian world. Extraordinarily large rubies are refined even further. The most valuable and perfected is the blood-red "Heart of the Sea". Once I witnessed the stone being inserted into an impressive statue during some kind of ceremony at the large central passageway they call Apex of Worship.]] },
		},
	},
	-- seashell bookcase at 33461,31341,13
	{
		itemId = 14066,
		itemPos = { x = 33461, y = 31341, z = 13 },
		contents = {
			{ itemId = 14015, -- seashell book
				text = [[
The Deepling Language, Volume II: Exercises
By Lagatos, Chronicler and Scholar

Exercises, Chapter II: Advanced Vocabulary 2

all=jeyon
avenge/avenging/avenger=nuijan
balance=runjh
battle=arjak
blind/blinding=jalgi
courage=hounth
dark=faoti
defy/defies=oljent
enemy/enemies=grum
fallen=oskijah
fame=glie
gaze=githn
god-king=reykhn
keeper=hidor
master=bayl
order=qna
our=jedo
repulse/repulsing=tobaj
strike/struck=djou
solitary=tehon
supreme=enijen
to=dh
weapon=nakk
with=kut]] },
			{ itemId = 14014, -- seashell book
				text = [[
The Deepling Language, Volume II: Exercises
By Lagatos, Chronicler and Scholar

The Deepling language is not yet understood to its fullest. However, it mostly consists of nouns and basic, infinite verbs.

Exercises, Chapter I: Pronouns
I/me = jh
we/us = jey
you = na
the/that/this = jeh]] },
		},
	},
	-- seashell bookcase at 33466,31316,13
	{
		itemId = 14066,
		itemPos = { x = 33466, y = 31316, z = 13 },
		contents = {
			{ itemId = 14014, -- seashell book
				text = [[
The Deepling Language, Volume II: Exercises
By Lagatos, Chronicler and Scholar

Exercises, Chapter III: Numbers

one/first=hon
two/second=rau
three/third=du
four/fourth=qo
five/fifth=rei
six/sixth=tau
eight/eighth=kri
nine/ninth=lod
ten/tenth=emm]] },
		},
	},
	-- seashell bookcase at 33470,31342,13
	{
		itemId = 14071,
		itemPos = { x = 33470, y = 31342, z = 13 },
		contents = {
			{ itemId = 14015, -- seashell book
				text = [[
Excerpt from "Deep Thoughts", personal comments of Chronicler Lagatos to his unfinished work "Encyclopedia Terra Subaqua":

Before the oceans that formed on Tibia took the shape they hold today, the underwater world of Tibia was already a diverse, busy and sprawling place. Ruled by the one god of the deep: Qjell*, Deus Profundis. Guarded by three depth lords: Obujos, Defensor Profundis, Jaul, Protektor Profundis and Tanjis, Expeditus Profundis, he dwelled on the very bottom of the deepest ocean. (*These names have been repeated excessively in almost all of the few writings discovered of this old civilisation so far and were extracted as the names of the three main individuals around Qjell.)
Although violent and often primitive in nature, these creatures of the deep are strangely interconnected and should be considered intelligent beings. They communicate and interact with each other on a higher level than most inhabitants of the Tibia oceans. However, each of their existences is mostly focused on specific tasks. As each Deepling has to play its role, the social structure of their society is clearly structured and layered in strict castes. From what is known through collected studies and vague interpretations of writings in the foreign language of higher Deeplings, higher castes suppress members of lower classes systematically. This is achieved by radical control of everyday life of lower Deeplings and strict classification. Besides fear and oppression, higher classes especially utilise limitations to reach these goals. Parts of the society will not be able to access specific religious sites, sacred writings or even habitats of higher members. It is not possible for the majority of Deeplings to acquire the knowledge necessary to breach their social status for their entire life. Members of the upper class hand-pick other Deeplings for their future role as they see fit. Effectively destroying their former social life, family ties and former duties. From what is known to this date, the selected members accept their fate for a "greater good" of which it is unknown whether it defines worshipping their God King Qjell or simply living in service for the upper castes. It is highly possible that this system of control is maintained to reduce the risk of riots and keep the general mood and morale at a manageable level. It is not known how old (or young) this civilisation was when they decided to "reduce" their society to cattle and shepherd, but it is possible that they found this to be the only form that guarantees survival of the race as a whole. So far this concept did not fail.
Lower castes consist of scouts, various kinds of warriors and simple workers. So far it is assumed that the main tasks of female Deeplings, while being valued very highly in all layers of Deepling society, focusses on creative or supportive tasks as well as their offspring. Though it is unknown whether there are specific roles for females in higher castes.]] },
		},
	},
	-- seashell bookcase at 33475,31341,13
	{
		itemId = 14066,
		itemPos = { x = 33475, y = 31341, z = 13 },
		contents = {
			{ itemId = 14015, -- seashell book
				text = [[
The Swimmer Part II
Translation from 'Jekhr' (language of the Deeplings)
By Lagatos, Chronicler and Scholar

Held captive for two lifetimes he became one with the stone and coral that bound him. He longed for the world above. Wandering the skies again in broad daylight. Roaming the deserts, mountains and vast plains of the world like he used to. Floating a drop above the rain and dodging beams of the twin suns, he would embrace the disembodied freedom of his true self.

He was a spirit and a ghost. His soul moved into the very walls and fences of every house and court. Claiming the very foundations of this watery city as his own.

The Swimmer now lingers in shadowy corners, damp and dark and hollow. Chasing flickers of light touching the ground like a cat born of fog. When the creatures of the deep fell for the first visitor, he mourned the loss of the good in their souls. When the colour finally fled from its last enclave, he longed for redemption.

What is left of the light once brought to us, what remains of the fires once thriving us, it is he.]] },
			{ itemId = 14014, -- seashell book
				text = [[
The Deepling Language, Volume II: Exercises
By Lagatos, Chronicler and Scholar

Exercises, Chapter II: Basic Vocabulary 2 (F-W)

face=thn
from/of the=ho
greet/greeting=lhnjei
guide=neta
hand=roff
him/he=ku
in=um
intruder=kenh
let=jul
library=giotja
light=fie
march=shum
narrow=dakn
not=ro
obey=qohn
over/up/on=gou
path=kweh
peace=dividej
perseverance/endurance=lorkulh
protect=jau
reach=lume
rise=cie
sea/water=jhli
seabed=jhlimeh
seven=laek
shall=to
sit/sitting=toky
smile/smiling=solesteh
statue/figure=bost
surface=gouthn
visit/visitor=buhel
walk=motom
watch=afar
what=gonn
when/if=el
who=hon
will=krum]] },
		},
	},
	-- bookcase at 32417,32136,14
	{
		itemId = 2436,
		itemPos = { x = 32417, y = 32136, z = 14 },
		contents = {
			{ itemId = 2821, -- book
				text = [[
Chronicle of Mintwallin - the city of the Minotaurs
written by Markwin, king of all Minotaurs

Volume I

( burned out )]] },
			{ itemId = 2821, -- book
				text = [[
Chronicle of Mintwallin - the city of the Minotaurs
written by Markwin, king of all Minotaurs

Volume II

( burned out )]] },
			{ itemId = 2821, -- book
				text = [[
Chronicle of Mintwallin - the city of the Minotaurs
written by Markwin, king of all Minotaurs

Volume III

We finally managed it to escape from the evil daemon. We had to give up most of our land. Only the city Mintwallin is left. Many good warriors died. We blocked the way out of the city with a drawbridge. I hope that will keep the daemon out. Now the only way out of the city leads to the labyrinth.

Palkar gets more and more influence in the city. Mostly the younger Minos listen to him.

Palkar sows discard. He wants to form a new army to investigate the labyrinth and to get back to the surface. I prefer living right here in peace.

He is too strong. I had to allow him to lead some small groups of our Minotaurs to fight against the orcs and trolls. He is a very good commander - and so he is a danger for me.

WHAT THE HELL MEANS "KAPLAR"?!?!?

Palkar conquered most of the tunnels and dungeons. He drove the trolls back. Perhaps he is right. Perhaps - someday - I will see the light of the sun again.]] },
		},
	},
	-- bookcase at 32421,31594,14
	{
		itemId = 2438,
		itemPos = { x = 32421, y = 31594, z = 14 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The formulas of Finoa
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32421,31596,14
	{
		itemId = 2439,
		itemPos = { x = 32421, y = 31596, z = 14 },
		contents = {
			{ itemId = 2828, -- book
				text = [[
The formulas of Ajina
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
	-- bookcase at 32421,31597,14
	{
		itemId = 2439,
		itemPos = { x = 32421, y = 31597, z = 14 },
		contents = {
			{ itemId = 2825, -- book
				text = [[
The formulas of Zonoa
Written by Herion

*You see several strange formulas that you dont understand*]] },
		},
	},
}
