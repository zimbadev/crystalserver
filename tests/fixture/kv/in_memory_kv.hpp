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

#include <vector>
#include <string>
#include <utility>

#include "kv/kv.hpp"

#include "test_injection.hpp"
#include "lib/di/container.hpp"

namespace di = boost::di;

class KVMemory final : public KVStore {
public:
	static di::extension::injector<> &install(di::extension::injector<> &injector) {
		injector.install(di::bind<KVStore>.to<KVMemory>().in(di::singleton));
		return injector;
	}

	explicit KVMemory(Logger &logger) :
		KVStore(logger) { }

	KVMemory &reset() {
		flush();
		return *this;
	}

protected:
	std::vector<std::string> loadPrefix(const std::string &prefix = "") override {
		return {};
	}
	std::optional<ValueWrapper> load(const std::string &key) override {
		return std::nullopt;
	}
	bool save(const std::string &key, const ValueWrapper &value) override {
		return false;
	}
};

template <>
struct TestInjection<KVStore> {
	using type = KVMemory;
};
