local teleportLocations  = {
    { name="Thais", position = Position(32369, 32241, 7) },
    { name="Edron", position = Position(33217, 31814, 8) },
    { name="Carlin", position = Position(32360, 31782, 7) },
    { name="Venore", position = Position(32957, 32076, 7) },
    { name="Ab'Dendriel", position = Position(32732, 31634, 7) },
    { name="Port Hope", position = Position(32594, 32745, 7) },
    { name="Yalahar", position = Position(32787, 31276, 7) },
    { name="Kazordoon", position = Position(32649, 31925, 11) },
    { name="Darashia", position = Position(33213, 32454, 1) },
    { name="Rathleton", position = Position(33594, 31899, 6) },
    { name="Svargrond", position = Position(32212, 31132, 7) },
    { name="Farmine", position = Position(33023, 31521, 11) },
    { name="Ankrahmun", position = Position(33194, 32853, 8) },
    { name="Liberty Bay", position = Position(32317, 32826, 7) },
    { name="Roshamuul", position = Position(33513, 32363, 6) },
    { name="Gray beach", position = Position(33447, 31323, 9) },
    { name="Issavi", position = Position(33921, 31477, 5) },
    { name="Krailos", position = Position(33655, 31666, 8) },
    { name="Hunts Teleports", position = Position(31891, 32024, 8) },
    { name="Forge", position = Position(31646, 32043, 8) },
}

local teleportItemID = 31633 -- Replace with the actual item ID

local teleportEvent = Action()

function teleportEvent.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not player:isVip() then
        player:sendCancelMessage("Somente jogadores VIP podem usar este item!")
        return true
    end
   
    player:registerEvent("TeleportModalWindowLocations")
   
    local teleportWindow = ModalWindow(1, "Selecione um Local")
    for i, location in ipairs(teleportLocations) do
        teleportWindow:addChoice(i, location.name)
    end
    teleportWindow:addButton(1, "Selecionar")
    teleportWindow:addButton(2, "Cancelar")
    teleportWindow:setDefaultEnterButton(1)
    teleportWindow:setDefaultEscapeButton(2)
    teleportWindow:sendToPlayer(player)
   
    return true
end

teleportEvent:id(teleportItemID)
teleportEvent:register()

local modalEvent = CreatureEvent("TeleportModalWindowLocations")

function modalEvent.onModalWindow(player, modalWindowId, buttonId, choiceId)
    player:unregisterEvent("TeleportModalWindowLocations")
   
    if buttonId == 1 then
        local selectedLocation = teleportLocations[choiceId]
        if selectedLocation then
            return player:ProcessTeleport(selectedLocation.position)
        end
    end
   
    return true
end

modalEvent:type("modalwindow")
modalEvent:register()

function Player.ProcessTeleport(self, position)
    if not self or not position then return false end
    if self:getCondition(CONDITION_INFIGHT) then
        self:sendTextMessage(MESSAGE_STATUS_SMALL, "Você não pode se teleportar enquanto está em combate.")
        return false
    end
    if self:isPzLocked() then
        self:sendTextMessage(MESSAGE_STATUS_SMALL, "Você não pode se teleportar enquanto está protegido por uma zona de paz.")
        return false
    end
   
    self:teleportTo(position)
    self:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
   
    return true
end