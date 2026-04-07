local internalNpcName = "Enpa Rudra"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1816,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 81,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end

npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end

local node1 = keywordHandler:addKeyword({ "greater tiger clash" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {greater tiger clash} magic spell for 6000 gold?" })
node1:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "greater tiger clash", vocation = { 9, 10 }, price = 6000, level = 18 })

local node2 = keywordHandler:addKeyword({ "greater flurry of blows" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {greater flurry of blows} magic spell for 11000 gold?" })
node2:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "greater flurry of blows", vocation = { 9, 10 }, price = 11000, level = 90 })

local node3 = keywordHandler:addKeyword({ "sweeping takedown" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {sweeping takedown} magic spell for 8000 gold?" })
node3:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "sweeping takedown", vocation = { 9, 10 }, price = 8000, level = 60 })

local node4 = keywordHandler:addKeyword({ "chained penance" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {chained penance} magic spell for 8000 gold?" })
node4:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "chained penance", vocation = { 9, 10 }, price = 8000, level = 70 })

local node5 = keywordHandler:addKeyword({ "spirit mend" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {spirit mend} magic spell for 9000 gold?" })
node5:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "spirit mend", vocation = { 9, 10 }, price = 9000, level = 80 })

local node6 = keywordHandler:addKeyword({ "flurry of blows" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {flurry of blows} magic spell for 1500 gold?" })
node6:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "flurry of blows", vocation = { 9, 10 }, price = 1500, level = 35 })

local node7 = keywordHandler:addKeyword({ "devastating knockout" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {devastating knockout} magic spell for 20000 gold?" })
node7:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "devastating knockout", vocation = { 9, 10 }, price = 20000, level = 125 })

local node8 = keywordHandler:addKeyword({ "mass spirit mend" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {mass spirit mend} magic spell for 20000 gold?" })
node8:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "mass spirit mend", vocation = { 9, 10 }, price = 20000, level = 150 })

local node9 = keywordHandler:addKeyword({ "focus serenity" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {focus serenity} magic spell for 125000 gold?" })
node9:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "focus serenity", vocation = { 9, 10 }, price = 125000, level = 150 })

local node10 = keywordHandler:addKeyword({ "mentor other" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {mentor other} magic spell for 175000 gold?" })
node10:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "mentor other", vocation = { 9, 10 }, price = 175000, level = 150 })

local node11 = keywordHandler:addKeyword({ "balanced brawl" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {balanced brawl} magic spell for 250000 gold?" })
node11:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "balanced brawl", vocation = { 9, 10 }, price = 250000, level = 175 })

local node12 = keywordHandler:addKeyword({ "summon monk familiar" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {summon monk familiar} magic spell for 50000 gold?" })
node12:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "summon monk familiar", vocation = { 9, 10 }, price = 50000, level = 200 })

local node13 = keywordHandler:addKeyword({ "restore balance" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {restore balance} magic spell for 800 gold?" })
node13:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "restore balance", vocation = { 9, 10 }, price = 800, level = 18 })

local node14 = keywordHandler:addKeyword({ "enlighten party" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {enlighten party} magic spell for 4000 gold?" })
node14:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "enlighten party", vocation = { 9, 10 }, price = 4000, level = 32 })

local node15 = keywordHandler:addKeyword({ "double jab" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {double jab} magic spell for 1000 gold?" })
node15:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "double jab", vocation = { 9, 10 }, price = 1000, level = 14 })

local node16 = keywordHandler:addKeyword({ "strong haste" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {strong haste} magic spell for 1300 gold?" })
node16:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "strong haste", vocation = { 1, 2, 5, 6, 9, 10 }, price = 1300, level = 20 })

local node17 = keywordHandler:addKeyword({ "tiger clash" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {tiger clash} magic spell for free?" })
node17:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "tiger clash", vocation = { 9, 10 }, price = 0, level = 1 })

local node18 = keywordHandler:addKeyword({ "swift jab" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {swift jab} magic spell for free?" })
node18:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "swift jab", vocation = { 9, 10 }, price = 0, level = 1 })

local node19 = keywordHandler:addKeyword({ "virtue of harmony" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {virtue of harmony} magic spell for free?" })
node19:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "virtue of harmony", vocation = { 10 }, price = 0, level = 20 })

local node20 = keywordHandler:addKeyword({ "virtue of justice" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {virtue of justice} magic spell for free?" })
node20:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "virtue of justice", vocation = { 10 }, price = 0, level = 20 })

local node21 = keywordHandler:addKeyword({ "virtue of sustain" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {virtue of sustain} magic spell for free?" })
node21:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "virtue of sustain", vocation = { 10 }, price = 0, level = 20 })

local node22 = keywordHandler:addKeyword({ "great light" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {great light} magic spell for 500 gold?" })
node22:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "great light", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 500, level = 13 })

local node23 = keywordHandler:addKeyword({ "intense healing" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {intense healing} magic spell for 350 gold?" })
node23:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "intense healing", vocation = { 1, 2, 3, 5, 6, 7, 9, 10 }, price = 350, level = 20 })

local node24 = keywordHandler:addKeyword({ "light healing" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {light healing} magic spell for free?" })
node24:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "light healing", vocation = { 1, 2, 3, 5, 6, 7, 9, 10 }, price = 0, level = 8 })

local node25 = keywordHandler:addKeyword({ "magic patch" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {magic patch} magic spell for free?" })
node25:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "magic patch", vocation = { 1, 2, 3, 5, 6, 7, 9, 10 }, price = 0, level = 1 })

local node26 = keywordHandler:addKeyword({ "magic rope" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {magic rope} magic spell for 200 gold?" })
node26:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "magic rope", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 200, level = 9 })

local node27 = keywordHandler:addKeyword({ "levitate" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {levitate} magic spell for 500 gold?" })
node27:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "levitate", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 500, level = 12 })

local node28 = keywordHandler:addKeyword({ "haste" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {haste} magic spell for 600 gold?" })
node28:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "haste", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 600, level = 14 })

local node29 = keywordHandler:addKeyword({ "find fiend" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {find fiend} magic spell for 1000 gold?" })
node29:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "find fiend", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 1000, level = 25 })

local node30 = keywordHandler:addKeyword({ "find person" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {find person} magic spell for 80 gold?" })
node30:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "find person", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 80, level = 8 })

local node31 = keywordHandler:addKeyword({ "cure poison" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {cure poison} magic spell for 150 gold?" })
node31:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "cure poison", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 150, level = 10 })

local node32 = keywordHandler:addKeyword({ "light" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {light} magic spell for free?" })
node32:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "light", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 0, level = 8 })

keywordHandler:addKeyword({ "spells" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "I can teach you {attack} spells, {healing} spells and {support} spells. What kind of spell do you wish to learn? I can also tell you which spells are available at your {level}.",
})

keywordHandler:addKeyword({ "attack" }, StdModule.say, {
	npcHandler = npcHandler,
	onlyFocus = true,
	text = "My attack spells are: {Chained Penance}, {Devastating Knockout}, {Double Jab}, {Flurry of Blows}, {Greater Flurry of Blows}, {Greater Tiger Clash}, {Sweeping Takedown}, {Swift Jab} and {Tiger Clash}.",
})

keywordHandler:addKeyword({ "healing" }, StdModule.say, {
	npcHandler = npcHandler,
	onlyFocus = true,
	text = "My healing spells are: {Cure Poison}, {Intense Healing}, {Light Healing}, {Magic Patch}, {Mass Spirit Mend}, {Restore Balance}, and {Spirit Mend}.",
})

keywordHandler:addKeyword({ "support" }, StdModule.say, {
	npcHandler = npcHandler,
	onlyFocus = true,
	text = "My support spells are: {Balanced Brawl}, {Enlighten Party}, {Find Fiend}, {Find Person}, {Focus Serenity}, {Great Light}, {Haste}, {Levitate}, {Light}, {Magic Rope}, {Mentor Other}, {Strong Haste} and {Summon Monk Familiar}, {Virtue of Harmony}, {Virtue of Justice} and {Virtue of Sustain}.",
})

local nodeLevels = keywordHandler:addKeyword({ "level" }, StdModule.say, {
	npcHandler = npcHandler,
	onlyFocus = true,
	text = "I have spells for level {1}, {8}, {9}, {10}, {12}, {13}, {14}, {18}, {20}, {25}, {32}, {35}, {60}, {70}, {80}, {90}, {125}, {150}, {175} and {200}.",
})

nodeLevels:addChildKeyword({ "200" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 200 I have {Summon Monk Familiar} for 50000 gold." })
nodeLevels:addChildKeyword({ "175" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 175 I have {Balanced Brawl} for 250000 gold." })
nodeLevels:addChildKeyword({ "150" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 150 I have {Focus Serenity} for 125000 gold, {Mass Spirit Mend} for 20000 gold and {Mentor Other} for 175000 gold." })
nodeLevels:addChildKeyword({ "125" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 125 I have {Devastating Knockout} for 20000 gold." })
nodeLevels:addChildKeyword({ "90" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 90 I have {Greater Flurry of Blows} for 11000 gold." })
nodeLevels:addChildKeyword({ "80" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 80 I have {Spirit Mend} for 9000 gold." })
nodeLevels:addChildKeyword({ "70" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 70 I have {Chained Penance} for 8000 gold." })
nodeLevels:addChildKeyword({ "60" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 60 I have {Sweeping Takedown} for 8000 gold." })
nodeLevels:addChildKeyword({ "35" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 35 I have {Flurry of Blows} for 1500 gold." })
nodeLevels:addChildKeyword({ "32" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 32 I have {Enlighten Party} for 4000 gold." })
nodeLevels:addChildKeyword({ "25" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 25 I have {Find Fiend} for 1000 gold." })
nodeLevels:addChildKeyword({ "20" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 20 I have {Intense Healing} for 350 gold, {Strong Haste} for 1300 gold, {Virtue of Harmony} for free, {Virtue of Justice} for free and {Virtue of Sustain} for free." })
nodeLevels:addChildKeyword({ "18" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 18 I have {Greater Tiger Clash} for 6000 gold and {Restore Balance} for 800 gold." })
nodeLevels:addChildKeyword({ "14" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 14 I have {Double Jab} for 1000 gold and {Haste} for 600 gold." })
nodeLevels:addChildKeyword({ "13" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 13 I have {Great Light} for 500 gold." })
nodeLevels:addChildKeyword({ "12" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 12 I have {Levitate} for 500 gold." })
nodeLevels:addChildKeyword({ "10" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 10 I have {Cure Poison} for 150 gold." })
nodeLevels:addChildKeyword({ "9" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 9 I have {Magic Rope} for 200 gold." })
nodeLevels:addChildKeyword({ "8" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 8 I have {Find Person} for 80 gold, {Light} for free and {Light Healing} for free." })
nodeLevels:addChildKeyword({ "1" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 1 I have {Magic Patch} for free, {Swift Jab} for free and {Tiger Clash} for free." })

-- Promotion
local node1 = keywordHandler:addKeyword({ "promot" }, StdModule.say, {
	npcHandler = npcHandler,
	onlyFocus = true,
	text = "I can promote you for 20000 gold coins. Do you want me to promote you?",
})
node1:addChildKeyword({ "yes" }, StdModule.promotePlayer, {
	npcHandler = npcHandler,
	cost = 20000,
	level = 20,
	text = "Congratulations! You are now promoted.",
})
node1:addChildKeyword({ "no" }, StdModule.say, {
	npcHandler = npcHandler,
	onlyFocus = true,
	text = "Alright then, come back when you are ready.",
	reset = true,
})

npcType.onCheckItem = function(npc, player, clientId, subType) end

npcType:register(npcConfig)
