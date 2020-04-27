#include "script_component.hpp"
/*
 * Author: Salbei
 * Help digging trench.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, ACE_player] call grad_trenches_functions_fnc_addDigger
 *
 * Public: No
 */

params ["_trench", "_unit"];

private _diggersCount = count (_trench getVariable [QGVAR(diggers), []]);

if (_diggersCount < 1) exitWith {
    [_trench, _unit, true] call FUNC(continueDiggingTrench);
};

[QGVAR(addDigger), [_trench, _unit, false]] call CBA_fnc_serverEvent;

private _type = true;
private _digTime = missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> (typeOf _trench) >> "ace_trenches_diggingDuration"), 20];
private _condition = {(_trench getVariable ["ace_trenches_progress", 0]) >= 1};
_unit setVariable [QGVAR(diggingTrench), true];

if ((_trench getVariable [QGVAR(diggingType), nil]) isEqualTo "Down") then {
    _type = false;
    _condition = {(_trench getVariable ["ace_trenches_progress", 0]) <= 0};
};

[
    {
        params ["_args", "_handle"];
        _args params ["_unit", "_trench", "_condition"];

        if (_condition) then {
            [_handle] call CBA_fnc_removePerFrameHandler;
        };

        if (_unit getVariable [QGVAR(diggingTrench), false] && {(_trench getVariable [QGVAR(diggers),[]]) isEqualTo ace_player}) then {
            [_handle] call CBA_fnc_removePerFrameHandler;
            [_trench, _unit, true] call FUNC(continueDiggingTrench);
        };
    }, 
    1, 
    [_unit, _trench, _condition]
] call CBA_fnc_addPerFrameHandler;

// Create progress bar
private _fnc_onFinish = {
    (_this select 0) params ["_unit"];

    _unit setVariable [QGVAR(diggingTrench), false];

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};

private _fnc_onFailure = {
    (_this select 0) params ["_unit", "_trench"];

    [QGVAR(addDigger), [_trench, _unit, true]] call CBA_fnc_serverEvent;
    _unit setVariable [QGVAR(diggingTrench), false];

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};
private _fnc_condition = {
    (_this select 0) params ["_unit", "_trench"];

    if (count (_trench getVariable [QGVAR(diggers),[]]) <= 1) exitWith {false};
    if (!(_trench getVariable ["ace_trenches_digging", false])) exitWith {false};
    if (GVAR(stopBuildingAtFatigueMax) && {ace_advanced_fatigue_anReserve <= 0}) exitWith {false};
    if (_unit getVariable [QGVAR(diggingTrench), false]) exitWith {false};

    true
};

[[_unit, _trench, _type], _fnc_onFinish, _fnc_onFailure, localize "STR_ace_trenches_DiggingTrench", _fnc_condition] call FUNC(progressBar);
[_unit] call FUNC(loopanimation);
