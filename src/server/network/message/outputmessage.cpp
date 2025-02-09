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

#include "server/network/message/outputmessage.hpp"

#include "lib/di/container.hpp"
#include "server/network/protocol/protocol.hpp"
#include "game/scheduling/dispatcher.hpp"
#include "utils/lockfree.hpp"

constexpr uint16_t OUTPUTMESSAGE_FREE_LIST_CAPACITY = 2048;
constexpr std::chrono::milliseconds OUTPUTMESSAGE_AUTOSEND_DELAY { 10 };

OutputMessagePool &OutputMessagePool::getInstance() {
	return inject<OutputMessagePool>();
}

void OutputMessagePool::scheduleSendAll() {
	g_dispatcher().scheduleEvent(
		OUTPUTMESSAGE_AUTOSEND_DELAY.count(), [this] { sendAll(); }, "OutputMessagePool::sendAll"
	);
}

void OutputMessagePool::sendAll() {
	// dispatcher thread
	for (const auto &protocol : bufferedProtocols) {
		auto &msg = protocol->getCurrentBuffer();
		if (msg) {
			protocol->send(std::move(msg));
		}
	}

	if (!bufferedProtocols.empty()) {
		scheduleSendAll();
	}
}

void OutputMessagePool::addProtocolToAutosend(const Protocol_ptr &protocol) {
	// dispatcher thread
	if (bufferedProtocols.empty()) {
		scheduleSendAll();
	}
	bufferedProtocols.emplace_back(protocol);
}

void OutputMessagePool::removeProtocolFromAutosend(const Protocol_ptr &protocol) {
	// dispatcher thread
	const auto it = std::ranges::find(bufferedProtocols, protocol);
	if (it != bufferedProtocols.end()) {
		*it = bufferedProtocols.back();
		bufferedProtocols.pop_back();
	}
}

OutputMessage_ptr OutputMessagePool::getOutputMessage() {
	return std::allocate_shared<OutputMessage>(LockfreePoolingAllocator<OutputMessage, OUTPUTMESSAGE_FREE_LIST_CAPACITY>());
}
