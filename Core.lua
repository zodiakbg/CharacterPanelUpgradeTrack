CPUT = {}
CPUT = _G.LibStub("AceAddon-3.0"):NewAddon(CPUT, "CPUT", "AceEvent-3.0")
CPUT.shown = false;
function CPUT:OnInitialize()
    -- initialize settings
    CPUT.settings:InitializeBlizOptions()
end

function CPUT:OnEnable()
    CharacterFrame:HookScript("OnShow", CPUT.onShowPlayerHandler)
    CharacterFrame:HookScript("OnHide", CPUT.onHidePlayerHandler)
    self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
    if CPUT.settings:GetSettingsValue("showOnInspect") then
        self:RegisterEvent("INSPECT_READY", CPUT.onShowInspectHandler)
    end
end

function CPUT:PLAYER_EQUIPMENT_CHANGED()

    if not CPUT.shown then
        return
    end
    self:UpdateEquipmentSlots()
end

function CPUT:onShowPlayerHandler()
    CPUT.Utils:debug("Show Player")
    CPUT.shown = true
    CPUT.UpdateEquipmentSlots()
end
function CPUT:onShowInspectHandler()
    CPUT.Utils:debug("Show Inspect")
    if InspectFrame then
        InspectFrame:HookScript("OnHide", CPUT.onHideInspectHandler)
    end
    CPUT.shown = true
    CPUT.UpdateInspectPanel()
end

function CPUT:onHidePlayerHandler()
    CPUT.Utils:debug("Hide Player")
    CPUT.shown = false
end

function CPUT:onHideInspectHandler()
    CPUT.Utils:debug("Hide Inspect")
    CPUT.shown = false
end

function CPUT:UpdateEquipmentSlots()
    if not CPUT.shown then
        return
    end
    CPUT.CPUTUI:ClearItemSlots("player")
    local slotData = {}
    for slot, _ in pairs(CPUT.Constants:getEquipmentSlots()) do
        CPUT.CPUTUI:UpdateSlot(slot, slotData, "player")
    end
end

function CPUT:UpdateInspectPanel(characterGUID)

    if not CPUT.shown then
        return
    end

    CPUT.inspectTimer = C_Timer.NewTimer(1, function()
        CPUT.CPUTUI:ClearItemSlots("inspect")
        local slotData = {}
        if not InspectFrame or not InspectFrame.unit then
            if CPUT.inspectTimer then
                CPUT.inspectTimer:Cancel()
            end
            return
        end
        for slot, _ in pairs(CPUT.Constants:getEquipmentSlots()) do
            CPUT.CPUTUI:UpdateSlot(slot, slotData, InspectFrame.unit)
        end
        if CPUT.settings:GetSettingsValue("showAvgIlvlOnInspect") then
            local avgItemLevel = C_PaperDollInfo.GetInspectItemLevel(InspectFrame.unit)
            if avgItemLevel > 0 and CPUT.inspectTimer then
                CPUT.inspectTimer:Cancel()
            end
            CPUT.CPUTUI:ShowInspectItemLevel(avgItemLevel)
        end
    end)
end

