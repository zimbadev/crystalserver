--[[
	Hunt Task Shop Offers Configuration

	This file defines all offers available in the Hunt Task Shop (Task Board Shop).
	Offers are loaded by the server at startup from this Lua table,
	so you can add, remove, or modify offers without recompilation.

	Offer Types:
		0 = Item          (sends looktypeOrItemId as the item sprite)
		1 = Mount         (sends looktypeOrItemId as the mount looktype)
		2 = Outfit        (sends looktypeOrItemId as the outfit looktype + addon byte)
		3 = Item Double   (sends looktypeOrItemId + a second itemId2)
		4 = Bonus Promotion (no name/description, special format)
		5 = Weekly Expansion (permanent weekly task expansion, like charm expansion)

	Status is determined dynamically per-player by getPlayerOfferStatus():
		0 = Available  (BUY button, clickable when HTP >= price, client checks automatically)
		1 = Not Available  (BUY button, tooltip "Not Available", not clickable)
		2 = Not Enough HTP (BUY button, tooltip "You don't have enough hunting task points", not clickable)
		3 = Requires Outfit (BUY button, tooltip "Requires base outfit", not clickable)
		4 = Bought     (BOUGHT button, already purchased)

	Fields:
		offerType          (number)  required  - One of the types above (0-5)
		name               (string)  required for types 0-3, 5
		description        (string)  required for types 0-3, 5
		looktypeOrItemId   (number)  required for types 0-3, 5
		addon              (number)  required for type 2 (outfit addon: 0, 1, or 2)
		itemId2            (number)  required for type 3 (second item ID)
		price              (number)  required  - Cost in Hunting Task Points
]]

HUNT_TASK_SHOP_OFFERS = {
	-- ========================================================================
	-- Outfits (type 2)
	-- ========================================================================
	-- Feral Trapper (Base Outfit)
	{
		offerType = 2,
		name = "Feral Trapper (Base Outfit)",
		description = "The newest fashion from Walter Jaeger.",
		looktypeOrItemId = 1907,
		addon = 0,
		price = 100000,
	},
	-- Feral Trapper (Addon 1)
	{
		offerType = 2,
		name = "Feral Trapper (Addon 1)",
		description = "Spice up your outfit for long hunts.",
		looktypeOrItemId = 1907,
		addon = 1,
		price = 35000,
	},
	-- Feral Trapper (Addon 2)
	{
		offerType = 2,
		name = "Feral Trapper (Addon 2)",
		description = "Spice up your outfit for long hunts.",
		looktypeOrItemId = 1907,
		addon = 2,
		price = 35000,
	},
	-- Falconer (Base Outfit)
	{
		offerType = 2,
		name = "Falconer (Base Outfit)",
		description = "Show off your hunting skills wearing this fashionable outfit.",
		looktypeOrItemId = 1282,
		addon = 0,
		price = 100000,
	},
	-- Falconer (Addon 1)
	{
		offerType = 2,
		name = "Falconer (Addon 1)",
		description = "Boar-ed running around without a helmet?",
		looktypeOrItemId = 1282,
		addon = 1,
		price = 35000,
	},
	-- Falconer (Addon 2)
	{
		offerType = 2,
		name = "Falconer (Addon 2)",
		description = "Pro: Fal Con: None.",
		looktypeOrItemId = 1282,
		addon = 2,
		price = 35000,
	},

	-- ========================================================================
	-- Mounts (type 1)
	-- ========================================================================
	-- Tidal Seawater Predator
	{
		offerType = 1,
		name = "Tidal Seawater Predator (Mount)",
		description = "Swim through a sea of prey.",
		looktypeOrItemId = 1908,
		price = 145000,
	},
	-- Ashen Coast Predator
	{
		offerType = 1,
		name = "Ashen Coast Predator (Mount)",
		description = "Swim through a sea of prey.",
		looktypeOrItemId = 1909,
		price = 145000,
	},
	-- Crimson Bay Predator
	{
		offerType = 1,
		name = "Crimson Bay Predator (Mount)",
		description = "Swim through a sea of prey.",
		looktypeOrItemId = 1910,
		price = 145000,
	},
	-- Antelope
	{
		offerType = 1,
		name = "Antelope (Mount)",
		description = "A true hunters loyal companion.",
		looktypeOrItemId = 1281,
		price = 145000,
	},

	-- ========================================================================
	-- Items (type 0) - Pets, Trophies, Dolls
	-- ========================================================================
	-- Falcon Pet
	{
		offerType = 0,
		name = "Falcon Pet",
		description = "A pet decorative purposes.",
		looktypeOrItemId = 36753,
		price = 135000,
	},
	-- Cerberus Champion Puppy
	{
		offerType = 0,
		name = "Cerberus Champion Puppy",
		description = "A pet decorative purposes.",
		looktypeOrItemId = 31465,
		price = 75000,
	},
	-- Hellflayer Trophy
	{
		offerType = 0,
		name = "Hellflayer Trophy",
		description = "A trophy from Walter Jaeger, commemorating your mastery in the wilds.",
		looktypeOrItemId = 32753,
		price = 80000,
	},
	-- Golden Hunter Trophy
	{
		offerType = 0,
		name = "Golden Hunter Trophy",
		description = "A trophy from Walter Jaeger, commemorating your mastery in the wilds.",
		looktypeOrItemId = 32756,
		price = 80000,
	},
	-- Brachiodemon Trophy
	{
		offerType = 0,
		name = "Brachiodemon Trophy",
		description = "A trophy from Walter Jaeger, commemorating your mastery in the wilds.",
		looktypeOrItemId = 36748,
		price = 80000,
	},
	-- Many Faces Trophy
	{
		offerType = 0,
		name = "Many Faces Trophy",
		description = "A trophy from Walter Jaeger, commemorating your mastery in the wilds.",
		looktypeOrItemId = 36749,
		price = 50000,
	},
	-- Sea Serpent Trophy
	{
		offerType = 0,
		name = "Sea Serpent Trophy",
		description = "A trophy from Walter Jaeger, commemorating your mastery in the wilds.",
		looktypeOrItemId = 32752,
		price = 15000,
	},
	-- Silver Hunter Trophy
	{
		offerType = 0,
		name = "Silver Hunter Trophy",
		description = "A trophy from Walter Jaeger, commemorating your mastery in the wilds.",
		looktypeOrItemId = 32755,
		price = 15000,
	},
	-- Bronze Hunter Trophy
	{
		offerType = 0,
		name = "Bronze Hunter Trophy",
		description = "A trophy from Walter Jaeger, commemorating your mastery in the wilds.",
		looktypeOrItemId = 32754,
		price = 3000,
	},
	-- Gozzler Trophy
	{
		offerType = 0,
		name = "Gozzler Trophy",
		description = "A trophy from Walter Jaeger, commemorating your mastery in the wilds.",
		looktypeOrItemId = 32751,
		price = 3000,
	},
	-- Demon Doll
	{
		offerType = 0,
		name = "Demon Doll",
		description = "A doll for skilled hunters, honouring your proven prowess in battle.",
		looktypeOrItemId = 32918,
		price = 37500,
	},
	-- Vexclaw Doll
	{
		offerType = 0,
		name = "Vexclaw Doll",
		description = "A doll for skilled hunters, honouring your proven prowess in battle.",
		looktypeOrItemId = 32943,
		price = 37500,
	},

	-- ========================================================================
	-- Item Double (type 3 - two item IDs displayed)
	-- ========================================================================
	-- Bone Bed
	{
		offerType = 3,
		name = "Bone Bed",
		description = "A bed carved from the bones of your fallen foes.",
		looktypeOrItemId = 32795,
		itemId2 = 32796,
		price = 35000,
	},

	-- ========================================================================
	-- Bonus Promotion (type 4 - special format, no name/description)
	-- ========================================================================
	-- [24] Bonus Promotion Points
	{
		offerType = 4,
		price = 100,
	},

	-- ========================================================================
	-- Permanent Weekly Task Expansion (type 5)
	-- Like charm expansion: once purchased, status becomes "bought" (4)
	-- Expands weekly tasks from 5+1 to 8+1 (kill and delivery)
	-- NOTE: This is sent to the client as type 0 (Item) by the server
	-- ========================================================================
	-- {
	-- 	offerType = 5,
	-- 	name = "Permanent Weekly Task Expansion",
	-- 	description = "Permanently expands your weekly tasks from 6 to 9 task slots (kill and delivery).",
	-- 	looktypeOrItemId = 32761,
	-- 	price = 50000,
	-- },
}
