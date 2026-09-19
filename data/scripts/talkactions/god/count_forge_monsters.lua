local talkaction = TalkAction("/countinfluenced")

function talkaction.onSay(player, words, param)
	-- create log
	logCommand(player, words, param)

	local influencedMonsters = Game.getInfluencedMonsters()
	local total = #influencedMonsters

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Total influenced monsters: %d.", total))
	return true
end

talkaction:groupType("god")
talkaction:register()

local talkactionFiendish = TalkAction("/countfiendish")

function talkactionFiendish.onSay(player, words, param)
	-- create log
	logCommand(player, words, param)

	local fiendishMonsters = Game.getFiendishMonsters()
	local total = #fiendishMonsters

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Total fiendish monsters: %d.", total))
	return true
end

talkactionFiendish:groupType("god")
talkactionFiendish:register()
