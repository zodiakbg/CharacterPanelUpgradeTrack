CPUT.Utils = CPUT:NewModule("CPUTUtils")

local locale = GetLocale();
if not locale then
    locale = "enUS"
end

function CPUT.Utils:ContainsString(str, substr)
    return string.find(str, substr) ~= nil
end

function CPUT.Utils:FetchItemSlotData(slotNumber, unit)

    local slotData = {}
    slotData.slot = slotNumber
    slotData.slotName = CPUT.Constants:getEquipmentSlot(slotNumber).name
    slotData.slotInspectName = CPUT.Constants:getEquipmentSlot(slotNumber).inspectName
    slotData.besidePosition = CPUT.Constants:getEquipmentSlot(slotNumber).besidePosition
    slotData.unit = unit
    if not unit then
        return
    end

    local tooltipData = C_TooltipInfo.GetInventoryItem(unit, slotNumber)
    if not tooltipData then
        return
    end

    -- get upgrade track string
    slotData.utString = self:GetTooltipString(tooltipData, CPUT.Constants:getUpgradeLevelString(locale))
    if slotData.utString then
        slotData.utString = CPUT.Constants:getUpgradeTrackAbbr(locale, string.sub(slotData.utString, 1, -5))
    end

    -- get item level string
    slotData.ilString = self:trim(self:GetTooltipString(tooltipData, CPUT.Constants:getItemLevelString(locale)))

    -- get last season string
    slotData.lsString = self:trim(self:GetTooltipString(tooltipData, CPUT.Constants:getSeasonString(locale)))

    -- get reshii wraps string
    slotData.rwString = self:trim(self:GetTooltipString(tooltipData, CPUT.Constants:getReshiiWrapsString(locale), true))

    -- get DISC string
    slotData.dsString = self:trim(self:GetTooltipString(tooltipData, CPUT.Constants:getDiscString(locale), true))
    if slotData.dsString then
        slotData.dsString = "DISC"
    end

    -- get enchanted string
    slotData.enchantedString = self:trim(self:GetTooltipString(tooltipData, CPUT.Constants:getEnchantedString(locale)))

    slotData.color = {
        r = tooltipData.lines[1].leftColor.r,
        g = tooltipData.lines[1].leftColor.g,
        b = tooltipData.lines[1].leftColor.b
    }

    if slotData.utString == nil and slotData.rwString ~= nil then
        slotData.utString = slotData.rwString:match("^(.-) ")
    end
    if slotData.utString == nil and slotData.dsString ~= nil then
        slotData.utString = slotData.dsString
    end

    if CPUT.settings:GetSettingsValue("grayOutPrevSeasons") then
        if slotData.lsString or slotData.utString == nil then
            slotData.color = {
                r = 0.5,
                g = 0.5,
                b = 0.5
            }
        end
    end

    return slotData
end

function CPUT.Utils:GetTooltipString(tooltipData, str, fullString)
    local line = self:findLine(tooltipData.lines, str)
    if not line then
        return
    end
    if fullString then
        return line.leftText
    end
    return string.gsub(line.leftText, str, "")
end

function CPUT.Utils:findLine(lines, str)
    for _, line in ipairs(lines) do
        if line.leftText and string.find(line.leftText, str) then
            return line
        end
    end
    return nil
end

function CPUT.Utils:trim(s)
    if not s then
        return s
    end
    return s:match("^%s*(.-)%s*$")
end

local function tableToString(tbl, indent)
    indent = indent or 0
    local toprint = string.rep("  ", indent) .. "{\n"
    indent = indent + 1
    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep("  ", indent)
        if type(k) == "string" then
            toprint = toprint .. '["' .. k .. '"] = '
        else
            toprint = toprint .. "[" .. tostring(k) .. "] = "
        end
        if type(v) == "table" then
            toprint = toprint .. tableToString(v, indent) .. ",\n"
        elseif type(v) == "string" then
            toprint = toprint .. '"' .. v .. '",\n'
        else
            toprint = toprint .. tostring(v) .. ",\n"
        end
    end
    indent = indent - 1
    toprint = toprint .. string.rep("  ", indent) .. "}"
    return toprint
end

function CPUT.Utils:debug(...)
    if false then -- disable debug messages
        local args = {...}
        for i, msg in ipairs(args) do
            if type(msg) == "table" then
                print("CPUT Debug table:")
                print(tableToString(msg))
            else
                print("CPUT Debug:", msg)
            end
        end
    end
end
