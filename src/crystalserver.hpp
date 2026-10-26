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

#include "security/rsa.hpp"
#include "server/server.hpp"

class Logger;

class FailedToInitializeCrystalServer : public std::exception {
private:
	std::string message;

public:
	// Constructor accepts a specific message
	explicit FailedToInitializeCrystalServer(const std::string &msg) :
		message("Crystal Server load couldn't be completed. " + msg) { }

	// Override the what() method from std::exception
	const char* what() const noexcept override {
		return message.c_str();
	}
};

class CrystalServer {
public:
	explicit CrystalServer(
		Logger &logger,
		RSA &rsa,
		ServiceManager &serviceManager
	);

	int run();

private:
	enum class LoaderStatus : uint8_t {
		LOADING,
		LOADED,
		FAILED
	};

	Logger &logger;
	RSA &rsa;
	ServiceManager &serviceManager;

	std::atomic<LoaderStatus> loaderStatus = LoaderStatus::LOADING;

	void logInfos();
	static void toggleForceCloseButton();
	static void badAllocationHandler();
	static void shutdown();

	static std::string getCompiler();
	static std::string getPlatform();

	void loadConfigLua();
	void initializeDatabase();
	void loadModules();
	void loadThisWorld();
	void loadMaps() const;
	void setupHousesRent();
	void modulesLoadHelper(bool loaded, std::string moduleName);
};
