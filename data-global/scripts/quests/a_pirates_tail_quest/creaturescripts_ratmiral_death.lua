local ratmiralDeath = CreatureEvent("ratmiralDeath")
local outfits = { 1371, 1372 }

function ratmiralDeath.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	if not creature or not creature:getMonster() then
		return true
	end

	local damageMap = creature:getMonster():getDamageMap()

	for key, _ in pairs(damageMap) do
		local player = Player(key)
		if player and player:getStorageValue(Storage.Quest.U12_60.APiratesTail.RatmiralKilled) <= 1 then
			player:setStorageValue(Storage.Quest.U12_60.APiratesTail.RatmiralKilled, 1)

			if not player:hasOutfit(outfits[1]) and not player:hasOutfit(outfits[2]) then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You received the Rascoohan Outfit.")
				player:addOutfit(outfits[1], 0)
				player:addOutfit(outfits[2], 0)
			end
		end
	end

	return true
end
ratmiralDeath:register()
