local armorId = 31482
local armorPos = Position(234, 621, 6)
local metalWallId = 31449

local function createArmor(id, amount, pos)
	local armor = Game.createItem(id, amount, pos)
	if armor then
		armor:setActionId(40003)
	end
end

local config = {
	boss = {
		name = "Scarlett Etzel",
		createFunction = function()
			local scarlett = Game.createMonster("Scarlett Etzel", Position(232, 623, 6), true, true)
			scarlett:setStorageValue(Storage.CrystalServer.Quests.CobraBastion.Questline, 1)
			return scarlett
		end,
	},
	playerPositions = {
		{ pos = Position(231, 642, 6), teleport = Position(231, 638, 6) },
		{ pos = Position(230, 643, 6), teleport = Position(231, 638, 6) },
		{ pos = Position(231, 643, 6), teleport = Position(231, 638, 6) },
		{ pos = Position(232, 643, 6), teleport = Position(231, 638, 6) },
		{ pos = Position(231, 644, 6), teleport = Position(231, 638, 6) },
	},
	specPos = {
		from = Position(221, 619, 6),
		to = Position(242, 641, 6),
	},
	onUseExtra = function()
		SCARLETT_MAY_TRANSFORM = 0
	end,
	exit = Position(231, 646, 6),
}

local lever = BossLever(config)
lever:position(Position(231, 641, 6))
lever:register()

local transformTo = {
	[31474] = 31475,
	[31475] = 31476,
	[31476] = 31477,
	[31477] = 31474,
}

local mirror = {
	fromPos = Position(225, 622, 6),
	toPos = Position(239, 636, 6),
	mirrors = { 31474, 31475, 31476, 31477 },
}

local function backMirror()
	for x = mirror.fromPos.x, mirror.toPos.x do
		for y = mirror.fromPos.y, mirror.toPos.y do
			local sqm = Tile(Position(x, y, 6))
			if sqm then
				for _, id in pairs(mirror.mirrors) do
					local item = sqm:getItemById(id)
					if item then
						item:transform(mirror.mirrors[math.random(#mirror.mirrors)])
						item:getPosition():sendMagicEffect(CONST_ME_POFF)
					end
				end
			end
		end
	end
end

local graveScarlettAid = Action()
function graveScarlettAid.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if table.contains(transformTo, item.itemid) then
		local pilar = transformTo[item.itemid]
		if pilar then
			item:transform(pilar)
			item:getPosition():sendMagicEffect(CONST_ME_POFF)
		end
	elseif item.itemid == armorId then
		item:getPosition():sendMagicEffect(CONST_ME_THUNDER)
		item:remove(1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You hold the old chestplate of Galthein in front of you. It does not fit and far too old to withstand any attack.")
		addEvent(createArmor, 20 * 1000, armorId, 1, armorPos)
		addEvent(backMirror, 10 * 1000)
		SCARLETT_MAY_TRANSFORM = 1
		addEvent(function()
			SCARLETT_MAY_TRANSFORM = 0
		end, 2000)
	elseif item.itemid == metalWallId then
		if player:getPosition().y == 649 then
			player:teleportTo(Position(231, 647, 6))
		else
			player:teleportTo(Position(231, 649, 6))
		end
	end
	return true
end

graveScarlettAid:aid(40003)
graveScarlettAid:register()
