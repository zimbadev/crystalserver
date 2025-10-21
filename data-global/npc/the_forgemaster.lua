local internalNpcName = "The Forgemaster"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 150
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 247,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.currency = 37317

npcConfig.shop = {}

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i tibia tokens.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "I'll be doing my job, same as ever. Just lay out your arms." },
	{ text = "I knew you'd be back. Lay out your arms. Let's get to smithing." },
	{ text = "Ah, You, is it? I... didn't notice you there." },
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

local weapon = {}
local selectedType = {}

local forgeItem = {
	-- Critical hit
	["critical_bow"] = { requiredID = 49520, forgedID = 49858 },
	["critical_crossbow"] = { requiredID = 49522, forgedID = 49861 },
	["critical_twohand_sword"] = { requiredID = 49530, forgedID = 49879 },
	["critical_twohand_club"] = { requiredID = 49526, forgedID = 49873 },
	["critical_twohand_axe"] = { requiredID = 49524, forgedID = 49867 },
	["critical_onehand_sword"] = { requiredID = 49527, forgedID = 49876 },
	["critical_onehand_club"] = { requiredID = 49525, forgedID = 49870 },
	["critical_onehand_axe"] = { requiredID = 49523, forgedID = 49864 },
	["critical_wand"] = { requiredID = 49528, forgedID = 49882 },
	["critical_rod"] = { requiredID = 49529, forgedID = 49885 },
	["critical_fist"] = { requiredID = 50250, forgedID = 50251 },
	-- Heal steal
	["life_bow"] = { requiredID = 49520, forgedID = 49859 },
	["life_crossbow"] = { requiredID = 49522, forgedID = 49862 },
	["life_twohand_sword"] = { requiredID = 49530, forgedID = 49880 },
	["life_twohand_club"] = { requiredID = 49526, forgedID = 49874 },
	["life_twohand_axe"] = { requiredID = 49524, forgedID = 49868 },
	["life_onehand_sword"] = { requiredID = 49527, forgedID = 49877 },
	["life_onehand_club"] = { requiredID = 49525, forgedID = 49871 },
	["life_onehand_axe"] = { requiredID = 49523, forgedID = 49865 },
	["life_wand"] = { requiredID = 49528, forgedID = 49883 },
	["life_rod"] = { requiredID = 49529, forgedID = 49886 },
	-- Mana drain
	["mana_bow"] = { requiredID = 49520, forgedID = 49860 },
	["mana_crossbow"] = { requiredID = 49522, forgedID = 49863 },
	["mana_twohand_sword"] = { requiredID = 49530, forgedID = 49881 },
	["mana_twohand_club"] = { requiredID = 49526, forgedID = 49875 },
	["mana_twohand_axe"] = { requiredID = 49524, forgedID = 49869 },
	["mana_onehand_sword"] = { requiredID = 49527, forgedID = 49878 },
	["mana_onehand_club"] = { requiredID = 49525, forgedID = 49872 },
	["mana_onehand_axe"] = { requiredID = 49523, forgedID = 49866 },
	["mana_wand"] = { requiredID = 49528, forgedID = 49884 },
	["mana_rod"] = { requiredID = 49529, forgedID = 49887 },
}

local requiredItems = {
	["critical"] = {
		{ id = 49892, count = 1 }, -- demon finger
		{ id = 12541, count = 1 }, -- skin of Gravalon
		{ id = 22728, count = 100 }, -- vexclaw talons
		{ id = 49894, count = 500 }, -- demonic matter
		{ id = 5954, count = 50 }, -- demon horn
		{ id = 6499, count = 350 }, -- demonic essence
		{ id = 6558, count = 750 }, -- demonic blood
	},
	["mana"] = {
		{ id = 49891, count = 1 }, -- skin of Twisterror
		{ id = 22730, count = 100 }, -- grimeleech wings
		{ id = 49894, count = 500 }, -- demonic matter
		{ id = 6499, count = 750 }, -- demonic essence
		{ id = 9647, count = 200 }, -- demonic skeletal hand
	},
	["life"] = {
		{ id = 49893, count = 1 }, -- skin of Malvaroth
		{ id = 9663, count = 100 }, -- pieces of dead brain
		{ id = 49894, count = 500 }, -- demonic matter
		{ id = 6558, count = 750 }, -- demonic blood
		{ id = 5906, count = 50 }, -- demon dust
	},
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if not player or not playerId then
		return false
	end

	if MsgContains(message, "key") then
		if player:getStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.ForgemasterDoor.Questline) == 2 then
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.ForgeMaster.AccessDoor, 1)
			player:setStorageValue(Storage.Quest.U14_10.NoRestForTheWicked.ForgemasterDoor.Questline, 3)
			npcHandler:say("You have proven yourself worthy. The door to the Forgemaster's chamber is now accessible.", npc, creature)
		else
			npcHandler:say("You are not ready yet. Proove yourself worthy first.", npc, creature)
		end
		return true
	end

	if MsgContains(message, "token") or MsgContains(message, "tokens") then
		npcHandler:say("If you have some tokens i can show you, i have some rare items to {exchange}.", npc, creature)
	elseif MsgContains(message, "forge") then
		npcHandler:say("You can forge you base Inferniarch Weapons into better versions.", npc, creature)
	elseif MsgContains(message, "exchange") then
		npc:openShopWindow(creature)
		npcHandler:say({ "Here's the deal, " .. player:getName() .. ". you can trade some items if you have a lot of Tibia Tokens!" }, npc, creature)
	elseif MsgContains(message, "craft") then
		npcHandler:say({
			"If you have the ingredients, I can channel the ancient demonic power of this place into {fist}s, {sword}s, {club}s, {axe}s {bow}s, {crossbow}s, {wand}s and {rod}s.",
			"But please know that this is only possible for unfused equipment that has not been treated at the Exaltation Forge.",
		}, npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "sword", "club", "axe" }, message:lower()) and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say("Do you want it for {twohand_" .. message .. "} or {onehand_" .. message .. "}?", npc, creature)
		weapon[playerId] = message:lower()
		npcHandler:setTopic(playerId, 2)
	elseif table.contains({ "fist" }, message:lower()) and npcHandler:getTopic(playerId) == 1 then
		weapon[playerId] = message:lower()
		npcHandler:say("Do you want to craft an inferniarch fist weapon that is destined to deal {critical} hits?", npc, creature)
		npcHandler:setTopic(playerId, 3)
	elseif table.contains({ "bow", "crossbow", "wand", "rod" }, message:lower()) and npcHandler:getTopic(playerId) == 1 then
		weapon[playerId] = message:lower()
		npcHandler:say("Do you want to craft an inferniarch " .. message .. " that is destined to deal {critical} hits, steal the {life} force of your enemies or absorb the {mana} pf your foes?", npc, creature)
		npcHandler:setTopic(playerId, 3)
	elseif table.contains({ "twohand_sword", "twohand_club", "twohand_axe", "onehand_sword", "onehand_club", "onehand_axe" }, message:lower()) and npcHandler:getTopic(playerId) == 2 then
		weapon[playerId] = message:lower()
		npcHandler:say("Do you want to craft an inferniarch " .. weapon[playerId]:gsub("twohand_", ""):gsub("onehand_", "") .. " that is destined to deal {critical} hits, steal the {life} force of your enemies or absorb the {mana} pf your foes?", npc, creature)
		npcHandler:setTopic(playerId, 3)
	elseif table.contains({ "critical", "life", "mana" }, message:lower()) and npcHandler:getTopic(playerId) == 3 then
		selectedType[playerId] = message:lower()
		if message:lower() == "critical" then
			npcHandler:say("In this case, you will need to spend the base version of your weapon, 100 vexclaw talons, 500 samples of demonic matter, 50 demon horns, 750 flask of demonic blood, 350 demonic essences, 1 demon finger and 1 skin of Gravalon. Do you want to proceed, {yes}?", npc, creature)
		elseif message:lower() == "life" then
			npcHandler:say("In this case, you will need to spend the base version of your weapon, 100 pieces of dead brain, 500 samples of demonic matter, 750 flask of demonic blood, 50 demon dust and 1 skin of Malvaroth. Do you want to proceed, {yes}?", npc, creature)
		elseif message:lower() == "mana" then
			npcHandler:say("In this case, you will need to spend the base version of your weapon, 100 some grimeleech wings, 500 samples of demonic matter, 750 demonic essences, 200 demonic skeletal hands and 1 skin of twisterror. Do you want to proceed, {yes}?", npc, creature)
		end
		npcHandler:setTopic(playerId, 4)
	elseif npcHandler:getTopic(playerId) == 4 then
		if MsgContains(message, "yes") then
			local itemsRequired = requiredItems[selectedType[playerId]]
			if not itemsRequired then
				npcHandler:say("No items found for this weapon class.", npc, creature)
				return false
			end

			for _, item in pairs(itemsRequired) do
				if player:getItemCount(item.id) < item.count then
					local itemName = ItemType(item.id):getName()
					npcHandler:say("You need " .. item.count - player:getItemCount(item.id) .. " " .. itemName .. " to craft it.", npc, creature)
					return false
				end
			end

			if player:getItemCount(forgeItem[selectedType[playerId] .. "_" .. weapon[playerId]].requiredID) < 1 then
				local itemName = ItemType(forgeItem[selectedType[playerId] .. "_" .. weapon[playerId]].requiredID):getName()
				npcHandler:say("You don't have an " .. itemName .. ".", npc, creature)
				return false
			end

			for _, item in pairs(itemsRequired) do
				player:removeItem(item.id, item.count)
			end

			player:removeItem(forgeItem[selectedType[playerId] .. "_" .. weapon[playerId]].requiredID, 1)
			player:addItem(forgeItem[selectedType[playerId] .. "_" .. weapon[playerId]].forgedID, 1)
			npcHandler:say("Here you go.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif MsgContains(message, "no") then
			npcHandler:say("Alright, come back if you have changed your mind.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "What brings you here this time, do you want to {craft} weapon in the forge?")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
