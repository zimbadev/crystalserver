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

static constexpr int32_t MAP_MAX_CLIENT_VIEW_PORT_X = 8;
static constexpr int32_t MAP_MAX_CLIENT_VIEW_PORT_Y = 6;
static constexpr int32_t MAP_MAX_VIEW_PORT_X = MAP_MAX_CLIENT_VIEW_PORT_X + 3; // min value: maxClientViewportX + 1
static constexpr int32_t MAP_MAX_VIEW_PORT_Y = MAP_MAX_CLIENT_VIEW_PORT_Y + 5; // min value: maxClientViewportY + 1

static constexpr int8_t MAP_MAX_LAYERS = 16;
static constexpr int8_t MAP_INIT_SURFACE_LAYER = 7; // (MAP_MAX_LAYERS / 2) -1
static constexpr int8_t MAP_LAYER_VIEW_LIMIT = 2;

// SECTOR_SIZE must be power of 2 value
// The bigger the SECTOR_SIZE is the less hash map collision there should be but it'll consume more memory
static constexpr int32_t SECTOR_SIZE = 16;
static constexpr int32_t SECTOR_MASK = SECTOR_SIZE - 1;
