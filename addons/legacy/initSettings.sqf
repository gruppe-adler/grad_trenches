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

// Vehicle Trench Build Speed
[QGVAR(vehicleTrenchBuildSpeed), "SLIDER", [LLSTRING(vehicleTrenchBuildSpeed_displayName), LLSTRING(vehicleTrenchBuildSpeed_tooltip)], [LLSTRING(settingCategory), LLSTRING(vehicleTrenchBuildSubCategory)], [1, 30, 5, 0], true] call CBA_fnc_addSetting;
