-- Shield Slam (id 316) - Knight shield spell.
-- Requires a wielded shield. Physical damage that hits ALL enemies adjacent to the
-- caster (3x3 area centered on the caster). Damage scales with the shield's defense
-- value and the caster's shielding skill, plus a base power of 52.
-- Each hit enemy also receives the debuff: outgoing (auto-attack) damage reduced by
-- 50% for 10 seconds (CONDITION_PARAM_BUFF_DAMAGEDEALT = 50 => deals 50% damage).
--
-- Self-targeted area spell (like Berserk / Groundshaker): it strikes everything
-- around the caster, so no client target position is needed.

local DEBUFF_DURATION = 10000 -- 10s
local DEBUFF_DAMAGEDEALT = 50 -- enemy deals 50% damage (= -50%) while debuffed

-- Shield defense for the current cast is stashed here by onCastSpell so the
-- formula callback (which does not receive the shield) can read it.
local castShieldDefense = 0

-- Returns the equipped shield item (highest defense one) or nil if none is worn.
-- A shield may sit in either hand slot, so both are checked (mirrors Player::getShieldAndWeapon).
local function getEquippedShield(player)
	local best, bestDefense = nil, -1
	for _, slot in ipairs({ CONST_SLOT_LEFT, CONST_SLOT_RIGHT }) do
		local item = player:getSlotItem(slot)
		if item then
			local itemType = item:getType()
			if itemType and itemType:getWeaponType() == WEAPON_SHIELD then
				local defense = itemType:getDefense()
				if defense > bestDefense then
					best, bestDefense = item, defense
				end
			end
		end
	end
	return best
end

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 318)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

function onGetFormulaValues(player, skill, attack, factor, basePower)
	-- skill here is the shielding skill (SKILL_SHIELD), attack is unused for a shield slam.
	local shieldingSkill = player:getSkillLevel(SKILL_SHIELD)
	local level = player:getLevel()
	local defense = castShieldDefense

	-- Damage scales with shield defense + shielding skill, on top of the base power.
	local min = calculateBaseDamageHealing(level) + basePower + (defense * 1.4) + (shieldingSkill * 0.55)
	local max = calculateBaseDamageHealing(level) + basePower + (defense * 2.3) + (shieldingSkill * 0.95)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onTargetCreature(creature, target)
	if not (creature and target) then
		return true
	end
	if target:isPlayer() then
		return true
	end

	-- Vocation Adjustment: Shield Slam wheel grade II augment raises the debuff to -75% (enemy deals 25%).
	local debuffDealt = DEBUFF_DAMAGEDEALT
	local caster = creature:getPlayer()
	if caster and caster:upgradeSpellsWOD("Shield Slam") >= 2 then
		debuffDealt = 25
	end

	local condition = Condition(CONDITION_ATTRIBUTES)
	condition:setParameter(CONDITION_PARAM_TICKS, DEBUFF_DURATION)
	condition:setParameter(CONDITION_PARAM_BUFF_DAMAGEDEALT, debuffDealt)
	target:addCondition(condition)
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	local shield = getEquippedShield(player)
	if not shield then
		player:sendCancelMessage("You need to wield a shield to cast this spell.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	castShieldDefense = shield:getType():getDefense()
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(316)
spell:name("Shield Slam")
spell:words("exori scu")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_GROUNDSHAKER)
spell:level(30)
spell:mana(110)
spell:basePower(52)
spell:isPremium(false)
spell:needWeapon(false)
spell:cooldown(6 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("knight;true", "elite knight;true")
spell:register()
