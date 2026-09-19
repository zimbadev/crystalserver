local KV_SCOPE = "shadows-of-yalahar"
local CORE_SAFE = "action-telescope"
local REWARD_KEY = "reward"
local COOLDOWN_KEY = "telescope-cooldown"
local TELESCOPE_COOLDOWN = 1 -- segundos

local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar

local telescopes = {
	{ x = 32867, y = 31257, z = 11 },
	{ x = 32869, y = 31257, z = 11 },
	{ x = 32871, y = 31257, z = 11 },
	{ x = 32873, y = 31257, z = 11 },
}

local pillars = {
	{ x = 32867, y = 31253, z = 11 },
	{ x = 32869, y = 31253, z = 11 },
	{ x = 32871, y = 31253, z = 11 },
	{ x = 32873, y = 31253, z = 11 },
}

local RED_PILLAR_ID = { [9137] = true, [9138] = true, [9139] = true, [9140] = true }
local GREEN_PILLAR_IDS = { [9133] = true, [9134] = true, [9135] = true, [9136] = true }
local ALL_PILLAR_IDS = { 9133, 9134, 9135, 9136, 9137, 9138, 9139, 9140 }

local FRONT_DIRECTION = { x = 0, y = -1 }

local function getPillarItemAt(position)
	local tile = Tile(position)
	if not tile then
		return nil
	end
	for _, id in ipairs(ALL_PILLAR_IDS) do
		local item = tile:getItemById(id)
		if item then
			return item
		end
	end
	return nil
end

local function findTelescopeIndex(position)
	for index, pos in ipairs(telescopes) do
		if pos.x == position.x and pos.y == position.y and pos.z == position.z then
			return index
		end
	end
	return nil
end

local function shootIceBeam(originPosition, direction)
	for step = 1, 4 do
		local pos = Position(originPosition.x + direction.x * step, originPosition.y + direction.y * step, originPosition.z)
		pos:sendMagicEffect(CONST_ME_ICEATTACK)
	end
end

-- Telescope
local yalaharTelescope = Action()

function yalaharTelescope.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local mission = player:getStorageValue(ShadowsOfYalahar.Questline)
	if mission ~= 3 then
		return true
	end

	local kv = player:kv():scoped(KV_SCOPE)

	local complete = kv:get(REWARD_KEY)
	if complete == true then
		return true
	end

	local coreSafe = kv:get(CORE_SAFE)
	if coreSafe == true then
		return true
	end

	local cooldownUntil = kv:get(COOLDOWN_KEY)
	if cooldownUntil and cooldownUntil > os.time() then
		return true
	end
	kv:set(COOLDOWN_KEY, os.time() + TELESCOPE_COOLDOWN)

	local itemPosition = item:getPosition()
	local telescopeIndex = findTelescopeIndex(itemPosition)
	if not telescopeIndex then
		return true
	end

	local pillarPosition = pillars[telescopeIndex]
	local pillarItem = getPillarItemAt(pillarPosition)
	if not pillarItem then
		return true
	end

	local pillarId = pillarItem:getId()

	if pillarId == RED_PILLAR_ID then
		player:say("You can take the core and have no reason to handle this dangerous object.", TALKTYPE_MONSTER_SAY)
		kv:set(CORE_SAFE, true)
	elseif GREEN_PILLAR_IDS[pillarId] then
		shootIceBeam(itemPosition, FRONT_DIRECTION)
		kv:set(CORE_SAFE, false)
	end

	return true
end

yalaharTelescope:aid(4969)
yalaharTelescope:register()

-- Core Dispenser
local yalaharCoreDispenser = Action()

function yalaharCoreDispenser.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local mission = player:getStorageValue(ShadowsOfYalahar.Questline)
	if mission ~= 3 then
		return true
	end

	local kv = player:kv():scoped(KV_SCOPE)

	local complete = kv:get(REWARD_KEY)
	if complete == true then
		return true
	end

	local coreSafe = kv:get(CORE_SAFE)
	if coreSafe ~= true then
		return true
	end

	player:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
	player:addItem(9249, 1) -- mago mechanic core
	player:say("You have acquired a mago-mechanic core and should deliver it to Telas.", TALKTYPE_MONSTER_SAY)
	kv:set(REWARD_KEY, true)

	return true
end

yalaharCoreDispenser:aid(4970)
yalaharCoreDispenser:register()
