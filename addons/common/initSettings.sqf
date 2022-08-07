// Common Settings
[QGVAR(allowDigging), "CHECKBOX", [LLSTRING(settingAllowDigging_displayName), LLSTRING(settingAllowDigging_tooltip)], LLSTRING(settingCategory), true, true] call CBA_fnc_addSetting;
[QGVAR(allowCamouflage), "CHECKBOX", [LLSTRING(settingAllowCamouflage_displayName), LLSTRING(settingAllowCamouflage_tooltip)], LLSTRING(settingCategory), true, true] call CBA_fnc_addSetting;
[QGVAR(camouflageRequireEntrenchmentTool), "CHECKBOX", [LLSTRING(settingCamouflageRequireEntrenchmentTool_displayName), LLSTRING(settingCamouflageRequireEntrenchmentTool_tooltip)], LLSTRING(settingCategory), true, true] call CBA_fnc_addSetting;
[QGVAR(stopBuildingAtFatigueMax), "CHECKBOX", [LLSTRING(stopBuildingAtFatigueMax_displayName), LLSTRING(stopBuildingAtFatigueMax_tooltip)], LLSTRING(settingCategory), true, true] call CBA_fnc_addSetting;
[QGVAR(buildFatigueFactor), "SLIDER", [LLSTRING(settingBuildFatigueFactor_displayName), LLSTRING(settingBuildFatigueFactor_tooltip)], LLSTRING(settingCategory), [0, 5, 1, 2], true] call CBA_fnc_addSetting;
[QGVAR(createTrenchMarker), "CHECKBOX", [LLSTRING(createTrenchMarker_displayName), LLSTRING(createTrenchMarker_tooltip)], LLSTRING(settingCategory), false, true, {}, true] call CBA_fnc_addSetting;
//[QGVAR(allowDiggingInVehicle), "CHECKBOX", [LLSTRING(allowDiggingInVehicle_displayName), LLSTRING(allowDiggingInVehicle_tooltip)], LLSTRING(settingCategory), true, true, {}, true] call CBA_fnc_addSetting;
[QGVAR(allowEffects), "CHECKBOX", [LLSTRING(allowEffects_displayName), LLSTRING(allowEffects_tooltip)], LLSTRING(settingCategory), true, true, {}, true] call CBA_fnc_addSetting;

// Trench decay settings
[QGVAR(allowTrenchDecay), "CHECKBOX", [LLSTRING(allowTrenchDecay_displayName), LLSTRING(allowTrenchDecay_tooltip)], [LLSTRING(settingCategory), LLSTRING(decaySubCategory)], false, true] call CBA_fnc_addSetting;
[QGVAR(timeoutToDecay), "SLIDER", [LLSTRING(timeoutToDecay_displayName), LLSTRING(timeoutToDecay_tooltip)], [LLSTRING(settingCategory), LLSTRING(decaySubCategory)], [60, 18000, 7200, 0], true] call CBA_fnc_addSetting;
[QGVAR(decayTime), "SLIDER", [LLSTRING(decayTime_displayName), LLSTRING(decayTime_tooltip)], [LLSTRING(settingCategory), LLSTRING(decaySubCategory)], [30, 3600, 1800, 0], true] call CBA_fnc_addSetting;
[QGVAR(playersInAreaRadius), "SLIDER", [LLSTRING(playersInAreaRadius_displayName), LLSTRING(playersInAreaRadius_tooltip)], [LLSTRING(settingCategory), LLSTRING(decaySubCategory)], [0, 1000, 0, 0], true] call CBA_fnc_addSetting;

// Trench hit degradation setting
[QGVAR(allowHitDecay), "CHECKBOX", [LLSTRING(allowHitDecay_displayName), LLSTRING(allowHitDecay_tooltip)], [LLSTRING(settingCategory), LLSTRING(hitDecaySubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(hitDecayMultiplier), "SLIDER", [LLSTRING(hitDecayMultiplier_displayName), LLSTRING(hitDecayMultiplier_tooltip)], [LLSTRING(settingCategory), LLSTRING(hitDecaySubCategory)], [0.1, 10, 1, 1], true] call CBA_fnc_addSetting;
