local addonName, addon = ...

addon.tooltip = {}

local locale = GetLocale();
if not locale then 
    locale = "enUS"
end

if not addon.strings.UPGRADE_LEVEL_STRING[locale] then
    print("Unsupported locale: " .. locale .. ". Addon [CharacterPanelUpgradeTrack] disabled.")
    return -- Gracefully stop the addon
end

function startsWith(str, prefix)
    return string.sub(str, 1, string.len(prefix)) == prefix
end

local function findUpgradeLevelLine(lines)
    for _, line in ipairs(lines) do
        if line.leftText and startsWith(line.leftText, addon.strings.UPGRADE_LEVEL_STRING[locale]) then
            return line
        end
    end
    return nil
end

function addon.tooltip.ExtractUpgradeTrackInfoFromTooltip(data)
    if type(data) ~= "table" or not data.lines then
        return
    end

    local colorData = data.lines[1].leftColor.r

    local line = findUpgradeLevelLine(data.lines)
    if not line then
        return
    end

    local upgradeTrackAndLevelStr = string.gsub(line.leftText, addon.strings.UPGRADE_LEVEL_STRING[locale], "")
    local upgradeTrackStr = string.sub(upgradeTrackAndLevelStr, 1, -5)

    return {
        upgradeTrackStr = addon.strings.UPGRADE_TRACKS[locale][upgradeTrackStr],
        color = {
            r = data.lines[1].leftColor.r,
            g = data.lines[1].leftColor.g,
            b = data.lines[1].leftColor.b
        },
        name = data.lines[1].leftText
    }
end
