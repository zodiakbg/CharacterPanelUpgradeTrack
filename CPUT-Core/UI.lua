CPUT.CPUTUI = CPUT:NewModule("CPUTUI")

local LSM = LibStub("LibSharedMedia-3.0")

local overlayTexts = {}
overlayTexts.player = {}
overlayTexts.inspect = {}
overlayTexts.player.ut = {}
overlayTexts.player.il = {}
overlayTexts.player.enchants = {}
overlayTexts.inspect.ut = {}
overlayTexts.inspect.il = {}
overlayTexts.inspect.enchants = {}

local UT_STRING_Y_OFFSET = -3
local IL_STRING_Y_OFFSET = -13
local EN_STRING_Y_OFFSET = -21

local LEFT_STRING_X_OFFSET = -3
local RIGHT_STRING_X_OFFSET = 3

function CPUT.CPUTUI:CreateUpgradeTrackTextOverlay(slotData, besideIcon, unit)

    local overlayTextsId = "player"
    local slotName = slotData.slotName

    if (unit ~= "player") then
        overlayTextsId = "inspect"
        slotName = slotData.slotInspectName
    end

    if not slotName then
        return
    end

    local parentFrame = _G[slotName]
    if (besideIcon) then
        parentFrame = _G["CPUT_" .. slotName .. "_BG"]
    end

    if not parentFrame then
        return
    end

    local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("upgradeTrackFont"))

    overlayTexts[overlayTextsId].ut[slotData.slot] = parentFrame:CreateFontString("CPUT_UT_" .. slotName, "OVERLAY")
    overlayTexts[overlayTextsId].ut[slotData.slot]:SetFont(font, 11, "OUTLINE, THICK")
    overlayTexts[overlayTextsId].ut[slotData.slot]:SetText(slotData.utString)
    overlayTexts[overlayTextsId].ut[slotData.slot]:SetTextColor(slotData.color.r, slotData.color.g, slotData.color.b)

    -- position string on top of icon
    if not besideIcon then
        overlayTexts[overlayTextsId].ut[slotData.slot]:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", 0,
            UT_STRING_Y_OFFSET)
        return
    end

    -- position string beside icon
    if slotData.besidePosition == "left" then
        overlayTexts[overlayTextsId].ut[slotData.slot]:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT",
            LEFT_STRING_X_OFFSET, UT_STRING_Y_OFFSET)
    else
        overlayTexts[overlayTextsId].ut[slotData.slot]:SetPoint("TOPLEFT", parentFrame, "TOPLEFT",
            RIGHT_STRING_X_OFFSET, UT_STRING_Y_OFFSET)
    end

end

function CPUT.CPUTUI:CreateItemLevelTextOverlay(slotData, besideIcon, unit)

    local overlayTextsId = "player"
    local slotName = slotData.slotName
    if (unit ~= "player") then
        slotName = slotData.slotInspectName
        overlayTextsId = "inspect"
    end

    local parentFrame = _G[slotName]
    if (besideIcon) then
        parentFrame = _G["CPUT_" .. slotName .. "_BG"]
    end

    if not parentFrame then
        return
    end

    local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("itemLevelFont"))

    overlayTexts[overlayTextsId].il[slotData.slot] = parentFrame:CreateFontString("CPUT_IL_" .. slotName, "OVERLAY")
    overlayTexts[overlayTextsId].il[slotData.slot]:SetFont(font, 11, "OUTLINE, THICK")
    overlayTexts[overlayTextsId].il[slotData.slot]:SetText(slotData.ilString)
    overlayTexts[overlayTextsId].il[slotData.slot]:SetTextColor(slotData.color.r, slotData.color.g, slotData.color.b)

    -- position string on top of icon
    if not besideIcon then
        overlayTexts[overlayTextsId].il[slotData.slot]:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", 0,
            IL_STRING_Y_OFFSET)
        return
    end

    -- position string beside icon
    if slotData.besidePosition == "left" then
        overlayTexts[overlayTextsId].il[slotData.slot]:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT",
            LEFT_STRING_X_OFFSET, IL_STRING_Y_OFFSET)
    else
        overlayTexts[overlayTextsId].il[slotData.slot]:SetPoint("TOPLEFT", parentFrame, "TOPLEFT",
            RIGHT_STRING_X_OFFSET, IL_STRING_Y_OFFSET)
    end

end

function CPUT.CPUTUI:CreateEnchantTextOverlay(slotData, besideIcon, unit)
    local overlayTextsId = "player"
    local slotName = slotData.slotName
    if (unit ~= "player") then
        slotName = slotData.slotInspectName
        overlayTextsId = "inspect"
    end

    local parentFrame = _G[slotName]
    if (besideIcon) then
        parentFrame = _G["CPUT_" .. slotName .. "_BG"]
    end

    if not parentFrame then
        return
    end

    if slotData.enchantedString then
        local pipeIndex = string.find(slotData.enchantedString, "|", 1, true)
        if pipeIndex then
            slotData.enchantedString = string.sub(slotData.enchantedString, 1, pipeIndex - 1)
        end
        slotData.enchantedString = string.sub(slotData.enchantedString, 1, 15)
    end

    local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("itemLevelFont"))

    overlayTexts[overlayTextsId].enchants[slotData.slot] = parentFrame:CreateFontString("CPUT_EN_" .. slotName,
        "OVERLAY")
    overlayTexts[overlayTextsId].enchants[slotData.slot]:SetFont(font, 11, "OUTLINE, THICK")
    overlayTexts[overlayTextsId].enchants[slotData.slot]:SetText(slotData.enchantedString)
    overlayTexts[overlayTextsId].enchants[slotData.slot]:SetTextColor(slotData.color.r, slotData.color.g,
        slotData.color.b)

    -- position string on top of icon
    if not besideIcon then
        overlayTexts[overlayTextsId].enchants[slotData.slot]:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", 0,
            EN_STRING_Y_OFFSET)
        return
    end

    -- position string beside icon
    if slotData.besidePosition == "left" then
        overlayTexts[overlayTextsId].enchants[slotData.slot]:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT",
            LEFT_STRING_X_OFFSET, EN_STRING_Y_OFFSET)
    else
        overlayTexts[overlayTextsId].enchants[slotData.slot]:SetPoint("TOPLEFT", parentFrame, "TOPLEFT",
            RIGHT_STRING_X_OFFSET, EN_STRING_Y_OFFSET)
    end

end

function CPUT.CPUTUI:UpdateSlot(slot, slotData, unit)
    local slotData = CPUT.Utils:FetchItemSlotData(slot, unit)

    if not slotData then
        return
    end

    local besideIcon = false;
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

    if not overlayTexts.inspect.itemLevel then

        local slotFrame = _G["InspectHandsSlot"]
        if not slotFrame then
            return
        end
        local font = LSM:Fetch("font", CPUT.settings:GetSettingsValue("itemLevelFont"))
        overlayTexts.inspect.itemLevel = slotFrame:CreateFontString(nil, "OVERLAY")
        overlayTexts.inspect.itemLevel:SetFont(font, 14, "OUTLINE, THICK")
        overlayTexts.inspect.itemLevel:SetTextColor(1, 1, 1)
        overlayTexts.inspect.itemLevel:SetPoint("BOTTOMRIGHT", slotFrame, "TOPRIGHT", 0, 5)
    end
    overlayTexts.inspect.itemLevel:SetText("ILevel: \n" .. itemLevel)

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
        if (unit ~= "player") then
            if (overlayTexts.inspect.il[slot]) then
                overlayTexts.inspect.il[slot]:Hide()
                overlayTexts.inspect.il[slot] = nil
            end
            if (overlayTexts.inspect.ut[slot]) then
                overlayTexts.inspect.ut[slot]:Hide()
                overlayTexts.inspect.ut[slot] = nil
            end
            if (overlayTexts.inspect.enchants[slot]) then
                overlayTexts.inspect.enchants[slot]:Hide()
                overlayTexts.inspect.enchants[slot] = nil
            end
        end
    end
    if (unit ~= "player") then
        if (overlayTexts.inspect.itemLevel) then
            overlayTexts.inspect.itemLevel:Hide()
            overlayTexts.inspect.itemLevel = nil
        end
    end

end

function setBackgroundSlot(slotData)

    local slotName = slotData.slotName
    if (slotData.unit ~= "player") then
        slotName = slotData.slotInspectName
    end

    if _G["CPUT_" .. slotName .. "_BG"] then
        return
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
