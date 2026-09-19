local BURNING_HEART_MISSION = Storage.Quest.U15_24.Targuna.BurningHeart.Mission
local HERALD_KILLED = Storage.Quest.U15_24.Targuna.BurningHeart.HeraldKilled

-- Escape portal that only appears once the Herald is defeated.
local ENERGY_PORTAL_ID = 25051
local ESCAPE_PORTAL_POSITION = Position(32496, 32661, 15)
local ESCAPE_PORTAL_DESTINATION = Position(32418, 32686, 13)

-- Fire fields that grant the Herald immunity while he stands on them.
local FIRE_FIELD_IDS = { 2118, 2119, 2120 }

local function isOnFireField(creature)
	local tile = Tile(creature:getPosition())
	if not tile then
		return false
	end
	for _, id in ipairs(FIRE_FIELD_IDS) do
		if tile:getItemById(id) then
			return true
		end
	end
	return false
end

-- Immunity: while the Herald stands on a fire field, he takes no damage.
local heraldImmunity = CreatureEvent("TargunaHeraldImmunity")

function heraldImmunity.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType)
	if creature and primaryDamage < 0 and isOnFireField(creature) then
		creature:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
		return 0, primaryType, 0, secondaryType
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

heraldImmunity:register()

local heraldKill = CreatureEvent("TargunaHeraldDeath")

function heraldKill.onDeath(creature, _corpse, _lastHitKiller, mostDamageKiller)
	onDeathForParty(creature, mostDamageKiller, function(_creature, player)
		if player:getStorageValue(BURNING_HEART_MISSION) >= 1 and player:getStorageValue(HERALD_KILLED) ~= 1 then
			player:setStorageValue(HERALD_KILLED, 1)
			if player:getStorageValue(BURNING_HEART_MISSION) < 3 then
				player:setStorageValue(BURNING_HEART_MISSION, 3)
			end
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have defeated the Herald of Fire! Use the portal to the south and report back to Emiliana.")
		end
	end)

	-- Reveal the escape portal back to the start of the hunt (skip if it already exists).
	local portalTile = Tile(ESCAPE_PORTAL_POSITION)
	if not (portalTile and portalTile:getItemById(ENERGY_PORTAL_ID)) then
		local portal = Game.createItem(ENERGY_PORTAL_ID, 1, ESCAPE_PORTAL_POSITION)
		if portal and portal:isTeleport() then
			portal:setDestination(ESCAPE_PORTAL_DESTINATION)
		end
		ESCAPE_PORTAL_POSITION:sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

heraldKill:register()
