-- Make sure Graphite is in our path
-- Only these examples need to do this
if (not __GRAPHITE_IN_PATH) then
	__GRAPHITE_IN_PATH = true
	package.path = package.path .. ";../?/init.lua"
end

--[[
	Graphite: Simple OOP

	Graphite provides an expressive OOP implementation.
	For inheritance, see easy-oop-inhertiance
]]

local Graphite = require("Graphite")

-- Create a class representing something with a Name
-- Also give it a __tostring
local Named = Graphite.OOP:Class()
	:Members {
		Name = "Unknown"
	}
	:Metatable {
		__tostring = function(self)
			return self.Name
		end
	}

-- Give it a constructor with an optional 'name' argument
function Named:_init(name)
	self.Name = name or "Unknown"
end

-- Usage

-- Create Bob and Jan
local Bob = Named:New("Bob")
local Jan = Named:New("Jan")

-- These give results as expected
print("Bob's name is " .. Bob.Name)
print("Jan's name is " .. Jan.Name)

-- We can change values with no problem
Bob.Name = "Bobby"

-- Bob has legally changed his name to Bobby!
print("Bob's new name is " .. Bob.Name)

-- Let's create a clone of Jan and name her Janice
local Janice = Jan:Copy()
Janice.Name = "Janice"

-- Our clone lives and has her own identity!
print("Janice's name is " .. Janice.Name)