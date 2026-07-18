function onCreateMagicWall(creature, position)
	local tile = Tile(position)
	if not tile then
		return false
	end

	if tile:hasFlag(TILESTATE_FLOORCHANGE) then
		return false
	end

	if tile:getTopCreature() and not tile:getTopCreature():isPlayer() then
		return false
	end

	local magicWall
	if Game.getWorldType() == WORLDTYPE_OPTIONAL then
		magicWall = ITEM_MAGICWALL_SAFE
	else
		magicWall = ITEM_MAGICWALL
	end

	local item = Game.createItem(magicWall, 1, position)
	if item then
		item:setDuration(16, 24)
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, string.format("Casted by: %s", creature:getName()))
		-- Open PvP (2014 rules): ownership decides who the wall blocks and who walks through.
		-- Normalize summon casts to the master so the owner is always a stable player GUID.
		local fieldOwner = creature:getMaster() or creature
		item:setOwner(fieldOwner)
		-- Cast outside a PvP situation -> PvE wall: blocks only monsters, every player
		-- (including the caster) walks through it
		if fieldOwner:isPlayer() and not fieldOwner:hasActivePvpSituation() then
			item:setCustomAttribute("pveWall", true)
		end
	end
end

local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onCreateMagicWall")

local rune = Spell("rune")
function rune.onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end

rune:id(86)
rune:name("Magic Wall Rune")
rune:group("attack")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_MAGIC_WALL_RUNE)
rune:cooldown(2 * 1000)
rune:groupCooldown(2 * 1000)
rune:level(32)
rune:magicLevel(9)
rune:runeId(3180)
rune:charges(3)
rune:isBlocking(true, true)
rune:allowFarUse(true)
rune:register()
