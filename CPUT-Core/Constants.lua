CPUT.Constants = CPUT:NewModule("Constants")

local slots = {}

slots[1] = {
    name = "CharacterHeadSlot",
    inspectName = "InspectHeadSlot",
    besidePosition = "right"
}
slots[2] = {
    name = "CharacterNeckSlot",
    inspectName = "InspectNeckSlot",
    besidePosition = "right"
}
slots[3] = {
    name = "CharacterShoulderSlot",
    inspectName = "InspectShoulderSlot",
    besidePosition = "right"
}
slots[5] = {
    name = "CharacterChestSlot",
    inspectName = "InspectChestSlot",
    besidePosition = "right"
}
slots[6] = {
    name = "CharacterWaistSlot",
    inspectName = "InspectWaistSlot",
    besidePosition = "left"
}
slots[7] = {
    name = "CharacterLegsSlot",
    inspectName = "InspectLegsSlot",
    besidePosition = "left"
}
slots[8] = {
    name = "CharacterFeetSlot",
    inspectName = "InspectFeetSlot",
    besidePosition = "left"
}
slots[9] = {
    name = "CharacterWristSlot",
    inspectName = "InspectWristSlot",
    besidePosition = "right"
}
slots[10] = {
    name = "CharacterHandsSlot",
    inspectName = "InspectHandsSlot",
    besidePosition = "left"
}
slots[11] = {
    name = "CharacterFinger0Slot",
    inspectName = "InspectFinger0Slot",
    besidePosition = "left"
}
slots[12] = {
    name = "CharacterFinger1Slot",
    inspectName = "InspectFinger1Slot",
    besidePosition = "left"
}
slots[13] = {
    name = "CharacterTrinket0Slot",
    inspectName = "InspectTrinket0Slot",
    besidePosition = "left"
}
slots[14] = {
    name = "CharacterTrinket1Slot",
    inspectName = "InspectTrinket1Slot",
    besidePosition = "left"
}
slots[15] = {
    name = "CharacterBackSlot",
    inspectName = "InspectBackSlot",
    besidePosition = "right"
}
slots[16] = {
    name = "CharacterMainHandSlot",
    inspectName = "InspectMainHandSlot",
    besidePosition = "left"
}
slots[17] = {
    name = "CharacterSecondaryHandSlot",
    inspectName = "InspectSecondaryHandSlot",
    besidePosition = "right"
}

local UPGRADE_LEVEL_STRING = {};
UPGRADE_LEVEL_STRING.enUS = "Upgrade Level: ";
UPGRADE_LEVEL_STRING.frFR = "Niveau d’amélioration : ";
UPGRADE_LEVEL_STRING.deDE = "Stufe aufwerten: ";
UPGRADE_LEVEL_STRING.esES = "Nivel de mejora: ";
UPGRADE_LEVEL_STRING.itIT = "Livello di potenziamento: ";
UPGRADE_LEVEL_STRING.ptBR = "Nível de aprimoramento: ";

local ENCHANTED_STRING = {};
ENCHANTED_STRING.enUS = "Enchanted: ";
ENCHANTED_STRING.frFR = "Enchanted: ";
ENCHANTED_STRING.deDE = "Enchanted: ";
ENCHANTED_STRING.esES = "Enchanted: ";
ENCHANTED_STRING.itIT = "Enchanted: ";
ENCHANTED_STRING.ptBR = "Enchanted: ";

local ITEM_LEVEL_STRING = {};
ITEM_LEVEL_STRING.enUS = "Item Level";
ITEM_LEVEL_STRING.frFR = "Item Level";
ITEM_LEVEL_STRING.deDE = "Item Level";
ITEM_LEVEL_STRING.esES = "Item Level";
ITEM_LEVEL_STRING.itIT = "Item Level";
ITEM_LEVEL_STRING.ptBR = "Item Level";

local SEASON_1 = {};
SEASON_1.enUS = "Season 1";
SEASON_1.frFR = "Saison 1";
SEASON_1.deDE = "Saison 1";
SEASON_1.esES = "Temporada 1";
SEASON_1.itIT = "Stagione 1";
SEASON_1.ptBR = "Série 1";

local RESHII_WRAPS = {};
RESHII_WRAPS.enUS = "Reshii Wraps";
RESHII_WRAPS.frFR = "Reshii Wraps";
RESHII_WRAPS.deDE = "Reshii Wraps";
RESHII_WRAPS.esES = "Reshii Wraps";
RESHII_WRAPS.itIT = "Reshii Wraps";
RESHII_WRAPS.ptBR = "Reshii Wraps";

local DISC = {};
DISC.enUS = "Durable Information Securing Container";
DISC.frFR = "Durable Information Securing Container";
DISC.deDE = "Durable Information Securing Container";
DISC.esES = "Durable Information Securing Container";
DISC.itIT = "Durable Information Securing Container";
DISC.ptBR = "Durable Information Securing Container";

local UPGRADE_TRACKS = {}
UPGRADE_TRACKS.enUS = {
    ["Explorer"] = "Exp",
    ["Adventurer"] = "Adv",
    ["Veteran"] = "Vet",
    ["Champion"] = "Cha",
    ["Hero"] = "Hero",
    ["Myth"] = "Myth"
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

function CPUT.Constants:getEnchantedString(locale)
    return ENCHANTED_STRING[locale]
end

function CPUT.Constants:getReshiiWrapsString(locale)
    return RESHII_WRAPS[locale]
end

function CPUT.Constants:getDiscString(locale)
    return DISC[locale]
end

function CPUT.Constants:getUpgradeTrackAbbr(locale, track)
    return UPGRADE_TRACKS[locale][track]
end

