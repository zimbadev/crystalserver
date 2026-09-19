-- Vocation Adjustment: a Master Sorcerer's elemental stance reshapes Scorch (element + impact EFFECT id):
--   Master of Thunder -> energy, effect 332
--   Master of Decay   -> death,  effect 331
--   Master of Flames / no stance -> base fire (CONST_ME_HITBYFIRE)
local function scorchFormula(level, maglevel)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 0.3) + 2
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 0.6) + 4
	return -min, -max
end

-- Each combat needs its OWN callback name (Canary won't let two combats share a callback name); all
-- three delegate to the same formula.
function onGetFormulaValues(player, level, maglevel, basePower)
	return scorchFormula(level, maglevel)
end
function onGetFormulaValuesThunder(player, level, maglevel)
	return scorchFormula(level, maglevel)
end
function onGetFormulaValuesDecay(player, level, maglevel)
	return scorchFormula(level, maglevel)
end

local function createScorchCombat(combatType, effect, callbackName)
	local c = Combat()
	c:setParameter(COMBAT_PARAM_TYPE, combatType)
	c:setParameter(COMBAT_PARAM_EFFECT, effect)
	c:setArea(createCombatArea(AREA_WAVE4, AREADIAGONAL_WAVE4))
	c:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, callbackName)
	return c
end

local combat = createScorchCombat(COMBAT_FIREDAMAGE, CONST_ME_HITBYFIRE, "onGetFormulaValues")
local combatThunder = createScorchCombat(COMBAT_ENERGYDAMAGE, 332, "onGetFormulaValuesThunder")
local combatDecay = createScorchCombat(COMBAT_DEATHDAMAGE, 331, "onGetFormulaValuesDecay")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player then
		local stance = player:getElementalStance()
		if stance == STANCE_MASTER_OF_THUNDER then
			return combatThunder:execute(creature, var)
		elseif stance == STANCE_MASTER_OF_DECAY then
			return combatDecay:execute(creature, var)
		end
	end
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(178)
spell:name("Scorch")
spell:words("exevo infir flam hur")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_SCORCH)
spell:level(1)
spell:mana(8)
spell:basePower(10)
spell:isAggressive(true)
spell:isPremium(false)
spell:needDirection(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
