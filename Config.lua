local _G = _G

CPUT.title = "CPUT"

-- Init CPUT setting module
CPUT.settings = CPUT:NewModule("Settings", "AceConsole-3.0")

-- Ace option config table
local aceConfig = _G.LibStub("AceConfig-3.0")
local aceDialog = _G.LibStub("AceConfigDialog-3.0")

local function GetProfileOption(info)
    return CPUT.settings.profile[info[#info]]
end

local function SetProfileOption(info, value)
    CPUT.settings.profile[info[#info]] = value
end

function CPUT.settings:InitializeBlizOptions()
    self:InitializeSettings()
    self:CreateBlizzOptions()

    self:RegisterChatCommand("cput", self.SlashCommand)
end

function CPUT.settings:InitializeSettings()
    local settingsDBDefaults = {
        profile = {
            -- upgrade track
            showUpgradeTrack = true,
            -- item level
            showItemLevel = true
        }
    }

    SettingsDB = LibStub("AceDB-3.0"):New("CPUTSettings", settingsDBDefaults)
    SettingsDB.RegisterCallback(self, "OnProfileChanged", "RefreshProfile")
    SettingsDB.RegisterCallback(self, "OnProfileCopied", "RefreshProfile")
    SettingsDB.RegisterCallback(self, "OnProfileReset", "RefreshProfile")

    self.profile = SettingsDB.profile
end

function CPUT.settings:RefreshProfile()
    self.profile = SettingsDB.profile
    C_UI.Reload()
end

function CPUT.settings:CreateBlizzOptions()

    local optionsTable = {
        name = "Character Panel Upgrade Track",
        type = "group",
        args = {
            header_UpgradeTrack = {
                order = 10,
                type = "header",
                width = "full",
                name = "Upgrade Track String"
            },
            showUpgradeTrack = {
                order = 11,
                type = "toggle",
                width = 2,
                name = "Show Upgrade Track String",
                desc = "Toggles the upgrade track string on the icon",
                get = GetProfileOption,
                set = SetProfileOption
            },
            upgradeTrackFont = {
                order = 12,
                type = "select",
                name = "Font",
                width = 1.25,
                dialogControl = "LSM30_Font",
                values = LibStub("LibSharedMedia-3.0"):HashTable("font"),
                get = function()
                    return CPUT.settings:GetSettingsValue("upgradeTrackFont")
                end,
                set = SetProfileOption
            },
            header_ItemLevel = {
                order = 20,
                type = "header",
                width = "full",
                name = "Item Level String"
            },
            showItemLevel = {
                order = 21,
                type = "toggle",
                width = 2,
                name = "Show Item Level String",
                desc = "Toggles the item level string on the icon",
                get = GetProfileOption,
                set = SetProfileOption
            },
            itemLevelFont = {
                order = 22,
                type = "select",
                name = "Font",
                width = 1.25,
                dialogControl = "LSM30_Font",
                values = LibStub("LibSharedMedia-3.0"):HashTable("font"),
                get = function()
                    return CPUT.settings:GetSettingsValue("itemLevelFont")
                end,
                set = SetProfileOption
            },
            header_PrevSeasons = {
                order = 30,
                type = "header",
                width = "full",
                name = "Previous seasons"
            },
            grayOutPrevSeasons = {
                order = 31,
                type = "toggle",
                name = "Gray out previous seasons' items",
                desc = "If checked previous seasons' items will be grayed out",
                get = GetProfileOption,
                set = SetProfileOption
            }
        }

    }
    -- Register setting to the option table
    aceConfig:RegisterOptionsTable(CPUT.title, optionsTable)

    -- Add settings to bliz option
    CPUT.Options = aceDialog:AddToBlizOptions(CPUT.title, CPUT.title)

    -- add profile to bliz option
    aceConfig:RegisterOptionsTable(CPUT.title .. "/Profile", _G.LibStub("AceDBOptions-3.0"):GetOptionsTable(SettingsDB))
    aceDialog:AddToBlizOptions(CPUT.title .. "/Profile", "Profiles", CPUT.title)

end

function CPUT.settings:GetSettingsValue(key)
    if string.find(key, "font") then
        local font = CPUT.settings.profile[key]
        return LibStub("LibSharedMedia-3.0"):IsValid("font", font) and font or
                   LibStub("LibSharedMedia-3.0"):GetDefault("font")
    end
    return self.profile[key]
end
function CPUT.settings:SlashCommand()
    --
    Settings.OpenToCategory(CPUT.title)
end
