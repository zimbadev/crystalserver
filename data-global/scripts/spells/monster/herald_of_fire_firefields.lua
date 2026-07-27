-- Herald of Fire (Targuna - Burning Heart): telegraph + fire fields.
-- Shows effect 53557 on the grid tiles and, after a delay, converts each one into a fire field.
-- The grid covers 32492..32500 x 32652..32660 (z15), every 2 sqm (5x5 = 25 points).
local TELEGRAPH_EFFECT = 53557
local FIRE_FIELD_ID = 2118
local FIRE_FIELD_IDS = { 2118, 2119, 2120 }
local TELEGRAPH_DELAY = 1500 -- ms between the telegraph and the fire field spawning

local GRID = {}
for x = 32492, 32500, 2 do
	for y = 32652, 32660, 2 do
		GRID[#GRID + 1] = Position(x, y, 15)
	end
end

local function spawnField(pos)
	local tile = Tile(pos)
	if not tile then
		return
	end
	-- Refresh: remove the previous fire field before creating a new one.
	for _, id in ipairs(FIRE_FIELD_IDS) do
		local old = tile:getItemById(id)
		if old then
			old:remove()
		end
	end
	local field = Game.createItem(FIRE_FIELD_ID, 1, pos)
	if field then
		field:decay()
	end
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	for _, pos in ipairs(GRID) do
		pos:sendMagicEffect(TELEGRAPH_EFFECT)
		addEvent(function()
			spawnField(pos)
		end, TELEGRAPH_DELAY)
	end
	return true
end

spell:name("heraldoffirefields")
spell:words("###targunaheraldfields")
spell:needLearn(true)
spell:isSelfTarget(true)
spell:cooldown(8000)
spell:register()
