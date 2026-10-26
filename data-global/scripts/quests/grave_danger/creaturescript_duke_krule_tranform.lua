-- Grave Danger: Duke Krule (TibiaWiki = W)
--   W BR: turns the players into Fire or Water Elementals; each player automatically casts
--      a Great Fireball (Fire) or an Avalanche (Water). These attacks deal high, steady damage to the players of the
--      OTHER element inside the blast; players of the same element are not hurt.
--   W EN: "they'll take around 2000 damage".
--   NOT CONFIRMED (server choice): the transformation lasts 6 s, then 10 s of cooldown (everyone normal), and repeats.
--   Area = the rune area (Great Fireball / Avalanche: 7x7 circle without the corners). 1,100-2,000 damage per cast (server
--   choice), of its element (fire/ice). NOT CONFIRMED: one cast per player every 2 s during the 6 s.
local FROM, TO = Position(33447, 31464, 13), Position(33464, 31481, 13)
local CENTER, RANGE_X, RANGE_Y = Position(33456, 31473, 13), 9, 9
local ACTIVE_S = 6
local COOLDOWN_S = 10
local PULSE_MS = 2000
local RADIUS = 3
local DAMAGE_MIN, DAMAGE_MAX = 1100, 2000 -- NOT CONFIRMED (W EN: "around 2000")
local FORMS = {
	fire = { look = 49, effect = CONST_ME_FIREAREA, combat = COMBAT_FIREDAMAGE, text = "You have been transformed into a Fire Elemental!" },
	water = { look = 286, effect = CONST_ME_ICEAREA, combat = COMBAT_ICEDAMAGE, text = "You have been transformed into a Water Elemental!" },
}

local fight = { bossId = 0, forms = {}, outfits = {}, token = 0 }

local function inRoom(position)
	return position.z == FROM.z and position.x >= FROM.x and position.x <= TO.x and position.y >= FROM.y and position.y <= TO.y
end

local function roomPlayers()
	local list = {}
	for _, player in ipairs(Game.getSpectators(CENTER, false, true, RANGE_X, RANGE_X, RANGE_Y, RANGE_Y)) do
		if inRoom(player:getPosition()) then
			list[#list + 1] = player
		end
	end
	return list
end

-- rune circle (radius 3 = rows 3-5-7-7-7-5-3)
local function inBlast(center, position)
	local dx, dy = position.x - center.x, position.y - center.y
	return position.z == center.z and dx * dx + dy * dy <= RADIUS * RADIUS + 1
end

local function restoreAll()
	for playerId, outfit in pairs(fight.outfits) do
		local player = Player(playerId)
		if player then
			player:setOutfit(outfit)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		end
	end
	fight.forms, fight.outfits = {}, {}
end

local function transformAll()
	for _, player in ipairs(roomPlayers()) do
		local id = player:getId()
		fight.outfits[id] = player:getOutfit()
		local form = math.random(2) == 1 and "fire" or "water"
		fight.forms[id] = form
		local outfit = player:getOutfit()
		outfit.lookType = FORMS[form].look
		player:setOutfit(outfit)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, FORMS[form].text)
	end
end

-- each transformed player casts its spell; it only hurts players of the OTHER element inside the blast
local function pulse()
	local players = {}
	for _, player in ipairs(roomPlayers()) do
		local form = fight.forms[player:getId()]
		if form then
			players[#players + 1] = { p = player, form = form, pos = player:getPosition() }
		end
	end
	for _, caster in ipairs(players) do
		local data = FORMS[caster.form]
		for dx = -RADIUS, RADIUS do
			for dy = -RADIUS, RADIUS do
				local pos = Position(caster.pos.x + dx, caster.pos.y + dy, caster.pos.z)
				if inBlast(caster.pos, pos) then
					pos:sendMagicEffect(data.effect)
				end
			end
		end
		for _, target in ipairs(players) do
			if target.form ~= caster.form and inBlast(caster.pos, target.pos) then
				doTargetCombatHealth(0, target.p, data.combat, -DAMAGE_MIN, -DAMAGE_MAX, CONST_ME_NONE)
			end
		end
	end
end

local function cycle(bossId, token)
	if fight.token ~= token or not Monster(bossId) then
		if fight.token == token then
			restoreAll()
			fight.bossId = 0
		end
		return
	end
	-- active phase: transform, cast every 2 s, and after 6 s everyone goes back to normal
	transformAll()
	local pulses = math.floor(ACTIVE_S * 1000 / PULSE_MS)
	for i = 0, pulses - 1 do
		addEvent(function()
			if fight.token == token and Monster(bossId) then
				pulse()
			end
		end, i * PULSE_MS)
	end
	addEvent(function()
		if fight.token == token then
			restoreAll()
		end
	end, ACTIVE_S * 1000)
	-- 10 s cooldown, then repeat
	addEvent(cycle, (ACTIVE_S + COOLDOWN_S) * 1000, bossId, token)
end

local dukeKruleTransformEvent = CreatureEvent("DukeKruleTransform")

function dukeKruleTransformEvent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	-- the cycle starts a few seconds after the first damage on the boss
	if fight.bossId ~= creature:getId() then
		restoreAll()
		fight.bossId = creature:getId()
		fight.token = fight.token + 1
		addEvent(cycle, 3000, creature:getId(), fight.token)
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

dukeKruleTransformEvent:register()
