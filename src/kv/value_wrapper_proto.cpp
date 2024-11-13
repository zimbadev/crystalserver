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

#include "kv/value_wrapper_proto.hpp"

#include "kv/value_wrapper.hpp"

#include <kv.pb.h>

namespace ProtoHelpers {
	void setProtoStringValue(Crystal::protobuf::kv::ValueWrapper &protoValue, const StringType &arg) {
		protoValue.set_str_value(arg);
	}

	void setProtoBooleanValue(Crystal::protobuf::kv::ValueWrapper &protoValue, const BooleanType &arg) {
		protoValue.set_bool_value(arg);
	}

	void setProtoIntValue(Crystal::protobuf::kv::ValueWrapper &protoValue, const IntType &arg) {
		protoValue.set_int_value(arg);
	}

	void setProtoDoubleValue(Crystal::protobuf::kv::ValueWrapper &protoValue, const DoubleType &arg) {
		protoValue.set_double_value(arg);
	}

	void setProtoArrayValue(Crystal::protobuf::kv::ValueWrapper &protoValue, const ArrayType &arg) {
		const auto arrayValue = protoValue.mutable_array_value();
		for (const auto &elem : arg) {
			*arrayValue->add_values() = ProtoSerializable::toProto(elem);
		}
	}

	void setProtoMapValue(Crystal::protobuf::kv::ValueWrapper &protoValue, const MapType &arg) {
		const auto mapValue = protoValue.mutable_map_value();
		for (const auto &[key, value] : arg) {
			auto* elem = mapValue->add_items();
			elem->set_key(key);
			*elem->mutable_value() = ProtoSerializable::toProto(*value);
		}
	}
}

Crystal::protobuf::kv::ValueWrapper ProtoSerializable::toProto(const ValueWrapper &obj) {
	Crystal::protobuf::kv::ValueWrapper protoValue;

	std::visit(
		[&protoValue](const auto &arg) {
			using T = std::decay_t<decltype(arg)>;
			if constexpr (std::is_same_v<T, StringType>) {
				ProtoHelpers::setProtoStringValue(protoValue, arg);
			} else if constexpr (std::is_same_v<T, BooleanType>) {
				ProtoHelpers::setProtoBooleanValue(protoValue, arg);
			} else if constexpr (std::is_same_v<T, IntType>) {
				ProtoHelpers::setProtoIntValue(protoValue, arg);
			} else if constexpr (std::is_same_v<T, DoubleType>) {
				ProtoHelpers::setProtoDoubleValue(protoValue, arg);
			} else if constexpr (std::is_same_v<T, ArrayType>) {
				ProtoHelpers::setProtoArrayValue(protoValue, arg);
			} else if constexpr (std::is_same_v<T, MapType>) {
				ProtoHelpers::setProtoMapValue(protoValue, arg);
			}
		},
		obj.getVariant()
	);

	return protoValue;
}

ValueWrapper ProtoSerializable::fromProto(const Crystal::protobuf::kv::ValueWrapper &protoValue, uint64_t timestamp) {
	ValueVariant data;
	switch (protoValue.value_case()) {
		case Crystal::protobuf::kv::ValueWrapper::kStrValue:
			data = protoValue.str_value();
			break;
		case Crystal::protobuf::kv::ValueWrapper::kBoolValue:
			data = protoValue.bool_value();
			break;
		case Crystal::protobuf::kv::ValueWrapper::kIntValue:
			data = protoValue.int_value();
			break;
		case Crystal::protobuf::kv::ValueWrapper::kDoubleValue:
			data = protoValue.double_value();
			break;
		case Crystal::protobuf::kv::ValueWrapper::kArrayValue: {
			ArrayType array;
			for (const auto &protoElem : protoValue.array_value().values()) {
				array.emplace_back(fromProto(protoElem, timestamp));
			}
			data = array;
		} break;
		case Crystal::protobuf::kv::ValueWrapper::kMapValue: {
			MapType map;
			for (const auto &protoElem : protoValue.map_value().items()) {
				map[protoElem.key()] = std::make_shared<ValueWrapper>(fromProto(protoElem.value(), timestamp));
			}
			data = map;
		} break;
		default:
			break;
	}
	return ValueWrapper(data, timestamp);
}
