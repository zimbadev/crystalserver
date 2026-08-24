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

#include <cctype>
#include <cerrno>
#include <cstdlib>

namespace pugi {
	void logError(const std::string &str);

	namespace detail {
		// libc++ ships only the integral overloads of std::from_chars and explicitly
		// deletes the rest, so any pugi::cast<float> fails to compile with Apple
		// clang. Floating point goes through the strto* family on every platform
		// rather than just on macOS, so a config value parses the same everywhere.
		//
		// Precondition: [first, last) spans a whole null-terminated string, which is
		// what cast() below always hands over.
		template <typename T>
		std::from_chars_result fromCharsFloat(const char* first, const char* last, T &value) {
			// strtod accepts three things std::from_chars rejects: leading
			// whitespace, a leading '+', and hexadecimal floats. Turn those away up
			// front so both paths agree on what counts as a number.
			if (first == last || std::isspace(static_cast<unsigned char>(*first)) || *first == '+') {
				return { first, std::errc::invalid_argument };
			}

			const char* digits = *first == '-' ? first + 1 : first;
			if (last - digits >= 2 && digits[0] == '0' && (digits[1] == 'x' || digits[1] == 'X')) {
				return { first, std::errc::invalid_argument };
			}

			// The strto* family reads the decimal point from LC_NUMERIC. Nothing in
			// the server installs a locale, so this stays the C locale's '.'.
			errno = 0;
			char* end = nullptr;
			if constexpr (std::is_same_v<T, float>) {
				value = std::strtof(first, &end);
			} else if constexpr (std::is_same_v<T, long double>) {
				value = std::strtold(first, &end);
			} else {
				value = std::strtod(first, &end);
			}

			if (end == first) {
				return { first, std::errc::invalid_argument };
			}

			if (errno == ERANGE) {
				return { end, std::errc::result_out_of_range };
			}

			return { end, std::errc {} };
		}

		template <typename T>
		std::from_chars_result fromChars(const char* first, const char* last, T &value) {
			if constexpr (std::is_floating_point_v<T>) {
				return fromCharsFloat(first, last, value);
			} else {
				return std::from_chars(first, last, value);
			}
		}
	}

	template <typename T>
	// NOTE: std::clamp returns the minimum value if the value is less than the specified minimum value, the maximum value if the value is greater than the specified maximum value, or the value itself if it falls within the range
	T cast(const pugi::char_t* str) {
		// Initialize value to return
		T value;

		// Set the last character to parse
		const std::string_view string(str);
		const auto last = str + string.size();

		// Convert the string to the specified type
		const auto [pointer, errorCode] = detail::fromChars(str, last, value);
		// If the conversion was successful and all characters were parsed
		if (errorCode == std::errc {} && pointer == last) {
			// Ensure that the converted value is within the valid range for the type
			value = std::clamp(
				value,
				std::numeric_limits<T>::lowest(),
				std::numeric_limits<T>::max()
			);
			return value;
		}

		// If the string could not be parsed as the specified type
		if (errorCode == std::errc::invalid_argument) {
			// Throw an exception indicating that the argument is invalid
			logError(fmt::format("[{}] Invalid argument {}", __FUNCTION__, str));
		}
		// If the parsed value is out of range for the specified type
		else if (errorCode == std::errc::result_out_of_range) {
			// Throw an exception indicating that the result is out of range
			logError(fmt::format("[{}] Result out of range: {}", __FUNCTION__, str));
		}

		// Return a default value if no exception is thrown
		return T {};
	}
}
