-- Grave Danger: Sir Nictros and Sir Baeloc (TibiaWiki = W)
--   W: Nictros fights first; around 60% he steps back and Baeloc comes in; around 60% Baeloc calls his brother and both
--      fight together. Together, their health must stay close: "the one with less HP will heal about 18,000 health
--      after a certain point".
--   NOT CONFIRMED: "a certain point" = a gap of more than 15 percentage points of health; checked every 2 s.
local SWAP_AT = 0.60
local BALANCE_GAP = 15
local BALANCE_HEAL = 18000

local function bothTogether(firstId, secondId)
	local a, b = Monster(firstId), Monster(secondId)
	if not a or not b then
		return
	end
	local pa = a:getHealth() * 100 / a:getMaxHealth()
	local pb = b:getHealth() * 100 / b:getMaxHealth()
	if math.abs(pa - pb) > BALANCE_GAP then
		local lower = pa < pb and a or b
		lower:addHealth(BALANCE_HEAL)
		lower:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		lower:say("My brother's strength flows into me!", TALKTYPE_MONSTER_SAY)
	end
	addEvent(bothTogether, 2000, firstId, secondId)
end

local sirNictrosThink = CreatureEvent("SirNictrosThink")
function sirNictrosThink.onThink(creature)
	if creature:getHealth() < creature:getMaxHealth() * SWAP_AT then
		creature:say("Now it's your chance for entertainment, dear brother!", TALKTYPE_MONSTER_SAY)
		creature:teleportTo(Position({ x = 33427, y = 31428, z = 13 }))
		local boss = Tile(Position({ x = 33422, y = 31428, z = 13 })):getTopCreature()
		if boss and boss:isMonster() then
			boss:teleportTo(Position({ x = 33423, y = 31437, z = 13 }))
		end
		creature:unregisterEvent("SirNictrosThink")
	end
	return true
end

sirNictrosThink:register()

local sirBaelocThink = CreatureEvent("SirBaelocThink")
function sirBaelocThink.onThink(creature)
	if creature:getHealth() < creature:getMaxHealth() * SWAP_AT then
		creature:say("Join me in battle, my brother. Let's share the fun!", TALKTYPE_MONSTER_SAY)
		local tile = Tile(Position({ x = 33427, y = 31428, z = 13 }))
		local brother = tile and tile:getTopCreature()
		if brother and brother:isMonster() then
			brother:teleportTo(Position({ x = 33424, y = 31437, z = 13 }))
			addEvent(bothTogether, 2000, creature:getId(), brother:getId())
		end
		creature:unregisterEvent("SirBaelocThink")
	end
	return true
end

sirBaelocThink:register()
