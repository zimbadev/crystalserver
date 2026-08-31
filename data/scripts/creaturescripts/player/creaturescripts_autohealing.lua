local AUTOHEAL_STORAGE = 65003
local AUTOHEAL_THRESHOLD_STORAGE = 65004

local HEAL_COOLDOWN_MS = 1000
local SPELL_CACHE_TTL_MS = 5000

-- cache: [pid] = { lastAttempt = ms, spells = {...}, spellsExpiry = ms }
local healCache = {}

-- vocation id map (for reference / debug)
local VOCATION_IDS = {
	["sorcerer"] = 1,
	["druid"] = 2,
	["paladin"] = 3,
	["knight"] = 4,
	["monk"] = 9,
	["master sorcerer"] = 5,
	["elder druid"] = 6,
	["royal paladin"] = 7,
	["elite knight"] = 8,
	["exalted monk"] = 10,
}

local HEALING_SPELLS = {
	["Magic Patch"] = {
		words = "exura infir",
		level = 1,
		mana = 6,
		voc = { 2, 6, 3, 7, 1, 5, 9, 10 },
		formula = function(player)
			local ml = player:getMagicLevel()
			return (ml * 0.1614) + 8, (ml * 0.2468) + 15
		end,
		cooldown = 3000,
		groupCooldown = 1000,
		effect = CONST_ME_MAGIC_BLUE,
		dispel = CONDITION_PARALYZE,
		priority = 1,
	},
	["Bruise Bane"] = {
		words = "exura infir ico",
		level = 1,
		mana = 10,
		voc = { 4, 8 },
		formula = function(player)
			local level = player:getLevel()
			local ml = player:getMagicLevel()
			local minv = level * 0.2 + ml * 1.795
			return math.max(1, minv), math.max(1, minv + 5)
		end,
		cooldown = 3000,
		groupCooldown = 1000,
		effect = CONST_ME_MAGIC_BLUE,
		dispel = CONDITION_PARALYZE,
		priority = 2,
	},
	["Light Healing"] = {
		words = "exura",
		level = 8,
		mana = 20,
		voc = { 2, 6, 3, 7, 1, 5, 9, 10 },
		formula = function(player)
			local level = player:getLevel()
			local ml = player:getMagicLevel()
			return (level * 0.2 + ml * 1.4) + 8, (level * 0.2 + ml * 1.795) + 11
		end,
		cooldown = 3000,
		groupCooldown = 1000,
		effect = CONST_ME_MAGIC_BLUE,
		dispel = CONDITION_PARALYZE,
		priority = 3,
	},
	["Wound Cleansing"] = {
		words = "exura ico",
		level = 8,
		mana = 40,
		voc = { 4, 8 },
		formula = function(player)
			local level = player:getLevel()
			local ml = player:getMagicLevel()
			return (level * 0.2 + ml * 4) + 25, (level * 0.2 + ml * 7.95) + 51
		end,
		cooldown = 3000,
		groupCooldown = 1000,
		effect = CONST_ME_MAGIC_BLUE,
		dispel = CONDITION_PARALYZE,
		priority = 3,
	},
	["Intense Healing"] = {
		words = "exura gran",
		level = 20,
		mana = 70,
		voc = { 2, 6, 3, 7, 1, 5, 9, 10 },
		formula = function(player)
			local level = player:getLevel()
			local ml = player:getMagicLevel()
			return (level * 0.2 + ml * 3.184) + 20, (level * 0.2 + ml * 5.59) + 35
		end,
		cooldown = 3000,
		groupCooldown = 1000,
		effect = CONST_ME_MAGIC_BLUE,
		dispel = CONDITION_PARALYZE,
		priority = 5,
	},
	["Ultimate Healing"] = {
		words = "exura vita",
		level = 30,
		mana = 160,
		voc = { 2, 6, 1, 5 },
		formula = function(player)
			local level = player:getLevel()
			local ml = player:getMagicLevel()
			return (level / 5) + (ml * 6.8) + 42, (level / 5) + (ml * 12.9) + 90
		end,
		cooldown = 3000,
		groupCooldown = 1000,
		effect = CONST_ME_MAGIC_BLUE,
		dispel = CONDITION_PARALYZE,
		priority = 7,
	},
	["Divine Healing"] = {
		words = "exura san",
		level = 35,
		mana = 160,
		voc = { 3, 7 },
		formula = function(player)
			local level = player:getLevel()
			local ml = player:getMagicLevel()
			return (level * 0.2 + ml * 7.22) + 44, (level * 0.2 + ml * 12.79) + 79
		end,
		cooldown = 3000,
		groupCooldown = 1000,
		effect = CONST_ME_MAGIC_BLUE,
		dispel = CONDITION_PARALYZE,
		priority = 6,
		premium = true,
	},
	["Intense Wound Cleansing"] = {
		words = "exura gran ico",
		level = 80,
		mana = 200,
		voc = { 4, 8 },
		formula = function(player)
			local level = player:getLevel()
			local ml = player:getMagicLevel()
			return (level * 0.2 + ml * 70) + 438, (level * 0.2 + ml * 92) + 544
		end,
		cooldown = 600000,
		groupCooldown = 1000,
		effect = CONST_ME_MAGIC_BLUE,
		dispel = CONDITION_PARALYZE,
		priority = 7,
		premium = true,
	},
	["Spirit Mend"] = {
		words = "exura gran tio",
		level = 80,
		mana = 210,
		voc = { 9, 10 },
		formula = function(player)
			local level = player:getLevel()
			local ml = player:getMagicLevel()
			return (level * 0.2 + ml * 12) + 75, (level * 0.2 + ml * 20) + 125
		end,
		cooldown = 3000,
		groupCooldown = 1000,
		effect = CONST_ME_MAGIC_BLUE,
		dispel = CONDITION_PARALYZE,
		priority = 7,
		premium = true,
	},
	["Salvation"] = {
		words = "exura gran san",
		level = 60,
		mana = 210,
		voc = { 3, 7 },
		formula = function(player)
			local level = player:getLevel()
			local ml = player:getMagicLevel()
			return (level * 0.2 + ml * 12) + 75, (level * 0.2 + ml * 20) + 125
		end,
		cooldown = 3000,
		groupCooldown = 1000,
		effect = CONST_ME_MAGIC_BLUE,
		dispel = CONDITION_PARALYZE,
		priority = 8,
		premium = true,
	},
	["Fair Wound Cleansing"] = {
		words = "exura med ico",
		level = 300,
		mana = 90,
		voc = { 4, 8 },
		formula = function(player)
			local level = player:getLevel()
			local ml = player:getMagicLevel()
			return ((level * 0.2 + ml * 4 + 25) * 2), ((level * 0.2 + ml * 7.95 + 51) * 2)
		end,
		cooldown = 3000,
		groupCooldown = 1000,
		effect = CONST_ME_MAGIC_BLUE,
		dispel = CONDITION_PARALYZE,
		priority = 5,
		premium = true,
	},
	["Restoration"] = {
		words = "exura max vita",
		level = 300,
		mana = 260,
		voc = { 2, 6, 1, 5 },
		formula = function(player)
			local level = player:getLevel()
			local ml = player:getMagicLevel()
			return (level * 1.4 / 5) + (ml * 9.22 * 1.4) + 44 * 1.4, (level * 1.4 / 5) + (ml * 10.79 * 1.4) + 79 * 1.4
		end,
		cooldown = 6000,
		groupCooldown = 1000,
		effect = CONST_ME_MAGIC_BLUE,
		dispel = CONDITION_PARALYZE,
		priority = 10,
	},
	["Practice Healing"] = {
		words = "exura dis",
		level = 1,
		mana = 5,
		voc = { 4, 8, 3, 7, 1, 5, 2, 6, 9, 10 },
		formula = function(player)
			return 5, 9
		end,
		cooldown = 3000,
		groupCooldown = 1000,
		effect = CONST_ME_MAGIC_BLUE,
		dispel = CONDITION_PARALYZE,
		priority = 1,
	},
}

-- cooldown tracking
local spellCooldowns = {}
local groupCooldowns = {}

local function getMs()
	return os.mtime and os.mtime() or (os.time() * 1000)
end

local function isSpellOnCooldown(player, spell)
	if not player or not player:isPlayer() then
		return true
	end
	local pid = player:getId()
	local now = getMs()

	if spellCooldowns[pid] and spellCooldowns[pid][spell.words] then
		if now < spellCooldowns[pid][spell.words] + spell.cooldown then
			return true
		end
	end
	if groupCooldowns[pid] then
		if now < groupCooldowns[pid] + spell.groupCooldown then
			return true
		end
	end
	return false
end

local function setSpellCooldown(player, spell)
	if not player or not player:isPlayer() then
		return
	end
	local pid = player:getId()
	local now = getMs()
	if not spellCooldowns[pid] then
		spellCooldowns[pid] = {}
	end
	spellCooldowns[pid][spell.words] = now
	groupCooldowns[pid] = now
end

local function hasCondition(player, condType)
	if not player or not player:isPlayer() then
		return false
	end
	return player:hasCondition(condType) or player:getCondition(condType) ~= nil
end

local function calculateHealAmount(spell, player)
	if not player or not player:isPlayer() then
		return 0
	end
	local ok, minv, maxv = pcall(function()
		local a, b = spell.formula(player)
		return a or 0, b or 0
	end)
	if not ok then
		return 0
	end
	minv = math.max(1, math.floor(minv))
	maxv = math.max(minv, math.floor(maxv))
	return math.random(minv, maxv)
end

-- slow criteria check (voc, level, premium) — used to build cache
local function isEligible(player, spell)
	local vocation = player:getVocation()
	if not vocation then
		return false
	end
	local vocId = vocation:getId()
	local vocOk = false
	for _, v in ipairs(spell.voc) do
		if vocId == v then
			vocOk = true
			break
		end
	end
	if not vocOk then
		return false
	end
	if player:getLevel() < spell.level then
		return false
	end
	if spell.premium and not player:isPremium() then
		return false
	end
	return true
end

-- fast criteria check (mana, cooldown) — always live
local function canUseSpell(player, spell)
	if player:getMana() < spell.mana then
		return false
	end
	if isSpellOnCooldown(player, spell) then
		return false
	end
	return true
end

local function getAvailableHealingSpells(player)
	if not player or not player:isPlayer() then
		return {}
	end

	local hp = player:getHealth()
	local maxHp = player:getMaxHealth()
	if maxHp <= 0 then
		return {}
	end

	local customThreshold = player:getStorageValue(AUTOHEAL_THRESHOLD_STORAGE)
	local healthThreshold = (customThreshold > 0 and customThreshold <= 100) and (customThreshold / 100) or 0.20

	if hp > maxHp * healthThreshold then
		return {}
	end

	local pid = player:getId()
	local now = getMs()
	local cache = healCache[pid]

	-- rebuild slow-criteria cache if expired
	if not cache or not cache.spells or now >= (cache.spellsExpiry or 0) then
		local eligible = {}
		for name, spell in pairs(HEALING_SPELLS) do
			if isEligible(player, spell) then
				table.insert(eligible, { spell = spell, name = name })
			end
		end
		if not healCache[pid] then
			healCache[pid] = {}
		end
		healCache[pid].spells = eligible
		healCache[pid].spellsExpiry = now + SPELL_CACHE_TTL_MS
		cache = healCache[pid]
	end

	-- filter cached eligibles by fast criteria
	local available = {}
	for _, entry in ipairs(cache.spells) do
		if canUseSpell(player, entry.spell) then
			local healAmount = calculateHealAmount(entry.spell, player)
			if healAmount > 0 then
				table.insert(available, {
					spell = entry.spell,
					name = entry.name,
					priority = entry.spell.priority + (entry.spell.dispel and hasCondition(player, entry.spell.dispel) and 5 or 0),
					healAmount = healAmount,
				})
			end
		end
	end

	table.sort(available, function(a, b)
		if a.priority == b.priority then
			return a.healAmount > b.healAmount
		end
		return a.priority > b.priority
	end)

	return available
end

local function tryHealingSpell(player)
	if not player or not player:isPlayer() then
		return
	end
	if player:getStorageValue(AUTOHEAL_STORAGE) ~= 1 then
		return
	end

	local pid = player:getId()
	local now = getMs()
	local cache = healCache[pid]

	-- throttle rapid fire calls
	if cache and cache.lastAttempt and (now - cache.lastAttempt) < HEAL_COOLDOWN_MS then
		return
	end

	local available = getAvailableHealingSpells(player)
	if #available == 0 then
		return
	end

	local best = available[1]
	local spell = best.spell

	if not healCache[pid] then
		healCache[pid] = {}
	end
	healCache[pid].lastAttempt = now

	setSpellCooldown(player, spell)
	player:addMana(-spell.mana)
	player:addHealth(best.healAmount)

	if spell.dispel and hasCondition(player, spell.dispel) then
		player:removeCondition(spell.dispel)
	end

	local talkType = configManager.getBoolean(configKeys.EMOTE_SPELLS) and TALKTYPE_MONSTER_SAY or TALKTYPE_SAY

	player:say(spell.words, talkType)
	player:getPosition():sendMagicEffect(spell.effect)
	player:sendTextMessage(MESSAGE_HEALED, string.format("You heal yourself for %d hitpoints.", best.healAmount))
end

-- CreatureEvents
local healthEvent = CreatureEvent("AutoHealHealthChange")
function healthEvent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if creature:isPlayer() then
		tryHealingSpell(creature)
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end
healthEvent:register()

local logoutEvent = CreatureEvent("AutoHealLogout")
function logoutEvent.onLogout(player)
	local pid = player:getId()
	healCache[pid] = nil
	spellCooldowns[pid] = nil
	groupCooldowns[pid] = nil
	return true
end
logoutEvent:register()
