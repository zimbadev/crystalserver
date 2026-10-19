-- Grave Danger: Count Vlarkorth (source TibiaWiki = W)
--   W: from time to time he becomes invulnerable and summons 1 Dark per player in the room, of that player's vocation (Knight,
--      Paladin, Sorcerer, Druid, Merudri/Monk). A dead Dark leaves its body (Good Remains of a ...) and a player
--      of THE SAME vocation uses it on the boss. All used = the shield drops.
--   W: Soulless Minions heal the boss and the Darks (0-545+).
--   NOT CONFIRMED: shield every 15% of health lost (Canary); the shield drops by itself after 120 s (safety
--      so the fight cannot get stuck if someone dies or leaves); minion heal every 2 s, 300-545.
local CENTER = Position(33456, 31437, 13)
local RANGE_X, RANGE_Y = 8, 9
local SHIELD_EACH = 0.15
local SHIELD_TIMEOUT_S = 120
local HEAL_MIN, HEAL_MAX = 300, 545
-- by BASE vocation (getBase), by NAME: the base monk id is 9, not the BASE_ID.MONK (5) of the lib (with 5 an
-- Exalted Monk got no Dark and the shield never went up)
local DARKS = { Sorcerer = "Dark Sorcerer", Druid = "Dark Druid", Paladin = "Dark Paladin", Knight = "Dark Knight", Monk = "Dark Merudri" }
local REMAINS = { [31206] = "Sorcerer", [31205] = "Druid", [31204] = "Paladin", [31203] = "Knight", [50311] = "Monk" } -- item -> base vocation

local function baseVocationName(player)
	local vocation = player:getVocation()
	return vocation and vocation:getBase():getName() or ""
end

local fights = {} -- [bossId] = { lost, shield, shieldToken, ticking }

local function fightOf(boss)
	local f = fights[boss:getId()]
	if not f then
		f = { lost = 0, shield = 0, shieldToken = 0 }
		fights[boss:getId()] = f
	end
	return f
end

local function roomCreatures(playersOnly)
	return Game.getSpectators(CENTER, false, playersOnly, RANGE_X, RANGE_X, RANGE_Y, RANGE_Y)
end

local function dropShield(boss, f, text)
	f.shield = 0
	f.shieldToken = f.shieldToken + 1
	boss:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
	if text then
		boss:say(text, TALKTYPE_MONSTER_SAY)
	end
end

local function raiseShield(bossId)
	local boss = Monster(bossId)
	if not boss then
		return
	end
	local f = fightOf(boss)
	local count = 0
	for _, player in ipairs(roomCreatures(true)) do
		local dark = DARKS[baseVocationName(player)]
		if dark then
			local spot = boss:getClosestFreePosition(boss:getPosition(), true)
			if spot and Game.createMonster(dark, spot, false, true) then
				count = count + 1
			end
		end
	end
	if count == 0 then
		return
	end
	f.shield = count
	f.shieldToken = f.shieldToken + 1
	local token = f.shieldToken
	boss:say("Face your own darkness!", TALKTYPE_MONSTER_SAY)
	boss:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
	addEvent(function()
		local b = Monster(bossId)
		local ff = fights[bossId]
		if b and ff and ff.shield > 0 and ff.shieldToken == token then
			dropShield(b, ff, "The darkness fades and the shield dissolves!")
		end
	end, SHIELD_TIMEOUT_S * 1000)
end

-- Soulless Minions: heal the boss and the Darks standing next to them (W)
local function minionTick(bossId)
	local boss = Monster(bossId)
	local f = fights[bossId]
	if not boss or not f then
		fights[bossId] = nil
		return
	end
	local healable = {}
	for _, creature in ipairs(roomCreatures(false)) do
		local name = creature:getName()
		if creature:isMonster() and (creature:getId() == bossId or name:find("^Dark ")) then
			healable[#healable + 1] = creature
		end
	end
	for _, creature in ipairs(roomCreatures(false)) do
		if creature:isMonster() and creature:getName() == "Soulless Minion" then
			for _, target in ipairs(healable) do
				if target:getHealth() < target:getMaxHealth() and target:getPosition():getDistance(creature:getPosition()) <= 1 then
					target:addHealth(math.random(HEAL_MIN, HEAL_MAX))
					target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
					break
				end
			end
		end
	end
	addEvent(minionTick, 2000, bossId)
end

local vlarkorth = CreatureEvent("GraveDangerVlarkorth")

function vlarkorth.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if primaryType == COMBAT_HEALING then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	local f = fightOf(creature)
	if not f.ticking then
		f.ticking = true
		addEvent(minionTick, 2000, creature:getId())
	end
	if f.shield > 0 then
		creature:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
		return 0, primaryType, 0, secondaryType -- unlike Canary, the shield really blocks the damage
	end
	f.lost = f.lost + math.abs(primaryDamage) + math.abs(secondaryDamage)
	if f.lost >= creature:getMaxHealth() * SHIELD_EACH then
		f.lost = 0
		addEvent(raiseShield, 100, creature:getId())
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

vlarkorth:register()

-- Dark remains used on the boss by a player of the same vocation
local remains = Action()

function remains.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local vocation = REMAINS[item:getId()]
	if not target or not target.isMonster or not target:isMonster() or target:getName() ~= "Count Vlarkorth" then
		return false
	end
	local f = fights[target:getId()]
	if not f or f.shield <= 0 then
		player:sendCancelMessage("The count is not protected by darkness right now.")
		return true
	end
	if baseVocationName(player) ~= vocation then
		player:sendCancelMessage("Only someone of the same vocation can use these remains.")
		return true
	end
	item:remove(1)
	f.shield = f.shield - 1
	toPosition:sendMagicEffect(CONST_ME_HOLYAREA)
	if f.shield <= 0 then
		dropShield(target, f, "The magic shield of protection breaks!")
	else
		target:say("The magic shield of protection is weakened!", TALKTYPE_MONSTER_SAY)
	end
	return true
end

for id in pairs(REMAINS) do
	remains:id(id)
end
remains:register()
