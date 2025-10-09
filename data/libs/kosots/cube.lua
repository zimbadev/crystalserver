---@class KosOTSCube

KosOTSCube = {
    Storage = {

    }
}
function KosOTSCube:openCubeTeleports(player)
local window = ModalWindow({
        title = title or "KosOTS Cube",
        message = "Chose action:",
    })



    window:addButton("Select")
	window:addButton("Close", function()
        KosOTSCube:openCubeWindow(player)
    end)
    window:setDefaultEnterButton(0)
    window:setDefaultEscapeButton(1)
    window:sendToPlayer(player)
    return true
end

function KosOTSCube:openCubeWindow(player)
    local window = ModalWindow({
        title = title or "KosOTS Cube",
        message = "Chose acti1on:",
    })

	-- Wybór: Bossy
	window:addChoice("Teleports", function(player, button)
		if button.name ~= "Select" then return true end


		return KosOTSCube:openCubeTeleports(player)
	end)
 	-- Wybór: Bossy
 	window:addChoice("Upgrades", function(player, button)
 		if button.name ~= "Select" then return true end


 		return KosOTSCube:openCubeTeleports(player)
 	end)

    window:addButton("Select")
    window:addButton("Close")
    window:setDefaultEnterButton(0)
    window:setDefaultEscapeButton(1)
    window:sendToPlayer(player)
end