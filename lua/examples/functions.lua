-- functions
local function hello(name)
    print("Hello", name)
end

hello("Sharif")

-- function as value
local greet = function(name)
    -- .. is string concatenation
    print("Greetings, " .. name .. "!")
end

greet("Kelly")

-- higher order function
local higher_order = function(value)
    return function(another)
        return value + another
    end
end

local addFiveTo = higher_order(5)
addFiveTo(3) -- should print 8

-- function with multiple returns
local returns_four_values = function()
    return 1,2,3,4
end

first, second, last = returns_four_values()

print("first", first)
print("second", second)
print("last", last) -- the "4" is discarded

local variable_arguments = function(...)
    local arguments = { ... }
    for i, v in ipairs({ ... }) do
        print(i, v)
    end

    return unpack(arguments)
end

print("================")
print("1:", variable_arguments("hello", "world", "!"))
print("================")
-- will print `hello <lost>`
print("2:", variable_arguments("hello", "world", "!"), "<lost>")

-- string shorthand
local single_string = function(s)
    return s .. " - WOW!"
end

local x = single_string("hi")
-- parenthesis are optional if there is only one argument
local y = single_string"hi"

print(x, y)


