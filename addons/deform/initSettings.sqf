// Trench specific settings
[QGVAR(allowFightingHoleEnvelope), "CHECKBOX", [LLSTRING(allowFightingHoleEnvelope_displayName), LLSTRING(allowFightingHoleEnvelope_tooltip)], [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], true, true] call CBA_fnc_addSetting;
[QGVAR(fightingHoleEnvelopeDigTime), "SLIDER", LLSTRING(FightingHoleEnvelopeDigTime), [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [5, 300, 15, 0], true] call CBA_fnc_addSetting;
[QGVAR(fightingHoleEnvelopeRemovalTime), "SLIDER", [LLSTRING(FightingHoleEnvelopeRemovalTime), LLSTRING(EnvelopeRemovalTime_tooltip)], [LLSTRING(settingCategory), LLSTRING(trenchSubCategory)], [-1, 300, -1, 0], true] call CBA_fnc_addSetting;
