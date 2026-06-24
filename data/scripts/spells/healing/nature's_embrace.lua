local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

-- Phase I rebalance (kept through Phase II/III): base healing 650 -> 2000.
local HEAL_SCALE = 2000 / 650

function onGetFormulaValues(player, level, maglevel, basePower)
	-- Vocation Adjustment: heal more consistently (lower highs, higher lows) -- 20/28 -> 22/26.
	local min = (level / 2.5) + (maglevel * 22)
	local max = (level / 2.5) + (maglevel * 26)
	return math.floor(min * HEAL_SCALE), math.floor(max * HEAL_SCALE)
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

-- Vocation Adjustment: Druid "Shared Conservation" stance also heals a secondary party member in
-- the game window for 30% of the heal (a different target than the primary, never the caster).
local SHARED_CONSERVATION_RATIO = 0.30

local sharedConservationCombat = Combat()
sharedConservationCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
sharedConservationCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
sharedConservationCombat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

function onGetFormulaValuesSharedConservation(player, level, maglevel)
	local min = (level / 2.5) + (maglevel * 22)
	local max = (level / 2.5) + (maglevel * 26)
	return math.floor(min * HEAL_SCALE * SHARED_CONSERVATION_RATIO), math.floor(max * HEAL_SCALE * SHARED_CONSERVATION_RATIO)
end

sharedConservationCombat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValuesSharedConservation")

-- Heals the nearest valid party member (same floor, alive, not the primary target, not the caster).
local function shareConservationHeal(player, primaryTargetId)
	if not player or player:getStance() ~= STANCE_SHARED_CONSERVATION then
		return
	end
	local party = player:getParty()
	if not party then
		return
	end
	local members = party:getMembers()
	table.insert(members, party:getLeader())
	local origin = player:getPosition()
	local best, bestDist
	for _, member in ipairs(members) do
		if member and member:isPlayer() and member:getId() ~= primaryTargetId and member:getId() ~= player:getId() and member:getHealth() > 0 then
			local pos = member:getPosition()
			if pos.z == origin.z then
				local dist = math.max(math.abs(pos.x - origin.x), math.abs(pos.y - origin.y))
				if not bestDist or dist < bestDist then
					best, bestDist = member, dist
				end
			end
		end
	end
	if best then
		-- Variant(<number id>) routes to the single-target heal path; Variant(<creature>) would become a
		-- target-POSITION variant and, with no area set, heal nothing (just a POFF effect).
		sharedConservationCombat:execute(player, Variant(best:getId()))
	end
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if creature:isPlayer() and var:getNumber() == creature:getId() then
		creature:sendCancelMessage("You can't cast this spell to yourself.")
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	else
		local result = combat:execute(creature, var)
		shareConservationHeal(creature:getPlayer(), var:getNumber())
		return result
	end
end

spell:group("healing")
spell:id(242)
spell:name("Nature's Embrace")
spell:words("exura gran sio")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_NATURES_EMBRACE)
spell:level(300)
spell:mana(400)
spell:basePower(2000)
spell:isPremium(true)
spell:needTarget(true)
spell:cooldown(60 * 1000)
spell:groupCooldown(1 * 1000)
spell:isAggressive(false)
spell:isBlockingWalls(true)
spell:hasParams(true)
spell:hasPlayerNameParam(true)
spell:vocation("druid;true", "elder druid;true")
spell:register()
