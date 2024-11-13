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

#include <atomic_queue/atomic_queue.h>

template <typename T, size_t CAPACITY>
struct LockfreeFreeList {
	using FreeList = atomic_queue::AtomicQueue2<T*, CAPACITY>;

	static FreeList &get() {
		static FreeList freeList;
		return freeList;
	}

	static void preallocate(size_t count) {
		auto &freeList = get();
		for (size_t i = 0; i < count; ++i) {
			auto p = static_cast<T*>(::operator new(sizeof(T), static_cast<std::align_val_t>(alignof(T))));
			if (!freeList.try_push(p)) {
				::operator delete(p, static_cast<std::align_val_t>(alignof(T)));
				break;
			}
		}
	}
};

template <typename T, size_t CAPACITY>
class LockfreePoolingAllocator {
public:
	using value_type = T;

	template <typename U>
	struct rebind {
		using other = LockfreePoolingAllocator<U, CAPACITY>;
	};

	LockfreePoolingAllocator() noexcept = default;

	template <typename U>
	explicit LockfreePoolingAllocator(const LockfreePoolingAllocator<U, CAPACITY> &) noexcept { }

	~LockfreePoolingAllocator() = default;

	T* allocate(std::size_t n) {
		if (n == 1) {
			T* p;
			if (LockfreeFreeList<T, CAPACITY>::get().try_pop(p)) {
				return p;
			}
		}
		return static_cast<T*>(::operator new(n * sizeof(T)));
	}

	void deallocate(T* p, std::size_t n) const noexcept {
		if (n == 1 && LockfreeFreeList<T, CAPACITY>::get().try_push(p)) {
			return;
		}
		::operator delete(p);
	}
};
