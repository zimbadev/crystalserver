-- ============================================================================
-- Echo Warden loot: ALWAYS 1 random basic scroll (53751-53774) + suffix.
-- The scroll is added unconditionally; the "(Echo Warden kill)" suffix is
-- best-effort cosmetic (creature.cpp only prints it when the most-damage
-- killer is a player receiving the loot message).
-- corpse is a Container userdata (events.cpp:1239), so corpse:addItem works;
-- there is NO Container:addLoot in this fork -- do not use it.
-- ============================================================================

local BASIC_SCROLL_MIN, BASIC_SCROLL_MAX = 53751, 53774

local callback = EventCallback("MonsterOnDropLootEchoWarden")

function callback.monsterOnDropLoot(monster, corpse)
	if not monster or not corpse then
		return
	end
	if monster:getStorageValue(EchoWarden.STORAGE_IS_WARDEN) ~= 1 then
		return
	end

	-- exactly one random basic imbuement scroll
	local scrollId = math.random(BASIC_SCROLL_MIN, BASIC_SCROLL_MAX)
	corpse:addItem(scrollId, 1)

	-- loot message suffix: C++ wraps as "Loot of X: items (Echo Warden kill)"
	local existing = corpse:getAttribute(ITEM_ATTRIBUTE_LOOTMESSAGE_SUFFIX) or ""
	local suffix = string.len(existing) > 0 and (existing .. " Echo Warden kill") or "Echo Warden kill"
	corpse:setAttribute(ITEM_ATTRIBUTE_LOOTMESSAGE_SUFFIX, suffix)
end

callback:register()
