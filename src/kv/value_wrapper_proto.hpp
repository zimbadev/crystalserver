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

class ValueWrapper;

using StringType = std::string;
using BooleanType = bool;
using IntType = int;
using DoubleType = double;
using ArrayType = std::vector<ValueWrapper>;
using MapType = phmap::flat_hash_map<std::string, std::shared_ptr<ValueWrapper>>;

using ValueVariant = std::variant<StringType, BooleanType, IntType, DoubleType, ArrayType, MapType>;

// Forward declaration for protobuf class
namespace Crystal::protobuf::kv {
	class ValueWrapper;
}

struct ProtoSerializable {
	static Crystal::protobuf::kv::ValueWrapper toProto(const ValueWrapper &obj);
	static ValueWrapper fromProto(const Crystal::protobuf::kv::ValueWrapper &protoValue, uint64_t timestamp);
};

namespace ProtoHelpers {
	void setProtoStringValue(Crystal::protobuf::kv::ValueWrapper &protoValue, const StringType &arg);
	void setProtoBooleanValue(Crystal::protobuf::kv::ValueWrapper &protoValue, const BooleanType &arg);
	void setProtoIntValue(Crystal::protobuf::kv::ValueWrapper &protoValue, const IntType &arg);
	void setProtoDoubleValue(Crystal::protobuf::kv::ValueWrapper &protoValue, const DoubleType &arg);
	void setProtoArrayValue(Crystal::protobuf::kv::ValueWrapper &protoValue, const ArrayType &arg);
	void setProtoMapValue(Crystal::protobuf::kv::ValueWrapper &protoValue, const MapType &arg);
}
