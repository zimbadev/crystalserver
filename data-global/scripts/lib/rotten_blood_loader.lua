--[[
	ROTTEN BLOOD SYSTEMS LOADER
	
	Este archivo carga todos los scripts del sistema Rotten Blood
	desde data-global/rotten_blood_systems/scripts/
	
	El servidor carga automáticamente los archivos en data-global/scripts/lib/
	por lo que este loader se ejecutará al iniciar el servidor.
]]

local ROTTEN_SCRIPTS_PATH = DATA_DIRECTORY .. "/rotten_blood_systems/scripts/"

-- Lista de scripts a cargar en orden de dependencias
local scriptsToLoad = {
	-- 0. MonsterAI_Death (debe cargar antes de monsters para que elder_bloodjaw no dé warning)
	"creaturescripts_monster_ai_death.lua",

	-- 1. Primero cargar funciones y sistemas base
	"monster_onthink_area_icons.lua",
	"eventcallback_on_combat_rottenblood.lua",

	-- 2. Scripts de mecánicas de bosses
	"bakragore_mechanics_death.lua",
	"chagorz_mechanics_death.lua",
	"vemiath_mechanics_death.lua",

	-- 3. Scripts de bosses principales
	"rotten_bakragore.lua",
	"rotten_bakragore1.lua",
	"rotten_chagorz.lua",
	"rotten_ichgahal.lua",
	"rotten_murcion.lua",
	"rotten_vemiath.lua",

	-- 4. CreatureScripts
	"creaturescripts_login.lua",
	"creaturescripts_bakragore_player_death.lua",
	"creaturescripts_bosses_killed.lua",
	"creaturescripts_monster_attack.lua",

	-- 5. Actions
	"actions_entrances.lua",
	"actions_sacrifice.lua",
	"phantasmal_jade.lua",
	"singeing_steed.lua",
	-- spirit_of_purity.lua - omit: item 44048 already registered by data/scripts/actions/items/usable_spirit_of_purity_items.lua

	-- 6. Movements
	"movements_blood_entrance.lua",
	"teleport_step_event.lua",

	-- 7. Teleports y áreas
	"teleport_rotten_blood.lua",
	"rotten_area_login.lua",

	-- 8. Debug y comandos de prueba
	"debug_bakragore_spawn.lua",
	"debug_bakragore_status.lua",
	"debug_elder_bloodjaw.lua",
	"debug_force_pause.lua",
	"debug_spawn_status.lua",
	"test_mechanics_command.lua",
	"test_teleport_command.lua",

	-- 9. Startup (debe ser el último)
	"startup_register_events.lua",
}

-- Cargar cada script
local loadedCount = 0
local failedScripts = {}

for _, scriptName in ipairs(scriptsToLoad) do
	local scriptPath = ROTTEN_SCRIPTS_PATH .. scriptName
	local success, err = pcall(dofile, scriptPath)

	if success then
		loadedCount = loadedCount + 1
	else
		table.insert(failedScripts, {
			name = scriptName,
			error = err,
		})
	end
end

-- Reportar resultados
if #failedScripts == 0 then
	logger.info("[Rotten Blood System] Successfully loaded {}/{} scripts", loadedCount, #scriptsToLoad)
else
	logger.error("[Rotten Blood System] Loaded {}/{} scripts ({} failed)", loadedCount, #scriptsToLoad, #failedScripts)

	for _, failed in ipairs(failedScripts) do
		logger.error("  [Rotten Blood System] Failed to load {}: {}", failed.name, failed.error)
	end
end
