-- Defined further down, beside the other lookup helpers. Declared here because the
-- table loaders below need it and Lua only sees what was already declared.
local findAttributeItem

-- This function load the table "CreateItemOnMap"from script "create_item.lua"
-- Basically it works to create items on the map without the need to edit the map
function CreateMapItem(itemsTable)
	if type(itemsTable) ~= "table" then
		logger.error("CreateMapItem: table is nil or invalid")
		return
	end

	for itemId, value in pairs(itemsTable) do
		if value.itemPos then
			for i = 1, #value.itemPos do
				local pos = value.itemPos[i]
				local tile = Tile(pos)

				if tile then
					-- Remove item(s) especificado(s) antes de criar o novo, se configurado
					if value.removeItemId then
						local removeIds = type(value.removeItemId) == "table" and value.removeItemId or { value.removeItemId }
						for _, removeId in ipairs(removeIds) do
							local toRemove = tile:getItemById(removeId)
							if toRemove then
								toRemove:remove()
								logger.debug("CreateMapItem: removed item {} at position {}", removeId, pos)
							end
						end
					end

					local item = tile:getItemById(itemId)

					if not item then
						item = Game.createItem(itemId, 1, pos)
						if item then
							item:setLoadedFromMap(true)
						end
					end
				end
			end
		end
	end

	logger.debug("Created all items in the map")
end

-- These functions load the action/unique tables on the map
function loadLuaMapAction(tablename)
	-- It load actions
	for index, blocks in pairs(tablename) do
		-- An entry is normally one { itemId, itemPos } block. When the same action id
		-- sits on several different items -- action id 100, the unmovable convention --
		-- the key cannot repeat, so the entry is a list of blocks instead.
		for _, value in ipairs(blocks.itemPos and { blocks } or blocks) do
			for i = 1, #value.itemPos do
				local tile = Tile(value.itemPos[i])
				local item
				-- Checks if the position is valid
				if tile then
					if value.itemId ~= false then
						-- Not just what lies loose on the tile: a key can sit inside a chest
						-- declared in container_*.lua, and getItemById() does not reach in.
						item = findAttributeItem(tile, value.itemId)
						if not item then
							logger.error("[loadLuaMapAction] - Wrong item id {} found", value.itemId)
							logger.warn("Action id: {}, position {}", index, tile:getPosition():toString())
							goto continue
						end
					end

					-- If he found the item, add the action id.
					if item and value.itemId ~= false then
						stampMapAttribute("loadLuaMapAction", item, "aid", index)
					end
					if value.itemId == false then
						local topDown = tile:getTopDownItem()
						if topDown then
							stampMapAttribute("loadLuaMapAction", topDown, "aid", index)
						end
						local topTop = tile:getTopTopItem()
						if topTop then
							stampMapAttribute("loadLuaMapAction", topTop, "aid", index)
						end
						local ground = tile:getGround()
						if ground then
							stampMapAttribute("loadLuaMapAction", ground, "aid", index)
						end
					end
				end
				::continue::
			end
		end
	end
end

function loadLuaMapUnique(tablename)
	-- It load uniques
	for index, value in pairs(tablename) do
		local tile = Tile(value.itemPos)
		local item
		-- Checks if the position is valid
		if tile then
			-- Not just what lies loose on the tile: the item can sit inside a container
			-- declared in container_*.lua, and getItemById() does not reach in.
			if value.itemId ~= false then
				item = findAttributeItem(tile, value.itemId)
			end
			if not item then
				logger.error("[loadLuaMapUnique] - Wrong item id {} found", value.itemId)
				logger.warn("Unique id: {}, position {}", index, tile:getPosition():toString())
				goto continue
			end

			stampMapAttribute("loadLuaMapUnique", item, "uid", index)
		end

		::continue::
	end
end

function loadLuaMapSign(tablename)
	-- It load signs on map table
	for index, value in pairs(tablename) do
		local tile = Tile(value.itemPos)
		local item
		-- Checks if the position is valid
		if tile then
			-- Checks that you have no items created
			if tile:getItemCountById(value.itemId) == 0 then
				logger.error("[loadLuaMapSign] - Wrong item id {} found", value.itemId)
				logger.warn("Sign id: {}, position {}, item id: wrong", index, tile:getPosition():toString())
				goto continue
			end
			if tile:getItemCountById(value.itemId) == 1 then
				item = tile:getItemById(value.itemId)
			end
			-- If he found the item, add the text
			if item then
				item:setAttribute(ITEM_ATTRIBUTE_TEXT, value.text)
				item:setLoadedFromMap(true)
			end
		end
		::continue::
	end
end

function loadLuaMapBookDocument(tablename)
	-- Index 1: total valid, index 2: total loaded
	local totals = { 0, 0 }
	for index, value in ipairs(tablename) do
		local tile = Tile(value.position)
		-- Check position (some items dont have a know position yet defined, lets ignore them)
		if value.position then
			totals[1] = totals[1] + 1
			-- Check if is a valid tile
			if tile then
				-- Try find the container on the map if containerId is set
				local container = (value.containerId and tile:getItemById(value.containerId) or nil)
				-- Check if cotainerId is not set or if containerId is set also if the container exists
				if not value.containerId or value.containerId and container then
					local item
					-- Check if the item need to be in a container
					if container then
						-- Create the item inside the container
						item = container:addItem(value.itemId, 1, INDEX_WHEREEVER, FLAG_NOLIMIT)
					else
						-- Try first find the item on the map (in some cases the item is already on the map)
						item = tile:getItemById(value.itemId)
						-- Create the item at map position if dont was found
						if not item then
							item = Game.createItem(value.itemId, 1, value.position)
						end
					end
					-- If the item exists, add the text
					if item then
						item:setAttribute(ITEM_ATTRIBUTE_TEXT, value.text)
						item:setLoadedFromMap(true)
						totals[2] = totals[2] + 1
					else
						logger.warn("[loadLuaMapBookDocument] - Item not found! Index: {}, itemId: {}", index, value.itemId)
						goto continue
					end
				else
					logger.warn("[loadLuaMapBookDocument] - Container not found! Index: {}, containerId: {}", index, value.containerId)
					goto continue
				end
			else
				logger.warn("[loadLuaMapBookDocument] - Tile not found! Index: {}, position: x: {} y: {} z: {}", index, value.position.x, value.position.y, value.position.z)
				goto continue
			end
		end
		::continue::
	end
	if totals[1] == totals[2] then
		logger.debug("Loaded {} books and documents in the map", totals[2])
	else
		logger.debug("Loaded {} of {} books and documents in the map", totals[2], totals[1])
	end
end

function updateKeysStorage(tablename)
	-- It updates old storage keys from quests for all players
	local newUpdate = tablename[0].latest
	local oldUpdate = getGlobalStorage(GlobalStorage.KeysUpdate)
	if newUpdate <= oldUpdate then
		return true
	end

	logger.info("Updating quest keys storages...")
	if oldUpdate < 1 then
		oldUpdate = 1
	end
	for u = oldUpdate, newUpdate do
		for i = 1, #tablename[u] do
			db.query("UPDATE `player_storage` SET `key` = '" .. tablename[u][i].new .. "' WHERE `key` = '" .. tablename[u][i].old .. "';")
		end
	end
	setGlobalStorage(GlobalStorage.KeysUpdate, newUpdate)
	logger.info("Storage Keys Updated")
end

--[[
	Map ids and container contents

	The world.otbm carries geometry and items only: no action id, no unique id, no
	container contents. All of that is declared in data-global/startup/tables/, so it
	is possible to know which numbers are in use without opening the map editor.
]]

-- Every id the startup stamps is recorded here. It lets the loaders tell an id that
-- was already on the item (so it came from the map) from one the startup just wrote,
-- and it catches two sources fighting over the same item.
local stampedIds = {}

local function attributeName(attribute)
	return attribute == "uid" and "unique id" or "action id"
end

local function checkBeforeStamp(source, item, attribute, value)
	local position = item:getPosition()
	local itemId = item:getId()
	local key = string.format("%d:%d:%d:%d:%s", position.x, position.y, position.z, itemId, attribute)
	local previous = stampedIds[key]

	if previous == nil then
		local current = attribute == "uid" and item:getAttribute(ITEM_ATTRIBUTE_UNIQUEID) or item:getAttribute(ITEM_ATTRIBUTE_ACTIONID)
		if current and current > 0 then
			logger.warn("[{}] - {} {} is stored inside the world.otbm, on item {} at {}. Declare it in data-global/startup/tables/ and clear it in the map editor.", source, attributeName(attribute), current, itemId, position:toString())
		end
	elseif previous.value ~= value then
		-- Two entries claiming the same item, and the loser simply never happens.
		logger.warn("[{}] - {} {} on item {} at {} was overwritten by {}. Two startup entries claim the same item; one of them should not be there.", source, attributeName(attribute), previous.value, itemId, position:toString(), value)
	end

	stampedIds[key] = { value = value, source = source }
end

-- Exposed so the table loaders above can use the same registry.
function stampMapAttribute(source, item, attribute, value)
	checkBeforeStamp(source, item, attribute, value)
	if attribute == "uid" then
		item:setAttribute(ITEM_ATTRIBUTE_UNIQUEID, value)
	else
		item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, value)
	end
end

-- Finds the item on the tile and, when it is not loose, inside the containers on it.
-- Some keys live inside a chest on the map, and tile:getItemById() does not reach those.
function findAttributeItem(tile, itemId)
	local item = tile:getItemById(itemId)
	if item then
		return item
	end

	local function searchContainer(container, depth)
		if depth > 3 then
			return nil
		end
		for i = 0, container:getSize() - 1 do
			local inside = container:getItem(i)
			if inside then
				if inside:getId() == itemId then
					return inside
				end
				if inside:isContainer() then
					local found = searchContainer(inside, depth + 1)
					if found then
						return found
					end
				end
			end
		end
		return nil
	end

	for i = 1, tile:getThingCount() do
		local thing = tile:getThing(i - 1)
		if thing and thing:isItem() and thing:isContainer() then
			local found = searchContainer(thing, 1)
			if found then
				return found
			end
		end
	end
	return nil
end

-- Puts back what used to be stored inside containers on the map: quest chests,
-- bookcases, a bag inside a chest. The content stays physical, so whoever takes it
-- keeps it and it returns on restart, exactly as it did when the OTBM carried it.
-- See data-global/startup/tables/container_*.lua
local function fillContainer(container, contents)
	local created = 0
	for i = 1, #contents do
		local entry = contents[i]
		local added = container:addItem(entry.itemId, entry.count or 1, INDEX_WHEREEVER, FLAG_NOLIMIT)
		if added then
			created = created + 1
			if entry.text then
				added:setAttribute(ITEM_ATTRIBUTE_TEXT, entry.text)
			end
			if entry.description then
				added:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, entry.description)
			end
			if entry.inside and added:isContainer() then
				created = created + fillContainer(added, entry.inside)
			end
		end
	end
	return created
end

function loadMapContainers(tablename)
	local loaded, created, failed = 0, 0, 0
	for i = 1, #tablename do
		local value = tablename[i]
		local tile = Tile(value.itemPos)
		if not tile then
			logger.warn("[loadMapContainers] - Tile not found, position {}", Position(value.itemPos):toString())
			failed = failed + 1
			goto continue
		end

		-- nth exists because a few tiles hold two containers with the same item id and
		-- different contents, and tile:getItemById() always returns the first one.
		local container
		if value.nth then
			local seen = 0
			for index = 1, tile:getThingCount() do
				local thing = tile:getThing(index - 1)
				if thing and thing:isItem() and thing:getId() == value.itemId then
					seen = seen + 1
					if seen == value.nth then
						container = thing
						break
					end
				end
			end
		else
			container = tile:getItemById(value.itemId)
		end

		if not container then
			container = Game.createItem(value.itemId, 1, value.itemPos)
			if container then
				container:setLoadedFromMap(true)
			end
		end

		if not container or not container:isContainer() then
			logger.warn("[loadMapContainers] - Container {} not found, position {}", value.itemId, tile:getPosition():toString())
			failed = failed + 1
			goto continue
		end

		loaded = loaded + 1
		if container:getSize() > 0 then
			-- Filling it now would stack a second copy on top of what is already there.
			logger.warn("[loadMapContainers] - Container {} at {} already holds {} item(s), stored inside the world.otbm. Clear it in the map editor: the contents are declared in data-global/startup/tables/container_*.lua.", value.itemId, tile:getPosition():toString(), container:getSize())
		else
			created = created + fillContainer(container, value.contents)
		end

		::continue::
	end

	if failed == 0 then
		logger.debug("Loaded {} map containers ({} items created)", loaded, created)
	else
		logger.warn("Loaded {} of {} map containers ({} items created)", loaded, loaded + failed, created)
	end
end
