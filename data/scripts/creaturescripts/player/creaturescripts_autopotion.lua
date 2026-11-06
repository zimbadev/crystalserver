-- config
local STORAGE = 65000
local STORAGE_THRESHOLD = 65001

local DEFAULT_HEALTH_THRESHOLD = 0.40
local DEFAULT_MANA_THRESHOLD = 0.40

-- minimum ms between potion attempts per player
local POTION_COOLDOWN_MS = 1000

-- cache: [pid] = { lastAttempt = ms }
local potionCache = {}

-- potion data
local POTION_DATA = {
	-- (EVERYONE)
	[7876] = { health = { 60, 90 }, flask = 285 }, -- small health potion
	[266] = { health = { 125, 175 }, flask = 285 }, -- health potion
	[268] = { mana = { 75, 125 }, flask = 285 }, -- mana potion

	[237] = { mana = { 115, 185 }, flask = 283, level = 50 }, -- strong mana potion

	-- (KNIGHT, PALADIN, MONK)
	[236] = { health = { 250, 350 }, flask = 283, level = 50, voc = {
		VOCATION.BASE_ID.PALADIN,
		VOCATION.BASE_ID.KNIGHT,
		VOCATION.BASE_ID.MONK,
	} },

	-- (KNIGHT)
	[239] = { health = { 425, 575 }, flask = 284, level = 80, voc = { VOCATION.BASE_ID.KNIGHT } },
	[7643] = { health = { 650, 850 }, flask = 284, level = 130, voc = { VOCATION.BASE_ID.KNIGHT } },
	[23375] = { health = { 875, 1125 }, flask = 284, level = 200, voc = { VOCATION.BASE_ID.KNIGHT } },

	-- (SORCERER, DRUID, PALADIN, MONK)
	[238] = { mana = { 150, 250 }, flask = 284, level = 80, voc = {
		VOCATION.BASE_ID.SORCERER,
		VOCATION.BASE_ID.DRUID,
		VOCATION.BASE_ID.PALADIN,
		VOCATION.BASE_ID.MONK,
	} },

	-- (PALADIN & MONK)
	[7642] = { health = { 250, 350 }, mana = { 100, 200 }, flask = 284, level = 80, voc = {
		VOCATION.BASE_ID.PALADIN,
		VOCATION.BASE_ID.MONK,
	} },
	[23374] = { health = { 420, 580 }, mana = { 250, 350 }, flask = 284, level = 130, voc = {
		VOCATION.BASE_ID.PALADIN,
		VOCATION.BASE_ID.MONK,
	} },

	-- (SORCERER & DRUID)
	[23373] = { mana = { 425, 575 }, flask = 284, level = 130, voc = {
		VOCATION.BASE_ID.SORCERER,
		VOCATION.BASE_ID.DRUID,
	} },
}

-- helpers
local function getMs()
	return os.mtime and os.mtime() or (os.time() * 1000)
end

local function createExhaustCondition()
	local exhaust = Condition(CONDITION_EXHAUST_HEAL)
	exhaust:setParameter(CONDITION_PARAM_TICKS, (configManager.getNumber(configKeys.EX_ACTIONS_DELAY_INTERVAL) - 1000))
	return exhaust
end

local function canUsePotion(player, potion)
	if not player or not player:isPlayer() or not potion then
		return false
	end

	local vocation = player:getVocation()
	if not vocation then
		return false
	end

	if potion.voc then
		local base = vocation:getBaseId()
		if not table.contains(potion.voc, base) then
			return false
		end
	end

	if potion.level and player:getLevel() < potion.level then
		return false
	end

	return true
end

local function findPotion(player)
	if not player or not player:isPlayer() then
		return nil
	end

	local hp = player:getHealth()
	local maxHp = player:getMaxHealth()
	local mana = player:getMana()
	local maxMana = player:getMaxMana()

	if maxHp <= 0 or maxMana <= 0 then
		return nil
	end

	local customThreshold = player:getStorageValue(STORAGE_THRESHOLD)
	local healthThreshold = (customThreshold > 0) and (customThreshold / 100) or DEFAULT_HEALTH_THRESHOLD
	local manaThreshold = (customThreshold > 0) and (customThreshold / 100) or DEFAULT_MANA_THRESHOLD

	local needHealth = hp < maxHp * healthThreshold
	local needMana = mana < maxMana * manaThreshold

	if not needHealth and not needMana then
		return nil
	end

	local best, bestScore = nil, 0

	for id, data in pairs(POTION_DATA) do
		if canUsePotion(player, data) then
			local item = player:getItemById(id, true)
			if item and item:isItem() then
				local score, matchesNeed = 0, false

				if needHealth and data.health then
					score = score + data.health[2]
					matchesNeed = true
				end
				if needMana and data.mana then
					score = score + data.mana[2]
					matchesNeed = true
				end

				if matchesNeed and score > bestScore then
					best = { item = item, info = data }
					bestScore = score
				end
			end
		end
	end

	return best
end

local function tryHeal(player)
	if not player or not player:isPlayer() then
		return
	end
	if player:getStorageValue(STORAGE) ~= 1 then
		return
	end
	if player:getCondition(CONDITION_EXHAUST_HEAL) then
		return
	end

	local pid = player:getId()
	local now = getMs()
	local cache = potionCache[pid]

	if cache and cache.lastAttempt and (now - cache.lastAttempt) < POTION_COOLDOWN_MS then
		return
	end

	local data = findPotion(player)
	if not data then
		return
	end

	if not potionCache[pid] then
		potionCache[pid] = {}
	end
	potionCache[pid].lastAttempt = now

	local info = data.info

	local exhaust = createExhaustCondition()
	player:addCondition(exhaust)

	if info.health then
		player:addHealth(math.random(info.health[1], info.health[2]))
	end
	if info.mana then
		player:addMana(math.random(info.mana[1], info.mana[2]))
	end

	if not data.item or not data.item:isItem() then
		return
	end
	data.item:remove(1)

	local deactivatedFlasks = player:kv():get("talkaction.potions.flask") or false
	if not deactivatedFlasks and info.flask then
		player:addItem(info.flask, 1)
	end

	player:say("Aaaah...", MESSAGE_POTION)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:addAchievementProgress("Potion Addict", 100000)
end

-- CreatureEvents
local healthEvent = CreatureEvent("AutoPotionHealthChange")
function healthEvent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if creature:isPlayer() then
		tryHeal(creature)
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end
healthEvent:register()

local manaEvent = CreatureEvent("AutoPotionManaChange")
function manaEvent.onManaChange(creature, attacker, manaChange, origin)
	if creature:isPlayer() then
		tryHeal(creature)
	end
	return manaChange
end
manaEvent:register()

local logoutEvent = CreatureEvent("AutoPotionLogout")
function logoutEvent.onLogout(player)
	potionCache[player:getId()] = nil
	return true
end
logoutEvent:register()
