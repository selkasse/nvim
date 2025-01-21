
--[[ with LSP installed, the presence of an "H" in the margin
indicates that the variable has not yet been read]]

-- variables
local number = 5

local double = "double"
local single = 'single'
local brackets = [[multi
line
brackets]]

local truth, lies = true, false
local nothing = nil

print(number, double, single, brackets, truth, lies, nothing)

