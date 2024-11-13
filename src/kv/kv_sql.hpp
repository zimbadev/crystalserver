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

#include "kv/kv.hpp"

class Database;
class Logger;
class DBInsert;
class ValueWrapper;

class KVSQL final : public KVStore {
public:
	explicit KVSQL(Database &db, Logger &logger);

	bool saveAll() override;

private:
	std::vector<std::string> loadPrefix(const std::string &prefix = "") override;
	std::optional<ValueWrapper> load(const std::string &key) override;
	bool save(const std::string &key, const ValueWrapper &value) override;
	bool prepareSave(const std::string &key, const ValueWrapper &value, DBInsert &update) const;

	DBInsert dbUpdate();

	Database &db;
};
