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

class Player;
struct Wing;
struct Aura;
struct Effect;
struct Shader;
class Creature;

class PlayerAttachedEffects {
public:
	explicit PlayerAttachedEffects(Player &player);

	// wings
	uint8_t getLastWing() const;
	uint8_t getCurrentWing() const;
	void setCurrentWing(uint8_t wingId);
	bool isWinged() const;
	bool toggleWing(bool wing);
	bool tameWing(uint8_t wingId);
	bool untameWing(uint8_t wingId);
	bool hasWing(const std::shared_ptr<Wing> &wing) const;
	bool hasAnyWing() const;
	uint8_t getRandomWingId() const;
	void diswing();

	// Auras
	uint8_t getLastAura() const;
	uint8_t getCurrentAura() const;
	void setCurrentAura(uint8_t auraId);
	bool isAuraed() const {
		return defaultOutfit.lookAura != 0;
	}
	bool toggleAura(bool aura);
	bool tameAura(uint8_t auraId);
	bool untameAura(uint8_t auraId);
	bool hasAura(const std::shared_ptr<Aura> &aura) const;
	bool hasAnyAura() const;
	uint8_t getRandomAuraId() const;
	void disaura();

	// Effect
	uint8_t getLastEffect() const;
	uint8_t getCurrentEffect() const;
	void setCurrentEffect(uint8_t effectId);
	bool isEffected() const {
		return defaultOutfit.lookEffect != 0;
	}
	bool toggleEffect(bool effect);
	bool tameEffect(uint8_t effectId);
	bool untameEffect(uint8_t effectId);
	bool hasEffect(const std::shared_ptr<Effect> &effect) const;
	bool hasAnyEffect() const;
	uint8_t getRandomEffectId() const;
	void diseffect();

	// Shader
	uint16_t getRandomShader() const;
	uint16_t getCurrentShader() const;
	void setCurrentShader(uint16_t shaderId);
	bool isShadered() const {
		return defaultOutfit.lookShader != 0;
	}
	bool toggleShader(bool shader);
	bool tameShader(uint16_t shaderId);
	bool untameShader(uint16_t shaderId);
	bool hasShader(const Shader* shader) const;
	bool hasShaders() const;
	void disshader();
	std::string getCurrentShader_NAME() const;
	bool addCustomOutfit(const std::string &type, const std::variant<uint16_t, std::string> &idOrName);
	bool removeCustomOutfit(const std::string &type, const std::variant<uint16_t, std::string> &idOrName);

	void sendAttachedEffect(const std::shared_ptr<Creature> &creature, uint16_t effectId) const;
	void sendDetachEffect(const std::shared_ptr<Creature> &creature, uint16_t effectId) const;
	void sendShader(const std::shared_ptr<Creature> &creature, const std::string &shaderName) const;
	void sendMapShader(const std::string &shaderName) const;
	const std::string &getMapShader() const {
		return mapShader;
	}
	void setMapShader(const std::string_view shaderName) {
		this->mapShader = shaderName;
	}

	void setWasWinged(bool wasWinged) {
		this->wasWinged = wasWinged;
	}

	void setWasAuraed(bool wasAuraed) {
		this->wasAuraed = wasAuraed;
	}

	void setWasEffected(bool wasEffected) {
		this->wasEffected = wasEffected;
	}

	void setWasShadered(bool wasShadered) {
		this->wasShadered = wasShadered;
	}

private:
	std::unordered_set<uint16_t> shaders;
	std::string mapShader;

	int64_t lastToggleWing = 0;
	int64_t lastToggleEffect = 0;
	int64_t lastToggleAura = 0;
	int64_t lastToggleShader = 0;

	uint16_t currentWing;
	uint16_t currentAura;
	uint16_t currentEffect;
	uint16_t currentShader;

	bool wasWinged = false;
	bool wasAuraed = false;
	bool wasEffected = false;
	bool wasShadered = false;
	bool randomizeWing = false;
	bool randomizeAura = false;
	bool randomizeEffect = false;
	bool randomizeShader = false;

	Outfit_t defaultOutfit;

	Player &m_player;
};
