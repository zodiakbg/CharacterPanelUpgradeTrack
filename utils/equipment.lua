local addonName, addon = ...

addon.equipment = {}

function addon.equipment.UpdateEquipmentSlots()
	addon.ui.ClearItemSlots()
	for slot, slotName in pairs(addon.CHARATER_PANEL_ITEM_SLOTS_MAPPING) do
		local function loop(slot, slotName)
			local itemLink = GetInventoryItemLink("player", slot)
			local upgradeTrackInfo =
				addon.tooltip.ExtractUpgradeTrackInfoFromTooltip(C_TooltipInfo.GetInventoryItem("player", slot))
			if not upgradeTrackInfo then
				return
			end
			addon.ui.UpdateCharacterPanelItemSlot(slot, upgradeTrackInfo.upgradeTrackStr, upgradeTrackInfo.color)
		end
		loop(slot, slotName)
	end
end
