-- table as a list
local list = {"first", 2, false, function() print("Fourth!") end}
print("Lua is 1-indexed:", list[1])

-- table as a map
local t = {
    literal_key = "a string",
    ["an expression"] = "also works",
    [function() end] = true
}

print("literal_key   : ", t.literal_key)
print("an expression : ", t["an expression"])
 -- prints nil because this function is a different pointer
print("function() end: ", t[function() end])

-- table shorthand
local setup = function(opts)
    --[[ emulate a default argument pattern,
    since Lua does not have this idea --]]
    if opts.default == nil then
        opts.default = 17
    end

    print(opts.default, opts.other)
end

--[[ the shorthand  here is that we are not passing
arguments to the `setup` function with parenthesis.

Rather, we are using the shorthand by passing the map
directly, because the map is the only argument 

Note that this shorthand is only valid for strings and maps--]]
setup { default = 12, other = false }
setup { other = true }

-- colon functions
local MyTable = {}

-- these are equivalent
-- the ":" syntax is a shorthand to reference "self"
function MyTable.something(self, ...) end
function MyTable:something(...) end

