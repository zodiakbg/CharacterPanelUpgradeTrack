local addonName, addon = ...

addon.ui = {}

local overlayTexts = {}

local function lightenColorNormalized(r, g, b, percentage)
    -- Ensure percentage is between 0 and 1
    percentage = math.max(0, math.min(percentage, 1))

    -- Lighten each color component
    r = r + (1 - r) * percentage
    g = g + (1 - g) * percentage
    b = b + (1 - b) * percentage

    -- Clamp values to ensure they stay in range [0, 1]
    r = math.min(1, r)
    g = math.min(1, g)
    b = math.min(1, b)

    return r, g, b
end

local function CreateItemTextOverlay(slot, slotFrame, text, color)
    local _lightenPercentage = 0.2
    local _offset = -3
    if not color then
        color = {r = 1, g = 1, b = 1}
    end

    overlayTexts[slot] = slotFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")

    overlayTexts[slot]:SetPoint("TOP", slotFrame, "TOP", 0, -2)
    overlayTexts[slot]:SetText(text)
    overlayTexts[slot]:SetTextColor(lightenColorNormalized(color.r, color.g, color.b, _lightenPercentage))
    overlayTexts[slot]:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE, THICK")

    return overlayTexts[slot]
end

function addon.ui.UpdateCharacterPanelItemSlot(slot, text, color)
    local slotName = addon.CHARATER_PANEL_ITEM_SLOTS_MAPPING[slot]
    addon.debug("updating frame for slot: [" .. slotName .. "-" .. slot .. "] with text: [" .. text .. "]")

    local slotFrame = _G[slotName]
    if slotFrame and slotFrame:IsShown() then
        CreateItemTextOverlay(slot, slotFrame, text, color)
    end
end

function addon.ui.ClearItemSlots()
    for slot, text in pairs(overlayTexts) do
        overlayTexts[slot]:Hide() -- Hide the old text if it exists
        overlayTexts[slot] = nil -- Unload the old instance by setting it to nil
    end
end
