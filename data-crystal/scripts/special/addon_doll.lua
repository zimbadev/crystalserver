local itemDollId = 6579

local outfits = {
	{ 136, 128, "Citizen" },
	{ 137, 129, "Hunter" },
	{ 138, 130, "Mage" },
	{ 139, 131, "Knight" },
	{ 140, 132, "Nobleman" },
	{ 141, 133, "Summoner" },
	{ 142, 134, "Warrior" },
	{ 147, 143, "Barbarian" },
	{ 148, 144, "Druid" },
	{ 149, 145, "Wizard" },
	{ 150, 146, "Oriental" },
	{ 155, 151, "Pirate" },
	{ 156, 152, "Assassin" },
	{ 157, 153, "Beggar" },
	{ 158, 154, "Shaman" },
	{ 252, 251, "Norseman" },
	{ 269, 268, "Nightmare" },
	{ 270, 273, "Jester" },
	{ 278, 279, "Brotherhood" },
	{ 288, 289, "Demonhunter" },
	{ 324, 325, "Yalaharian" },
	{ 336, 335, "Wayfarer" },
	{ 366, 367, "Warmaster" },
	{ 329, 328, "Wedding" },
	{ 430, 431, "Afflicted" },
	{ 432, 433, "Elementalist" },
	{ 463, 464, "Deepling" },
	{ 465, 466, "Insectoid" },
	{ 471, 472, "Entrepreneur" },
	{ 512, 513, "Crystal Warlord" },
	{ 516, 514, "Soil Guardian" },
	{ 541, 542, "Demon" },
	{ 574, 575, "Cave Explorer" },
	{ 578, 579, "Dream Warden" },
	{ 618, 619, "Glooth Engineer" },
	{ 620, 621, "Jungle Explorer" },
	{ 632, 633, "Chaos Acolyte" },
	{ 634, 635, "Death Herald" },
	{ 636, 637, "Ranger" },
	{ 664, 665, "Ceremonial Garb" },
	{ 666, 667, "Puppeteer" },
	{ 683, 684, "Spirit Caller" },
	{ 694, 695, "Evoker" },
	{ 696, 697, "Conjurer" },
}

local randOutfit = Action("RandomOutfitOneAddon")

function randOutfit.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local outfit = outfits[math.random(1, #outfits)]
	local addon = math.random(1, 2)

	local hasAlready = player:hasOutfit(outfit[1], addon) and player:hasOutfit(outfit[2], addon)

	if hasAlready then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already have this outfit with this addon.")
		return true
	end

	player:addOutfitAddon(outfit[1], addon) -- Male
	player:addOutfitAddon(outfit[2], addon) -- Female

	-- ?? Dodanie efektu specjalnego
	player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You received the %s outfit with addon %d!", outfit[3], addon))
	item:remove(1)
	return true
end

randOutfit:id(itemDollId)
randOutfit:register()
