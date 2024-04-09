#include "script_component.hpp"

// Common Settings
[QGVAR(allowDigging), "CHECKBOX", [LLSTRING(settingAllowDigging_displayName), LLSTRING(settingAllowDigging_tooltip)], LLSTRING(settingCategory), true, true] call CBA_fnc_addSetting;
[QGVAR(allowCamouflage), "CHECKBOX", [LLSTRING(settingAllowCamouflage_displayName), LLSTRING(settingAllowCamouflage_tooltip)], LLSTRING(settingCategory), true, true] call CBA_fnc_addSetting;
[QGVAR(camouflageRequireEntrenchmentTool), "CHECKBOX", [LLSTRING(settingCamouflageRequireEntrenchmentTool_displayName), LLSTRING(settingCamouflageRequireEntrenchmentTool_tooltip)], LLSTRING(settingCategory), true, true] call CBA_fnc_addSetting;
[QGVAR(stopBuildingAtFatigueMax), "CHECKBOX", [LLSTRING(stopBuildingAtFatigueMax_displayName), LLSTRING(stopBuildingAtFatigueMax_tooltip)], LLSTRING(settingCategory), true, true] call CBA_fnc_addSetting;
[QGVAR(buildFatigueFactor), "SLIDER", [LLSTRING(settingBuildFatigueFactor_displayName), LLSTRING(settingBuildFatigueFactor_tooltip)], LLSTRING(settingCategory), [0, 5, 1, 2], true] call CBA_fnc_addSetting;
[QGVAR(createTrenchMarker), "CHECKBOX", [LLSTRING(createTrenchMarker_displayName), LLSTRING(createTrenchMarker_tooltip)], LLSTRING(settingCategory), false, true, {}, true] call CBA_fnc_addSetting;
//[QGVAR(allowDiggingInVehicle), "CHECKBOX", [LLSTRING(allowDiggingInVehicle_displayName), LLSTRING(allowDiggingInVehicle_tooltip)], LLSTRING(settingCategory), true, true, {}, true] call CBA_fnc_addSetting;
[QGVAR(allowEffects), "CHECKBOX", [LLSTRING(allowEffects_displayName), LLSTRING(allowEffects_tooltip)], LLSTRING(settingCategory), true, true, {}, true] call CBA_fnc_addSetting;

// Texture Lock
[QGVAR(allowTextureLock), "CHECKBOX", [LLSTRING(allowTextureLock_displayName), LLSTRING(allowTextureLock_tooltip)], LLSTRING(settingCategory), true, true, {}, true] call CBA_fnc_addSetting;
[QGVAR(textureLockDistance), "SLIDER", LLSTRING(textureLockDistance), [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [0.1, 50, 5, 1], true] call CBA_fnc_addSetting;

// Trench specific settings
[QGVAR(allowShortEnvelope), "CHECKBOX", [LLSTRING(allowShortEnvelope_displayName), LLSTRING(allowShortEnvelope_tooltip)], [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(shortEnvelopeDigTime), "SLIDER", LLSTRING(ShortEnvelopeDigTime), [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [5, 300, 15, 0], true] call CBA_fnc_addSetting;
[QGVAR(shortEnvelopeRemovalTime), "SLIDER", [LLSTRING(ShortEnvelopeRemovalTime), LLSTRING(EnvelopeRemovalTime_tooltip)], [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [-1, 300, -1, 0], true] call CBA_fnc_addSetting;
[QGVAR(allowSmallEnvelope), "CHECKBOX", [LLSTRING(allowSmallEnvelope_displayName), LLSTRING(allowSmallEnvelope_tooltip)], [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(smallEnvelopeDigTime), "SLIDER", LLSTRING(SmallEnvelopeDigTime), [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [5, 450, 30, 0], true] call CBA_fnc_addSetting;
[QGVAR(smallEnvelopeRemovalTime), "SLIDER", [LLSTRING(SmallEnvelopeRemovalTime), LLSTRING(EnvelopeRemovalTime_tooltip)], [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [-1, 450, -1, 0], true] call CBA_fnc_addSetting;
[QGVAR(allowBigEnvelope), "CHECKBOX", [LLSTRING(allowBigEnvelope_displayName), LLSTRING(allowBigEnvelope_tooltip)], [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(bigEnvelopeDigTime), "SLIDER", LLSTRING(BigEnvelopeDigTime), [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [5, 600, 40, 0], true] call CBA_fnc_addSetting;
[QGVAR(bigEnvelopeRemovalTime), "SLIDER", [LLSTRING(BigEnvelopeRemovalTime), LLSTRING(EnvelopeRemovalTime_tooltip)], [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [-1, 600, -1, 0], true] call CBA_fnc_addSetting;
[QGVAR(allowGiantEnvelope), "CHECKBOX", [LLSTRING(allowGiantEnvelope_displayName), LLSTRING(allowGiantEnvelope_tooltip)], [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(giantEnvelopeDigTime), "SLIDER", LLSTRING(GiantEnvelopeDigTime), [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [5, 900, 90, 0], true] call CBA_fnc_addSetting;
[QGVAR(giantEnvelopeRemovalTime), "SLIDER", [LLSTRING(GiantEnvelopeRemovalTime), LLSTRING(EnvelopeRemovalTime_tooltip)], [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [-1, 900, -1, 0], true] call CBA_fnc_addSetting;
[QGVAR(allowVehicleEnvelope), "CHECKBOX", [LLSTRING(allowVehicleEnvelope_displayName), LLSTRING(allowVehicleEnvelope_tooltip)], [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(vehicleEnvelopeDigTime), "SLIDER", LLSTRING(VehicleEnvelopeDigTime), [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [5, 1200, 120, 0], true] call CBA_fnc_addSetting;
[QGVAR(vehicleEnvelopeRemovalTime), "SLIDER", [LLSTRING(VehicleEnvelopeRemovalTime), LLSTRING(EnvelopeRemovalTime_tooltip)], [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [-1, 1200, -1, 0], true] call CBA_fnc_addSetting;
[QGVAR(allowLongEnvelope), "CHECKBOX", [LLSTRING(allowLongEnvelope_displayName), LLSTRING(allowLongEnvelope_tooltip)], [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(LongEnvelopeDigTime), "SLIDER", LLSTRING(LongEnvelopeDigTime), [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [5, 1200, 100, 0], true] call CBA_fnc_addSetting;
[QGVAR(LongEnvelopeRemovalTime), "SLIDER", [LLSTRING(LongEnvelopeRemovalTime), LLSTRING(EnvelopeRemovalTime_tooltip)], [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [-1, 1200, -1, 0], true] call CBA_fnc_addSetting;

// Trench hit damage multiplier
[QGVAR(smallEnvelopeDamageMultiplier), "SLIDER", LLSTRING(smallEnvelopeDamageMultiplier), [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [0.1, 10, 3, 1], true] call CBA_fnc_addSetting;
[QGVAR(shortEnvelopeDamageMultiplier), "SLIDER", LLSTRING(shortEnvelopeDamageMultiplier), [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [0.1, 10, 2, 1], true] call CBA_fnc_addSetting;
[QGVAR(bigEnvelopeDamageMultiplier), "SLIDER", LLSTRING(bigEnvelopeDamageMultiplier), [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [0.1, 10, 2, 1], true] call CBA_fnc_addSetting;
[QGVAR(giantEnvelopeDamageMultiplier), "SLIDER", LLSTRING(giantEnvelopeDamageMultiplier), [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [0.1, 10, 1, 1], true] call CBA_fnc_addSetting;
[QGVAR(vehicleEnvelopeDamageMultiplier), "SLIDER", LLSTRING(vehicleEnvelopeDamageMultiplier), [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [0.1, 10, 1, 1], true] call CBA_fnc_addSetting;

// Trench decay settings
[QGVAR(allowTrenchDecay), "CHECKBOX", [LLSTRING(allowTrenchDecay_displayName), LLSTRING(allowTrenchDecay_tooltip)], [LLSTRING(settingCategory), LLSTRING(decaySubCategory)], false, true] call CBA_fnc_addSetting;
[QGVAR(timeoutToDecay), "SLIDER", [LLSTRING(timeoutToDecay_displayName), LLSTRING(timeoutToDecay_tooltip)], [LLSTRING(settingCategory), LLSTRING(decaySubCategory)], [60, 18000, 7200, 0], true] call CBA_fnc_addSetting;
[QGVAR(decayTime), "SLIDER", [LLSTRING(decayTime_displayName), LLSTRING(decayTime_tooltip)], [LLSTRING(settingCategory), LLSTRING(decaySubCategory)], [30, 3600, 1800, 0], true] call CBA_fnc_addSetting;
[QGVAR(playersInAreaRadius), "SLIDER", [LLSTRING(playersInAreaRadius_displayName), LLSTRING(playersInAreaRadius_tooltip)], [LLSTRING(settingCategory), LLSTRING(decaySubCategory)], [0, 1000, 0, 0], true] call CBA_fnc_addSetting;

// Trench hit degradation setting
[QGVAR(allowHitDecay), "CHECKBOX", [LLSTRING(allowHitDecay_displayName), LLSTRING(allowHitDecay_tooltip)], [LLSTRING(settingCategory), LLSTRING(hitDecaySubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(hitDecayMultiplier), "SLIDER", [LLSTRING(hitDecayMultiplier_displayName), LLSTRING(hitDecayMultiplier_tooltip)], [LLSTRING(settingCategory), LLSTRING(hitDecaySubCategory)], [0.1, 10, 1, 1], true] call CBA_fnc_addSetting;

// Vehicle Trench Build Speed
[QGVAR(vehicleTrenchBuildSpeed), "SLIDER", [LLSTRING(vehicleTrenchBuildSpeed_displayName), LLSTRING(vehicleTrenchBuildSpeed_tooltip)], [LLSTRING(settingCategory), LLSTRING(vehicleTrenchBuildSubCategory)], [1, 30, 5, 0], true] call CBA_fnc_addSetting;
