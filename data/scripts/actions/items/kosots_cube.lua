local kosOTSCube = Action()
-- Lista teleportów: Miasta
local cityTeleports = {
	{ name = "Dawnport Tutorial", pos = Position(32069, 31901, 6) },
	{ name = "Dawnport", pos = Position(32064, 31894, 6) },
	{ name = "Rookgaard", pos = Position(32097, 32219, 7) },
	{ name = "Island of Destiny", pos = Position(32091, 32027, 7) },
	{ name = "Ab'Dendriel", pos = Position(32732, 31634, 7) },
	{ name = "Carlin", pos = Position(32360, 31782, 7) },
	{ name = "Kazordoon", pos = Position(32649, 31925, 11) },
	{ name = "Thais", pos = Position(32369, 32241, 7) },
	{ name = "Venore", pos = Position(32957, 32076, 7) },
	{ name = "Ankrahmun", pos = Position(33194, 32853, 8) },
	{ name = "Edron", pos = Position(33217, 31814, 8) },
	{ name = "Farmine", pos = Position(33023, 31521, 11) },
	{ name = "Darashia", pos = Position(33213, 32454, 1) },
	{ name = "Liberty Bay", pos = Position(32317, 32826, 7) },
	{ name = "Port Hope", pos = Position(32594, 32745, 7) },
	{ name = "Svargrond", pos = Position(32212, 31132, 7) },
	{ name = "Yalahar", pos = Position(32787, 31276, 7) },
	{ name = "Gray Beach", pos = Position(33447, 31323, 9) },
	{ name = "Krailos", pos = Position(33657, 31665, 8) },
	{ name = "Rathleton", pos = Position(33594, 31899, 6) },
	{ name = "Roshamuul", pos = Position(33513, 32363, 6) },
	{ name = "Issavi", pos = Position(33921, 31477, 5) },
	{ name = "Event Room", pos = Position(1054, 1040, 7) },
	{ name = "Cobra Bastion", pos = Position(33397, 32651, 7) },
	{ name = "Bounac", pos = Position(32424, 32445, 7) },
	{ name = "Feyrist", pos = Position(33490, 32221, 7) },
	{ name = "Gnomprona", pos = Position(33517, 32856, 14) },
	{ name = "Marapur", pos = Position(33842, 32853, 7) },
	{ name = "Candia", pos = Position(33338, 32125, 7) },
	{ name = "Silvertides", pos = Position(33776, 32842, 7) },
	{ name = "Moonfall", pos = Position(33797, 32755, 5) },
	{ name = "Blue Valley", pos = Position(33614, 31494, 7) },
}



-- Funkcja pomocnicza: otwiera modal z listą teleportów (teleports = tabela z {name,pos})
local function openTeleportList(player, teleports, title)
	if not teleports or #teleports == 0 then
		player:sendCancelMessage("Brak skonfigurowanych teleportów dla tej kategorii.")
		return true
	end

	local window = ModalWindow({
		title = title or "Lista teleportów",
		message = "Wybierz miejsce:",
	})

	for _, tp in ipairs(teleports) do
		local thisTp = tp -- zabezpieczenie zamknięcia
		window:addChoice(thisTp.name, function(player, button)
			if button.name ~= "Select" then
				return true
			end

			if not thisTp or not thisTp.pos or not thisTp.pos.x then
				player:sendCancelMessage("Błąd konfiguracji teleportu.")
				return true
			end

			player:teleportTo(thisTp.pos)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Teleportowano do " .. thisTp.name .. ".")
			return true
		end)
	end

	window:addButton("Select")
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
	return true
end
function kosOTSCube.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local inPz = player:getTile():hasFlag(TILESTATE_PROTECTIONZONE)
	local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)
    if inPz or not inFight then
        local window = ModalWindow({
            title = "Typ teleportu",
            message = "Wybierz kategorię teleportów:",
        })

        -- Wybór: Miasta
        window:addChoice("Miasto", function(player, button)
            if button.name ~= "Select" then return true end
            return openTeleportList(player, cityTeleports, "Teleporta - Miasta")
        end)

        -- Wybór: Bossy
        window:addChoice("Boss", function(player, button)
            if button.name ~= "Select" then return true end
            local bosses = BossLever:getAll()

            return openTeleportList(player, bosses, "Teleporta - Bossy")
        end)

        window:addButton("Select")
        window:addButton("Close")
        window:setDefaultEnterButton(0)
        window:setDefaultEscapeButton(1)
        window:sendToPlayer(player)

        return true
	else
		player:sendCancelMessage("You can't use this when you're in a fight.")
		fromPosition:sendMagicEffect(CONST_ME_POFF)
	end
end

kosOTSCube:id(33313)
kosOTSCube:register()
