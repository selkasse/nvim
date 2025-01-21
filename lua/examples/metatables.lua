-- metatables describe what to do in certain scenarios
-- Lua doesn't normally allow for addition on table literals
local vector_mt = {}
vector_mt.__add = function(left, right)
    return setmetatable({
        left[1] + right[1],
        left[2] + right[2],
        left[3] + right[3],
    }, vector_mt)
end

local v1 = setmetatable({3, 1, 5}, vector_mt)
local v2 = setmetatable({-3, 2, 2}, vector_mt)
-- the __add function above is what allows us to do this
-- these are called "meta methods"
local v3 = v1 + v2

vim.print(v3[1], v3[2], v3[3])
vim.print(v3 + v3)

--[[ __newindex meta method is called when creating
a new index in a table. can also be overridden --]]

-- __call is used to table a table as a function

-- there are no examples of __call in this file


-- metatable indexes
--[[ indexes are called whenever you try to get a value
from a table that does not exist -- ]]

local fib_mt = {
    __index = function(self, key)
        if key < 2 then return 1 end
        -- update the table to save intermediate results
        self[key] = self[key - 2] + self[key -1] -- __newindex called
        -- Return the result
        return self[key]
    end
}

--[[ create an empty table and set its
metatable to the Fibbonaci metatable above --]]
local fib = setmetatable({}, fib_mt)

--[[ remember that at this point, fib is an empty
metatable with fib_met as its metatable.
therefore, there is no index with the value 5 in it.
because of this, the __index function is called --]]

--[[ remember that the `self` inside the __index function
is referring to the empty table `{}` we created when we
called setmetatable({}, fib_mt) --]]

print(fib[5])
-- fib does not have value 5
-- __index function is called with (self, key), which is {}, 5
-- key is not < 2
-- empty table {} gets set to {5: self[3] + self[4]}

-- neither self[3] nor self[4] are present in the table
-- therefore, __index is called again with both of those
-- self[3]: key not <2, moves forward
--[[ table gets updated to {
    5: self[3] + self[4],
    3: self[1] + self[2],
} --]]

-- neither self[1]  nor self[2] are present in the table
-- therefore, __index is called again with both of those
-- self[1]: key IS less than 2, so 1 is returned

--[[ now the table looks like: {
    5: self[3] + self[4],
    3: 1 + self[2],
    1: 1
} --]]

-- self[2]:
--[[ {
    5: self[3] + self[4],
    3: 1 + self[2],
    2: self[0] + 1,
    1: 1
} --]]

-- now we know that self[0] will be 1 because they key is <2
--[[ {
    5: 3 + self[4],
    3: 3,
    2: 2,
    1: 1
} --]]

-- self[4]: self[2] + self[3] = 5
--[[ {
    5: 8,
    4: 5,
    3: 3,
    2: 2,
    1: 1
} --]]

print(fib[1000])


