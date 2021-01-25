//Common Settings
[QGVAR(allowDigging), "CHECKBOX", [localize LSTRING(settingAllowDigging_displayName), localize LSTRING(settingAllowDigging_tooltip)], localize LSTRING(settingCategory), true, true] call CBA_fnc_addSetting;
[QGVAR(allowCamouflage), "CHECKBOX", [localize LSTRING(settingAllowCamouflage_displayName), localize LSTRING(settingAllowCamouflage_tooltip)], localize LSTRING(settingCategory), true, true] call CBA_fnc_addSetting;
[QGVAR(camouflageRequireEntrenchmentTool), "CHECKBOX", [localize LSTRING(settingCamouflageRequireEntrenchmentTool_displayName), localize LSTRING(settingCamouflageRequireEntrenchmentTool_tooltip)], localize LSTRING(settingCategory), true, true] call CBA_fnc_addSetting;
[QGVAR(stopBuildingAtFatigueMax), "CHECKBOX", [localize LSTRING(stopBuildingAtFatigueMax_displayName), localize LSTRING(stopBuildingAtFatigueMax_tooltip)], localize LSTRING(settingCategory), true, true] call CBA_fnc_addSetting;
[QGVAR(buildFatigueFactor), "SLIDER", [localize LSTRING(settingBuildFatigueFactor_displayName), localize LSTRING(settingBuildFatigueFactor_tooltip)], localize LSTRING(settingCategory), [0, 5, 1, 2], true] call CBA_fnc_addSetting;

//Trench specific settings
[QGVAR(allowShortEnvelope), "CHECKBOX", [localize LSTRING(allowShortEnvelope_displayName), localize LSTRING(allowShortEnvelope_tooltip)], [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(shortEnvelopeDigTime), "SLIDER", localize LSTRING(ShortEnvelopeDigTime), [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], [5, 300, 15, 0], true] call CBA_fnc_addSetting;
[QGVAR(shortEnvelopeRemovalTime), "SLIDER", localize LSTRING(ShortEnvelopeRemovalTime), [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], [-1, 300, -1, 0], true] call CBA_fnc_addSetting;
[QGVAR(allowSmallEnvelope), "CHECKBOX", [localize LSTRING(allowSmallEnvelope_displayName), localize LSTRING(allowSmallEnvelope_tooltip)], [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(smallEnvelopeDigTime), "SLIDER", localize LSTRING(SmallEnvelopeDigTime), [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], [5, 450, 30, 0], true] call CBA_fnc_addSetting;
[QGVAR(smallEnvelopeRemovalTime), "SLIDER", localize LSTRING(SmallEnvelopeRemovalTime), [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], [-1, 450, -1, 0], true] call CBA_fnc_addSetting;
[QGVAR(allowBigEnvelope), "CHECKBOX", [localize LSTRING(allowBigEnvelope_displayName), localize LSTRING(allowBigEnvelope_tooltip)], [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(bigEnvelopeDigTime), "SLIDER", localize LSTRING(BigEnvelopeDigTime), [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], [5, 600, 40, 0], true] call CBA_fnc_addSetting;
[QGVAR(bigEnvelopeRemovalTime), "SLIDER", localize LSTRING(BigEnvelopeRemovalTime), [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], [-1, 600, -1, 0], true] call CBA_fnc_addSetting;
[QGVAR(allowGiantEnvelope), "CHECKBOX", [localize LSTRING(allowGiantEnvelope_displayName), localize LSTRING(allowGiantEnvelope_tooltip)], [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(giantEnvelopeDigTime), "SLIDER", localize LSTRING(GiantEnvelopeDigTime), [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], [5, 900, 90, 0], true] call CBA_fnc_addSetting;
[QGVAR(giantEnvelopeRemovalTime), "SLIDER", localize LSTRING(GiantEnvelopeRemovalTime), [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], [-1, 900, -1, 0], true] call CBA_fnc_addSetting;
[QGVAR(allowVehicleEnvelope), "CHECKBOX", [localize LSTRING(allowVehicleEnvelope_displayName), localize LSTRING(allowVehicleEnvelope_tooltip)], [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(vehicleEnvelopeDigTime), "SLIDER", localize LSTRING(VehicleEnvelopeDigTime), [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], [5, 1200, 120, 0], true] call CBA_fnc_addSetting;
[QGVAR(vehicleEnvelopeRemovalTime), "SLIDER", localize LSTRING(VehicleEnvelopeRemovalTime), [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], [-1, 1200, -1, 0], true] call CBA_fnc_addSetting;
[QGVAR(allowLongEnvelope), "CHECKBOX", [localize LSTRING(allowLongEnvelope_displayName), localize LSTRING(allowLongEnvelope_tooltip)], [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(LongEnvelopeDigTime), "SLIDER", localize LSTRING(LongEnvelopeDigTime), [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], [5, 1200, 100, 0], true] call CBA_fnc_addSetting;
[QGVAR(LongEnvelopeRemovalTime), "SLIDER", localize LSTRING(LongEnvelopeRemovalTime), [localize LSTRING(settingCategory), localize LSTRING(trenchSubCategory)], [-1, 1200, -1, 0], true] call CBA_fnc_addSetting;

//Trench decay settings
[QGVAR(allowTrenchDecay), "CHECKBOX", [localize LSTRING(allowTrenchDecay_displayName), localize LSTRING(allowTrenchDecay_tooltip)], [localize LSTRING(settingCategory), localize LSTRING(decaySubCategory)], false, true] call CBA_fnc_addSetting;
[QGVAR(timeoutToDecay), "SLIDER", [localize LSTRING(timeoutToDecay_displayName), localize LSTRING(timeoutToDecay_tooltip)], [localize LSTRING(settingCategory), localize LSTRING(decaySubCategory)], [60, 18000, 7200, 0], true] call CBA_fnc_addSetting;
[QGVAR(decayTime), "SLIDER", [localize LSTRING(decayTime_displayName), localize LSTRING(decayTime_tooltip)], [localize LSTRING(settingCategory), localize LSTRING(decaySubCategory)], [30, 3600, 1800, 0], true] call CBA_fnc_addSetting;
