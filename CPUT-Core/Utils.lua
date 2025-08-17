CPUT.CPUTUtils = CPUT:NewModule("CPUTUtils")

local locale = GetLocale();
if not locale then
    locale = "enUS"
end

function CPUT.CPUTUtils:ContainsString(str, substr)
    return string.find(str, substr) ~= nil
end

function CPUT.CPUTUtils:FetchItemSlotData(slotNumber, unit)

    local slotData = {}
    slotData.slot = slotNumber
    slotData.slotName = CPUT.Constants:getEquipmentSlot(slotNumber).name
    slotData.slotInspectName = CPUT.Constants:getEquipmentSlot(slotNumber).inspectName
    slotData.besidePosition = CPUT.Constants:getEquipmentSlot(slotNumber).besidePosition

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
    slotData.rwString = self:trim(self:GetTooltipString(tooltipData, CPUT.Constants:getReshiiWraps(locale), true))

    -- get enchanted string
    slotData.enchantedString = self:trim(self:GetTooltipString(tooltipData, CPUT.Constants:getEnchantedString(locale)))

    slotData.color = {
        r = tooltipData.lines[1].leftColor.r,
        g = tooltipData.lines[1].leftColor.g,
        b = tooltipData.lines[1].leftColor.b
    }

    if CPUT.settings:GetSettingsValue("grayOutPrevSeasons") then
        if slotData.lsString or (slotData.utString == nil and slotData.rwString == nil) then
            slotData.color = {
                r = 0.5,
                g = 0.5,
                b = 0.5
            }
        end
    end

    if slotData.utString == nil and slotData.rwString ~= nil then
        slotData.utString = slotData.rwString:match("^(.-) ")
    end

    return slotData
end

function CPUT.CPUTUtils:GetTooltipString(tooltipData, str, fullString)
    local line = self:findLine(tooltipData.lines, str)
    if not line then
        return
    end
    if fullString then
        return line.leftText
    end
    return string.gsub(line.leftText, str, "")
end

function CPUT.CPUTUtils:findLine(lines, str)
    for _, line in ipairs(lines) do
        if line.leftText and string.find(line.leftText, str) then
            return line
        end
    end
    return nil
end

function CPUT.CPUTUtils:trim(s)
    if not s then
        return s
    end
    return s:match("^%s*(.-)%s*$")
end
