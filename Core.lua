CPUT = {}
CPUT = _G.LibStub("AceAddon-3.0"):NewAddon(CPUT, "CPUT", "AceEvent-3.0")

function CPUT:OnInitialize()
    -- initialize settings
    CPUT.settings:InitializeBlizOptions()
end

function CPUT:OnEnable()
    CharacterFrame:HookScript("OnShow", CPUT.UpdateEquipmentSlots)
    self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
    if CPUT.settings:GetSettingsValue("showOnInspect") then
        self:RegisterEvent("INSPECT_READY", CPUT.UpdateInspectPanel)
    end
end

function CPUT:PLAYER_EQUIPMENT_CHANGED()
    --
    self:UpdateEquipmentSlots()
end

function CPUT:UpdateEquipmentSlots()
    CPUT.CPUTUI:ClearItemSlots()
    local slotData = {}
    for slot, _ in pairs(CPUT.Constants:getEquipmentSlots()) do
        CPUT.CPUTUI:UpdateSlot(slot, slotData, "player")
    end
end

function CPUT:UpdateInspectPanel()
    CPUT.CPUTUI:ClearItemSlots()
    local slotData = {}
    for slot, _ in pairs(CPUT.Constants:getEquipmentSlots()) do
        CPUT.CPUTUI:UpdateSlot(slot, slotData, "target")
    end
end
