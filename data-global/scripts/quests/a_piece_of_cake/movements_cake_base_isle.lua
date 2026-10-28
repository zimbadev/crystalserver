--	A Piece of Cake - Cake Base Isle

local cakeBase = MoveEvent()

function cakeBase.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if not player:hasAchievement("Cake Conqueror") then
		player:addAchievement("Cake Conqueror")
	end

	if CakeQuest.getStage() ~= 3 then
		return true
	end

	local errand = CakeQuest.getBrutusErrand(player)

	if not player:hasAchievement("I Did My Part") then
		player:addAchievement("I Did My Part")
	end

	if not errand.stepIsleArmed and #errand.visitedCities < 5 then
		errand.stepIsleArmed = true
		CakeQuest.setBrutusErrand(player, errand)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You feel ready to head to the next extraction machine.")
		position:sendMagicEffect(CONST_ME_CAKE)
		player:say("SPLASH!", TALKTYPE_MONSTER_SAY)
	end

	return true
end

cakeBase:type("stepin")
cakeBase:id(CakeQuest.Items.CakeBaseIds[1], CakeQuest.Items.CakeBaseIds[2], CakeQuest.Items.CakeBaseIds[3], CakeQuest.Items.CakeBaseIds[4], CakeQuest.Items.CakeBaseIds[5], CakeQuest.Items.CakeBaseIds[6])
cakeBase:register()
