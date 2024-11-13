////////////////////////////////////////////////////////////////////////
// Crystal Server - an opensource roleplaying game
////////////////////////////////////////////////////////////////////////
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
////////////////////////////////////////////////////////////////////////

#pragma once

#include "config_enums.hpp"

using ConfigValue = std::variant<std::string, int32_t, bool, float>;

class ConfigManager {
public:
	ConfigManager() = default;

	// Singleton - ensures we don't accidentally copy it
	ConfigManager(const ConfigManager &) = delete;
	void operator=(const ConfigManager &) = delete;

	static ConfigManager &getInstance();

	bool load();
	bool reload();

	void missingConfigWarning(const char* identifier);

	const std::string &setConfigFileLua(const std::string &what) {
		configFileLua = { what };
		return configFileLua;
	};
	[[nodiscard]] const std::string &getConfigFileLua() const {
		return configFileLua;
	};

	[[nodiscard]] const std::string &getString(const ConfigKey_t &key, const std::source_location &location = std::source_location::current()) const;
	[[nodiscard]] int32_t getNumber(const ConfigKey_t &key, const std::source_location &location = std::source_location::current()) const;
	[[nodiscard]] bool getBoolean(const ConfigKey_t &key, const std::source_location &location = std::source_location::current()) const;
	[[nodiscard]] float getFloat(const ConfigKey_t &key, const std::source_location &location = std::source_location::current()) const;

private:
	phmap::flat_hash_map<ConfigKey_t, ConfigValue> configs;
	std::string loadStringConfig(lua_State* L, const ConfigKey_t &key, const char* identifier, const std::string &defaultValue);
	int32_t loadIntConfig(lua_State* L, const ConfigKey_t &key, const char* identifier, const int32_t &defaultValue);
	bool loadBoolConfig(lua_State* L, const ConfigKey_t &key, const char* identifier, const bool &defaultValue);
	float loadFloatConfig(lua_State* L, const ConfigKey_t &key, const char* identifier, const float &defaultValue);

	std::string configFileLua = { "config.lua" };
	bool loaded = false;
};

constexpr auto g_configManager = ConfigManager::getInstance;
