CPUT.CPUTUtils = CPUT:NewModule("CPUTUtils")
local LSM = LibStub("LibSharedMedia-3.0")

local locale = GetLocale();
if not locale then
    locale = "enUS"
end

local overlayTexts = {}
-- upgrade track texts
overlayTexts.ut = {}
-- item level texts
overlayTexts.il = {}

function CPUT.CPUTUtils:ContainsString(str, substr)
    return string.find(str, substr) ~= nil
end

function CPUT.CPUTUtils:FetchItemSlotData(slot)

    local slotData = {}
    slotData.slot = slot
    slotData.slotName = CPUT.Constants:getEquipmentSlot(slot)

    local tooltipData = C_TooltipInfo.GetInventoryItem("player", slot)
    if not tooltipData then
        return
    end

    -- get upgrade track string
    slotData.utString = self:GetTooltipString(tooltipData, CPUT.Constants:getUpgradeLevelString(locale))
    if slotData.utString then
        slotData.utString = CPUT.Constants:getUpgradeTrackAbbr(locale, string.sub(slotData.utString, 1, -5))
    end

    -- get item level string
    slotData.ilString = self:GetTooltipString(tooltipData, CPUT.Constants:getItemLevelString(locale))

    -- get last season string
    slotData.lsString = self:GetTooltipString(tooltipData, CPUT.Constants:getSeasonString(locale))

    -- get reshii wraps string
    slotData.rwString = self:GetTooltipString(tooltipData, CPUT.Constants:getReshiiWraps(locale), true)

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

function CPUT.CPUTUtils:UpdateSlot(slot, slotData)
    local slotData = self:FetchItemSlotData(slot)

    if not slotData then
        return
    end

    if CPUT.settings:GetSettingsValue("showUpgradeTrack") then
        self:CreateUpgradeTrackTextOverlay(slotData)
    end
    if CPUT.settings:GetSettingsValue("showItemLevel") then
        self:CreateItemLevelTextOverlay(slotData)
    end
end

function CPUT.CPUTUtils:CreateUpgradeTrackTextOverlay(slotData)

    local slotFrame = _G[slotData.slotName]
    local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("upgradeTrackFont"))

    overlayTexts.ut[slotData.slot] = slotFrame:CreateFontString(nil, "OVERLAY")
    overlayTexts.ut[slotData.slot]:SetFont(font, 11, "OUTLINE, THICK")
    overlayTexts.ut[slotData.slot]:SetPoint("TOP", slotFrame, "TOP", 0, -2)
    overlayTexts.ut[slotData.slot]:SetText(slotData.utString)
    overlayTexts.ut[slotData.slot]:SetTextColor(slotData.color.r, slotData.color.g, slotData.color.b)

end

function CPUT.CPUTUtils:CreateItemLevelTextOverlay(slotData)

    local slotFrame = _G[slotData.slotName]
    local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("itemLevelFont"))

    overlayTexts.il[slotData.slot] = slotFrame:CreateFontString(nil, "OVERLAY")
    overlayTexts.il[slotData.slot]:SetFont(font, 11, "OUTLINE, THICK")
    overlayTexts.il[slotData.slot]:SetPoint("BOTTOMRIGHT", slotFrame, "BOTTOMRIGHT", 0, -2)
    overlayTexts.il[slotData.slot]:SetText(slotData.ilString)
    overlayTexts.il[slotData.slot]:SetTextColor(slotData.color.r, slotData.color.g, slotData.color.b)

end

function CPUT.CPUTUtils:findLine(lines, str)
    for _, line in ipairs(lines) do
        if line.leftText and string.find(line.leftText, str) then
            return line
        end
    end
    return nil
end

function CPUT.CPUTUtils:ClearItemSlots()
    for slot, text in pairs(CPUT.Constants:getEquipmentSlots()) do
        if (overlayTexts.il[slot]) then
            overlayTexts.il[slot]:Hide()
            overlayTexts.il[slot] = nil
        end
        if (overlayTexts.ut[slot]) then
            overlayTexts.ut[slot]:Hide()
            overlayTexts.ut[slot] = nil
        end
    end
end
