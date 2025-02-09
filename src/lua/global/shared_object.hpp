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

#include <parallel_hashmap/phmap.h>

class SharedObject;
using SharedObjectPtr = std::shared_ptr<SharedObject>;

class SharedObject : public std::enable_shared_from_this<SharedObject> {
public:
	virtual ~SharedObject() = default;

	SharedObject &operator=(const SharedObject &) = delete;

	SharedObjectPtr asSharedObject() {
		return shared_from_this();
	}

	template <typename T>
	std::shared_ptr<T> static_self_cast() {
		return std::static_pointer_cast<T>(shared_from_this());
	}

	template <typename T>
	std::shared_ptr<const T> static_self_cast() const {
		return std::static_pointer_cast<const T>(shared_from_this());
	}

	template <typename T>
	std::shared_ptr<T> dynamic_self_cast() {
		return std::dynamic_pointer_cast<T>(shared_from_this());
	}

	template <typename TargetType, typename SourceType>
	std::shared_ptr<TargetType> static_self_cast(std::shared_ptr<SourceType> source) {
		return std::static_pointer_cast<TargetType>(source);
	}

	template <typename TargetType, typename SourceType>
	std::shared_ptr<TargetType> dynamic_self_cast(std::shared_ptr<SourceType> source) {
		return std::dynamic_pointer_cast<TargetType>(source);
	}
};
