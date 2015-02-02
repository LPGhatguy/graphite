# Graphite for Lua
Graphite is a set of core functionality extensions to Lua in a small package using [Graphene](https://github.com/LPGhatguy/lua-graphene). It supports Lua 5.1, 5.2, 5.3, and LuaJIT. Builds will be available soon for platforms without full filesystem access, taking advantage of Graphene's VFS.

Graphite provides utility methods intended to be used as a Graphene submodule of a larger Graphene-based project, like Coeus. Simply add Graphite to your library directory, provide a submodule directive in your module, and remove `./Graphite/init.lua`. Graphite will then use the top-level Graphene loader.

It presently exposes a number of utilities, including `Dictionary` and `List` operations, various pointer types (`ForwardPointer`, `LookupPointer`, `WeakPointer`) and an expressive `OOP` implementation.

The OOP syntax is very powerful, with features present in lots of other frameworks and languages like custom attributes, multiple inheritance and ancestor typechecking.

See the `examples` directory for more detailed examples.

```lua
local Graphite = require("Graphite")
local OOP = Graphite.OOP

-- Report our Graphite version
print("Using Graphite Version " .. Graphite.VersionString)

-- Sample class attribute
-- Adds a "Name" that's the string reversal of the attribute
-- Completely pointless
OOP:RegisterAttribute("Class", "Name", function(class)
	class.members.Name = class.attributes.Name:reverse()
end)

local A
A = OOP:Class()
	:Metatable {
		__add = function(a, b)
			return A:New(a.Value + b.Value)
		end,

		__tostring = function(self)
			return tostring(self.Value)
		end,

		__gc = function(self)
			return self:Destroy()
		end
	}
	:Attributes {
		InstanceIndirection = true, -- Wraps the object in a userdata to allow __gc on Lua 5.1 and LuaJIT.
		SparseInstances = true, -- Uses less memory by not storing members per-instance unless they change.
		Name = "Apple" -- Custom attribute! See above
	}
	:Members {
		Hello = "World",
		Foo = "Bar"
	}

function A:_init(value)
	self.Value = value
end

function A:Destroy()
	print("A got collected.")
end

local B
B = OOP:Class()

local C
C = OOP:Class()
	:Inherits(A, B)
	:Attributes {
		Name = "Cat"
	}

print("C inherits from A:", C.Is[A]) --> true

do
	local a = A:New(5)
	local b = C:New(6)
	print(a + b) --> 11

	local c = a:Copy()
	print(a + c) --> 10

	print(a.Name) --> elppA
	print(b.Name) --> taC
	print(c.Name) --> elppA

	print("a is of type A:", a.Is[A]) --> true

	print("b is of type A:", b.Is[A]) --> true
	print("b is of type B:", b.Is[B]) --> true
	
	print("c is of type A:", c.Is[A]) --> true
end

collectgarbage() --> 5 objects collected (a, b, a + b, c, a + c)
```