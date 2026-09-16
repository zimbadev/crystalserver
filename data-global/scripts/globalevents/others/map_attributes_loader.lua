local function loadMapActionsAndUniques()
	CreateMapItem(CreateItemOnMap)
	loadLuaMapAction(ChestAction)
	loadLuaMapUnique(ChestUnique)
	loadLuaMapAction(CorpseAction)
	loadLuaMapUnique(CorpseUnique)
	loadLuaMapAction(KeyDoorAction)
	loadLuaMapAction(LevelDoorAction)
	loadLuaMapAction(QuestDoorAction)
	loadLuaMapUnique(QuestDoorUnique)
	loadLuaMapAction(ItemAction)
	loadLuaMapUnique(ItemUnique)
	loadLuaMapAction(ItemUnmovableAction)
	loadLuaMapAction(LeverAction)
	loadLuaMapUnique(LeverUnique)
	loadLuaMapAction(TeleportAction)
	loadLuaMapUnique(TeleportUnique)
	loadLuaMapAction(TeleportItemAction)
	loadLuaMapUnique(TeleportItemUnique)
	loadLuaMapAction(TileAction)
	loadLuaMapUnique(TileUnique)
	loadLuaMapAction(TilePickAction)
	updateKeysStorage(QuestKeysUpdate)
end

local function loadMapAttributes()
	logger.debug("Loading map attributes")
	-- Before BookDocumentTable: it adds a book into a container without checking whether
	-- one is already there, and the container loader only fills what is empty.
	loadMapContainers(MapContainersQuest)
	loadMapContainers(MapContainersBooks1)
	loadMapContainers(MapContainersBooks2)
	loadMapContainers(MapContainersBooks3)
	loadMapContainers(MapContainersBooks4)
	loadMapContainers(MapContainersMisc)
	loadLuaMapSign(SignTable)
	loadLuaMapBookDocument(BookDocumentTable)

	loadMapActionsAndUniques()
	logger.debug("Loaded all actions and uniques in the map")

	-- Last, with the ids already stamped: a script registered by position never runs
	-- when an item on that tile carries an id another script registered, because
	-- getAction() checks the ids first.
	Game.reportShadowedScripts()
end

local function resetGlobalStorages()
	for i = 1, #startupGlobalStorages do
		Game.setStorageValue(startupGlobalStorages[i], 0)
	end
end

local function resetFerumbrasAscendantQuestHabitats()
	for i = 1, #Storage.Quest.U10_90.FerumbrasAscension.Habitats do
		Game.setStorageValue(Storage.Quest.U10_90.FerumbrasAscension.Habitats[i], 0)
	end
end

local mapAttributesLoader = GlobalEvent("Map Attributes Loader")

function mapAttributesLoader.onStartup()
	loadMapAttributes()
	resetGlobalStorages()
	resetFerumbrasAscendantQuestHabitats()
end

mapAttributesLoader:register()
