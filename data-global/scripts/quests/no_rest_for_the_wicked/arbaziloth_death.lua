-- No Rest for the Wicked - Arbaziloth's death (both modes)
--   * First victory, in any mode: Fiend Slayer outfit (on global, Lai hands it out after the fight; W: Reward).
--     This base has no Lai, so it is given here.
--   * Room with the 11 chests: 10 victories in HARD mode (W: "killing the boss 10 times in the Hard difficulty").
--     Then ask The Forgemaster for the "key" (npc/the_forgemaster.lua).
local stag = Storage.Quest.U14_10.NoRestForTheWicked
local HARD_KILLS_NEEDED = 10 -- W
local KV_SCOPE = "no-rest-for-the-wicked"

NoRestForTheWicked = NoRestForTheWicked or {}

function NoRestForTheWicked.getHardKills(player)
	return player:kv():scoped(KV_SCOPE):get("hard-kills") or 0
end

local arbazilothOnDeath = CreatureEvent("azzilonCastleArbazilothOnDeath")

function arbazilothOnDeath.onDeath(creature)
	if creature:getName():lower() ~= "arbaziloth" then
		return true
	end

	local fight = ArbazilothFight and ArbazilothFight.state
	local hard = fight and fight.hardMode and fight.bossId == creature:getId() or false
	if fight then
		fight.result = hard and "hard" or "easy"
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(stag.Questlog) < 1 then
			player:setStorageValue(stag.Questlog, 1)
		end
		if player:getStorageValue(stag.KillArbaziloth.Questline) < 2 then
			player:setStorageValue(stag.KillArbaziloth.Questline, 2)
			if player:getStorageValue(stag.ForgemasterDoor.Questline) < 1 then
				player:setStorageValue(stag.ForgemasterDoor.Questline, 1)
			end
			if not player:hasOutfit(1808) or not player:hasOutfit(1809) then
				player:addOutfit(1808)
				player:addOutfit(1809)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have defeated Arbaziloth for the first time. You have won the Fiend Slayer Outfit.")
			end
		end

		if not hard or player:getStorageValue(stag.ForgemasterDoor.Questline) >= 2 then
			return
		end
		local kills = NoRestForTheWicked.getHardKills(player) + 1
		player:kv():scoped(KV_SCOPE):set("hard-kills", kills)
		if kills >= HARD_KILLS_NEEDED then
			player:setStorageValue(stag.ForgemasterDoor.Questline, 2)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have defeated Arbaziloth 10 times in his full power. Ask The Forgemaster for the key.")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have defeated Arbaziloth in his full power %d of %d times.", kills, HARD_KILLS_NEEDED))
		end
	end)
	return true
end

arbazilothOnDeath:register()
