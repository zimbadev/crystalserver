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

enum class EventType {
};

using IEvent = Message<EventType>;
using EventHandler = MessageHandler<EventType>;
using EventPolicy = MessagePolicy<EventType>;
using EventListener = IMessageListener<EventType>;
using EventListeners = MessageListeners<EventType>;
using EventDispatcher = MessageDispatcher<EventType>;
using EventRemover = MessageRemover<EventType>;

inline IEvent event(EventType type) {
	return IEvent { type };
}
#define eventCallback(block) [this](const IEvent &) block
#define appendEventListener(type, block) dispatcher.appendListener(type, eventCallback(block))
