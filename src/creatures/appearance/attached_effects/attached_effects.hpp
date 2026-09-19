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

struct Aura {
	Aura(uint16_t initId, const std::string &name) :
		id(initId), name(name) { }
	uint16_t id;
	std::string name;
};

struct Shader {
	Shader(uint8_t initId, const std::string &name) :
		id(initId), name(name) { }
	uint8_t id;
	std::string name;
};

struct Effect {
	Effect(uint16_t initId, const std::string &name) :
		id(initId), name(name) { }
	uint16_t id;
	std::string name;
};

struct Wing {
	Wing(uint16_t initId, const std::string &name) :
		id(initId), name(name) { }
	uint16_t id;
	std::string name;
};

class AttachedEffects {
public:
	bool reload();
	bool loadFromXml();

	std::shared_ptr<Aura> getAuraByID(uint8_t id);
	std::shared_ptr<Effect> getEffectByID(uint8_t id);
	std::shared_ptr<Wing> getWingByID(uint8_t id);
	std::shared_ptr<Shader> getShaderByID(uint8_t id);

	std::shared_ptr<Aura> getAuraByName(const std::string &name);
	std::shared_ptr<Shader> getShaderByName(const std::string &name);
	std::shared_ptr<Effect> getEffectByName(const std::string &name);
	std::shared_ptr<Wing> getWingByName(const std::string &name);

	[[nodiscard]] const std::vector<std::shared_ptr<Aura>> &getAuras() const {
		return auras;
	}
	[[nodiscard]] const std::vector<std::shared_ptr<Shader>> &getShaders() const {
		return shaders;
	}
	[[nodiscard]] const std::vector<std::shared_ptr<Effect>> &getEffects() const {
		return effects;
	}
	[[nodiscard]] const std::vector<std::shared_ptr<Wing>> &getWings() const {
		return wings;
	}

private:
	std::vector<std::shared_ptr<Aura>> auras;
	std::vector<std::shared_ptr<Shader>> shaders;
	std::vector<std::shared_ptr<Effect>> effects;
	std::vector<std::shared_ptr<Wing>> wings;
};
