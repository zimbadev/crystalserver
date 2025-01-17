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

#include "creatures/appearance/mounts/mounts.hpp"

#include "config/configmanager.hpp"
#include "game/game.hpp"
#include "utils/pugicast.hpp"
#include "utils/tools.hpp"

bool Mounts::reload() {
	mounts.clear();
	return loadFromXml();
}

bool Mounts::loadFromXml() {
	pugi::xml_document doc;
	auto folder = g_configManager().getString(CORE_DIRECTORY) + "/XML/mounts.xml";
	pugi::xml_parse_result result = doc.load_file(folder.c_str());
	if (!result) {
		printXMLError(__FUNCTION__, folder, result);
		return false;
	}

	for (auto mountNode : doc.child("mounts").children()) {
		auto lookType = pugi::cast<uint16_t>(mountNode.attribute("clientid").value());
		if (g_configManager().getBoolean(WARN_UNSAFE_SCRIPTS) && lookType != 0 && !g_game().isLookTypeRegistered(lookType)) {
			g_logger().warn("{} - An unregistered creature mount with id '{}' was blocked to prevent client crash.", __FUNCTION__, lookType);
			continue;
		}

		int32_t attackSpeedValue = mountNode.attribute("attackspeed") ? pugi::cast<int32_t>(mountNode.attribute("attackspeed").value()) : 0;
		mounts.emplace(std::make_shared<Mount>(
			static_cast<uint8_t>(pugi::cast<uint16_t>(mountNode.attribute("id").value())),
			lookType,
			mountNode.attribute("name").as_string(),
			pugi::cast<int32_t>(mountNode.attribute("speed").value()),
			mountNode.attribute("premium").as_bool(),
			mountNode.attribute("type").as_string(),
			attackSpeedValue
		));
	}
	return true;
}

std::shared_ptr<Mount> Mounts::getMountByID(uint8_t id) {
	auto it = std::find_if(mounts.begin(), mounts.end(), [id](const std::shared_ptr<Mount> &mount) {
		return mount->id == id;
	});

	return it != mounts.end() ? *it : nullptr;
}

std::shared_ptr<Mount> Mounts::getMountByName(const std::string &name) {
	auto mountName = name.c_str();
	auto it = std::find_if(mounts.begin(), mounts.end(), [mountName](const std::shared_ptr<Mount> &mount) {
		return strcasecmp(mountName, mount->name.c_str()) == 0;
	});

	return it != mounts.end() ? *it : nullptr;
}

std::shared_ptr<Mount> Mounts::getMountByClientID(uint16_t clientId) {
	auto it = std::find_if(mounts.begin(), mounts.end(), [clientId](const std::shared_ptr<Mount> &mount) {
		return mount->clientId == clientId;
	});

	return it != mounts.end() ? *it : nullptr;
}
