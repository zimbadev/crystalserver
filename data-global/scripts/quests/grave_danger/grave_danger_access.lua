-- Grave Danger: access to King Zelos and quest log.
-- The freequest opens the quest only up to the graves: questline 1 (mission "The Lich Knights"), graves without a boss
-- already visited (2) and the 5 with a boss pending (1). Each boss marks its grave (GraveDangerGraves, called by
-- actions_bosses_killed.lua); with all 5 the mission goes to 2 and Jack Springer (report) opens King Zelos' door.
-- On login, players who got the old freequest (questline 14 = empty quest log + free door to Zelos) are
-- set back to what they really killed.
local GD = Storage.Quest.U12_20.GraveDanger
local B = GD.Bosses

-- boss -> killed storage and the grave it marks
GraveDangerGraves = {
	["sir baeloc"] = { killed = B.BaelocNictrosKilled, grave = GD.Graves.Darashia },
	["count vlarkorth"] = { killed = B.CountVlarkorthKilled, grave = GD.Graves.Edron },
	["duke krule"] = { killed = B.DukeKruleKilled, grave = GD.Graves.Thais },
	["earl osam"] = { killed = B.EarlOsamKilled, grave = GD.Graves.Cormaya },
	["lord azaram"] = { killed = B.LordAzaramKilled, grave = GD.Graves.Ghostlands },
}
local NO_BOSS_GRAVES = { GD.Graves.DarkCathedral, GD.Graves.FemorHills, GD.Graves.Ankrahmun, GD.Graves.Kilmaresh, GD.Graves.Vengoth, GD.Graves.Orclands, GD.Graves.IceIslands }

-- checks the 5 bosses: marks their graves and, with all of them, moves the mission on
function GraveDangerGraves.refresh(player)
	local all = true
	for _, entry in pairs(GraveDangerGraves) do
		if type(entry) == "table" then
			if player:getStorageValue(entry.killed) > 0 then
				if player:getStorageValue(entry.grave) < 2 then
					player:setStorageValue(entry.grave, 2)
				end
			else
				all = false
				if player:getStorageValue(entry.grave) < 1 then
					player:setStorageValue(entry.grave, 1)
				end
			end
		end
	end
	-- W: with the 12 graves the mission goes to 2 (back to Jack Springer); the door only opens when Jack
	-- tells about the ritual (questline 3, npc/jack_springer.lua). Zelos dead = questline 4.
	local questline = player:getStorageValue(GD.QuestLine)
	if all then
		if questline < 2 then
			player:setStorageValue(GD.QuestLine, 2)
			questline = 2
		end
		if player:getStorageValue(B.KingZelosKilled) > 0 and questline < 4 then
			player:setStorageValue(GD.QuestLine, 4)
			questline = 4
		end
	end
	if all and questline >= 3 then
		if player:getStorageValue(B.KingZelosDoor) < 1 then
			player:setStorageValue(B.KingZelosDoor, 1)
		end
	elseif player:getStorageValue(B.KingZelosDoor) > 0 then
		player:setStorageValue(B.KingZelosDoor, -1)
	end
	return all
end

local access = CreatureEvent("GraveDangerZelosAccess")

function access.onLogin(player)
	local questline = player:getStorageValue(GD.QuestLine)
	if questline == 14 then
		-- old freequest version: redo it like the new one
		player:setStorageValue(GD.QuestLine, 1)
		for _, storage in ipairs(NO_BOSS_GRAVES) do
			player:setStorageValue(storage, 2)
		end
		GraveDangerGraves.refresh(player)
	elseif questline >= 1 or player:getStorageValue(B.KingZelosDoor) > 0 then
		GraveDangerGraves.refresh(player)
	end
	return true
end

access:register()
