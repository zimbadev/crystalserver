local dukeKruleTransformEvent = CreatureEvent("DukeKruleTransform")
local transformationCooldown = 11
local lastTransformationTime = 0
local damageAmount = 4000
local damageCooldown = 4
local lastDamageTime = {}
local fromPosition = Position(33447, 31464, 13)
local toPosition = Position(33464, 31481, 13)
local transformationDuration = 10000

local function isInArea(position, fromPos, toPos)
	return position.x >= fromPos.x and position.x <= toPos.x and position.y >= fromPos.y and position.y <= toPos.y and position.z == fromPos.z
end

local function applyAreaEffect(player, transformationType)
	if not player or not player:isPlayer() then
		return
	end

	local playerPos = player:getPosition()
	if transformationType == "fire" then
		for x = -2, 2 do
			for y = -2, 2 do
				local pos = Position(playerPos.x + x, playerPos.y + y, playerPos.z)
				pos:sendMagicEffect(CONST_ME_HITBYFIRE)
			end
		end
	elseif transformationType == "water" then
		for x = -2, 2 do
			for y = -2, 2 do
				local pos = Position(playerPos.x + x, playerPos.y + y, playerPos.z)
				pos:sendMagicEffect(CONST_ME_ICETORNADO)
			end
		end
	end
end

function transformPlayers(position)
	local players = Game.getSpectators(position, false, false, 30, 30, 30, 30)
	local transformedPlayers = {}
	for _, player in ipairs(players) do
		if player:isPlayer() and isInArea(player:getPosition(), fromPosition, toPosition) then
			local originalOutfit = player:getOutfit()
			local randomTransformation = math.random(2)
			if randomTransformation == 1 then
				player:setOutfit({ lookType = 49 })
				player:sendCancelMessage("You have been transformed into a Fire Elemental!")
				transformedPlayers[player:getId()] = { type = "fire", originalOutfit = originalOutfit }
			else
				player:setOutfit({ lookType = 286 })
				player:sendCancelMessage("You have been transformed into a Water Elemental!")
				transformedPlayers[player:getId()] = { type = "water", originalOutfit = originalOutfit }
			end

			local function periodicEffect(playerId, transformationType)
				local player = Player(playerId)
				if player and player:getOutfit().lookType == (transformationType == "fire" and 49 or 286) then
					applyAreaEffect(player, transformationType)
					addEvent(periodicEffect, 2000, playerId, transformationType)
				end
			end
			addEvent(periodicEffect, 2000, player:getId(), transformedPlayers[player:getId()].type)

			addEvent(function()
				for _, p in ipairs(players) do
					if p:isPlayer() and transformedPlayers[p:getId()] then
						p:setOutfit(transformedPlayers[p:getId()].originalOutfit)
						p:sendCancelMessage("You have returned to your normal form.")
						p:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
						transformedPlayers[p:getId()] = nil
					end
				end
			end, transformationDuration)

			addEvent(checkProximityAndApplyDamage, 1000, transformedPlayers)
		end
	end
end

function checkProximityAndApplyDamage(transformedPlayers)
	local currentTime = os.time()
	local playerIds = {}
	for playerId, _ in pairs(transformedPlayers) do
		table.insert(playerIds, playerId)
	end
	for i = 1, #playerIds - 1 do
		local player1 = Player(playerIds[i])
		if player1 then
			local outfit1 = transformedPlayers[player1:getId()].type
			for j = i + 1, #playerIds do
				local player2 = Player(playerIds[j])
				if player2 and player1:getPosition():getDistance(player2:getPosition()) <= 3 then
					local outfit2 = transformedPlayers[player2:getId()].type
					if outfit1 ~= outfit2 then
						local lastDamage1 = lastDamageTime[player1:getId()] or 0
						local lastDamage2 = lastDamageTime[player2:getId()] or 0
						if currentTime - lastDamage1 >= damageCooldown or currentTime - lastDamage2 >= damageCooldown then
							if currentTime - lastDamage1 >= damageCooldown then
								player1:addHealth(-damageAmount)
								player1:sendCancelMessage("You took damage for being too close to an opposite elemental!")
								player1:getPosition():sendMagicEffect(CONST_ME_BIGCLOUDS)
								lastDamageTime[player1:getId()] = currentTime
							end
							if currentTime - lastDamage2 >= damageCooldown then
								player2:addHealth(-damageAmount)
								player2:sendCancelMessage("You took damage for being too close to an opposite elemental!")
								player2:getPosition():sendMagicEffect(CONST_ME_BIGCLOUDS)
								lastDamageTime[player2:getId()] = currentTime
							end
						end
					end
				end
			end
		end
	end

	addEvent(checkProximityAndApplyDamage, 1000, transformedPlayers)
end

function dukeKruleTransformEvent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if creature and creature:isMonster() and creature:getName():lower() == "duke krule" then
		local currentTime = os.time()
		if currentTime - lastTransformationTime >= transformationCooldown then
			transformPlayers(creature:getPosition())
			lastTransformationTime = currentTime
		end
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

dukeKruleTransformEvent:register()
