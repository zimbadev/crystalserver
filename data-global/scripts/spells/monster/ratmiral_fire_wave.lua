local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREATTACK)

local arr = {
	{ 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 3, 0, 0 },
	{ 0, 0, 0, 0, 0 },
}

local area = createCombatArea(arr)
combat:setArea(area)

local function tickShields(player)
	local currentIcon = player:getIcon("blue-shield")
	if not currentIcon or currentIcon.category ~= CreatureIconCategory_Quests or currentIcon.icon ~= CreatureIconQuests_BlueShield then
		return 0
	end
	if currentIcon.count <= 0 then
		player:removeIcon("blue-shield")
		player:setStorageValue(Storage.Quest.U12_60.APiratesTail.WaterIcon, 0)
		return 0
	end
	local newCount = currentIcon.count - 1
	player:setIcon("blue-shield", CreatureIconCategory_Quests, CreatureIconQuests_BlueShield, newCount)
	player:setStorageValue(Storage.Quest.U12_60.APiratesTail.WaterIcon, newCount)
	return newCount
end

local function spellCallbackPiratBall(param)
	local tile = Tile(Position(param.pos))

	if tile then
		local creature = tile:getTopCreature()
		if creature then
			if creature:isPlayer() then
				local shieldCount = tickShields(creature)

				if shieldCount > 0 then
					local damage1 = math.random(500, 1000)
					doTargetCombatHealth(param.cid, creature, COMBAT_FIREDAMAGE, -damage1, -damage1, CONST_ME_FIREAREA)
					creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your wetness spares you of most of the ratmirals flaming attack!")
				else
					local damage2 = math.random(1000, 1500)
					doTargetCombatHealth(param.cid, creature, COMBAT_FIREDAMAGE, -damage2, -damage2, CONST_ME_FIREAREA)
					creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are hit by the full power of the ratmirals flaming attack!")
				end
			end
		end
	end
end

function onTargetTilePiratBall(cid, pos)
	local param = {}
	param.cid = cid
	param.pos = pos
	spellCallbackPiratBall(param)
end

combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTilePiratBall")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("ratmiral fire wave")
spell:words("###8653")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needTarget(false)
spell:needDirection(true)
spell:register()
