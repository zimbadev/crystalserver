local partyProtection = CreatureEvent("PartyProtection")
local enabled = configManager.getBoolean(configKeys.ADVANCED_PARTY_PROTECTION)
local function getPlayerMaster(creature)
	if not creature then
		return nil
	end
	if creature:isPlayer() then
		return creature
	end
	if creature:isMonster() then
		local master = creature:getMaster()
		if master and master:isPlayer() then
			return master
		end
	end
	return nil
end
function partyProtection.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not enabled then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	if not attacker then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	local sourcePlayer = getPlayerMaster(attacker)
	if not sourcePlayer then
		return primaryDamage, primaryType, secondaryDamage, secondaryDamage, secondaryType
	end
	local targetPlayer = getPlayerMaster(creature)
	if not targetPlayer then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	if primaryType == COMBAT_HEALING or secondaryType == COMBAT_HEALING then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	local party1 = sourcePlayer:getParty()
	local party2 = targetPlayer:getParty()
	if party1 and party2 and party1 == party2 then
		return 0, primaryType, 0, secondaryType
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end
partyProtection:register()
