-- Boss Difficulty Selection window — S2C opcode 0x2F.
-- Field -> controller (RE'd open handler 0x1405ed8d3):
--   f1->+0x40 = lowestDifficulty | f2(u8)->+0x44 = SPINNER GATE (f2=0 -> spinner editable!) |
--   f3->+0x48 = raceId | f4->+0x4c = selectedDifficulty (value shown in spinner) |
--   f5->+0x50 = highestDifficultyOfGroup | f6->+0x54 = personalHighestDifficulty | f7->+0x58 = badLuck/1000
--
-- LIVE-confirmed: f2=0 makes the "Select Difficulty" spinner appear with arrows; f4 = the shown value.
-- The server NO LONGER auto-closes on the client's 0xC2 (that was making the window vanish); it now
-- just logs the 0xC2 body so we can wire Cancel/Start properly next.
--
-- Usage: /bossdiff <raceId> [selected=f4] [lowest=f1] [group=f5] [personal=f6]
--   default: /bossdiff 100  -> boss 100, spinner ON, selected 1, range lowest 1 .. group/personal 25

local talkaction = TalkAction("/bossdiff")

function talkaction.onSay(player, words, param)
	local a = {}
	for tok in string.gmatch(param or "", "%S+") do
		a[#a + 1] = tonumber(tok)
	end

	local raceId = a[1] or 100
	local selected = a[2] or 0 -- f4 = selectedDifficulty (spinner start value)
	local lowest = a[3] or 0 -- f1 = lowestDifficulty (spinner min = 0)
	local group = a[4] or 25 -- f5 = highestDifficultyOfGroup (max = 25)
	local personal = a[5] or 25 -- f6 = personalHighestDifficulty (max = 25)
	local spinnerGate = 0 -- f2 = 0 -> spinner editable (difficulty 0..25)

	-- numbers = { f1=lowest, f2=gate, f3=raceId, f4=selected, f5=group, f6=personal, f7=badluck }
	local numbers = { lowest, spinnerGate, raceId, selected, group, personal, 2000 }
	local banners = { "Yvara", "Gryllan", "Frost Walker", "Drift Reaper", "Eradrel" }

	player:sendBossDifficultySelection(0, numbers, banners, {}, {})
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("[bossdiff] boss=%d selected=%d lowest=%d group=%d personal=%d", raceId, selected, lowest, group, personal))
	return true
end

talkaction:separator(" ")
talkaction:groupType("god")
talkaction:register()
