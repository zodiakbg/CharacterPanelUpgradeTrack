local addonName, addon = ...

local degubEnabled = false

local function printTable(tbl)
    for key, value in pairs(tbl) do
        print(key, value)
    end
end

function addon.debug(data)
    if (degubEnabled ~= true) then
        return
    end
    if type(data) == "table" then
        printTable(data)
    else
        print(data)
    end
end
