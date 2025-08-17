CPUT.CPUTUI = CPUT:NewModule("CPUTUI")

local LSM = LibStub("LibSharedMedia-3.0")

local overlayTexts = {}
overlayTexts.player = {}
overlayTexts.target = {}
overlayTexts.player.ut = {}
overlayTexts.player.il = {}
overlayTexts.player.enchants = {}
overlayTexts.target.ut = {}
overlayTexts.target.il = {}
overlayTexts.target.enchants = {}

local UT_STRING_Y_OFFSET = -3
local IL_STRING_Y_OFFSET = -13
local EN_STRING_Y_OFFSET = -21

local LEFT_STRING_X_OFFSET = -3
local RIGHT_STRING_X_OFFSET = 3

function CPUT.CPUTUI:CreateUpgradeTrackTextOverlay(slotData, besideIcon, unit)

    local slotName = slotData.slotName
    if (unit == "target") then
        slotName = slotData.slotInspectName
    end

    local parentFrame = _G[slotName]
    if (besideIcon) then
        parentFrame = _G["CPUT_" .. slotName .. "_BG"]
    end

    local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("upgradeTrackFont"))

    overlayTexts[unit].ut[slotData.slot] = parentFrame:CreateFontString("CPUT_UT_" .. slotName, "OVERLAY")
    overlayTexts[unit].ut[slotData.slot]:SetFont(font, 11, "OUTLINE, THICK")
    overlayTexts[unit].ut[slotData.slot]:SetText(slotData.utString)
    overlayTexts[unit].ut[slotData.slot]:SetTextColor(slotData.color.r, slotData.color.g, slotData.color.b)

    -- position string on top of icon
    if not besideIcon then
        overlayTexts[unit].ut[slotData.slot]:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", 0, UT_STRING_Y_OFFSET)
        return
    end

    -- position string beside icon
    if slotData.besidePosition == "left" then
        overlayTexts[unit].ut[slotData.slot]:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", LEFT_STRING_X_OFFSET,
            UT_STRING_Y_OFFSET)
    else
        overlayTexts[unit].ut[slotData.slot]:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", RIGHT_STRING_X_OFFSET,
            UT_STRING_Y_OFFSET)
    end

end

function CPUT.CPUTUI:CreateItemLevelTextOverlay(slotData, besideIcon, unit)

    local slotName = slotData.slotName
    if (unit == "target") then
        slotName = slotData.slotInspectName
    end

    local parentFrame = _G[slotName]
    if (besideIcon) then
        parentFrame = _G["CPUT_" .. slotName .. "_BG"]
    end

    local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("itemLevelFont"))

    overlayTexts[unit].il[slotData.slot] = parentFrame:CreateFontString("CPUT_IL_" .. slotName, "OVERLAY")
    overlayTexts[unit].il[slotData.slot]:SetFont(font, 11, "OUTLINE, THICK")
    overlayTexts[unit].il[slotData.slot]:SetText(slotData.ilString)
    overlayTexts[unit].il[slotData.slot]:SetTextColor(slotData.color.r, slotData.color.g, slotData.color.b)

    -- position string on top of icon
    if not besideIcon then
        overlayTexts[unit].il[slotData.slot]:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", 0, IL_STRING_Y_OFFSET)
        return
    end

    -- position string beside icon
    if slotData.besidePosition == "left" then
        overlayTexts[unit].il[slotData.slot]:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", LEFT_STRING_X_OFFSET,
            IL_STRING_Y_OFFSET)
    else
        overlayTexts[unit].il[slotData.slot]:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", RIGHT_STRING_X_OFFSET,
            IL_STRING_Y_OFFSET)
    end

end

function CPUT.CPUTUI:CreateEnchantTextOverlay(slotData, besideIcon, unit)

    local slotName = slotData.slotName
    if (unit == "target") then
        slotName = slotData.slotInspectName
    end

    local parentFrame = _G[slotName]
    if (besideIcon) then
        parentFrame = _G["CPUT_" .. slotName .. "_BG"]
    end

    local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("itemLevelFont"))

    overlayTexts[unit].enchants[slotData.slot] = parentFrame:CreateFontString("CPUT_EN_" .. slotName, "OVERLAY")
    overlayTexts[unit].enchants[slotData.slot]:SetFont(font, 11, "OUTLINE, THICK")
    overlayTexts[unit].enchants[slotData.slot]:SetText(slotData.enchantedString)
    overlayTexts[unit].enchants[slotData.slot]:SetTextColor(slotData.color.r, slotData.color.g, slotData.color.b)

    -- position string on top of icon
    if not besideIcon then
        overlayTexts[unit].enchants[slotData.slot]:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", 0, EN_STRING_Y_OFFSET)
        return
    end

    -- position string beside icon
    if slotData.besidePosition == "left" then
        overlayTexts[unit].enchants[slotData.slot]:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", LEFT_STRING_X_OFFSET,
            EN_STRING_Y_OFFSET)
    else
        overlayTexts[unit].enchants[slotData.slot]:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", RIGHT_STRING_X_OFFSET,
            EN_STRING_Y_OFFSET)
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

    if besideIcon then
        setBackgroundSlot(slotData)
    end

    if CPUT.settings:GetSettingsValue("showUpgradeTrack") then
        self:CreateUpgradeTrackTextOverlay(slotData, besideIcon, unit)
    end
    if CPUT.settings:GetSettingsValue("showItemLevel") then
        self:CreateItemLevelTextOverlay(slotData, besideIcon, unit)
    end
    if CPUT.settings:GetSettingsValue("showEnchants") then
        self:CreateEnchantTextOverlay(slotData, besideIcon, unit)
    end
end

function CPUT.CPUTUI:ShowInspectItemLevel(itemLevel)

    local slotFrame = _G["InspectHandsSlot"]

    local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("itemLevelFont"))

    overlayTexts.target.itemLevel = slotFrame:CreateFontString(nil, "OVERLAY")
    overlayTexts.target.itemLevel:SetFont(font, 11, "OUTLINE, THICK")
    overlayTexts.target.itemLevel:SetText("Item Level: \n" .. itemLevel)
    overlayTexts.target.itemLevel:SetTextColor(1, 1, 1)
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
            if (overlayTexts.player.enchants[slot]) then
                overlayTexts.player.enchants[slot]:Hide()
                overlayTexts.player.enchants[slot] = nil
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
            if (overlayTexts.target.enchants[slot]) then
                overlayTexts.target.enchants[slot]:Hide()
                overlayTexts.target.enchants[slot] = nil
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

function setBackgroundSlot(slotData)
    local slotName = slotData.slotName
    if (slotData.unit == "target") then
        slotName = slotData.slotInspectName
    end

    if _G["CPUT_" .. slotName .. "_BG"] then
        return
    end

    local slotName = slotData.slotName
    if (unit == "target") then
        slotName = slotData.slotInspectName
    end

    local slotFrame = _G[slotName]

    local f = CreateFrame("Frame", "CPUT_" .. slotName .. "_BG", slotFrame)

    f:SetSize(64, 38)
    f.tex = f:CreateTexture()
    f.tex:SetAllPoints()
    f.tex:SetColorTexture(1, 1, 1, 1)

    if slotData.besidePosition == "left" then
        local startColor = CreateColor(0.1, 0.1, 0.1, 0.2)
        local endColor = CreateColor(0.1, 0.1, 0.1, 1)
        f.tex:SetGradient("HORIZONTAL", startColor, endColor)
        f:SetPoint("TOPRIGHT", slotFrame, "TOPLEFT", -10, 0)
    else
        local startColor = CreateColor(0.1, 0.1, 0.1, 1)
        local endColor = CreateColor(0, 0, 0, 0.2)
        f.tex:SetGradient("HORIZONTAL", startColor, endColor)
        f:SetPoint("TOPLEFT", slotFrame, "TOPRIGHT", 10, 0)
    end

end
