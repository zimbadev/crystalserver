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

#include "creatures/appearance/attached_effects/attached_effects.hpp"

#include "config/configmanager.hpp"
#include "game/game.hpp"
#include "utils/pugicast.hpp"
#include "utils/tools.hpp"

bool AttachedEffects::reload() {
	auras.clear();
	shaders.clear();
	effects.clear();
	wings.clear();
	return loadFromXml();
}

bool AttachedEffects::loadFromXml() {
	pugi::xml_document doc;
	auto folder = g_configManager().getString(CORE_DIRECTORY) + "/XML/attachedeffects.xml";
	pugi::xml_parse_result result = doc.load_file(folder.c_str());
	if (!result) {
		printXMLError(__FUNCTION__, folder, result);
		return false;
	}

	for (auto auraNode : doc.child("attachedeffects").children("aura")) {
		auras.push_back(std::make_shared<Aura>(
			pugi::cast<uint16_t>(auraNode.attribute("id").value()),
			auraNode.attribute("name").as_string()
		));
	}

	for (auto shaderNode : doc.child("attachedeffects").children("shader")) {
		shaders.push_back(std::make_shared<Shader>(
			pugi::cast<uint16_t>(shaderNode.attribute("id").value()),
			shaderNode.attribute("name").as_string()
		));
	}

	for (auto effectNode : doc.child("attachedeffects").children("effect")) {
		effects.push_back(std::make_shared<Effect>(
			pugi::cast<uint16_t>(effectNode.attribute("id").value()),
			effectNode.attribute("name").as_string()
		));
	}

	for (auto wingNode : doc.child("attachedeffects").children("wing")) {
		wings.push_back(std::make_shared<Wing>(
			pugi::cast<uint16_t>(wingNode.attribute("id").value()),
			wingNode.attribute("name").as_string()
		));
	}

	return true;
}

std::shared_ptr<Aura> AttachedEffects::getAuraByID(uint8_t id) {
	auto it = std::ranges::find_if(auras.begin(), auras.end(), [id](const std::shared_ptr<Aura> &aura) {
		return aura->id == id;
	});
	return it != auras.end() ? *it : nullptr;
}

std::shared_ptr<Effect> AttachedEffects::getEffectByID(uint8_t id) {
	auto it = std::ranges::find_if(effects.begin(), effects.end(), [id](const std::shared_ptr<Effect> &effect) {
		return effect->id == id;
	});
	return it != effects.end() ? *it : nullptr;
}

std::shared_ptr<Wing> AttachedEffects::getWingByID(uint8_t id) {
	auto it = std::ranges::find_if(wings.begin(), wings.end(), [id](const std::shared_ptr<Wing> &wing) {
		return wing->id == id;
	});
	return it != wings.end() ? *it : nullptr;
}

std::shared_ptr<Shader> AttachedEffects::getShaderByID(uint8_t id) {
	auto it = std::ranges::find_if(shaders.begin(), shaders.end(), [id](const std::shared_ptr<Shader> &shader) {
		return shader->id == id;
	});
	return it != shaders.end() ? *it : nullptr;
}

std::shared_ptr<Aura> AttachedEffects::getAuraByName(const std::string &name) {
	auto auraName = name.c_str();
	auto it = std::ranges::find_if(auras.begin(), auras.end(), [auraName](const std::shared_ptr<Aura> &aura) {
		return strcasecmp(auraName, aura->name.c_str()) == 0;
	});
	return it != auras.end() ? *it : nullptr;
}

std::shared_ptr<Shader> AttachedEffects::getShaderByName(const std::string &name) {
	auto shaderName = name.c_str();
	auto it = std::ranges::find_if(shaders.begin(), shaders.end(), [shaderName](const std::shared_ptr<Shader> &shader) {
		return strcasecmp(shaderName, shader->name.c_str()) == 0;
	});
	return it != shaders.end() ? *it : nullptr;
}

std::shared_ptr<Effect> AttachedEffects::getEffectByName(const std::string &name) {
	auto effectName = name.c_str();
	auto it = std::ranges::find_if(effects.begin(), effects.end(), [effectName](const std::shared_ptr<Effect> &effect) {
		return strcasecmp(effectName, effect->name.c_str()) == 0;
	});
	return it != effects.end() ? *it : nullptr;
}

std::shared_ptr<Wing> AttachedEffects::getWingByName(const std::string &name) {
	auto wingName = name.c_str();
	auto it = std::ranges::find_if(wings.begin(), wings.end(), [wingName](const std::shared_ptr<Wing> &wing) {
		return strcasecmp(wingName, wing->name.c_str()) == 0;
	});
	return it != wings.end() ? *it : nullptr;
}
