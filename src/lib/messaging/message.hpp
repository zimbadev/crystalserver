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

#include <eventpp/utilities/scopedremover.h>
#include <eventpp/eventdispatcher.h>

template <typename T>
struct Message {
	T type;
};

template <typename T>
using MessageHandler = void(const Message<T> &);

template <typename T>
struct MessagePolicy {
	static T getEvent(const Message<T> &msg) {
		return msg.type;
	}
};

template <typename T>
using MessageDispatcher = eventpp::EventDispatcher<T, MessageHandler<T>, MessagePolicy<T>>;

template <typename T>
using MessageRemover = eventpp::ScopedRemover<MessageDispatcher<T>>;

template <typename T>
class IMessageListener {
public:
	virtual ~IMessageListener() = default;
	virtual void setupListeners(MessageDispatcher<T> &dispatcher) = 0;
};

template <typename T>
using MessageListeners = std::vector<std::shared_ptr<IMessageListener<T>>>;
