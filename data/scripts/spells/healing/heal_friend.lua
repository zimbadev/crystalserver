local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

function onGetFormulaValues(player, level, magicLevel, basePower)
	-- Vocation Adjustment: heal more consistently (lower highs, higher lows) -- 10/14 -> 11/13.
	local min = (calculateBaseDamageHealing(level) + magicLevel * 11) + 4
	local max = (calculateBaseDamageHealing(level) + magicLevel * 13) + 5
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

-- Vocation Adjustment: Druid "Shared Conservation" stance also heals a secondary party member in
-- the game window for 30% of the heal (a different target than the primary, never the caster).
local SHARED_CONSERVATION_RATIO = 0.30

local sharedConservationCombat = Combat()
sharedConservationCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
sharedConservationCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
sharedConservationCombat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

function onGetFormulaValuesSharedConservation(player, level, magicLevel)
	local min = (calculateBaseDamageHealing(level) + magicLevel * 11) + 4
	local max = (calculateBaseDamageHealing(level) + magicLevel * 13) + 5
	return min * SHARED_CONSERVATION_RATIO, max * SHARED_CONSERVATION_RATIO
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

function spell.onCastSpell(creature, variant)
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	local result = combat:execute(creature, variant)
	shareConservationHeal(creature:getPlayer(), variant:getNumber())
	return result
end

spell:name("Heal Friend")
spell:words("exura sio")
spell:group("healing")
spell:vocation("druid;true", "elder druid;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_HEAL_FRIEND)
spell:id(84)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:level(18)
spell:mana(120)
spell:basePower(260)
spell:needTarget(true)
spell:hasParams(true)
spell:hasPlayerNameParam(true)
spell:allowOnSelf(false)
spell:isAggressive(false)
spell:isPremium(true)
spell:register()
