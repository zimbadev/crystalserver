local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_NONE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)

local area = createCombatArea(AREA_CIRCLE1X1)
combat:setArea(area)

local areaFrom = Position(32999, 32325, 15)
local areaTo = Position(33016, 32342, 15)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if not(combat:execute(creature, var)) then
		return false
	end

	local validPositions = {}
	for x = areaFrom.x, areaTo.x do
		for y = areaFrom.y, areaTo.y do
			local checkPosition = Position(x, y, areaFrom.z)
			local tile = Tile(checkPosition)
			if tile and tile:isWalkable() then
				table.insert(validPositions, checkPosition)
			end
		end
	end

	local function isPositionValid(newPos, existingPositions, minDistance)
		for _, existingPos in ipairs(existingPositions) do
			local distance = math.max(math.abs(newPos.x - existingPos.x), math.abs(newPos.y - existingPos.y))
			if distance < minDistance then
				return false
			end
		end
		return true
	end

	local selectedPositions = {}
	local maxMushrooms = 8
	local minDistance = 1
	local maxAttempts = 100
	
	if #validPositions > 0 then
		for i = #validPositions, 2, -1 do
			local j = math.random(1, i)
			validPositions[i], validPositions[j] = validPositions[j], validPositions[i]
		end
		
		local attempts = 0
		while #selectedPositions < maxMushrooms and attempts < maxAttempts and #validPositions > 0 do
			local randomIndex = math.random(1, #validPositions)
			local candidatePos = validPositions[randomIndex]
			
			if #selectedPositions == 0 or isPositionValid(candidatePos, selectedPositions, minDistance) then
				table.insert(selectedPositions, candidatePos)
				table.remove(validPositions, randomIndex)
			else
				attempts = attempts + 1
			end
		end
		
		for _, spawnPosition in ipairs(selectedPositions) do
			local pillar = Game.createMonster("Mushroom", spawnPosition)
			if pillar then
				pillar:setMaster(creature)
				pillar:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				addEvent(function(pcid)
					local monster = Creature(pcid)
					if monster then
						monster:remove()
					end
				end, 10 * 1000, pillar:getId())
			end
		end
	end

	return true
end

spell:name("mushroom ichgahal")
spell:words("###99545")
spell:isAggressive(false)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()