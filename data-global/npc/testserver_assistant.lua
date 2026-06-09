local internalNpcName = "Testserver Assistant"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {
	amountMoney = 100, -- 1 kk
	amountTibiaCoin = 1000, -- 1000 tibia coins
	amountLevel = 100, -- 100 levels per try
	maxLevel = 600, -- maximum test server level
}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 396,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
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

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
-- test items
npcConfig.shop = {

	{ itemName = "lesser guardian gem", clientId = 44602, buy = 100000 },
	{ itemName = "guardian gem", clientId = 44603, buy = 100000 },
	{ itemName = "greater guardian gem", clientId = 44604, buy = 100000 },
	{ itemName = "lesser marksman gem", clientId = 44605, buy = 100000 },
	{ itemName = "marksman gem", clientId = 44606, buy = 100000 },
	{ itemName = "greater marksman gem", clientId = 44607, buy = 100000 },
	{ itemName = "lesser sage gem", clientId = 44608, buy = 100000 },
	{ itemName = "sage gem", clientId = 44609, buy = 100000 },
	{ itemName = "greater sage gem", clientId = 44610, buy = 100000 },
	{ itemName = "lesser mystic gem", clientId = 44611, buy = 100000 },
	{ itemName = "mystic gem", clientId = 44612, buy = 100000 },
	{ itemName = "greater mystic gem", clientId = 44613, buy = 100000 },
	{ itemName = "proficiency catalyst", clientId = 51588, buy = 100000 },
	{ itemName = "greater proficiency catalyst", clientId = 51589, buy = 100000 },
	{ itemName = "exalted core", clientId = 37110, buy = 100000 },
	{ itemName = "kooldown-aid", clientId = 36723, buy = 100000 },
	{ itemName = "strike enhancement", clientId = 36724, buy = 100000 },
	{ itemName = "stamina extension", clientId = 36725, buy = 100000 },
	{ itemName = "charm upgrade", clientId = 36726, buy = 100000 },
	{ itemName = "wealth duplex", clientId = 36727, buy = 100000 },
	{ itemName = "bestiary betterment", clientId = 36728, buy = 100000 },
	{ itemName = "fire resilience", clientId = 36729, buy = 100000 },
	{ itemName = "ice resilience", clientId = 36730, buy = 100000 },
	{ itemName = "earth resilience", clientId = 36731, buy = 100000 },
	{ itemName = "energy resilience", clientId = 36732, buy = 100000 },
	{ itemName = "holy resilience", clientId = 36733, buy = 100000 },
	{ itemName = "death resilience", clientId = 36734, buy = 100000 },
	{ itemName = "physical resilience", clientId = 36735, buy = 100000 },
	{ itemName = "fire amplification", clientId = 36736, buy = 100000 },
	{ itemName = "ice amplification", clientId = 36737, buy = 100000 },
	{ itemName = "earth amplification", clientId = 36738, buy = 100000 },
	{ itemName = "energy amplification", clientId = 36739, buy = 100000 },
	{ itemName = "holy amplification", clientId = 36740, buy = 100000 },
	{ itemName = "death amplification", clientId = 36741, buy = 100000 },
	{ itemName = "physical amplification", clientId = 36742, buy = 100000 },
	{ itemName = "blank imbuement scroll", clientId = 51442, buy = 100000 },
	{ itemName = "powerful bash scroll", clientId = 51444, buy = 100000 },
	{ itemName = "powerful blockade scroll", clientId = 51445, buy = 100000 },
	{ itemName = "powerful chop scroll", clientId = 51446, buy = 100000 },
	{ itemName = "powerful cloud fabric scroll", clientId = 51447, buy = 100000 },
	{ itemName = "powerful demon presence scroll", clientId = 51448, buy = 100000 },
	{ itemName = "powerful dragon hide scroll", clientId = 51449, buy = 100000 },
	{ itemName = "powerful electrify scroll", clientId = 51450, buy = 100000 },
	{ itemName = "powerful epiphany scroll", clientId = 51451, buy = 100000 },
	{ itemName = "powerful featherweight scroll", clientId = 51452, buy = 100000 },
	{ itemName = "powerful frost scroll", clientId = 51453, buy = 100000 },
	{ itemName = "powerful lich shroud scroll", clientId = 51454, buy = 100000 },
	{ itemName = "powerful precision scroll", clientId = 51455, buy = 100000 },
	{ itemName = "powerful punch scroll", clientId = 51456, buy = 100000 },
	{ itemName = "powerful quara scale scroll", clientId = 51457, buy = 100000 },
	{ itemName = "powerful reap scroll", clientId = 51458, buy = 100000 },
	{ itemName = "powerful scorch scroll", clientId = 51459, buy = 100000 },
	{ itemName = "powerful slash scroll", clientId = 51460, buy = 100000 },
	{ itemName = "powerful snake skin scroll", clientId = 51461, buy = 100000 },
	{ itemName = "powerful strike scroll", clientId = 51462, buy = 100000 },
	{ itemName = "powerful swiftness scroll", clientId = 51463, buy = 100000 },
	{ itemName = "powerful vampirism scroll", clientId = 51464, buy = 100000 },
	{ itemName = "powerful venom scroll", clientId = 51465, buy = 100000 },
	{ itemName = "powerful vibrancy scroll", clientId = 51466, buy = 100000 },
	{ itemName = "powerful void scroll", clientId = 51467, buy = 100000 },
	{ itemName = "intricate bash scroll", clientId = 51724, buy = 100000 },
	{ itemName = "intricate blockade scroll", clientId = 51725, buy = 100000 },
	{ itemName = "intricate chop scroll", clientId = 51726, buy = 100000 },
	{ itemName = "intricate cloud fabric scroll", clientId = 51727, buy = 100000 },
	{ itemName = "intricate demon presence scroll", clientId = 51728, buy = 100000 },
	{ itemName = "intricate dragon hide scroll", clientId = 51729, buy = 100000 },
	{ itemName = "intricate electrify scroll", clientId = 51730, buy = 100000 },
	{ itemName = "intricate epiphany scroll", clientId = 51731, buy = 100000 },
	{ itemName = "intricate featherweight scroll", clientId = 51732, buy = 100000 },
	{ itemName = "intricate frost scroll", clientId = 51733, buy = 100000 },
	{ itemName = "intricate lich shroud scroll", clientId = 51734, buy = 100000 },
	{ itemName = "intricate precision scroll", clientId = 51735, buy = 100000 },
	{ itemName = "intricate punch scroll", clientId = 51736, buy = 100000 },
	{ itemName = "intricate quara scale scroll", clientId = 51737, buy = 100000 },
	{ itemName = "intricate reap scroll", clientId = 51738, buy = 100000 },
	{ itemName = "intricate scorch scroll", clientId = 51739, buy = 100000 },
	{ itemName = "intricate slash scroll", clientId = 51740, buy = 100000 },
	{ itemName = "intricate snake skin scroll", clientId = 51741, buy = 100000 },
	{ itemName = "intricate strike scroll", clientId = 51742, buy = 100000 },
	{ itemName = "intricate swiftness scroll", clientId = 51743, buy = 100000 },
	{ itemName = "intricate vampirism scroll", clientId = 51744, buy = 100000 },
	{ itemName = "intricate venom scroll", clientId = 51745, buy = 100000 },
	{ itemName = "intricate vibrancy scroll", clientId = 51746, buy = 100000 },
	{ itemName = "intricate void scroll", clientId = 51747, buy = 100000 },
	{ itemName = "greater garlic necklace", clientId = 51275, buy = 100000 },
	{ itemName = "sanguine blade", clientId = 43864, buy = 100000 },
	{ itemName = "grand sanguine blade", clientId = 43865, buy = 100000 },
	{ itemName = "sanguine cudgel", clientId = 43866, buy = 100000 },
	{ itemName = "grand sanguine cudgel", clientId = 43867, buy = 100000 },
	{ itemName = "sanguine hatchet", clientId = 43868, buy = 100000 },
	{ itemName = "grand sanguine hatchet", clientId = 43869, buy = 100000 },
	{ itemName = "sanguine razor", clientId = 43870, buy = 100000 },
	{ itemName = "grand sanguine razor", clientId = 43871, buy = 100000 },
	{ itemName = "sanguine bludgeon", clientId = 43872, buy = 100000 },
	{ itemName = "grand sanguine bludgeon", clientId = 43873, buy = 100000 },
	{ itemName = "sanguine battleaxe", clientId = 43874, buy = 100000 },
	{ itemName = "grand sanguine battleaxe", clientId = 43875, buy = 100000 },
	{ itemName = "sanguine legs", clientId = 43876, buy = 100000 },
	{ itemName = "sanguine bow", clientId = 43877, buy = 100000 },
	{ itemName = "grand sanguine bow", clientId = 43878, buy = 100000 },
	{ itemName = "sanguine crossbow", clientId = 43879, buy = 100000 },
	{ itemName = "grand sanguine crossbow", clientId = 43880, buy = 100000 },
	{ itemName = "sanguine greaves", clientId = 43881, buy = 100000 },
	{ itemName = "sanguine coil", clientId = 43882, buy = 100000 },
	{ itemName = "grand sanguine coil", clientId = 43883, buy = 100000 },
	{ itemName = "sanguine boots", clientId = 43884, buy = 100000 },
	{ itemName = "sanguine rod", clientId = 43885, buy = 100000 },
	{ itemName = "grand sanguine rod", clientId = 43886, buy = 100000 },
	{ itemName = "sanguine galoshes", clientId = 43887, buy = 100000 },
	{ itemName = "sanguine claws", clientId = 50157, buy = 100000 },
	{ itemName = "grand sanguine claws", clientId = 50158, buy = 100000 },
	{ itemName = "sanguine trousers", clientId = 50146, buy = 100000 },
	{ itemName = "spiritthorn armor", clientId = 39147, buy = 100000 },
	{ itemName = "spiritthorn helmet", clientId = 39148, buy = 100000 },
	{ itemName = "spiritthorn ring", clientId = 39177, buy = 100000 },
	{ itemName = "alicorn headguard", clientId = 39149, buy = 100000 },
	{ itemName = "alicorn quiver", clientId = 39150, buy = 100000 },
	{ itemName = "alicorn ring", clientId = 39182, buy = 100000 },
	{ itemName = "arcanomancer regalia", clientId = 39151, buy = 100000 },
	{ itemName = "arcanomancer folio", clientId = 39152, buy = 100000 },
	{ itemName = "arcanomancer sigil", clientId = 39185, buy = 100000 },
	{ itemName = "arboreal crown", clientId = 39153, buy = 100000 },
	{ itemName = "arboreal tome", clientId = 39154, buy = 100000 },
	{ itemName = "arboreal ring", clientId = 39188, buy = 100000 },
	{ itemName = "soulcutter", clientId = 34082, buy = 100000 },
	{ itemName = "soulshredder", clientId = 34083, buy = 100000 },
	{ itemName = "soulbiter", clientId = 34084, buy = 100000 },
	{ itemName = "souleater", clientId = 34085, buy = 100000 },
	{ itemName = "soulcrusher", clientId = 34086, buy = 100000 },
	{ itemName = "soulmaimer", clientId = 34087, buy = 100000 },
	{ itemName = "soulbleeder", clientId = 34088, buy = 100000 },
	{ itemName = "soulpiercer", clientId = 34089, buy = 100000 },
	{ itemName = "soultainter", clientId = 34090, buy = 100000 },
	{ itemName = "soulhexer", clientId = 34091, buy = 100000 },
	{ itemName = "soulshanks", clientId = 34092, buy = 100000 },
	{ itemName = "soulstrider", clientId = 34093, buy = 100000 },
	{ itemName = "soulshell", clientId = 34094, buy = 100000 },
	{ itemName = "soulmantle", clientId = 34095, buy = 100000 },
	{ itemName = "soulshroud", clientId = 34096, buy = 100000 },
	{ itemName = "pair of soulwalkers", clientId = 34097, buy = 100000 },
	{ itemName = "pair of soulstalkers", clientId = 34098, buy = 100000 },
	{ itemName = "soulbastion", clientId = 34099, buy = 100000 },
	{ itemName = "soulkamas", clientId = 50159, buy = 100000 },
	{ itemName = "soulsoles", clientId = 50240, buy = 100000 },
	{ itemName = "soulgarb", clientId = 50254, buy = 100000 },
	{ itemName = "falcon circlet", clientId = 28714, buy = 100000 },
	{ itemName = "falcon coif", clientId = 28715, buy = 100000 },
	{ itemName = "falcon rod", clientId = 28716, buy = 100000 },
	{ itemName = "falcon wand", clientId = 28717, buy = 100000 },
	{ itemName = "falcon bow", clientId = 28718, buy = 100000 },
	{ itemName = "falcon plate", clientId = 28719, buy = 100000 },
	{ itemName = "falcon greaves", clientId = 28720, buy = 100000 },
	{ itemName = "falcon shield", clientId = 28721, buy = 100000 },
	{ itemName = "falcon escutcheon", clientId = 28722, buy = 100000 },
	{ itemName = "falcon longsword", clientId = 28723, buy = 100000 },
	{ itemName = "falcon battleaxe", clientId = 28724, buy = 100000 },
	{ itemName = "falcon mace", clientId = 28725, buy = 100000 },
	{ itemName = "falcon sai", clientId = 50161, buy = 100000 },
	{ itemName = "lion hammer", clientId = 34254, buy = 100000 },
	{ itemName = "lion axe", clientId = 34253, buy = 100000 },
	{ itemName = "lion amulet", clientId = 34158, buy = 100000 },
	{ itemName = "lion plate", clientId = 34157, buy = 100000 },
	{ itemName = "lion spangenhelm", clientId = 34156, buy = 100000 },
	{ itemName = "lion longsword", clientId = 34155, buy = 100000 },
	{ itemName = "lion shield", clientId = 34154, buy = 100000 },
	{ itemName = "lion spellbook", clientId = 34153, buy = 100000 },
	{ itemName = "lion wand", clientId = 34152, buy = 100000 },
	{ itemName = "lion rod", clientId = 34151, buy = 100000 },
	{ itemName = "lion longbow", clientId = 34150, buy = 100000 },
	{ itemName = "lion claws", clientId = 50162, buy = 100000 },
	{ itemName = "cobra crossbow", clientId = 30393, buy = 100000 },
	{ itemName = "cobra boots", clientId = 30394, buy = 100000 },
	{ itemName = "cobra club", clientId = 30395, buy = 100000 },
	{ itemName = "cobra axe", clientId = 30396, buy = 100000 },
	{ itemName = "cobra hood", clientId = 30397, buy = 100000 },
	{ itemName = "cobra sword", clientId = 30398, buy = 100000 },
	{ itemName = "cobra wand", clientId = 30399, buy = 100000 },
	{ itemName = "cobra rod", clientId = 30400, buy = 100000 },
	{ itemName = "the cobra amulet", clientId = 31631, buy = 100000 },
	{ itemName = "cobra bo", clientId = 50167, buy = 100000 },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	-- promotion
	local node1 = keywordHandler:addKeyword({ "promot" }, StdModule.say, {
		npcHandler = npcHandler,
		onlyFocus = true,
		text = "I can promote you for 1 gold coins. Do you want me to promote you?",
	})
	node1:addChildKeyword({ "yes" }, StdModule.promotePlayer, {
		npcHandler = npcHandler,
		cost = 1,
		level = 20,
		text = "Congratulations! You are now promoted.",
	})
	node1:addChildKeyword({ "no" }, StdModule.say, {
		npcHandler = npcHandler,
		onlyFocus = true,
		text = "Fine.",
		reset = true,
	})
	-- tibia coins
	if MsgContains(message, "tibia coin") or MsgContains(message, "tibia coin") then
		npcHandler:say("Here you are |PLAYERNAME|.", npc, creature)
		player:addItem(22118, npcConfig.amountTibiaCoin)
	end
	-- gold coins
	if MsgContains(message, "money") or MsgContains(message, "gold") then
		npcHandler:say("Here you are |PLAYERNAME|.", npc, creature)
		player:addItem(3043, npcConfig.amountMoney)
	end
	-- experience
	if MsgContains(message, "exp") or MsgContains(message, "experience") then
		if player:getLevel() > npcConfig.maxLevel then
			npcHandler:say("You can not take more experience.", npc, creature)
		else
			npcHandler:say("Here you are |PLAYERNAME|.", npc, creature)
			local level = player:getLevel() + npcConfig.amountLevel - 1
			local experience = ((50 * level * level * level) - (150 * level * level) + (400 * level)) / 3
			player:addExperience(experience - player:getExperience(), true, true)
		end
	end
	-- skills
	if MsgContains(message, "skill") or MsgContains(message, "skills") then
		if player:getMagicLevel() >= 90 and player:getSkillLevel(SKILL_FIST) >= 90 then
			npcHandler:say("You already got skills for testing.", npc, creature)
		else
			npcHandler:say("Here you are |PLAYERNAME|. You received skills for testing.", npc, creature)

			player:setMagicLevel(100)
			player:setSkillLevel(SKILL_FIST, 100)
			player:setSkillLevel(SKILL_CLUB, 100)
			player:setSkillLevel(SKILL_SWORD, 100)
			player:setSkillLevel(SKILL_AXE, 100)
			player:setSkillLevel(SKILL_DISTANCE, 100)
			player:setSkillLevel(SKILL_SHIELD, 100)
			player:setSkillLevel(SKILL_FISHING, 100)

			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			player:sendTextMessage(MESSAGE_STATUS, "You received maximum skills for testing.")
		end
		return true
	end
	-- blessings
	if MsgContains(message, "bless") or MsgContains(message, "blessing") then
		local hasToF = Blessings.Config.HasToF and player:hasBlessing(1) or true
		donthavefilter = function(p, b)
			return not p:hasBlessing(b)
		end
		local missingBless = player:getBlessings(nil, donthavefilter)
		local missingBlessAmt = #missingBless + (hasToF and 0 or 1)

		if missingBlessAmt == 0 then
			player:sendTextMessage(MESSAGE_STATUS, "You are already blessed.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end

		for i, v in ipairs(missingBless) do
			player:addBlessing(v.id, 1)
		end
		npcHandler:say("You have been blessed, |PLAYERNAME|.", npc, creature)
		player:sendTextMessage(MESSAGE_STATUS, "You received the remaining " .. missingBlessAmt .. " blessings.")
		player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
	end
	-- reset your character
	if MsgContains(message, "reset") then
		if player:getLevel() > 8 then
			local level = 7
			local experience = ((50 * level * level * level) - (150 * level * level) + (400 * level)) / 3
			player:removeExperience(player:getExperience() - experience)
		else
			npcHandler:say("You cannot reset anymore.", npc, creature)
		end
	end
	-- outfits
	if MsgContains(message, "outfit") then
		npcHandler:say("Here you are |PLAYERNAME|.", npc, creature)

		local outfits = {
			{
				136,
				137,
				128,
				129,
				141,
				130,
				139,
				131,
				148,
				144,
				140,
				132,
				138,
				133,
				142,
				134,
				147,
				143,
				149,
				145,
				150,
				146,
				155,
				151,
				156,
				152,
				157,
				153,
				158,
				154,
				252,
				251,
				269,
				268,
				270,
				273,
				279,
				278,
				288,
				289,
				324,
				325,
				336,
				335,
				366,
				367,
				329,
				328,
				431,
				430,
				433,
				432,
				463,
				464,
				466,
				465,
				471,
				472,
				513,
				512,
				514,
				516,
				542,
				541,
				575,
				574,
				578,
				577,
				618,
				610,
				620,
				619,
				632,
				633,
				634,
				635,
				636,
				637,
				664,
				665,
				666,
				667,
				683,
				684,
				694,
				695,
				696,
				697,
				698,
				699,
				724,
				725,
				732,
				733,
				745,
				746,
				749,
				750,
				759,
				760,
				845,
				846,
				852,
				853,
				874,
				873,
				885,
				884,
				900,
				899,
				909,
				908,
				929,
				931,
				956,
				955,
				958,
				957,
				963,
				962,
				965,
				964,
				967,
				966,
				969,
				968,
				971,
				970,
				973,
				972,
				975,
				974,
				1021,
				1020,
				1024,
				1023,
				1043,
				1042,
				1050,
				1051,
				1057,
				1056,
				1070,
				1069,
				1095,
				1094,
				1103,
				1102,
				1128,
				1127,
				1147,
				1146,
				1162,
				1161,
				1174,
				1173,
				1187,
				1186,
				1203,
				1202,
				1205,
				1204,
				1207,
				1206,
				1211,
				1210,
				1244,
				1243,
				1246,
				1245,
				1252,
				1251,
				1270,
				1271,
				1280,
				1279,
				1283,
				1282,
				1289,
				1288,
				1293,
				1292,
				1323,
				1322,
				1332,
				1331,
				1338,
				1339,
				1372,
				1371,
				1383,
				1382,
				1385,
				1384,
				1387,
				1386,
				1416,
				1415,
				1437,
				1436,
				1445,
				1444,
				1450,
				1449,
				1456,
				1457,
				1461,
				1460,
				1490,
				1489,
				1501,
				1500,
				1569,
				1568,
				1576,
				1575,
				1582,
				1581,
				1598,
				1597,
				1613,
				1612,
				1619,
				1618,
				1663,
				1662,
				1676,
				1675,
				1681,
				1680,
				1714,
				1713,
				1723,
				1722,
				1726,
				1725,
				1746,
				1745,
				1775,
				1774,
				1777,
				1776,
				1808,
				1809,
				1832,
				1831,
				1837,
				1838,
				1845,
				1846,
				1860,
				1861,
				1874,
				1875,
			},
		}

		for _, outfitId in ipairs(outfits[1]) do
			player:addOutfit(outfitId)
			player:addOutfitAddon(outfitId, 3)
		end

		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:sendTextMessage(MESSAGE_STATUS, "You received all available outfits and addons.")
	end
	-- mounts
	if MsgContains(message, "mount") then
		npcHandler:say("Here you are |PLAYERNAME|", npc, creature)

		for mountId = 1, 245 do
			player:addMount(mountId)
		end

		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:sendTextMessage(MESSAGE_STATUS, "You received all available mounts.")
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(
	MESSAGE_GREET,
	"Hey |PLAYERNAME|. I'm Testserver Assistant and I can give {outfits}, {mounts}, {promotion}, {money}, {tibia coins}, {experience}, {skills} and {blessing} which will be useful for testing on " .. configManager.getString(configKeys.SERVER_NAME) .. " server." .. " You can return to level 8 with {reset}. Ask me for {trade} to test weapons and armor along other items."
)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Rude.")

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

-- npcType registering the npcConfig table

-- Dialog options (interactive icons in the NPC conversation window)
npcType:addDialogOptions("trade", "bye")

npcType:register(npcConfig)
