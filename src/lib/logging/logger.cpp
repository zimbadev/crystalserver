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

#include <spdlog/spdlog.h>
#include <spdlog/sinks/basic_file_sink.h>
#include <spdlog/sinks/stdout_color_sinks.h>
#include "lib/di/container.hpp"

void Logger::setLevel(const std::string &name) const {
	debug("Setting log level to: {}.", name);
	const auto level = spdlog::level::from_str(name);
	spdlog::set_level(level);
}

std::string Logger::getLevel() const {
	const auto level = spdlog::level::to_string_view(spdlog::get_level());
	return std::string { level.begin(), level.end() };
}

void Logger::logProfile(const std::string &name, double duration_ms) const {
	std::string mutable_name = name;

	std::ranges::replace(mutable_name, ':', '_');
	std::ranges::replace(mutable_name, '\\', '_');
	std::ranges::replace(mutable_name, '/', '_');

	std::string filename = "log/profile_log-" + mutable_name + ".txt";

	const auto it = profile_loggers_.find(filename);
	if (it == profile_loggers_.end()) {
		try {
			auto file_sink = std::make_shared<spdlog::sinks::basic_file_sink_mt>(filename, true);
			const auto profile_logger = std::make_shared<spdlog::logger>(mutable_name, file_sink);
			profile_loggers_[filename] = profile_logger;
			profile_logger->info("Function {} executed in {} ms", name, duration_ms);
		} catch (const spdlog::spdlog_ex &ex) {
			error("Profile log initialization failed: {}", ex.what());
		}
	} else {
		it->second->info("Function {} executed in {} ms", mutable_name, duration_ms);
	}
}

void Logger::info(const std::string &msg) const {
	SPDLOG_INFO(msg);
}

void Logger::warn(const std::string &msg) const {
	SPDLOG_WARN(msg);
}

void Logger::error(const std::string &msg) const {
	SPDLOG_ERROR(msg);
}

void Logger::critical(const std::string &msg) const {
	SPDLOG_CRITICAL(msg);
}

#if defined(DEBUG_LOG)
void Logger::debug(const std::string &msg) const {
	SPDLOG_DEBUG(msg);
}

void Logger::trace(const std::string &msg) const {
	SPDLOG_TRACE(msg);
}
#endif
