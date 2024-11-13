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

#include "kv/kv.hpp"

#include "lib/di/container.hpp"
#include "database/database.hpp"

int64_t KV::lastTimestamp_ = 0;
uint64_t KV::counter_ = 0;
std::mutex KV::mutex_ = {};

KVStore &KVStore::getInstance() {
	return inject<KVStore>();
}

void KVStore::set(const std::string &key, const std::initializer_list<ValueWrapper> &init_list) {
	const ValueWrapper wrappedInitList(init_list);
	set(key, wrappedInitList);
}

void KVStore::set(const std::string &key, const std::initializer_list<std::pair<const std::string, ValueWrapper>> &init_list) {
	const ValueWrapper wrappedInitList(init_list);
	set(key, wrappedInitList);
}

void KVStore::set(const std::string &key, const ValueWrapper &value) {
	std::scoped_lock lock(mutex_);
	return setLocked(key, value);
}

void KVStore::setLocked(const std::string &key, const ValueWrapper &value) {
	logger.trace("KVStore::set({})", key);
	const auto it = store_.find(key);
	if (it != store_.end()) {
		it->second.first = value;
		lruQueue_.splice(lruQueue_.begin(), lruQueue_, it->second.second);
	} else {
		if (store_.size() >= MAX_SIZE) {
			logger.debug("KVStore::set() - MAX_SIZE reached, removing last element");
			auto last = lruQueue_.end();
			last--;
			save(*last, store_[*last].first);
			store_.erase(*last);
			lruQueue_.pop_back();
		}

		lruQueue_.push_front(key);
		store_.try_emplace(key, std::make_pair(value, lruQueue_.begin()));
	}
}

std::optional<ValueWrapper> KVStore::get(const std::string &key, bool forceLoad /*= false */) {
	logger.trace("KVStore::get({})", key);
	std::scoped_lock lock(mutex_);
	if (forceLoad || !store_.contains(key)) {
		auto value = load(key);
		if (value) {
			setLocked(key, *value);
		}
		return value;
	}

	auto &[value, lruIt] = store_[key];
	if (value.isDeleted()) {
		lruQueue_.splice(lruQueue_.end(), lruQueue_, lruIt);
		return std::nullopt;
	}
	lruQueue_.splice(lruQueue_.begin(), lruQueue_, lruIt);
	return value;
}

std::unordered_set<std::string> KVStore::keys(const std::string &prefix /*= ""*/) {
	std::scoped_lock lock(mutex_);
	std::unordered_set<std::string> keys;
	for (const auto &[key, value] : store_) {
		if (key.find(prefix) == 0) {
			std::string suffix = key.substr(prefix.size());
			keys.insert(suffix);
		}
	}
	for (const auto &key : loadPrefix(prefix)) {
		keys.insert(key);
	}
	return keys;
}

void KV::remove(const std::string &key) {
	set(key, ValueWrapper::deleted());
}

std::shared_ptr<KV> KVStore::scoped(const std::string &scope) {
	logger.trace("KVStore::scoped({})", scope);
	return std::make_shared<ScopedKV>(logger, *this, scope);
}
