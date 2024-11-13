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

#include "lua/callbacks/events_callbacks.hpp"

#include "lua/callbacks/event_callback.hpp"
#include "game/game.hpp"
#include "lib/di/container.hpp"

/**
 * @class EventsCallbacks
 * @brief Class managing all event callbacks.
 *
 * @note This class is a singleton that holds all registered event callbacks.
 * @details It provides functions to add new callbacks and retrieve callbacks by type.
 */
EventsCallbacks::EventsCallbacks() = default;

EventsCallbacks::~EventsCallbacks() = default;

EventsCallbacks &EventsCallbacks::getInstance() {
	return inject<EventsCallbacks>();
}

bool EventsCallbacks::isCallbackRegistered(const std::shared_ptr<EventCallback> &callback) {
	auto it = m_callbacks.find(callback->getType());

	if (it == m_callbacks.end()) {
		return false;
	}

	const auto &callbacks = it->second;

	auto isSameCallbackName = [&callback](const auto &pair) {
		return pair.name == callback->getName();
	};

	auto found = std::ranges::find_if(callbacks, isSameCallbackName);

	return (found != callbacks.end() && !callback->skipDuplicationCheck());
}

void EventsCallbacks::addCallback(const std::shared_ptr<EventCallback> &callback) {
	auto &callbackList = m_callbacks[callback->getType()];

	for (const auto &entry : callbackList) {
		if (entry.name == callback->getName() && !callback->skipDuplicationCheck()) {
			g_logger().trace("Event callback already registered: {}", callback->getName());
			return;
		}
	}

	g_logger().trace("Registering event callback: {}", callback->getName());
	callbackList.emplace_back(EventCallbackEntry { callback->getName(), callback });
}

void EventsCallbacks::clear() {
	m_callbacks.clear();
}
