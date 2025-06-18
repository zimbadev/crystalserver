local itemMountId = 37746
local storeMounts = {
	{ 23, "Fire War Horse" },
	{ 24, "Shadow Draptor" },
	{ 29, "Flamesteed" },
	{ 30, "Jade Lion" },
	{ 31, "Jade Pincer" },
	{ 32, "Nethersteed" },
	{ 33, "Tempest" },
	{ 34, "Winter King" },
	{ 35, "Flying Divan" },
	{ 36, "Magic Carpet" },
	{ 37, "Floating Kaupang" },
	{ 38, "Armoured War Horse" },
	{ 39, "Blessed Deer" },
	{ 40, "Ancient Lion Knight" },
	{ 41, "Ironblight" },
	{ 42, "Magma Crawler" },
	{ 43, "Dragonling" },
	{ 44, "Gnarlhound" },
	{ 45, "Crimson Ray" },
	{ 46, "Steelbeak" },
	{ 47, "Water Buffalo" },
	{ 48, "Golden Dragonfly" },
	{ 49, "Shock Head" },
	{ 50, "Walker" },
	{ 51, "Azudocus" },
	{ 52, "Carpacosaurus" },
	{ 53, "Death Crawler" },
	{ 54, "Flamemane" },
	{ 55, "Hailtorm Fury" },
	{ 56, "Leafscuttler" },
	{ 57, "Sparkion" },
	{ 58, "Swamp Snapper" },
	{ 59, "Venompaw" },
	{ 60, "Void Watcher" },
	{ 61, "Feral Tiger" },
}

local randStoreMount = Action("RandomStoreMount")

function randStoreMount.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player or not item then
		print("[RandomStoreMount] Missing player or item context.")
		return false
	end

	-- Losowy mount ze sklepu
	local mount = storeMounts[math.random(1, #storeMounts)]
	local mountId = mount[1]
	local mountName = mount[2]

	-- Sprawdz, czy gracz juz ma ten mount
	if player:hasMount(mountId) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already own the store mount: " .. mountName .. ".")
		return true
	end

	-- Dodaj mount
	if player:addMount(mountId) then
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received the store mount: " .. mountName .. "!")
		Item(item.uid):remove() -- usuwa przedmiot
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Mount could not be added. Please contact an admin.")
	end

	return true
end

randStoreMount:id(itemMountId)
randStoreMount:register()
