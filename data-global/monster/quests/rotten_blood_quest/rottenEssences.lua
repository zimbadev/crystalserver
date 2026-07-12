local essenciasID = {
	[43501] = { str = 52280 }, -- essence of Murcion
	[43502] = { str = 52282 }, -- essence of Chagorz
	[43503] = { str = 52281 }, -- essence of Ichgahal
	[43504] = { str = 52283 }, -- essence of Vemiath
}

local essencesRottenBlood = Action("essencesRottenBlood")

function essencesRottenBlood.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local info = essenciasID[item:getId()]
	if not info then
		return true
	end

	local value = player:getStorageValue(info.str)
	if value >= 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "sorry not possible.")
		return true
	end

	player:setStorageValue(info.str, 1)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	item:remove(1)
	return true
end

essencesRottenBlood:id(43501, 43502, 43503, 43504)
essencesRottenBlood:register()

local pillarID = 43507

local flamesID = {
	[52280] = {
		globalstr = "essenceOfMurcion",
		name = "Murcion",
		flameID = 43983,
		transformflameID = 43984,
		flamePos = Position(33085, 32398, 15),
		pillarPos = Position(33081, 32398, 15),
	},
	[52281] = {
		globalstr = "essenceOfIchgahal",
		name = "Ichgahal",
		flameID = 43497,
		transformflameID = 43498,
		flamePos = Position(33076, 32389, 15),
		pillarPos = Position(33076, 32395, 15),
	},
	[52282] = {
		globalstr = "essenceOfChagorz",
		name = "Chagorz",
		flameID = 43987,
		transformflameID = 43988,
		flamePos = Position(33067, 32398, 15),
		pillarPos = Position(33071, 32398, 15),
	},
	[52283] = {
		globalstr = "essenceOfVemiath",
		name = "Vemiath",
		flameID = 43985,
		transformflameID = 43986,
		flamePos = Position(33076, 32407, 15),
		pillarPos = Position(33076, 32401, 15),
	},
}

local activateEssenceFlame = Action("activateEssenceFlame")

function activateEssenceFlame.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	for storageId, info in pairs(flamesID) do
		if item:getId() == info.flameID then
			local value = player:getStorageValue(storageId)
			if value >= 1 then
				if Game.getStorageValue(info.globalstr) > 0 then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This flame has already been activated.")
					return true
				end

				local flameItem = Tile(info.flamePos):getItemById(info.flameID)
				if flameItem then
					flameItem:transform(info.transformflameID)
				end

				local pillarItem = Tile(info.pillarPos):getItemById(pillarID)
				if pillarItem then
					pillarItem:transform(pillarID + 1)
				end

				Game.setStorageValue(info.globalstr, 1)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "essence of " .. info.name .. " activated.")
				player:setStorageValue(storageId, 0)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			end
			return true
		end
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "sorry not possible.")
	return false
end

activateEssenceFlame:id(43983, 43497, 43987, 43985)
activateEssenceFlame:register()
