CPUT.CPUTUI = CPUT:NewModule("CPUTUI")

local LSM = LibStub("LibSharedMedia-3.0")

local overlayTexts = {}
-- upgrade track texts
overlayTexts.ut = {}
-- item level texts
overlayTexts.il = {}

local UT_STRING_Y_OFFSET = -5
local IL_STRING_Y_OFFSET = 5

local LEFT_STRING_X_OFFSET = -10
local RIGHT_STRING_X_OFFSET = 10

function CPUT.CPUTUI:CreateUpgradeTrackTextOverlay(slotData, besideIcon)

    local slotFrame = _G[slotData.slotName]
    local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("upgradeTrackFont"))

    overlayTexts.ut[slotData.slot] = slotFrame:CreateFontString(nil, "OVERLAY")
    overlayTexts.ut[slotData.slot]:SetFont(font, 11, "OUTLINE, THICK")
    overlayTexts.ut[slotData.slot]:SetText(slotData.utString)
    overlayTexts.ut[slotData.slot]:SetTextColor(slotData.color.r, slotData.color.g, slotData.color.b)

    -- position string on top of icon
    if not besideIcon then
        overlayTexts.ut[slotData.slot]:SetPoint("TOP", slotFrame, "TOP", 0, -2)
        return
    end

    -- position string beside icon
    if slotData.besidePosition == "left" then
        overlayTexts.ut[slotData.slot]:SetPoint("TOPRIGHT", slotFrame, "TOPLEFT", LEFT_STRING_X_OFFSET,
            UT_STRING_Y_OFFSET)
    else
        overlayTexts.ut[slotData.slot]:SetPoint("TOPLEFT", slotFrame, "TOPRIGHT", RIGHT_STRING_X_OFFSET,
            UT_STRING_Y_OFFSET)
    end

end

function CPUT.CPUTUI:CreateItemLevelTextOverlay(slotData, besideIcon)

    local slotFrame = _G[slotData.slotName]
    local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("itemLevelFont"))

    overlayTexts.il[slotData.slot] = slotFrame:CreateFontString(nil, "OVERLAY")
    overlayTexts.il[slotData.slot]:SetFont(font, 11, "OUTLINE, THICK")
    overlayTexts.il[slotData.slot]:SetText(slotData.ilString)
    overlayTexts.il[slotData.slot]:SetTextColor(slotData.color.r, slotData.color.g, slotData.color.b)

    -- position string on top of icon
    if not besideIcon then
        overlayTexts.il[slotData.slot]:SetPoint("BOTTOMRIGHT", slotFrame, "BOTTOMRIGHT", 0, -2)
        return
    end

    -- position string beside icon
    if slotData.besidePosition == "left" then
        overlayTexts.il[slotData.slot]:SetPoint("BOTTOMRIGHT", slotFrame, "BOTTOMLEFT", LEFT_STRING_X_OFFSET,
            IL_STRING_Y_OFFSET)
    else
        overlayTexts.il[slotData.slot]:SetPoint("BOTTOMLEFT", slotFrame, "BOTTOMRIGHT", RIGHT_STRING_X_OFFSET,
            IL_STRING_Y_OFFSET)
    end

end

function CPUT.CPUTUI:UpdateSlot(slot, slotData)
    local slotData = CPUT.CPUTUtils:FetchItemSlotData(slot)
    local besideIcon = false;

    if not slotData then
        return
    end

    if CPUT.settings:GetSettingsValue("showInfoBesideIcon") then
        besideIcon = true;
    end

    if CPUT.settings:GetSettingsValue("showUpgradeTrack") then
        self:CreateUpgradeTrackTextOverlay(slotData, besideIcon)
    end
    if CPUT.settings:GetSettingsValue("showItemLevel") then
        self:CreateItemLevelTextOverlay(slotData, besideIcon)
    end
end

function CPUT.CPUTUI:ClearItemSlots()
    for slot, _ in pairs(CPUT.Constants:getEquipmentSlots()) do
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
