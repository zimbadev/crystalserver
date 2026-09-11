# data-global/startup

Everything the map needs but does not carry: action ids, unique ids, container
contents, sign and book texts. The `world.otbm` holds geometry and items only, so
this folder is the single place that answers "which numbers are in use, and where".

---

## The rule

**Never write an action id, a unique id or container contents into the map editor.**

An id typed into the RME is invisible to anyone reading the Lua. It is also invisible
to the server's own bookkeeping, which is why two entries could quietly fight over the
same door for years. Declare it here instead. The server warns about anything still
left inside the map file, and the warning names the position.

---

## How it loads

`tables/load.lua` reads every table file, then the `Map Attributes Loader` global event
applies them **in this order**:

```
loadMapContainers(MapContainers*)     fills chests, bookcases, bags
loadLuaMapSign(SignTable)             sign texts
loadLuaMapBookDocument(BookDocument)  book texts

CreateMapItem(CreateItemOnMap)        creates and removes items on the map
loadLuaMapAction(ChestAction)         then every thematic table, in order:
loadLuaMapUnique(ChestUnique)             Chest, Corpse, KeyDoor, LevelDoor,
loadLuaMapAction(CorpseAction)            QuestDoor, Item, ItemUnmovable, Lever,
...                                       Teleport, TeleportItem, Tile, TilePick
```

Order matters, and one detail bites: **`CreateMapItem` runs before the ids.** It can
delete an item (`removeItemId`) that a later entry expects. If a table points at
something that no longer exists, this is the first thing to check.

Anything later overwrites anything earlier, and within one table the order of `pairs()`
is **not** defined by Lua. Two entries claiming the same item is therefore a bug even
when it appears to work.

---

## Which table to use

| File | Tables | For |
|------|--------|-----|
| `chest.lua` | `ChestAction`, `ChestUnique` | reward chests; `ChestUnique` also carries the reward itself |
| `corpse.lua` | `CorpseAction`, `CorpseUnique` | coffins, graves, remains |
| `door_key.lua` | `KeyDoorAction` | doors opened by a key |
| `door_level.lua` | `LevelDoorAction` | level doors, where the id **is** `1000 + level` |
| `door_quest.lua` | `QuestDoorAction`, `QuestDoorUnique` | doors gated by a storage; the key **is** the storage |
| `item.lua` | `ItemAction`, `ItemUnique` | anything that does not fit elsewhere |
| `item_unmovable.lua` | `ItemUnmovableAction` | action id 100, the unmovable convention: one block per item under the single key |
| `lever.lua` | `LeverAction`, `LeverUnique` | levers and switches |
| `teleport.lua` | `TeleportAction`, `TeleportUnique` | magic forcefields; `TeleportUnique` carries the destination |
| `teleport_item.lua` | `TeleportItem*` | teleport items, not forcefields |
| `tile.lua` | `TileAction`, `TileUnique` | floor tiles |
| `tile_pick.lua` | `TilePickAction` | action id 101, the pick floor convention |
| `create_item.lua` | `CreateItemOnMap` | creating or replacing an item on the map |
| `container_*.lua` | `MapContainers*` | what sits inside a chest, bookcase or bag |
| `writeable.lua` | `SignTable`, `BookDocumentTable` | sign and book texts |

Pick by what the item is, not by what the id does. A lever goes in `lever.lua` even when
the quest that uses it lives elsewhere.

---

## Adding an action or unique id

1. **Find the item.** You need its item id and its exact position. In the map editor,
   look at the tile and note which item on it should carry the id, not just the tile.
2. **Pick the table** from the list above.
3. **Pick a number** — see *Picking a number* below.
4. **Write the entry.** An `Action` table takes a list of positions; a `Unique` table
   takes exactly one, because a unique id is unique.

```lua
-- chest
[25033] = {
    itemId = 2472,
    itemPos = { { x = 33000, y = 32000, z = 7 } },
},
```

```lua
-- lever, a Unique table: one position, no list
[30039] = {
    itemId = 2772,
    itemPos = { x = 32826, y = 32263, z = 12 },
},
```

Always name the item in a comment. `data/items/items.xml` has the names.

### About `itemId = false`

It makes the loader stamp the ground, the top-down item **and** the top-top item of the
tile. It looks convenient and it is how several old entries were written, but it claims
three items instead of one, and that is how a custom door script erased the storage of
twenty quest doors. Use a real item id unless you genuinely mean all three.

---

## Adding container contents

In `container_quest.lua`, `container_books_1..4.lua` or `container_misc.lua`:

```lua
{
    itemId = 2472,                                -- the container
    itemPos = { x = 33000, y = 32000, z = 7 },
    contents = {
        { itemId = 3031, count = 50 },            -- a stack
        { itemId = 2854, inside = {               -- a bag with things in it
            { itemId = 3003 },
        } },
        { itemId = 2828, text = [[
Book text goes here.]] },
    },
},
```

- `count` is the OTBM **subtype**, not an amount, for anything that does not stack. Leave
  it out when in doubt.
- `inside` nests a container within a container.
- `nth = 2` picks the second container with that item id when the tile holds more than one.
- The loader only fills a container that is **empty**, and creates the container itself if
  it is missing.

The contents stay physical: whoever takes them keeps them, and they come back on restart,
exactly as when the OTBM carried them.

### Not for a reward chest

A reward chest -- a `ChestUnique` entry with a `reward`, unique id in 5000-9000 or
10000-12000 -- never opens as a container: `quest_reward_common.lua` catches the click
and returns true on every path. Its prize is the `reward` in `chest.lua` and nothing
else, so declaring contents for it here describes something no player can reach.

When the prize is a book with text, the text goes in the `AttributeTable` of
`quest_reward_common.lua`, beside the reward, with the `itemId` that carries it:

```lua
[6202] = {
    itemId = 2836,
    text = [[Banor I praise your name.]],
},
```

The **action id 2000** chest (`quest_system1.lua`) is the opposite: there the contents
**are** the prize, the script copies what is inside. Those belong here.

---

## The same action id on several different items

A table key fits once, and one entry names one `itemId`. When the same action id belongs
on items that are not all the same — action id 100 (unmovable) is on 205 of them — the
entry takes a **list of blocks** instead, one per item:

```lua
ItemUnmovableAction = {
    [100] = {
        { itemId = 3003, itemPos = { { x = 31948, y = 31925, z = 8 } } },  -- rope
        { itemId = 7741, itemPos = { { x = 32011, y = 31709, z = 7 } } },  -- ice cube
    },
}
```

`loadLuaMapAction` accepts both shapes, so use the plain one whenever a single `itemId`
covers the entry and the list only when it does not. Same item, several positions? That
is still one block, with several entries in `itemPos`.

There is no separate file for ids that "cannot be a key": every id lives in the thematic
table of the item that carries it. A `Unique` table has no list form on purpose — a
unique id belongs to exactly one item.

---

## Picking a number

**Do not trust the ranges below on their own.** They describe intent, not reality: plenty
of numbers in use fall outside every one of them. A number is free only when no table
claims it **and** no script registers it, so check both:

```bash
grep -rn '\[1234\] = {' data-global/startup/tables/   # already a key in a table?
grep -rn ':aid(1234)\|:uid(1234)' data data-global    # already registered by a script?
grep -rn '== 1234' data data-global                   # or compared, which the greps above miss
```

A number can also be swallowed by a range some script registers wholesale - see below -
so read that list too before settling on one.

### Reserved ranges

| Range | Use |
|-------|-----|
| 1000-1999 | level door, where the id is `1000 + level`: 1010 is level 10, 1100 is level 100 |
| 5000-6000 | reward keys |
| 5000-12000 | chest, action and unique |
| 12001-15000 | custom chests |
| 15001-20000 | teleport items, not magic forcefields |
| 20000-25000 | corpse action; 20000-22000 corpse unique |
| 22001-25000 | door storage unique |
| 25001-29000 | tile |
| 29001-30000 | tile remove/create item |
| 30001-35000 | lever |
| 35001-40000 | teleport, meaning magic forcefield items |
| 40001-42000 | item |

Quest doors have no range: their key **is** the storage.

### Ranges some scripts register in bulk

These catch **any** item whose number falls inside them, whether or not you meant it:

| Range | Kind | Script |
|-------|------|--------|
| 5000-9000, 10000-12000 | unique | `actions/system/quest_reward_common.lua` |
| 15001-20000 | unique | `actions/other/teleport_item.lua` |
| 29001-30000 | unique | `movements/others/remove-create_item.lua` |
| 38001-40000 | unique | `movements/others/teleport.lua` |
| 2050-2065 | unique | `quests/the_pits_of_inferno_quest/actions_levers.lua` |
| 3091-3102 | unique | `quests/in_service_of_yalahar/actions_mechanism.lua` |
| 14021-14023 | unique | `quests/the_first_dragon/actions_rewards.lua` |
| 30013-30017 | unique | `quests/the_queen_of_the_banshees/action-3-third_seal_lever.lua` |
| 50095-50104 | unique | `quests/the_pits_of_inferno_quest/actions_bazir_wrong_levers.lua` |
| 57350-57367 | action | `quests/dangerous_depth/actions_warzone_crystals.lua` |
| 57531-57534 | action | `quests/kilmaresh/movements_tpvoc.lua` |

The number inside such a loop never appears literally anywhere, so grepping for it finds
nothing. That is not evidence the number is free -- check this table as well.

A stray unique id in one of those gets hijacked by that handler. In
`quest_reward_common.lua` the guard is `if not setting then return true end`, and that
`return true` swallows the click: the item silently stops doing what it did. So a chest
reward **must** be in 5000-9000 or 10000-12000, and anything that is not a chest reward
must stay out of them.

### An id whose number appears nowhere is still doing something

Grepping a number and finding nothing does **not** mean the id is dead. Three things read
an id without ever naming it:

- **A handler registered by item id, reading that an id exists.**
  `movements/others/walkback.lua` registers on the chest and box item ids and tests
  `item.uid > 65535`. `Item::getUniqueId` returns the real unique id when there is one and
  otherwise a script-environment handle, and `lastUID` starts at 65535 -- so that
  comparison means "this item has no declared unique id". A chest with any unique id walks
  the player back; a chest without one does not, and the number is never mentioned.
- **A loop registering a whole range**, as in the table above.
- **The engine itself.** `Item::canBeMoved` returns false for any unique id and for action
  id 100; a unique id or action id on a corpse makes it unlootable; either one keeps the
  item out of the map cleaner. Removing one changes behaviour even when no script ever
  looks at the number.

So an unmentioned number is a question, not a finding -- and for most of them the answer
is that the id is doing work.

### Numbers that are data, not keys

Some ids are read for their value and cannot be renumbered at all:

- a level door is `1000 + level`
- a key's action id **is** the key number
- a quest door's action id **is** the storage the player needs
- `special_tiles.lua` reads a tile's action id as a level (`actionid - 1000`) or as a
  storage key

---

## Warnings at startup

| Warning | What it means | What to do |
|---------|---------------|------------|
| *an id is stored inside the world.otbm* | someone set an id in the map editor at a position the startup also manages | declare it here, clear it in the map |
| *two startup entries set an id on the same item* | two tables claim the same item; only one survives and Lua does not promise which | decide which one owns it and remove the other |
| *a container already holds items* | the container contents are still inside the OTBM | clear the container in the map editor |
| *the map file still stores N action id(s)...* | reported by the OTBM parser itself, for the whole map | the log lists the first ten positions |
| *Item X not found for action id Y* | the item is not there when the loader runs | check whether `CreateItemOnMap` deleted it first |
| *the action registered for position P never runs* | a script hooked by position lost to an id on the same tile that another script registers, because ids are checked first | drop the id from that item, or hook the script by that id instead |

The first warning only fires at positions the startup already touches. The fourth one, from
the C++ side, covers the whole map and only the main map.

The last one exists because `Actions::getAction` looks up unique id, then action id, then
item id, and only then the position, so a position script is dead whenever an id on that
tile is already claimed. Movements do not have this problem: `onCreatureMove` fires the
tile event and the item events, so both run. Two scripts claiming the same id, or the same
position, are already reported by the registration itself.

---

## Before you commit

**Boot the server and read the log.** The loader checks itself while it runs and reports,
by position, everything that can go wrong here: two entries claiming the same item, an id
still stored inside the map, a container that already holds items, and an entry pointing
at an item that is not there. The table under *Warnings at startup* says what each one
means. A silent boot is the only proof that a new entry landed on the item you meant.

Reading the file is not enough: `itemId = false` claims the ground, the top-down item and
the top-top item, so two entries can collide without sharing a single line of text.

---

## Reference: reserved player storage keys

This folder is about map ids, but action ids double as player storage keys, so these
ranges are reserved at the source (`const.h`) and must not be used as storages:

```
[10000000 - 20000000]
[1000 - 1500]
[2001 - 2011]
```

Other reserved player action/storage values:

```
[100] = unmovable/untrade/unusable items
[101] = use pick floor
[102] = down floor action
[103] = key 0010
[103-120] = keys action
[104] = Parchment of the parchment room quest
[303] = key 0303
[1000] = level door, 1 followed by the level: 1010 = level 10, 1100 = level 100
[3001-3008] [3012] [3033] [3100] [3142] [3200] = keys
[3301-3304] [3350] [3520] [3600] [3610] [3620] [3650] [3666] [3667] = keys
[3700] [3701-3703] [3800-3802] [3899] [3900] [3909-3917] = keys
[3923] [3925] [3930] [3932] [3934] [3935] [3936] [3938] [3940] = keys
[3950] [3960] [3980] [3988] = keys
[4001] [4009] [4022] [4023] [4033] [4037] [4055] [4210] = keys
[4501] [4502] [4503] [4600] [4601] [4603] = keys
[5000] [5002] [5010] [5050] [6010] = keys
```

Use an action id only when the same behaviour repeats in several places. For a one-off,
register the script by position instead.

