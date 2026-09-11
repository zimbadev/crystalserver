local supremeCube = Action()

local config = {
    price = 2000,
    soulCost = 2,
    storage = 9007,
    cooldown = 30
}

local CONDITIONS_TO_CLEAR = {
    CONDITION_POISON, CONDITION_FIRE, CONDITION_ENERGY, CONDITION_BLEEDING,
    CONDITION_PARALYZE, CONDITION_HASTE, CONDITION_OUTFIT, CONDITION_INVISIBLE,
    CONDITION_SOUL, CONDITION_DROWN, CONDITION_MUTED, CONDITION_DAZZLED,
    CONDITION_CURSED, CONDITION_FREEZING, CONDITION_PACIFIED, CONDITION_FEARED,
    CONDITION_ROOTED, CONDITION_BAKRAGORE,
}

local function clearAllIconsAndEffects(player)
    -- Remove client icons (if your core supports icons)
    if player.removeIcon then
        for id = 0, 255 do
            player:removeIcon(id)
        end
        if player.sendIcons then
            player:sendIcons()
        end
    end

    if player.sendCreatureIcon then
        player:sendCreatureIcon(player)
    end

    for _, c in ipairs(CONDITIONS_TO_CLEAR) do
        player:removeCondition(c)
    end

    player:getPosition():sendMagicEffect(CONST_ME_POFF)
end

local cities = {
    { name = "Ab'Dendriel", teleport = Position(32671, 31678, 7), requiredLevel = 8 },
    { name = "Ankrahmun", teleport = Position(33160, 32865, 7), requiredLevel = 8 },
    { name = "Carlin", teleport = Position(32347, 31794, 7), requiredLevel = 8 },
    { name = "Darashia", teleport = Position(33223, 32422, 7), requiredLevel = 8 },
    { name = "Edron", teleport = Position(33188, 31854, 7), requiredLevel = 8 },
    { name = "Farmine", teleport = Position(33004, 31482, 10), requiredLevel = 8 },
    { name = "Issavi", teleport = Position(33958, 31482, 6), requiredLevel = 8 },
    { name = "Kazordoon", teleport = Position(32631, 31929, 11), requiredLevel = 8 },
    { name = "Krailos", teleport = Position(33644, 31674, 7), requiredLevel = 8 },
    { name = "Liberty Bay", teleport = Position(32321, 32838, 7), requiredLevel = 8 },
    { name = "Marapur", teleport = Position(33788, 32759, 5), requiredLevel = 8 },
    { name = "Port Hope", teleport = Position(32623, 32759, 7), requiredLevel = 8 },
    { name = "Rathleton", teleport = Position(33668, 31918, 6), requiredLevel = 8 },
    { name = "Roshamuul", teleport = Position(33532, 32378, 7), requiredLevel = 8 },
    { name = "Svargrond", teleport = Position(32285, 31141, 7), requiredLevel = 8 },
    { name = "Thais", teleport = Position(32325, 32228, 7), requiredLevel = 8 },
    { name = "Venore", teleport = Position(32924, 32062, 6), requiredLevel = 8 },
    { name = "Yalahar", teleport = Position(32805, 31238, 7), requiredLevel = 8 },
    { name = "Grey Beach", teleport = Position(33463, 31319, 7), requiredLevel = 8 },
    { name = "Adventurer Island", teleport = Position(32210, 32300, 6), requiredLevel = 8 }
}
table.sort(cities, function(a, b) return a.name < b.name end)

local bossCategories = {
    ["Grave Danger"] = {
        { name = "Scarlett Etzel", teleport = Position(33395, 32670, 6), requiredLevel = 100 },
        { name = "Duke Krule", teleport = Position(32347, 32167, 12), requiredLevel = 100 },
        { name = "Earl Osam", teleport = Position(33262, 31981, 8), requiredLevel = 100 },
        { name = "Count Vlarkorth", teleport = Position(33195, 31690, 8), requiredLevel = 100 },
        { name = "Sir Nictros and Baeloc", teleport = Position(33290, 32474, 9), requiredLevel = 100 },
        { name = "Lord Azaram", teleport = Position(32192, 31819, 8), requiredLevel = 100 },
        { name = "King Zelos", teleport = Position(32172, 31918, 8), requiredLevel = 100 },
    },

    ["Cults of Tibia"] = {
        { name = "Ravenous Hunger", teleport = Position(32668, 31540, 9), requiredLevel = 100 },
        { name = "The Unarmored Voidborn", teleport = Position(33177, 31843, 15), requiredLevel = 100 },
        { name = "The Souldespoiler", teleport = Position(33109, 31887, 15), requiredLevel = 100 },
        { name = "The Sandking", teleport = Position(33511, 32234, 10), requiredLevel = 100 },
        { name = "The False God", teleport = Position(33181, 31894, 15), requiredLevel = 100 },
        { name = "Essence of Malice", teleport = Position(32349, 31673, 10), requiredLevel = 100 },
        { name = "The Source of Corruption", teleport = Position(33453, 32246, 7), requiredLevel = 100 },
    },

    ["Forgotten Knowledge"] = {
        { name = "Lloyd", teleport = Position(32757, 32875, 14), requiredLevel = 100 },
        { name = "Lady Tenebris", teleport = Position(32918, 31637, 14), requiredLevel = 100 },
        { name = "Frozen Horror", teleport = Position(32319, 31094, 14), requiredLevel = 100 },
        { name = "The Thorn Knight", teleport = Position(32679, 32886, 14), requiredLevel = 100 },
        { name = "The Dragonking Zyrtarch", teleport = Position(33410, 31172, 10), requiredLevel = 100 },
        { name = "The Time Guardian", teleport = Position(33026, 31666, 14), requiredLevel = 100 },
        { name = "The Last Lore Keeper", teleport = Position(32037, 32861, 14), requiredLevel = 100 },
    },

    ["Ferumbras Ascension"] = {
        { name = "Plagirath", teleport = Position(33196, 31439, 13), requiredLevel = 100 },
        { name = "Zamulosh", teleport = Position(33664, 32682, 10), requiredLevel = 100 },
        { name = "Mazoran", teleport = Position(33591, 32654, 14), requiredLevel = 100 },
        { name = "Razzagorn", teleport = Position(33404, 32403, 15), requiredLevel = 100 },
        { name = "Ragiaz", teleport = Position(33429, 32332, 14), requiredLevel = 100 },
        { name = "Tarbaz", teleport = Position(33484, 32774, 12), requiredLevel = 100 },
        { name = "Shulgrax", teleport = Position(33438, 32794, 13), requiredLevel = 100 },
        { name = "Ferumbras Mortal Shell", teleport = Position(33266, 31484, 14), requiredLevel = 100 },
    },

    ["Secret Library"] = {
        { name = "Grand Master Oberon", teleport = Position(33287, 31289, 9), requiredLevel = 100 },
        { name = "Brokul", teleport = Position(33519, 31468, 15), requiredLevel = 100 },
        { name = "Lokathmor", teleport = Position(32464, 32650, 12), requiredLevel = 100 },
        { name = "Mazzinor", teleport = Position(32616, 32533, 13), requiredLevel = 100 },
        { name = "Ghulosh", teleport = Position(32660, 32713, 13), requiredLevel = 100 },
        { name = "Gorzindel", teleport = Position(32660, 32732, 12), requiredLevel = 100 },
        { name = "The Scourge of Oblivion", teleport = Position(32480, 32605, 15), requiredLevel = 100 },
    },

    ["Feaster of Souls"] = {
        { name = "Unaz the Mean", teleport = Position(33568, 31477, 8), requiredLevel = 100 },
        { name = "Irgix The Flimsy", teleport = Position(33493, 31399, 8), requiredLevel = 100 },
        { name = "Vok the Freakish", teleport = Position(33511, 31452, 9), requiredLevel = 100 },
        { name = "Brain Head", teleport = Position(31977, 32328, 10), requiredLevel = 100 },
        { name = "The Unwelcome", teleport = Position(33608, 31523, 10), requiredLevel = 100 },
        { name = "The Dread Maiden", teleport = Position(33556, 31518, 10), requiredLevel = 100 },
        { name = "The Fear Feaster", teleport = Position(33606, 31494, 10), requiredLevel = 100 },
        { name = "The Pale Worm", teleport = Position(33569, 31446, 10), requiredLevel = 100 },
    },

    ["Kilmaresh Bosses"] = {
        { name = "Urmahlullu The Immaculate", teleport = Position(33920, 31608, 8), requiredLevel = 100 },
        { name = "Neferi the Spy", teleport = Position(33888, 31478, 6), requiredLevel = 100 },
        { name = "Amenef the Burning", teleport = Position(33819, 31776, 10), requiredLevel = 100 },
        { name = "Sister Hetai", teleport = Position(33883, 31471, 9), requiredLevel = 100 },
        { name = "Bragrumol", teleport = Position(33789, 31598, 8), requiredLevel = 100 },
        { name = "Xogixath", teleport = Position(33787, 31482, 8), requiredLevel = 100 },
        { name = "Mozradek", teleport = Position(33947, 31450, 9), requiredLevel = 100 },
    },

    ["Warzones"] = {
        { name = "Deathstrike", teleport = Position(33100, 31903, 10), requiredLevel = 100 },
        { name = "Gnomevil", teleport = Position(33091, 31983, 11), requiredLevel = 100 },
        { name = "Abyssador", teleport = Position(33084, 31875, 12), requiredLevel = 100 },
        { name = "The Baron From Below", teleport = Position(33462, 32268, 15), requiredLevel = 100 },
        { name = "The Count Of The Core", teleport = Position(33323, 32112, 15), requiredLevel = 100 },
        { name = "The Duke Of The Depths", teleport = Position(33275, 32319, 15), requiredLevel = 100 },
        { name = "The Brainstealer", teleport = Position(32053, 31463, 15), requiredLevel = 100 },
    },

    ["Werebosses"] = {
        { name = "Black Vixen", teleport = Position(33443, 32053, 9), requiredLevel = 100 },
        { name = "Shadowpelt", teleport = Position(33404, 32098, 9), requiredLevel = 100 },
        { name = "Sharpclaw", teleport = Position(33128, 31973, 9), requiredLevel = 100 },
        { name = "Darkfang", teleport = Position(33054, 31912, 9), requiredLevel = 100 },
        { name = "Bloodback", teleport = Position(33166, 31978, 8), requiredLevel = 100 },
        { name = "Lion Sanctum", teleport = Position(33123, 32242, 12), requiredLevel = 100 },
    },

    ["The Dream Courts"] = {
        { name = "Alptramun", teleport = Position(32212, 32035, 13), requiredLevel = 100 },
        { name = "The Nightmare Beast", teleport = Position(32208, 32085, 15), requiredLevel = 100 },
    },

    ["Heart of Destruction"] = {
        { name = "World Devourer", teleport = Position(32212, 31376, 14), requiredLevel = 100 },
        { name = "Anomaly", teleport = Position(32102, 31328, 12), requiredLevel = 100 },
        { name = "Rupture", teleport = Position(32087, 31324, 13), requiredLevel = 100 },
    },

    ["Others"] = {
        { name = "Drume", teleport = Position(32459, 32502, 7), requiredLevel = 100 },
        { name = "Faceless Bane", teleport = Position(33618, 32523, 15), requiredLevel = 100 },
        { name = "Soul War", teleport = Position(33622, 31432, 10), requiredLevel = 300 },
        { name = "Rotten Blood", teleport = Position(32975, 32401, 9), requiredLevel = 300 },
        { name = "Timira The Many-Headed", teleport = Position(33803, 32705, 7), requiredLevel = 200 },
        { name = "Tentugly's Head", teleport = Position(33795, 31385, 6), requiredLevel = 100 },
        { name = "Ratmiral Blackwhiskersk", teleport = Position(33890, 31197, 7), requiredLevel = 100 },
        { name = "Dragon Pack", teleport = Position(33276, 31059, 13), requiredLevel = 100 },
        { name = "The Primal Menace", teleport = Position(33714, 32799, 14), requiredLevel = 250 },
        { name = "Magma Bubble", teleport = Position(33660, 32897, 14), requiredLevel = 250 },
        { name = "The Monster", teleport = Position(33792, 32579, 12), requiredLevel = 100 },
        { name = "Sugar Daddy", teleport = Position(33398, 32204, 9), requiredLevel = 100 },
        { name = "The Rootkraken", teleport = Position(33852, 31983, 11), requiredLevel = 250 },
        { name = "Arbaziloth", teleport = Position(33877, 32399, 10), requiredLevel = 250 },
        { name = "Jaul", teleport = Position(33558, 31284, 11), requiredLevel = 100 },
        { name = "Mitmah Vanguard", teleport = Position(34050, 31435, 11), requiredLevel = 100 },
        { name = "Ahau", teleport = Position(34034, 31717, 10), requiredLevel = 100 },
        { name = "Vladrukh", teleport = Position(32894, 31420, 12), requiredLevel = 200 },
    }
}

local function validateUse(player)

    local tile = player:getTile()
    if not tile then
        return false, "You cannot use this here."
    end

    local inPz = tile:hasFlag(TILESTATE_PROTECTIONZONE)
    local inNologout = tile:hasFlag(TILESTATE_NOLOGOUT)
    local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)

    if not inPz and inFight then
        return false, "You cannot use this in combat."
    end

    if inNologout then
        return false, "You cannot use this in a no-logout zone."
    end

    if player:getMoney() + player:getBankBalance() < config.price then
        return false, "You do not have enough money."
    end

    if player:getSoul() < config.soulCost then
        return false, "You do not have enough soul points (" .. config.soulCost .. " required)."
    end

    local now = os.time()
    local cd = player:getStorageValue(config.storage)
    if cd ~= -1 and cd > now then
        local remaining = cd - now
        return false, "You must wait " .. remaining .. " seconds before using this again."
    end

    return true, nil
end

local function performTeleport(player, toPos, destinationName)
    if not toPos then
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The destination position is invalid.")
        return
    end

    local ok, err = validateUse(player)
    if not ok then
        local pos = player:getPosition()
        pos:sendMagicEffect(err:find("wait") and CONST_ME_AGONY or CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, err)
        return
    end

    local fromPos = player:getPosition()

    player:teleportTo(toPos, true)
    player:removeMoneyBank(config.price)
    player:addSoul(-config.soulCost)

    clearAllIconsAndEffects(player)

    fromPos:sendMagicEffect(201)
    player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have teleported to " .. destinationName)
    player:setDirection(DIRECTION_SOUTH)
    player:setStorageValue(config.storage, os.time() + config.cooldown)
end

-- Forward declarations for mutual recursion
local showMainWindow
local showBossCategories
local showTeleportMenu

-- Resolve the guild hall belonging to the player's guild leader.
-- Returns a House or nil if the guild has no guild hall.
local function getGuildLeaderHouse(player)
    local guild = player:getGuild()
    if not guild then
        return nil
    end

    -- The guild leader's GUID is stored authoritatively in `guilds`.`ownerid`.
    local resultId = db.storeQuery(
        "SELECT `ownerid` FROM `guilds` WHERE `id` = " .. guild:getId() .. " LIMIT 1"
    )
    if not resultId then
        return nil
    end

    local leaderGuid = result.getNumber(resultId, "ownerid")
    result.free(resultId)
    if not leaderGuid or leaderGuid == 0 then
        return nil
    end

    -- A guild hall's owner column holds the GUID of the player who owns it
    -- (by convention the guild leader). Match the guild hall to that GUID.
    for _, house in ipairs(Game.getHouses()) do
        if house:isGuildhall() and house:getOwnerGuid() == leaderGuid then
            return house
        end
    end

    return nil
end

showTeleportMenu = function(player, title, list, backCallback)
    local window = ModalWindow({
        title = title,
        message = "Select a destination.",
    })

    for _, entry in ipairs(list) do
        window:addChoice(entry.name, function(player, button)
            if button.name ~= "Select" then
                return
            end

            if player:getLevel() < entry.requiredLevel then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                    "You need at least level " .. entry.requiredLevel .. " to go to this place.")
                return
            end

            performTeleport(player, entry.teleport, entry.name)
        end)
    end

    window:addButton("Select")
    window:addButton("Back", function(player) backCallback(player) end)
    window:setDefaultEnterButton(0)
    window:setDefaultEscapeButton(2)
    window:sendToPlayer(player)
end

showBossCategories = function(player)
    local window = ModalWindow({
        title = "Boss Categories",
        message = "Select a boss category:",
    })

    local sortedCategories = {}
    for categoryName in pairs(bossCategories) do
        table.insert(sortedCategories, categoryName)
    end
    table.sort(sortedCategories)

    for _, categoryName in ipairs(sortedCategories) do
        local list = bossCategories[categoryName]
        window:addChoice(categoryName, function(player, button)
            if button.name ~= "Select" then
                return
            end
            showTeleportMenu(player, categoryName, list, showBossCategories)
        end)
    end

    window:addButton("Select")
    window:addButton("Back", function(player) showMainWindow(player) end)
    window:setDefaultEnterButton(0)
    window:setDefaultEscapeButton(2)
    window:sendToPlayer(player)
end

showMainWindow = function(player)
    local window = ModalWindow({
        title = "Supreme Cube 1000gp each tp",
        message = "Select a destination category:",
    })

    window:addChoice("Cities", function(player, button)
        if button.name ~= "Select" then
            return
        end
        showTeleportMenu(player, "Cities", cities, showMainWindow)
    end)

    window:addChoice("Bosses", function(player, button)
        if button.name ~= "Select" then
            return
        end
        showBossCategories(player)
    end)

    local house = player:getHouse()
    if house then
        window:addChoice("House", function(player, button)
            if button.name ~= "Select" then
                return
            end

            local housePosition = house:getExitPosition()
            if not housePosition then
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your house entry position is invalid.")
                return
            end

            performTeleport(player, housePosition, "your house")
        end)
    end

    local guildHall = getGuildLeaderHouse(player)
    if guildHall then
        window:addChoice("Guild Hall", function(player, button)
            if button.name ~= "Select" then
                return
            end

            local hallPosition = guildHall:getExitPosition()
            if not hallPosition then
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your guild hall entry position is invalid.")
                return
            end

            performTeleport(player, hallPosition, "your guild hall")
        end)
    end

    window:addButton("Select")
    window:addButton("Close")
    window:setDefaultEnterButton(0)
    window:setDefaultEscapeButton(2)
    window:sendToPlayer(player)
end

function supremeCube.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local ok, err = validateUse(player)
    if not ok then
        local pos = player:getPosition()
        local effect = err:find("wait") and CONST_ME_AGONY or CONST_ME_POFF
        pos:sendMagicEffect(effect)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, err)
        return false
    end

    showMainWindow(player)
    return true
end

supremeCube:id(31633)
supremeCube:register()

