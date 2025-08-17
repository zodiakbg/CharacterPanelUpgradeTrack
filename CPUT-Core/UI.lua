CPUT.CPUTUI = CPUT:NewModule("CPUTUI")

local LSM = LibStub("LibSharedMedia-3.0")

local overlayTexts = {}
overlayTexts.player = {}
overlayTexts.target = {}
overlayTexts.player.ut = {}
overlayTexts.player.il = {}
overlayTexts.target.ut = {}
overlayTexts.target.il = {}

local UT_STRING_Y_OFFSET = -5
local IL_STRING_Y_OFFSET = 5

local LEFT_STRING_X_OFFSET = -10
local RIGHT_STRING_X_OFFSET = 10

function CPUT.CPUTUI:CreateUpgradeTrackTextOverlay(slotData, besideIcon, unit)

    local slotName = slotData.slotName
    if (unit == "target") then
        slotName = slotData.slotInspectName
    end

    local slotFrame = _G[slotName]

    local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("upgradeTrackFont"))

    overlayTexts[unit].ut[slotData.slot] = slotFrame:CreateFontString(nil, "OVERLAY")
    overlayTexts[unit].ut[slotData.slot]:SetFont(font, 11, "OUTLINE, THICK")
    overlayTexts[unit].ut[slotData.slot]:SetText(slotData.utString)
    overlayTexts[unit].ut[slotData.slot]:SetTextColor(slotData.color.r, slotData.color.g, slotData.color.b)

    -- position string on top of icon
    if not besideIcon then
        overlayTexts[unit].ut[slotData.slot]:SetPoint("TOP", slotFrame, "TOP", 0, -2)
        return
    end

    -- position string beside icon
    if slotData.besidePosition == "left" then
        overlayTexts[unit].ut[slotData.slot]:SetPoint("TOPRIGHT", slotFrame, "TOPLEFT", LEFT_STRING_X_OFFSET,
            UT_STRING_Y_OFFSET)
    else
        overlayTexts[unit].ut[slotData.slot]:SetPoint("TOPLEFT", slotFrame, "TOPRIGHT", RIGHT_STRING_X_OFFSET,
            UT_STRING_Y_OFFSET)
    end

end

function CPUT.CPUTUI:CreateItemLevelTextOverlay(slotData, besideIcon, unit)

    local slotName = slotData.slotName
    if (unit == "target") then
        slotName = slotData.slotInspectName
    end

    local slotFrame = _G[slotName]

    local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("itemLevelFont"))

    overlayTexts[unit].il[slotData.slot] = slotFrame:CreateFontString(nil, "OVERLAY")
    overlayTexts[unit].il[slotData.slot]:SetFont(font, 11, "OUTLINE, THICK")
    overlayTexts[unit].il[slotData.slot]:SetText(slotData.ilString)
    overlayTexts[unit].il[slotData.slot]:SetTextColor(slotData.color.r, slotData.color.g, slotData.color.b)

    -- position string on top of icon
    if not besideIcon then
        overlayTexts[unit].il[slotData.slot]:SetPoint("BOTTOMRIGHT", slotFrame, "BOTTOMRIGHT", 0, -2)
        return
    end

    -- position string beside icon
    if slotData.besidePosition == "left" then
        overlayTexts[unit].il[slotData.slot]:SetPoint("BOTTOMRIGHT", slotFrame, "BOTTOMLEFT", LEFT_STRING_X_OFFSET,
            IL_STRING_Y_OFFSET)
    else
        overlayTexts[unit].il[slotData.slot]:SetPoint("BOTTOMLEFT", slotFrame, "BOTTOMRIGHT", RIGHT_STRING_X_OFFSET,
            IL_STRING_Y_OFFSET)
    end

end

function CPUT.CPUTUI:UpdateSlot(slot, slotData, unit)
    local slotData = CPUT.CPUTUtils:FetchItemSlotData(slot, unit)

    if not slotData then
        return
    end

    local besideIcon = false;

    if not slotData then
        return
    end

    if CPUT.settings:GetSettingsValue("showInfoBesideIcon") then
        besideIcon = true;
    end

    if CPUT.settings:GetSettingsValue("showUpgradeTrack") then
        self:CreateUpgradeTrackTextOverlay(slotData, besideIcon, unit)
    end
    if CPUT.settings:GetSettingsValue("showItemLevel") then
        self:CreateItemLevelTextOverlay(slotData, besideIcon, unit)
    end
end

function CPUT.CPUTUI:ShowInspectItemLevel(itemLevel)

    local slotFrame = _G["InspectHandsSlot"]

    local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("itemLevelFont"))

    overlayTexts.target.itemLevel = slotFrame:CreateFontString(nil, "OVERLAY")
    overlayTexts.target.itemLevel:SetFont(font, 11, "OUTLINE, THICK")
    overlayTexts.target.itemLevel:SetText("Item Level: \n" .. itemLevel)
    overlayTexts.target.itemLevel:SetTextColor(100, 100, 100)
    overlayTexts.target.itemLevel:SetPoint("BOTTOMRIGHT", slotFrame, "TOPRIGHT", 0, 5)

end

function CPUT.CPUTUI:ClearItemSlots(unit)
    for slot, _ in pairs(CPUT.Constants:getEquipmentSlots()) do
        if (unit == "player") then
            if (overlayTexts.player.ut[slot]) then
                overlayTexts.player.ut[slot]:Hide()
                overlayTexts.player.ut[slot] = nil
            end
            if (overlayTexts.player.il[slot]) then
                overlayTexts.player.il[slot]:Hide()
                overlayTexts.player.il[slot] = nil
            end
        end
        if (unit == "target") then
            if (overlayTexts.target.il[slot]) then
                overlayTexts.target.il[slot]:Hide()
                overlayTexts.target.il[slot] = nil
            end
            if (overlayTexts.target.ut[slot]) then
                overlayTexts.target.ut[slot]:Hide()
                overlayTexts.target.ut[slot] = nil
            end
        end
    end
    if (unit == "target") then
        if (overlayTexts.target.itemLevel) then
            overlayTexts.target.itemLevel:Hide()
            overlayTexts.target.itemLevel = nil
        end
    end

end
