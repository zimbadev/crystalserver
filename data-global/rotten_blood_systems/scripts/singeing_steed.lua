local itemMount = 36938
local mountId = 184
local requiredUses = 4
local storageKey = "singeing_steed_mount"

local fireItemMount = Action("fireItemMount")

function fireItemMount.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:hasMount(mountId) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already own the singeing steed mount.")
		return false
	end

	local uses = tonumber(player:kv():get(storageKey)) or 0
	uses = uses + 1
	player:kv():set(storageKey, uses)
	item:remove(1)

	if uses >= requiredUses then
		player:addMount(mountId)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have obtained the singeing steed mount!")
		player:kv():set(storageKey, 0)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "fiery horseshoes used... (" .. uses .. "/" .. requiredUses .. ")")
	end

	return true
end

fireItemMount:id(itemMount)
fireItemMount:register()
