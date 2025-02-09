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

class SharedPtrManager {
public:
	SharedPtrManager() = default;
	~SharedPtrManager() = default;

	// Singleton - ensures we don't accidentally copy it.
	SharedPtrManager(const SharedPtrManager &) = delete;
	SharedPtrManager &operator=(const SharedPtrManager &) = delete;

	static SharedPtrManager &getInstance();

	template <typename T>
	void store(const std::string &name, const std::shared_ptr<T> &ptr) {
		m_sharedPtrMap[name] = ptr;
	}

	void countAllReferencesAndClean();

private:
	std::unordered_map<std::string, std::weak_ptr<void>> m_sharedPtrMap;
};

constexpr auto g_counterPointer = SharedPtrManager::getInstance;
