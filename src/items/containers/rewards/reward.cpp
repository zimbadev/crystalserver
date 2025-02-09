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

#include "items/containers/rewards/reward.hpp"

Reward::Reward() :
	Container(ITEM_REWARD_CONTAINER) {
	maxSize = 32;
	unlocked = false;
	pagination = true;
}

ReturnValue Reward::queryAdd(int32_t, const std::shared_ptr<Thing> &thing, uint32_t, uint32_t, const std::shared_ptr<Creature> &actor /* = nullptr*/) {
	if (actor || !thing) {
		return RETURNVALUE_NOTPOSSIBLE;
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

	return RETURNVALUE_NOERROR;
}

void Reward::postAddNotification(const std::shared_ptr<Thing> &thing, const std::shared_ptr<Cylinder> &oldParent, int32_t index, CylinderLink_t) {
	const std::shared_ptr<Cylinder> &localParent = getParent();
	if (localParent != nullptr) {
		localParent->postAddNotification(thing, oldParent, index, LINK_PARENT);
	}
}

void Reward::postRemoveNotification(const std::shared_ptr<Thing> &thing, const std::shared_ptr<Cylinder> &newParent, int32_t index, CylinderLink_t) {
	const std::shared_ptr<Cylinder> &localParent = getParent();
	if (localParent != nullptr) {
		localParent->postRemoveNotification(thing, newParent, index, LINK_PARENT);
	}
}

std::shared_ptr<Cylinder> Reward::getParent() {
	return m_parent.lock();
}
