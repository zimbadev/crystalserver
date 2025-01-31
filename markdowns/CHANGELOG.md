# Changelog for Crystal Server


## Version 4.1.3

### Features

- Added new attributes to outfits. Check `outfits.xml` for examples. ([Tryller](https://github.com/jprzimba))
- Added new attributies to /attr: `text`, `writer`, `duration`, `weight`, `imbuementslot`, `tier`, `hitchance`, `shootrange`, `special` and `quicklootcontainer`. ([Tryller](https://github.com/jprzimba))
- Added new flags: `CanMoveFromFar`, `HasFullLight`, `AllowIdle`, `CanWearAllMounts`, and `NotGainUnjustified`. ([Tryller](https://github.com/jprzimba))
- Added Vibrancy imbuement. ([pennaor](https://github.com/pennaor))
- Added Soul Pit arena/animus mastery/soul core. ([FelipePaluco](https://github.com/FelipePaluco))
- Added a new command `/mute`, which will mute a player until unmuted by `/unmute`. ([Tryller](https://github.com/jprzimba))
- Cyclopedia House Auction system. ([murilo09](https://github.com/murilo09))
- Updated name change functionality to save old player names in a database table called `player_oldnames`. ([Tryller](https://github.com/jprzimba))

## Added files

- data/migrations/49.lua
- data/migrations/50.lua
- data/migrations/51.lua
- data-global/lib/others/soulpit.lua
- data-global/startup/tables/tile.lua
- data-global/npc/myzzi.lua
- data-global/npc/shirtalis_of_the_summer_court.lua
- data-global/npc/farhilorn_of_the_winter_court.lua
- data-global/scripts/actions/soulpit/soulpit_arena_exit.lua
- data-global/scripts/actions/soulpit/soulpit_entrance.lua
- data-global/scripts/quests/soulpit/exalted_core.lua
- data-global/scripts/quests/soulpit/ondroploot_soul_core.lua
- data-global/scripts/quests/soulpit/soul_prism.lua
- data-global/scripts/quests/soulpit/soulpit_creatureevents.lua
- data-global/scripts/quests/soulpit/soulpit_fight.lua
- data-global/scripts/quests/soulpit/soulpit_intensehex.lua
- data-global/scripts/quests/soulpit/soulpit_opressor.lua
- data-global/scripts/quests/soulpit/soulpit_powerless.lua

## Modified files

- config.lua
- schema.sql
- data/items/items.xm
- data/libs/functions/lever.lua
- data/modules/scripts/gamestore/init.lua
- data/scripts/talkactions/god/attributes.lua
- data/scripts/lib/register_spells.lua
- data/XML/groups.xml
- data/XML/outfits.xml
- data-global/lib/others/load.lua
- data-global/scripts/quests/ferumbras_ascension/actions_lever_first.lua
- data-global/scripts/quests/ferumbras_ascension/actions_lever_four.lua
- data-global/scripts/quests/ferumbras_ascension/actions_lever_second.lua
- data-global/scripts/quests/ferumbras_ascension/actions_lever_third.lua
- data-global/scripts/quests/ferumbras_ascension/actions_the_shatterer_levers.lua
- data-global/scripts/quests/ferumbras_ascension/creaturescripts_bosses_kill.lua
- data-global/scripts/quests/ferumbras_ascension/creaturescripts_death_dragon.lua
- data-global/scripts/quests/ferumbras_ascension/creaturescripts_the_shatterer_kill.lua
- data-global/scripts/quests/ferumbras_ascension/creaturescripts_zamulosh_clone.lua
- data-global/world/world-house.xml
- data-global/world/world-monster.xml
- data-global/world/world-npc.xml
- data-global/world/world.otbm (world.7z)

### Bug Fixes

- Fixed Stealth Ring being destroyed in certain cases, based on [Stealth Ring](https://tibia.fandom.com/wiki/Stealth_Ring). ([Tryller](https://github.com/jprzimba))
- Fixed an issue where store items could not be moved to the store inbox after being unwrapped. ([TheGlitchLab](https://github.com/TheGlitchLab))
- Fixed some features not being disabled when deactivated in `config.lua`: `!chain`, `!emote`, and `!spellwords`. ([Tryller](https://github.com/jprzimba))


## Version 4.1.2

### Features

- Protocol 14.05 support. ([Tryller](https://github.com/jprzimba))
- New protocol 14.05 assets. ([Tryller](https://github.com/jprzimba))
- Add new configurable featurees in `config.lua`:  `chainSystemVipOnly`, `fieldOwnershipDuration`, `bedsOnlyPremium`, `loginProtectionPeriod`, `chainSystemModifyMagic`, `logPlayersStatements`. ([Tryller](https://github.com/jprzimba))
- Added a new commands for players: `!randomoutfit`, `!spellwords`. ([Tryller](https://github.com/jprzimba))
- Moved emote spells to `kv` instead of `storage`. ([Tryller](https://github.com/jprzimba))
- Updated npcs and spells from 13.40 updates. ([murilo09](https://github.com/murilo09))
- Added a Rook system with configurations in `config.lua`. ([Tryller](https://github.com/jprzimba))
- Added a new group `game tester` with flag `isgametester` in `groups.xml` and a new player flag `PlayerFlag_IsGameTester`. ([Tryller](https://github.com/jprzimba))

## Added files

- Add all files in data/migrations
- data/scripts/talkactions/player/randomoutfit.lua
- data/scripts/talkactions/player/spell_name_instead_words.lua
- data/scripts/creaturescripts/player/swimming.lua
- data-global/scripts/creaturescripts/customs/water_houses.lua

## Modified files

- crystalserver.exe
- config.lua
- data/items/assets.dat
- data/items/items.xml
- data/libs/functions/boss_lever.lua
- data/libs/systems/features.lua
- data/scripts/creaturescripts/player/login.lua
- data/scripts/movements/special_tiles.lua
- data/scripts/movements/swimming.lua
- data/scripts/talkactions/god/icons_functions.lua
- data/scripts/talkactions/god/goto_house.lua
- data/scripts/talkactions/god/manage_monster.lua
- data/scripts/talkactions/god/create_item.lua
- data/scripts/talkactions/god/create_summon.lua
- data/scripts/talkactions/god/create_npc.lua
- data/scripts/talkactions/god/flags.lua
- data/scripts/talkactions/player/chain_system.lua
- data/scripts/talkactions/player/emote_spell.lua
- data/scripts/spells/attack/annihilation.lua
- data/scripts/spells/attack/ultimate_ice_strike.lua
- data/scripts/spells/attack/ultimate_terra_strike.lua
- data/XML/imbuements.xml
- data/XML/groups.xml
- data-global/npc (all npc files)
- data-global/npc/the_oracle.lua (modified to rook system)
- data-global/world/world.otbm (7z file)
- data-global/world/world-house.xml
- data-global/scripts/quests/ferumbras_ascension/actions_flower_puzzle_lever.lua
- data-global/scripts/quests/ferumbras_ascension/movements_flower_puzzle.lua
- data-global/scripts/lib/register_actions.lua

### Bug Fixes

- Fixed influenced creatures not spawning. ([Tryller](https://github.com/jprzimba))
- Fixed sending damage higher then monster health. ([Tryller](https://github.com/jprzimba))
- Fixed chain targets. ([Mortera-world](https://github.com/Mortera-world))
- Fixed houses with pool bug. ([Tryller](https://github.com/jprzimba))
- Fixed some V.I.P list issues. ([Tryller](https://github.com/jprzimba))
- Fixed gotoHouse talkaction. ([Tryller](https://github.com/jprzimba))
- Fixed the `/i` command displaying effects while in ghost mode. ([Tryller](https://github.com/jprzimba))
- Fixed Ferumbras' Ascendant Garden Flower Puzzle. ([Mckay666](https://github.com/Mckay666))
- Fixed lava tiles in entrance of The Pits of Inferno Quest. ([jeansouzak](https://github.com/jeansouzak))
- Fixed Items created using CreateMapItem are cleanable by /clean. ([#7](https://github.com/jprzimba/crystalserver/issues/7)) ([Tryller](https://github.com/jprzimba))
- Prevent players from entering the pool while in ghost mode. ([Tryller](https://github.com/jprzimba))
- Prevent players from logging out while in the pool.
- Prevent the use of `/n`, `/m`, and `/s` commands while in the pool. ([Tryller](https://github.com/jprzimba))
- Fixed Morguthis wall action. ([kaleohanopahala](https://github.com/kaleohanopahala))

## Version 4.1

### Features

- Load Gamemaster, Community Manager and God outfits from groups.xml ([Tryller](https://github.com/jprzimba)).
- New tag for rune spells: `rune:removeOnUse(bool)`. This can be used to specify a particular rune to remove charges, even when `removeChargesFromRunes` is set to false in `config.lua`. ([Tryller](https://github.com/jprzimba))
- Moved files from data-global/migrations to data/migrations. ([Tryller](https://github.com/jprzimba))
- New configurations in `config.lua`: `timeToRegenMinuteStamina` and `timeToRegenMinutePremiumStamina`. ([Tryller](https://github.com/jprzimba))
- Added a new attribute `attackspeed` to mounts.xml, allowing mounts to increase player attack speed. ([Tryller](https://github.com/jprzimba))
- New Feature: `fairFightTimeRange` is now configurable in `config.lua`. ([Tryller](https://github.com/jprzimba))
- New Feature: `blackSkulledDeathHealth` and `blackSkulledDeathMana` are now configurable in `config.lua`. ([Tryller](https://github.com/jprzimba))

## Added files

- Add all files in data/migrations

## Modified files

- crystalserver.exe
- config.lua
- data/scripts/creaturescripts/player/login.lua
- data/scripts/creaturescripts/player/regenerate_stamina.lua
- data/XML/groups.xml
- data/XML/mounts.xml

## Deleted files

- All files in data-global/migrations

### Bug Fixes

- Fixed issue [#1](https://github.com/jprzimba/crystalserver/issues/1) ([Tryller](https://github.com/jprzimba))

## Version 4.0

### Features

- Implemented Surprise Bags System: data/items/bags.xml ([Tryller](https://github.com/jprzimba), [dguprado](https://github.com/dguprado)).
- New configs to chain system at config.lua "combatChainSkillFormulaMissile" is used for weapons like assassin star/viper star and others, "combatChainSkillFormulaDistance" used for weapons like arrows/bols and "combatChainSkillFormulaWandsAndRods" used for weapons like wands/rods ([Tryller](https://github.com/jprzimba)).
- New feature: `playerAlwaysLoginMounted`, configurable in `config.lua` ([Tryller](https://github.com/jprzimba)).
- Players can enable the chain system using the `!chain` command. ([Tryller](https://github.com/jprzimba)).
- Updated npc data-global/npc/hireling.lua, now it sell imbuement packages and also buy all loots inside Loot Pouch ([Tryller](https://github.com/jprzimba)).
- Cyclopedia item summary ([phacUFPE](https://github.com/phacUFPE))
- Badge system ([elsongabriel](https://github.com/elsongabriel))
- Screenshots configurable in config.lua enableScreenshots ([Tryller](https://github.com/jprzimba)).
- Augments system ([phacUFPE](https://github.com/phacUFPE)).
- Add Cyclopedia character titles ([Tryller](https://github.com/jprzimba)).
- Monster rename functionality ([luanluciano93](https://github.com/luanluciano93)).
- Updated monsters and npcs like Tibia RL ([Tryller](https://github.com/jprzimba)).
- Add some monsters from protocol 13.40 ([Tryller](https://github.com/jprzimba), [dguprado](https://github.com/dguprado)).
- Add items from Winter Update 2023 ([Tryller](https://github.com/jprzimba), [dguprado](https://github.com/dguprado)).
- Add V.I.P groups ([phacUFPE](https://github.com/phacUFPE)).
- Added new feature configurable in config.lua halfLossExp, halfLossSkilla and halfLossMagicLevel ([dguprado](https://github.com/dguprado), [Tryller](https://github.com/jprzimba)).

### Bug Fixes

- Fixed chain system. Now works properly for Mages and Paladins ([Tryller](https://github.com/jprzimba)).
- Fixed V.I.P List ([Tryller](https://github.com/jprzimba)).
- Fixed damage reflection not working properly ([Tryller](https://github.com/jprzimba)).
- Fixed imbuement system when the player adds imbuement or cancels imbuement and the imbuement window is open not updating ([Tryller](https://github.com/jprzimba)).
- Fixed data/scripts/talkactions/player/refill.lua, now check if player has capacity to receive items. ([Tryller](https://github.com/jprzimba)).
- Fixed Loot pouch using in the Obtain method ([carlospess0a](https://github.com/carlospess0a)).
- Fixed destroy field is working inside pz ([carlospess0a](https://github.com/carlospess0a)).
- Fixed diamond arrow static attack points ([svetrey](https://github.com/svetrey)).
- Fixed stamina not recovering when dead ([carlospess0a](https://github.com/carlospess0a)).
- Fixed alana sio only to "aleta som" users ([carlospess0a](https://github.com/carlospess0a)).
- Fixed Player always logging with mount ([Tryller](https://github.com/jprzimba)).
- Fixed quiver bugs ([phacUFPE](https://github.com/phacUFPE)).
- Fixed avatar cooldown reduction ([phacUFPE](https://github.com/phacUFPE)).
- Fixed imbuement elemental damage only to physical damag ([carlospess0a](https://github.com/carlospess0a)).
- Fixed bed issues ([phacUFPE](https://github.com/phacUFPE)).
- Fixed crash on moving creatures ([mehah](https://github.com/mehah)).

### Changed Features

- Removed "useAnyDatapackFolder" at config.lua, now it's enable by default ([Tryller](https://github.com/jprzimba)).
- Remove map download, since we share compressed .7z map ([Tryller](https://github.com/jprzimba)).

---

_Note: This Markdown document provides a concise overview of the changes introduced in Crystal Server, categorized into features, bug fixes, and other updates. For a more detailed breakdown, refer to the commit history or release notes.
In the changelog when [Tryller](https://github.com/jprzimba) is mentioned, it refers to me, [jprzimba](https://github.com/jprzimba) (João Paulo)_
