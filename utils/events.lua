local addonName, addon = ...

addon.events = {}

function OnCharacterPanelOpened()
    addon.debug("Character panel opened!")
    addon.equipment.UpdateEquipmentSlots()
end

function OnEquipmentChanged()
    addon.debug("Gear updated!")
    addon.equipment.UpdateEquipmentSlots()
end

function addon.events.RegisterEvents()
    CharacterFrame:HookScript("OnShow", OnCharacterPanelOpened)
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
    frame:SetScript(
        "OnEvent",
        function(self, event, slotID)
            if event == "PLAYER_EQUIPMENT_CHANGED" then
                OnEquipmentChanged()
            end
        end
    )
end
