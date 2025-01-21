-- if statements
local function action(loves_coffee)
    if loves_coffee then
        print("Check out `ssh terminalshop`")
    else
        print("Drink tea, I guess?")
    end
end

-- "falsey", nil ,false
action() -- same as action(nil)
action(false)

-- everything else is "truthy"
action(true)
action(0)
action({})
