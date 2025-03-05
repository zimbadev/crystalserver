local removeMonsters = TalkAction("/rm")

function removeMonsters.onSay(player, words, param)
	-- create log
	logCommand(player, words, param)

	local spectators = Game.getSpectators(player:getPosition(), false, false)

	for i = 1, #spectators do
		local creature = spectators[i]
		if creature and not creature:isPlayer() and not creature:isNpc() then
			creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
			creature:remove()
		end
	end

	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	return true
end

removeMonsters:groupType("god")
removeMonsters:register()
