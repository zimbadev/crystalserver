-- Discovery System ("Measuring Tibia") - AUTOMATIC exploration (no "Start Discovering" button).
-- Entering a registered subarea auto-activates discovery: the server rolls 7 viewpoints (PoI),
-- walking within view range of one marks it found; 7/7 unlocks the subarea permanently (KV).
-- Wire: S2C 0xDD sub 1 (DiscoveryData), sub 5 (SetDiscoveryArea), sub 10 (SetCurrentArea);
-- area/subarea ids must match the client's map-a743.dat (see DISCOVERY_AREA_MAP.txt dump).
-- Rewards: achievements 470 "Widely Travelled" / 539 "Measuring the World", Discoverer outfit
-- (1094/1095) + addons, cyclopedia MAP titles 74/75 via kv "discovery/map-percent" + checkMap().

-- exact client footprints (generated from subarea-*.bmp.lzma masks); load-order guard
if not DiscoveryGeometry then
	dofile(CORE_DIRECTORY .. "/scripts/discovery_geometry.lua")
end

DiscoverySystem = DiscoverySystem or {}

local VIEW_X = 7 -- client game window is 15x11 -> half extents
local VIEW_Y = 5
local POI_TARGET = 7
local MIN_POI_SPACING = 4
-- bump when subarea geometry changes: stale rolled viewpoints (possibly outside the
-- new footprint) are wiped on login; completed subareas are kept
local GEOMETRY_VERSION = 4

local OUTFIT_DISCOVERER_FEMALE = 1095
local OUTFIT_DISCOVERER_MALE = 1094
local ACHIEVEMENT_WIDELY_TRAVELLED = 470
local ACHIEVEMENT_MEASURING_THE_WORLD = 539

-- main areas: taken 1:1 from the client (DiscoveryGeometry.mains, real area_id -> name)
local MAIN_AREAS = DiscoveryGeometry.mains

-- SUBAREA_LIST is built automatically from DiscoveryGeometry.subs (207 pixel-exact,
-- mutually disjoint surface footprints). Underground subareas have no client mask -
-- add them to MANUAL_SUBAREAS with hand-made boxes (tune via /disco where, Lua only).
-- floors = where the player counts as inside (detection, incl. rooftops/mountain tops);
-- poiFloors = where viewpoints may be rolled (reachable ground levels only).
local SURFACE = { 0, 1, 2, 3, 4, 5, 6, 7 }

-- per-subarea tweaks on top of the generated geometry
local OVERRIDES = {
	[34] = { poiFloors = { 6, 7 } }, -- Mount Sternum: viewpoints also on the plateau (z6)
	[33] = { floors = { 8, 9 } }, -- Trolls' Cave: underground, mask = horizontal footprint
	[35] = { extraBoxes = { { from = { x = 32130, y = 32360 }, to = { x = 32230, y = 32450 }, floors = { 8 } } } }, -- Fibula dungeon
	[317] = { floors = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, poiFloors = { 7, 8 } }, -- Rookgaard incl. dungeons
}

-- hand-made subareas (none right now - undergrounds come from DiscoveryGeometry.approx);
-- format: { id, mainArea, name, floors, boxes = { { from = {x,y}, to = {x,y}, floors? } } }
local MANUAL_SUBAREAS = {}

local function floorSetOf(list)
	local set = {}
	for _, z in ipairs(list) do
		set[z] = true
	end
	return set
end

-- "x1,y1,x2,y2 x1,y1,x2,y2 ..." -> flat number array (stride 4)
local function parseRects(str)
	local flat = {}
	local n = 0
	for x1, y1, x2, y2 in str:gmatch("(%d+),(%d+),(%d+),(%d+)") do
		flat[n + 1] = tonumber(x1)
		flat[n + 2] = tonumber(y1)
		flat[n + 3] = tonumber(x2)
		flat[n + 4] = tonumber(y2)
		n = n + 4
	end
	return flat
end

-- def carries: rects = flat array (uniform def.floors) + extra = { {x1,y1,x2,y2, floors} }
-- (per-box floor exceptions). finalizeDef computes bbox, floor sets and the cumulative
-- area array (rects first, then extras) used for weighted viewpoint rolls.
local function finalizeDef(def)
	local bb = def.bbox and { x1 = def.bbox.x1, y1 = def.bbox.y1, x2 = def.bbox.x2, y2 = def.bbox.y2 } or nil
	local rects = def.rects
	local cum = {}
	local area = 0
	local nRects = #rects / 4
	for i = 0, nRects - 1 do
		local x1, y1, x2, y2 = rects[i * 4 + 1], rects[i * 4 + 2], rects[i * 4 + 3], rects[i * 4 + 4]
		if not bb then
			bb = { x1 = x1, y1 = y1, x2 = x2, y2 = y2 }
		else
			bb.x1 = math.min(bb.x1, x1)
			bb.y1 = math.min(bb.y1, y1)
			bb.x2 = math.max(bb.x2, x2)
			bb.y2 = math.max(bb.y2, y2)
		end
		area = area + (x2 - x1 + 1) * (y2 - y1 + 1)
		cum[i + 1] = area
	end
	def.extra = def.extra or {}
	for _, e in ipairs(def.extra) do
		bb.x1 = math.min(bb.x1, e.x1)
		bb.y1 = math.min(bb.y1, e.y1)
		bb.x2 = math.max(bb.x2, e.x2)
		bb.y2 = math.max(bb.y2, e.y2)
		area = area + (e.x2 - e.x1 + 1) * (e.y2 - e.y1 + 1)
		cum[#cum + 1] = area
		e.floorSet = floorSetOf(e.floors)
	end
	def.nRects = nRects
	def.bbox = bb
	def.area = area
	def.cum = cum
	def.floorSet = floorSetOf(def.floors)
	return def
end

local SUBAREA_LIST = {}

local function addDef(def)
	SUBAREA_LIST[#SUBAREA_LIST + 1] = finalizeDef(def)
end

local function sortedKeys(tbl)
	local keys = {}
	for k in pairs(tbl) do
		keys[#keys + 1] = k
	end
	table.sort(keys)
	return keys
end

for _, def in ipairs(MANUAL_SUBAREAS) do
	local flat = {}
	local extras = {}
	for _, box in ipairs(def.boxes) do
		if box.floors then
			extras[#extras + 1] = { x1 = box.from.x, y1 = box.from.y, x2 = box.to.x, y2 = box.to.y, floors = box.floors }
		else
			flat[#flat + 1] = box.from.x
			flat[#flat + 1] = box.from.y
			flat[#flat + 1] = box.to.x
			flat[#flat + 1] = box.to.y
		end
	end
	def.rects = flat
	def.extra = extras
	def.boxes = nil
	addDef(def)
end

-- pixel-exact surface footprints (client masks)
for _, sid in ipairs(sortedKeys(DiscoveryGeometry.subs)) do
	local g = DiscoveryGeometry.subs[sid]
	local ov = OVERRIDES[sid] or {}
	local extras = {}
	for _, box in ipairs(ov.extraBoxes or {}) do
		extras[#extras + 1] = { x1 = box.from.x, y1 = box.from.y, x2 = box.to.x, y2 = box.to.y, floors = box.floors or { 7 } }
	end
	addDef({
		id = sid,
		mainArea = g.mainArea,
		name = g.name,
		floors = ov.floors or SURFACE,
		poiFloors = ov.poiFloors or { 7 },
		rects = parseRects(g.rects),
		extra = extras,
		bbox = g.bbox,
	})
end

-- approximate underground boxes (landmark clusters) - AFTER the exact ones, so an exact
-- footprint always wins the first-match scan
for _, sid in ipairs(sortedKeys(DiscoveryGeometry.approx or {})) do
	local g = DiscoveryGeometry.approx[sid]
	local ov = OVERRIDES[sid] or {}
	local floors = ov.floors or g.floors
	addDef({
		id = sid,
		mainArea = g.mainArea,
		name = g.name,
		approx = true,
		floors = floors,
		poiFloors = ov.poiFloors or floors,
		rects = { g.box.x1, g.box.y1, g.box.x2, g.box.y2 },
	})
end

local sessions = {} -- guid -> { subId, def, pois = { {x, y, z, found} }, foundCount, completed }

-- ===== Area donations -> "Improved Respawn Rate" (0xDD sub 9) =====
-- Players donate gold to a MAIN area. When the pool reaches the goal, the boost is
-- SCHEDULED: it activates at the NEXT server save and lasts until the following one
-- (24h), then the cycle can repeat (goal amount is consumed, excess carries over).
-- While active, every spawn inside the area's footprints respawns twice as fast.
local DONATION_GOAL = 10000000 -- 10kk per main area
local BOOST_DURATION = 24 * 60 * 60 -- seconds; one full server-save cycle
local donationStore = kv.scoped("discovery-donations")
-- publish the goal for the C++ donation handler (map-UI "Donate", protocolgame 0x92)
donationStore:set("goal", DONATION_GOAL)

local function donationsOf(areaId)
	return donationStore:get("area-" .. areaId) or 0
end

local function boostUntil(areaId)
	return donationStore:get("boost-until-" .. areaId) or 0
end

local function isRespawnBoosted(areaId)
	return os.time() < boostUntil(areaId)
end

local function isBoostScheduled(areaId)
	return donationsOf(areaId) >= DONATION_GOAL
end

function DiscoverySystem.sendDonations(player)
	local entries = {}
	local mainIds = {}
	for mainId in pairs(MAIN_AREAS) do
		mainIds[#mainIds + 1] = mainId
	end
	table.sort(mainIds)
	for _, mainId in ipairs(mainIds) do
		entries[#entries + 1] = { mainId, isRespawnBoosted(mainId), donationsOf(mainId) }
	end
	player:sendDiscoveryDonations(DONATION_GOAL, entries)
end

function DiscoverySystem.applyImprovedRespawnZones()
	local rects = {}
	local boosted = {}
	for _, def in ipairs(SUBAREA_LIST) do
		if isRespawnBoosted(def.mainArea) then
			boosted[def.mainArea] = true
			local r = def.rects
			for i = 1, #r, 4 do
				rects[#rects + 1] = { r[i], r[i + 1], r[i + 2], r[i + 3] }
			end
			for _, e in ipairs(def.extra) do
				rects[#rects + 1] = { e.x1, e.y1, e.x2, e.y2 }
			end
		end
	end
	Game.setImprovedRespawnZones(rects)
	local names = {}
	for mainId in pairs(boosted) do
		names[#names + 1] = MAIN_AREAS[mainId] or tostring(mainId)
	end
	return #rects, names
end

function DiscoverySystem.donate(player, areaId, amount)
	if not MAIN_AREAS[areaId] then
		return false, string.format("unknown main area id %d", areaId)
	end
	if not amount or amount <= 0 then
		return false, "amount must be positive"
	end
	local wasScheduled = isBoostScheduled(areaId)
	donationStore:set("area-" .. areaId, donationsOf(areaId) + amount)
	local nowScheduled = isBoostScheduled(areaId) and not wasScheduled
	for _, p in ipairs(Game.getPlayers()) do
		DiscoverySystem.sendDonations(p)
		if nowScheduled then
			p:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Donations for %s reached their goal - improved respawn rate will activate at the next server save and last one day!", MAIN_AREAS[areaId]))
		end
	end
	return true
end

-- Server-save boundary: consume filled pools -> activate their boost for one day;
-- boosts from the previous day expire here naturally (time comparison).
-- Called from global_server_save.lua and from the /disco ss test command.
function DiscoverySystem.onServerSave()
	local activated = {}
	for mainId in pairs(MAIN_AREAS) do
		if isBoostScheduled(mainId) then
			donationStore:set("area-" .. mainId, donationsOf(mainId) - DONATION_GOAL)
			donationStore:set("boost-until-" .. mainId, os.time() + BOOST_DURATION)
			activated[#activated + 1] = MAIN_AREAS[mainId] or tostring(mainId)
		end
	end
	DiscoverySystem.applyImprovedRespawnZones()
	for _, p in ipairs(Game.getPlayers()) do
		DiscoverySystem.sendDonations(p)
		if #activated > 0 then
			p:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Improved respawn rate is now active in: %s (for one day).", table.concat(activated, ", ")))
		end
	end
	return #activated
end

-- test/admin helper: zero every pool and boost, deactivate zones, refresh everyone
function DiscoverySystem.resetDonations()
	for mainId in pairs(MAIN_AREAS) do
		donationStore:set("area-" .. mainId, 0)
		donationStore:set("boost-until-" .. mainId, 0)
	end
	DiscoverySystem.applyImprovedRespawnZones()
	for _, p in ipairs(Game.getPlayers()) do
		DiscoverySystem.sendDonations(p)
	end
end

function DiscoverySystem.donationStatus()
	local lines = {}
	local mainIds = {}
	for mainId in pairs(MAIN_AREAS) do
		mainIds[#mainIds + 1] = mainId
	end
	table.sort(mainIds)
	for _, mainId in ipairs(mainIds) do
		local donated = donationsOf(mainId)
		local until_ = boostUntil(mainId)
		if donated > 0 or os.time() < until_ then
			local state = ""
			if os.time() < until_ then
				state = string.format(" [ACTIVE until %s]", os.date("%d.%m %H:%M", until_))
			elseif donated >= DONATION_GOAL then
				state = " [SCHEDULED - activates at next server save]"
			end
			lines[#lines + 1] = string.format("%s: %d/%d%s", MAIN_AREAS[mainId], donated, DONATION_GOAL, state)
		end
	end
	if #lines == 0 then
		lines[1] = "no donations yet"
	end
	return lines
end

-- safety net for boundaries not covered by an SS event (e.g. expiry while the server
-- runs past 24h): re-apply zones whenever the set of active boosts changes
local lastBoostSignature = nil

local discoveryBoostWatch = GlobalEvent("DiscoveryBoostWatch")

function discoveryBoostWatch.onThink(interval)
	local sig = {}
	for mainId in pairs(MAIN_AREAS) do
		if isRespawnBoosted(mainId) then
			sig[#sig + 1] = mainId
		end
	end
	table.sort(sig)
	local s = table.concat(sig, ",")
	if s ~= lastBoostSignature then
		lastBoostSignature = s
		DiscoverySystem.applyImprovedRespawnZones()
		for _, p in ipairs(Game.getPlayers()) do
			DiscoverySystem.sendDonations(p)
		end
	end
	return true
end

discoveryBoostWatch:interval(60000)
discoveryBoostWatch:register()

local function kv(player)
	return player:kv():scoped("discovery")
end

local function isCompleted(player, subId)
	return kv(player):get("done-" .. subId) == true
end

local function serializePois(pois)
	local parts = {}
	for _, p in ipairs(pois) do
		parts[#parts + 1] = string.format("%d,%d,%d,%d", p.x, p.y, p.z, p.found and 1 or 0)
	end
	return table.concat(parts, "|")
end

local function deserializePois(str)
	if not str or str == "" then
		return nil
	end
	local pois = {}
	for chunk in str:gmatch("[^|]+") do
		local x, y, z, f = chunk:match("(%d+),(%d+),(%d+),(%d+)")
		if not x then
			return nil
		end
		pois[#pois + 1] = { x = tonumber(x), y = tonumber(y), z = tonumber(z), found = f == "1" }
	end
	return #pois > 0 and pois or nil
end

local function countFound(pois)
	local n = 0
	for _, p in ipairs(pois) do
		if p.found then
			n = n + 1
		end
	end
	return n
end

local function poisToWire(pois)
	local points = {}
	for _, p in ipairs(pois) do
		points[#points + 1] = { p.x, p.y, p.z, p.found and 1 or 0 }
	end
	return points
end

local function positionInDef(position, def)
	local bb = def.bbox
	local x, y, z = position.x, position.y, position.z
	if x < bb.x1 or x > bb.x2 or y < bb.y1 or y > bb.y2 then
		return false
	end
	if def.floorSet[z] then
		local r = def.rects
		for i = 1, #r, 4 do
			if x >= r[i] and x <= r[i + 2] and y >= r[i + 1] and y <= r[i + 3] then
				return true
			end
		end
	end
	for _, e in ipairs(def.extra) do
		if e.floorSet[z] and x >= e.x1 and x <= e.x2 and y >= e.y1 and y <= e.y2 then
			return true
		end
	end
	return false
end

function DiscoverySystem.findSubarea(position)
	for _, def in ipairs(SUBAREA_LIST) do
		if positionInDef(position, def) then
			return def.id, def
		end
	end
	return nil, nil
end

-- area-weighted random rect via binary search; returns x1, y1, x2, y2, floorsOverride
local function pickSpot(def)
	local roll = math.random(def.area)
	local cum = def.cum
	local lo, hi = 1, #cum
	while lo < hi do
		local mid = math.floor((lo + hi) / 2)
		if cum[mid] < roll then
			lo = mid + 1
		else
			hi = mid
		end
	end
	if lo <= def.nRects then
		local i = (lo - 1) * 4
		local r = def.rects
		return r[i + 1], r[i + 2], r[i + 3], r[i + 4], nil
	end
	local e = def.extra[lo - def.nRects]
	return e.x1, e.y1, e.x2, e.y2, e.floors
end

local function generatePois(player, def)
	local playerPos = player:getPosition()
	local pois = {}
	local tries = 0
	while #pois < POI_TARGET and tries < 800 do
		tries = tries + 1
		local x1, y1, x2, y2, extraFloors = pickSpot(def)
		local floors = extraFloors or def.poiFloors or def.floors
		local x = math.random(x1, x2)
		local y = math.random(y1, y2)
		local z = floors[math.random(#floors)]
		local tile = Tile(Position(x, y, z))
		if tile and tile:isWalkable(true) then
			-- never inside the player's current view (they must walk to find it)
			local hiddenFromPlayer = z ~= playerPos.z or math.abs(x - playerPos.x) > VIEW_X + 1 or math.abs(y - playerPos.y) > VIEW_Y + 1
			if hiddenFromPlayer then
				local spaced = true
				for _, p in ipairs(pois) do
					if p.z == z and math.abs(p.x - x) < MIN_POI_SPACING and math.abs(p.y - y) < MIN_POI_SPACING then
						spaced = false
						break
					end
				end
				-- relax the spacing rule if the box is hard to fill
				if spaced or tries > 600 then
					pois[#pois + 1] = { x = x, y = y, z = z, found = false }
				end
			end
		end
	end
	return #pois == POI_TARGET and pois or nil
end

local function subareaCounts(player, mainId)
	local total, done = 0, 0
	for _, def in ipairs(SUBAREA_LIST) do
		if def.mainArea == mainId then
			total = total + 1
			if isCompleted(player, def.id) then
				done = done + 1
			end
		end
	end
	return total, done
end

function DiscoverySystem.sendDiscoveryData(player)
	local mains = {}
	local discovered = {}
	local discoverable = {}
	for mainId, _ in pairs(MAIN_AREAS) do
		local total, done = subareaCounts(player, mainId)
		for _, def in ipairs(SUBAREA_LIST) do
			if def.mainArea == mainId then
				if isCompleted(player, def.id) then
					discovered[#discovered + 1] = def.id
				else
					discoverable[#discoverable + 1] = def.id
				end
			end
		end
		if total > 0 then
			local progress = math.floor(done / total * 100)
			local status = done == total and 3 or 1
			mains[#mains + 1] = { mainId, status, progress }
		end
	end
	player:sendDiscoveryData(mains, discovered, discoverable)
end

function DiscoverySystem.grantMilestones(player)
	local totalMains, doneMains = 0, 0
	for mainId, _ in pairs(MAIN_AREAS) do
		totalMains = totalMains + 1
		local total, done = subareaCounts(player, mainId)
		if total > 0 and done == total then
			doneMains = doneMains + 1
		end
	end
	local percent = totalMains > 0 and math.floor(doneMains / totalMains * 100) or 0
	kv(player):set("map-percent", percent)

	if doneMains >= 1 then
		-- first fully explored main area: Discoverer outfit + "Widely Travelled"
		if not player:hasAchievement(ACHIEVEMENT_WIDELY_TRAVELLED) then
			player:addAchievement(ACHIEVEMENT_WIDELY_TRAVELLED)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have earned the Discoverer outfit!")
		end
		player:addOutfit(OUTFIT_DISCOVERER_MALE)
		player:addOutfit(OUTFIT_DISCOVERER_FEMALE)
	end
	if percent >= 50 then
		player:addOutfitAddon(OUTFIT_DISCOVERER_MALE, 1)
		player:addOutfitAddon(OUTFIT_DISCOVERER_FEMALE, 1)
	end
	if percent >= 100 then
		if not player:hasAchievement(ACHIEVEMENT_MEASURING_THE_WORLD) then
			player:addAchievement(ACHIEVEMENT_MEASURING_THE_WORLD)
		end
		player:addOutfitAddon(OUTFIT_DISCOVERER_MALE, 2)
		player:addOutfitAddon(OUTFIT_DISCOVERER_FEMALE, 2)
	end

	-- cyclopedia MAP titles (74 Dedicated Entrepreneur @50%, 75 Globetrotter @100%) read map-percent
	player:checkNewTitles()
end

local function sendAreaState(player, subId, session, active)
	player:sendDiscoveryArea(subId, active, POI_TARGET, poisToWire(session.pois))
end

local function enterSubarea(player, subId, def)
	if isCompleted(player, subId) then
		player:sendDiscoveryCurrentArea(subId)
		player:sendDiscoveryExploring(0)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have entered %s (fully explored).", def.name))
		sessions[player:getGuid()] = { subId = subId, def = def, completed = true }
		return
	end

	local pois = deserializePois(kv(player):get("pois-" .. subId))
	if not pois then
		pois = generatePois(player, def)
		if not pois then
			logger.warn("[DiscoverySystem] could not roll {} viewpoints for subarea {} ({})", POI_TARGET, subId, def.name)
			return
		end
		kv(player):set("pois-" .. subId, serializePois(pois))
	end

	local session = { subId = subId, def = def, pois = pois, foundCount = countFound(pois) }
	sessions[player:getGuid()] = session
	player:sendDiscoveryCurrentArea(subId)
	player:sendDiscoveryExploring(subId)
	sendAreaState(player, subId, session, true)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have entered %s. Exploration in progress: %d/%d viewpoints found.", def.name, session.foundCount, POI_TARGET))
end

local function leaveSubarea(player, session)
	sessions[player:getGuid()] = nil
	player:sendDiscoveryCurrentArea(0)
	player:sendDiscoveryExploring(0)
	if session.def then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have left %s.", session.def.name))
	end
end

local function completeSubarea(player, session)
	kv(player):set("done-" .. session.subId, true)
	kv(player):set("pois-" .. session.subId, "")
	session.completed = true
	player:sendDiscoveryExploring(0)
	player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_BLUE)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Congratulations! You have fully explored %s.", session.def.name))
	sendAreaState(player, session.subId, session, false)
	DiscoverySystem.sendDiscoveryData(player)
	DiscoverySystem.grantMilestones(player)
end

-- Debug/restore: mark a subarea (or all) fully explored without walking.
function DiscoverySystem.markComplete(player, subId)
	local ids = {}
	if subId then
		ids = { subId }
	else
		for _, def in ipairs(SUBAREA_LIST) do
			ids[#ids + 1] = def.id
		end
	end
	for _, id in ipairs(ids) do
		kv(player):set("done-" .. id, true)
		kv(player):set("pois-" .. id, "")
	end
	sessions[player:getGuid()] = nil
	player:sendDiscoveryCurrentArea(0)
	player:sendDiscoveryExploring(0)
	DiscoverySystem.sendDiscoveryData(player)
	DiscoverySystem.grantMilestones(player)
	return #ids
end

local function checkViewpoints(player, session)
	local pos = player:getPosition()
	local foundNow = false
	for _, p in ipairs(session.pois) do
		if not p.found and p.z == pos.z and math.abs(p.x - pos.x) <= VIEW_X and math.abs(p.y - pos.y) <= VIEW_Y then
			p.found = true
			session.foundCount = session.foundCount + 1
			foundNow = true
			Position(p.x, p.y, p.z):sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have discovered a viewpoint! (%d/%d)", session.foundCount, POI_TARGET))
			-- Echo Warden: each discovered viewpoint may ARM a world-wide pending echo
			-- (released later at some eligible kill anywhere - see echo_warden.lua)
			if EchoWarden and EchoWarden.onViewpointDiscovered then
				EchoWarden.onViewpointDiscovered(player)
			end
		end
	end
	if foundNow then
		kv(player):set("pois-" .. session.subId, serializePois(session.pois))
		if session.foundCount >= POI_TARGET then
			completeSubarea(player, session)
		else
			sendAreaState(player, session.subId, session, true)
		end
	end
end

function DiscoverySystem.tick(player)
	local guid = player:getGuid()
	local session = sessions[guid]
	local subId, def = DiscoverySystem.findSubarea(player:getPosition())

	if session and session.subId ~= subId then
		leaveSubarea(player, session)
		session = nil
	end
	if not session and subId then
		enterSubarea(player, subId, def)
		session = sessions[guid]
	end
	if session and not session.completed then
		checkViewpoints(player, session)
	end
end

function DiscoverySystem.reset(player)
	for _, def in ipairs(SUBAREA_LIST) do
		kv(player):set("done-" .. def.id, false)
		kv(player):set("pois-" .. def.id, "")
	end
	kv(player):set("map-percent", 0)
	sessions[player:getGuid()] = nil
	player:sendDiscoveryCurrentArea(0)
	DiscoverySystem.sendDiscoveryData(player)
end

function DiscoverySystem.status(player)
	-- summary per main area + detail lines only for started-but-unfinished subareas
	local lines = {}
	local perMain = {}
	local inProgress = {}
	for _, def in ipairs(SUBAREA_LIST) do
		local pm = perMain[def.mainArea]
		if not pm then
			pm = { total = 0, done = 0 }
			perMain[def.mainArea] = pm
		end
		pm.total = pm.total + 1
		if isCompleted(player, def.id) then
			pm.done = pm.done + 1
		else
			local pois = deserializePois(kv(player):get("pois-" .. def.id))
			if pois then
				inProgress[#inProgress + 1] = string.format("  %s (%d): %d/%d", def.name, def.id, countFound(pois), POI_TARGET)
			end
		end
	end
	local mainIds = {}
	for mainId in pairs(perMain) do
		mainIds[#mainIds + 1] = mainId
	end
	table.sort(mainIds)
	for _, mainId in ipairs(mainIds) do
		local pm = perMain[mainId]
		lines[#lines + 1] = string.format("%s: %d/%d subareas done", MAIN_AREAS[mainId] or ("area " .. mainId), pm.done, pm.total)
	end
	if #inProgress > 0 then
		lines[#lines + 1] = "In progress:"
		for _, l in ipairs(inProgress) do
			lines[#lines + 1] = l
		end
	end
	return lines
end

function DiscoverySystem.dumpPois(player)
	local session = sessions[player:getGuid()]
	if session and session.pois then
		logger.info("[disco] {} subarea {} pois: {}", player:getName(), session.subId, serializePois(session.pois))
		return true
	end
	return false
end

local discoveryTick = GlobalEvent("DiscoverySystemTick")

function discoveryTick.onThink(interval)
	for _, player in ipairs(Game.getPlayers()) do
		DiscoverySystem.tick(player)
	end
	return true
end

discoveryTick:interval(1000)
discoveryTick:register()

local discoveryLogin = CreatureEvent("DiscoverySystemLogin")
discoveryLogin:type("login")

function discoveryLogin.onLogin(player)
	local store = kv(player)
	if store:get("geom-version") ~= GEOMETRY_VERSION then
		for _, def in ipairs(SUBAREA_LIST) do
			store:set("pois-" .. def.id, "")
		end
		store:set("geom-version", GEOMETRY_VERSION)
	end
	DiscoverySystem.sendDiscoveryData(player)
	DiscoverySystem.sendDonations(player)
	return true
end

discoveryLogin:register()

local discoveryStartup = GlobalEvent("DiscoverySystemStartup")

function discoveryStartup.onStartup()
	local rects, names = DiscoverySystem.applyImprovedRespawnZones()
	if rects > 0 then
		logger.info("[DiscoverySystem] improved respawn active in: {} ({} rects)", table.concat(names, ", "), rects)
	end
	return true
end

discoveryStartup:register()

local discoveryLogout = CreatureEvent("DiscoverySystemLogout")
discoveryLogout:type("logout")

function discoveryLogout.onLogout(player)
	sessions[player:getGuid()] = nil
	return true
end

discoveryLogout:register()
