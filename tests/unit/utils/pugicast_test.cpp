#include "pch.hpp"

#include <boost/ut.hpp>

#include "utils/pugicast.hpp"

using namespace boost::ut;

namespace {
	// cast() reports a bad value by logging, and boost::ut runs suites during
	// static initialisation, before the DI container holding the logger is
	// constructed. Rejection is therefore checked one level down, on the helper,
	// which is also where the parse actually differs per type.
	template <typename T>
	std::from_chars_result parse(const char* str, T &value) {
		const std::string_view view(str);
		return pugi::detail::fromChars(str, str + view.size(), value);
	}

	// The exact condition cast() treats as success: no error, everything consumed.
	template <typename T>
	bool accepts(const char* str) {
		T value {};
		const auto [pointer, errorCode] = parse(str, value);
		return errorCode == std::errc {} && pointer == str + std::string_view(str).size();
	}
}

suite<"utils"> pugiCastTest = [] {
	test("casts integers") = [] {
		expect(eq(42u, pugi::cast<uint32_t>("42")));
		expect(eq(-7, pugi::cast<int32_t>("-7")));
		expect(eq(0u, pugi::cast<uint16_t>("0")));
	};

	test("casts floating point") = [] {
		expect(eq(1.5f, pugi::cast<float>("1.5")));
		expect(eq(-2.25, pugi::cast<double>("-2.25")));
		expect(eq(1000.0, pugi::cast<double>("1e3")));
		expect(eq(0.75f, pugi::cast<float>("0.75")));
	};

	// Integers go through std::from_chars on every platform while floating point
	// is hand-rolled over strtof/strtod, so the two have to agree on what counts
	// as a number. strtod is the more permissive of the pair.
	test("floating point accepts the same shapes as std::from_chars") = [] {
		expect(accepts<float>("1.5"));
		expect(accepts<float>("-1.5"));
		expect(accepts<float>("1"));
		expect(accepts<double>("1e3"));
		expect(accepts<double>("1.5E-3"));

		expect(!accepts<float>("1.5abc")) << "trailing garbage";
		expect(!accepts<float>(" 1.5")) << "leading whitespace";
		expect(!accepts<float>("+1.5")) << "leading plus";
		expect(!accepts<float>("0x10")) << "hexadecimal";
		expect(!accepts<float>("-0x10")) << "negative hexadecimal";
		expect(!accepts<float>("")) << "empty";
		expect(!accepts<float>("abc")) << "not a number";

		// Whatever the integral path rejects, the floating point path rejects too.
		expect(!accepts<uint32_t>(" 42") && !accepts<float>(" 42"));
		expect(!accepts<uint32_t>("+42") && !accepts<float>("+42"));
		expect(!accepts<uint32_t>("0x10") && !accepts<float>("0x10"));
	};

	test("reports the reason a parse failed") = [] {
		float floatValue {};
		expect(parse("abc", floatValue).ec == std::errc::invalid_argument);
		expect(parse("1e400", floatValue).ec == std::errc::result_out_of_range);

		uint8_t intValue {};
		expect(parse("abc", intValue).ec == std::errc::invalid_argument);
		expect(parse("256", intValue).ec == std::errc::result_out_of_range);
	};
};
