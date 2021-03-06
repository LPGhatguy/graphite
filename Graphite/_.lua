--[[
	Graphite for Lua
	Core

	Provides information about Graphite.

	Copyright (c) 2014 Lucien Greathouse (LPGhatguy)

	This software is provided 'as-is', without any express or implied warranty.
	In no event will the authors be held liable for any damages arising from the
	use of this software.

	Permission is granted to anyone to use this software for any purpose, including
	commercial applications, and to alter it and redistribute it freely, subject to
	the following restrictions:

	1. The origin of this software must not be misrepresented; you must not claim
	that you wrote the original software. If you use this software in a product, an
	acknowledgment in the product documentation would be appreciated but is not required.

	2. Altered source versions must be plainly marked as such, and must not be misrepresented
	as being the original software.

	3. This notice may not be removed or altered from any source distribution.
]]

local libGraphite = (...)
local Configuration = libGraphite.Configuration

local Graphite = {
	Version = {0, 1, 0, "beta"},

	Config = {
		OOP = Configuration:Create("Graphite.Config.OOP") {
			InitializerName = "_init",
			ConstructorName = "New",
			PlacementConstructorName = "PlacementNew",
			DestructorName = "Destroy",
			CopyName = "Copy",
			TypeCheckerName = "Is",

			DefaultAttributes = {
			},

			DefaultStaticAttributes = {
			}
		},
		Pointers = Configuration:Create("Graphite.Config.Pointer") {
			SetName = "Set",
			AvailableCheckName = "Available"
		}
	}
}

Graphite.VersionString = ("%d.%d.%d-%s"):format(unpack(Graphite.Version))

return Graphite