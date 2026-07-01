-- Vocation Adjustment: a Master Sorcerer's elemental stance reshapes Hell's Core (element + the
-- AoE magic EFFECT id):
--   Master of Thunder -> energy, effect 337
--   Master of Decay   -> death,  effect 338
--   Master of Flames / no stance -> base fire (CONST_ME_FIREAREA)
local function hellsCoreFormula(level, maglevel)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 10)
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 14)
	return -min, -max
end

-- Each combat needs its OWN callback name (Canary won't let two combats share a callback name); all
-- delegate to the same formula.
function onGetFormulaValues(player, level, maglevel, basePower)
	return hellsCoreFormula(level, maglevel)
end
function onGetFormulaValuesThunder(player, level, maglevel)
	return hellsCoreFormula(level, maglevel)
end
function onGetFormulaValuesDecay(player, level, maglevel)
	return hellsCoreFormula(level, maglevel)
end

local function createHellsCoreCombat(combatType, effect, callbackName)
	local c = Combat()
	c:setParameter(COMBAT_PARAM_TYPE, combatType)
	c:setParameter(COMBAT_PARAM_EFFECT, effect)
	c:setArea(createCombatArea(AREA_CIRCLE5X5))
	c:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, callbackName)
	return c
end

local combat = createHellsCoreCombat(COMBAT_FIREDAMAGE, CONST_ME_FIREAREA, "onGetFormulaValues")
local combatThunder = createHellsCoreCombat(COMBAT_ENERGYDAMAGE, 337, "onGetFormulaValuesThunder")
local combatDecay = createHellsCoreCombat(COMBAT_DEATHDAMAGE, 338, "onGetFormulaValuesDecay")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	local player = creature:getPlayer()
	if player then
		local stance = player:getElementalStance()
		if stance == STANCE_MASTER_OF_THUNDER then
			return combatThunder:execute(creature, variant)
		elseif stance == STANCE_MASTER_OF_DECAY then
			return combatDecay:execute(creature, variant)
		end
	end
	return combat:execute(creature, variant)
end

spell:group("attack", "focus")
spell:id(24)
spell:name("Hell's Core")
spell:words("exevo gran mas flam")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_HELL_SCORE)
spell:level(60)
spell:mana(1100)
spell:basePower(250)
spell:isSelfTarget(true)
spell:isPremium(true)
spell:cooldown(40 * 1000)
spell:groupCooldown(4 * 1000, 40 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
