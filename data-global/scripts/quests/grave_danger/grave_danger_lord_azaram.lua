-- Grave Danger: Lord Azaram (source TibiaWiki = W)
--   W: from time to time the boss becomes Azaram's Soul and Tainted Soul Splinters appear; a dead splinter becomes a
--      Cleansed Soul Splinter (item 31160). Luring the soul over one of them heals the soul; 3 times = the Lord comes back.
--      In the first rounds Mass Healing and UH also fill the soul. The soul is immune to damage.
--   W: Condensed Sins reflect death damage.
--   Here the soul is the SAME boss with another type (setType), so the damage dealt to the Lord, the difficulty
--   and the reward are kept. The Lord's health is saved and restored when he comes back.
--   NOT CONFIRMED: becomes the soul every 20% of health lost; the soul starts at 30% and each splinter fills 1/3;
--   a full soul (by healing) also brings the Lord back; 4 splinters (Canary positions); 100% reflect.
local CENTER = Position(33424, 31472, 13)
local RANGE_X, RANGE_Y = 9, 10
local TRANSFORM_EACH = 0.20
local SOUL_START = 0.30
local ABSORBS_NEEDED = 3
local SPLINTERS = { Position(33422, 31470, 13), Position(33427, 31470, 13), Position(33422, 31476, 13), Position(33427, 31476, 13) }

local fights = {} -- [bossId] = { lost, lordHealth, absorbs, busy }

local function fightOf(boss)
	local f = fights[boss:getId()]
	if not f then
		f = { lost = 0, absorbs = 0 }
		fights[boss:getId()] = f
	end
	return f
end

local function removeTainted()
	for _, creature in ipairs(Game.getSpectators(CENTER, false, false, RANGE_X, RANGE_X, RANGE_Y, RANGE_Y)) do
		if creature:isMonster() and creature:getName() == "Tainted Soul Splinter" then
			creature:remove()
		end
	end
	-- leftover Cleansed Soul Splinters (purple fire) made the Lord walk around them; they are removed when he comes back
	for x = CENTER.x - RANGE_X, CENTER.x + RANGE_X do
		for y = CENTER.y - RANGE_Y, CENTER.y + RANGE_Y do
			local tile = Tile(Position(x, y, CENTER.z))
			local splinter = tile and tile:getItemById(31160)
			if splinter then
				splinter:remove()
			end
		end
	end
end

local function backToLord(bossId)
	local boss = Monster(bossId)
	local f = fights[bossId]
	if not boss or not f or boss:getName() ~= "Azaram's Soul" then
		return
	end
	boss:setType("Lord Azaram")
	boss:setHealth(f.lordHealth or boss:getMaxHealth())
	f.lost, f.absorbs, f.busy = 0, 0, false
	removeTainted()
	boss:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
	boss:say("MY SOUL IS WHOLE AGAIN!", TALKTYPE_MONSTER_YELL)
end

local function toSoul(bossId)
	local boss = Monster(bossId)
	local f = fights[bossId]
	if not boss or not f or boss:getName() ~= "Lord Azaram" then
		return
	end
	f.lordHealth = boss:getHealth()
	f.absorbs = 0
	boss:setType("Azaram's Soul")
	boss:setHealth(math.max(1, math.floor(boss:getMaxHealth() * SOUL_START)))
	boss:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
	for _, spot in ipairs(SPLINTERS) do
		Game.createMonster("Tainted Soul Splinter", spot, true, true)
	end
end

local function absorb(boss)
	local f = fights[boss:getId()]
	if not f then
		return
	end
	f.absorbs = f.absorbs + 1
	boss:addHealth(math.floor(boss:getMaxHealth() / ABSORBS_NEEDED))
	boss:getPosition():sendMagicEffect(CONST_ME_HOLYDAMAGE)
	if f.absorbs >= ABSORBS_NEEDED or boss:getHealth() >= boss:getMaxHealth() then
		f.busy = true
		addEvent(backToLord, 500, boss:getId())
	end
end

-- registered on Lord Azaram and on Azaram's Soul
local azaram = CreatureEvent("GraveDangerAzaram")

function azaram.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	local f = fightOf(creature)
	if creature:getName() == "Azaram's Soul" then
		if primaryType == COMBAT_HEALING then
			-- W: Mass Healing / UH fill the soul; full = the Lord comes back
			if not f.busy and creature:getHealth() + math.abs(primaryDamage) >= creature:getMaxHealth() then
				f.busy = true
				addEvent(backToLord, 500, creature:getId())
			end
			return primaryDamage, primaryType, secondaryDamage, secondaryType
		end
		creature:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
		return 0, primaryType, 0, secondaryType
	end
	if primaryType == COMBAT_HEALING or f.busy then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	f.lost = f.lost + math.abs(primaryDamage) + math.abs(secondaryDamage)
	if f.lost >= creature:getMaxHealth() * TRANSFORM_EACH then
		f.lost = 0
		addEvent(toSoul, 100, creature:getId())
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

azaram:register()

-- soul walking over a Cleansed Soul Splinter (corpse of the Tainted Soul Splinter)
local cleansed = MoveEvent()

function cleansed.onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() and creature:getName() == "Azaram's Soul" then
		item:remove()
		creature:say("The broken soul absorbs the power of the soul splinter!", TALKTYPE_MONSTER_SAY)
		absorb(creature)
	end
	return true
end

cleansed:id(31160)
cleansed:register()

-- Condensed Sins send death damage back to the attacker (W)
local reflect = CreatureEvent("GraveDangerSinReflect")

function reflect.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if attacker and attacker:isPlayer() then
		local amount = 0
		if primaryType == COMBAT_DEATHDAMAGE then
			amount = amount + math.abs(primaryDamage)
		end
		if secondaryType == COMBAT_DEATHDAMAGE then
			amount = amount + math.abs(secondaryDamage)
		end
		if amount > 0 then
			-- the reflection hits the player, so it does not come back to this event (no loop)
			doTargetCombatHealth(creature, attacker, COMBAT_DEATHDAMAGE, -amount, -amount, CONST_ME_MORTAREA, ORIGIN_NONE)
		end
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

reflect:register()
