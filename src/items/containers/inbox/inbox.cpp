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

#include "items/containers/inbox/inbox.hpp"

#include "utils/tools.hpp"

Inbox::Inbox(uint16_t type) :
	Container(type, 30, false, true) {
	maxInboxItems = std::numeric_limits<uint16_t>::max();
}

ReturnValue Inbox::queryAdd(int32_t, const std::shared_ptr<Thing> &thing, uint32_t, uint32_t flags, const std::shared_ptr<Creature> &) {
	int32_t addCount = 0;

	if (!hasBitSet(FLAG_NOLIMIT, flags)) {
		return RETURNVALUE_CONTAINERNOTENOUGHROOM;
	}

	const auto &item = thing->getItem();
	if (!item) {
		return RETURNVALUE_NOTPOSSIBLE;
	}

	if (item.get() == this) {
		return RETURNVALUE_THISISIMPOSSIBLE;
	}

	if (!item->isPickupable()) {
		return RETURNVALUE_CANNOTPICKUP;
	}

	if (item->getTopParent().get() != this) { // MY
		if (const std::shared_ptr<Container> &container = item->getContainer()) {
			addCount = container->getItemHoldingCount() + 1;
		} else {
			addCount = 1;
		}
	}

	if (getItemHoldingCount() + addCount > maxInboxItems) { // MY
		return RETURNVALUE_DEPOTISFULL;
	}

	return RETURNVALUE_NOERROR;
}

void Inbox::postAddNotification(const std::shared_ptr<Thing> &thing, const std::shared_ptr<Cylinder> &oldParent, int32_t index, CylinderLink_t) {
	const std::shared_ptr<Cylinder> &localParent = getParent();
	if (localParent != nullptr) {
		localParent->postAddNotification(thing, oldParent, index, LINK_PARENT);
	}
}

void Inbox::postRemoveNotification(const std::shared_ptr<Thing> &thing, const std::shared_ptr<Cylinder> &newParent, int32_t index, CylinderLink_t) {
	const std::shared_ptr<Cylinder> &localParent = getParent();
	if (localParent != nullptr) {
		localParent->postRemoveNotification(thing, newParent, index, LINK_PARENT);
	}
}

std::shared_ptr<Cylinder> Inbox::getParent() {
	const auto &parentLocked = m_parent.lock();
	if (parentLocked) {
		return parentLocked->getParent();
	}
	return nullptr;
}
