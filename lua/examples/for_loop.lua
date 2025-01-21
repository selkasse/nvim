-- for loop
local favorite_accounts = {"teej_dv", "ThePrimeagen", "terminaldotshop"}

for index = 1, #favorite_accounts do
    print(index, favorite_accounts[index])
end

for index, value in ipairs(favorite_accounts) do
    print(index, value)
end

-- trying to use a for loop on map
local reading_scores = { teej_dev = 10, ThePrimeagen = "N/A" }

--[[ this won't print anything because
maps don't technically have a length --]]

for index = 1, #reading_scores do
    print(reading_scores[index])
end

-- however, the syntax works here because it's a list, not a map
local scores = { 10, "N/A" }

for index = 1, #scores do
    print(scores[index])
end

-- but if we need to use a map, we can use the `pairs` function
for key, value in pairs(reading_scores) do
    print(key, value)
end

