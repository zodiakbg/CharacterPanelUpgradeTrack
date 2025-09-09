CPUT.Constants = CPUT:NewModule("Constants")

local slots = {}

slots[1] = "CharacterHeadSlot"
slots[2] = "CharacterNeckSlot"
slots[3] = "CharacterShoulderSlot"
slots[5] = "CharacterChestSlot"
slots[6] = "CharacterWaistSlot"
slots[7] = "CharacterLegsSlot"
slots[8] = "CharacterFeetSlot"
slots[9] = "CharacterWristSlot"
slots[10] = "CharacterHandsSlot"
slots[11] = "CharacterFinger0Slot"
slots[12] = "CharacterFinger1Slot"
slots[13] = "CharacterTrinket0Slot"
slots[14] = "CharacterTrinket1Slot"
slots[15] = "CharacterBackSlot"
slots[16] = "CharacterMainHandSlot"
slots[17] = "CharacterSecondaryHandSlot"

local UPGRADE_LEVEL_STRING = {};
UPGRADE_LEVEL_STRING.enUS = "Upgrade Level: ";
UPGRADE_LEVEL_STRING.koKR = "레벨 강화: ";
UPGRADE_LEVEL_STRING.frFR = "Niveau d’amélioration : ";
UPGRADE_LEVEL_STRING.deDE = "Stufe aufwerten: ";
UPGRADE_LEVEL_STRING.esES = "Nivel de mejora: ";
UPGRADE_LEVEL_STRING.itIT = "Livello di potenziamento: ";
UPGRADE_LEVEL_STRING.ptBR = "Nível de aprimoramento: ";

local ITEM_LEVEL_STRING = {};
ITEM_LEVEL_STRING.enUS = "Item Level";
ITEM_LEVEL_STRING.koKR = "아이템 레벨";
ITEM_LEVEL_STRING.frFR = "Item Level";
ITEM_LEVEL_STRING.deDE = "Item Level";
ITEM_LEVEL_STRING.esES = "Item Level";
ITEM_LEVEL_STRING.itIT = "Item Level";
ITEM_LEVEL_STRING.ptBR = "Item Level";

local SEASON_1 = {};
SEASON_1.enUS = "Season 1";
SEASON_1.koKR = "1 시즌";
SEASON_1.frFR = "Saison 1";
SEASON_1.deDE = "Saison 1";
SEASON_1.esES = "Temporada 1";
SEASON_1.itIT = "Stagione 1";
SEASON_1.ptBR = "Série 1";

local RESHII_WRAPS = {};
RESHII_WRAPS.enUS = "Reshii Wraps";
RESHII_WRAPS.koKR = "레시 붕대";
RESHII_WRAPS.frFR = "Reshii Wraps";
RESHII_WRAPS.deDE = "Reshii Wraps";
RESHII_WRAPS.esES = "Reshii Wraps";
RESHII_WRAPS.itIT = "Reshii Wraps";
RESHII_WRAPS.ptBR = "Reshii Wraps";

local UPGRADE_TRACKS = {}
UPGRADE_TRACKS.enUS = {
    ["Explorer"] = "Exp",
    ["Adventurer"] = "Adv",
    ["Veteran"] = "Vet",
    ["Champion"] = "Cha",
    ["Hero"] = "Hero",
    ["Myth"] = "Myth"
};

UPGRADE_TRACKS.koKR = {
    ["탐험가"] = "탐험가",
    ["모험가"] = "모험가",
    ["노련가"] = "노련가",
    ["챔피언"] = "챔피언",
    ["영웅"] = "영웅",
    ["신화"] = "신화"
};

UPGRADE_TRACKS.frFR = {
    ["Explorateur"] = "Exp",
    ["Aventurier"] = "Adv",
    ["Vétéran"] = "Vet",
    ["Champion"] = "Cha",
    ["Héros"] = "Hero",
    ["Mythique"] = "Myth"
};
UPGRADE_TRACKS.deDE = {
    ["Forscher"] = "Exp",
    ["Abenteurer"] = "Adv",
    ["Veteran"] = "Vet",
    ["Champion"] = "Cha",
    ["Held"] = "Hero",
    ["Mythos"] = "Myth"
};
UPGRADE_TRACKS.esES = {
    ["Explorador"] = "Exp",
    ["Aventurero"] = "Adv",
    ["Veterano"] = "Vet",
    ["Campeón"] = "Cha",
    ["Héroe"] = "Hero",
    ["Mítico"] = "Myth"
};
UPGRADE_TRACKS.itIT = {
    ["Esploratore"] = "Exp",
    ["Avventuriero"] = "Adv",
    ["Veterano"] = "Vet",
    ["Campione"] = "Cha",
    ["Eroe"] = "Hero",
    ["Mitico"] = "Myth"
};
UPGRADE_TRACKS.ptBR = {
    ["Explorador"] = "Exp",
    ["Aventureiro"] = "Adv",
    ["Veterano"] = "Vet",
    ["Campeão"] = "Cha",
    ["Herói"] = "Hero",
    ["Mítico"] = "Myth"
};

function CPUT.Constants:getEquipmentSlot(slot)
    return slots[slot]
end

function CPUT.Constants:getEquipmentSlots()
    return slots
end

function CPUT.Constants:getUpgradeLevelString(locale)
    return UPGRADE_LEVEL_STRING[locale]
end

function CPUT.Constants:getItemLevelString(locale)
    return ITEM_LEVEL_STRING[locale]
end

function CPUT.Constants:getSeasonString(locale)
    return SEASON_1[locale]
end

function CPUT.Constants:getReshiiWraps(locale)
    return RESHII_WRAPS[locale]
end

function CPUT.Constants:getUpgradeTrackAbbr(locale, track)
    return UPGRADE_TRACKS[locale][track]
end
