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

private _diggingPlayers = _trench getVariable [QGVAR(diggers), []];

if (
    (count _diggingPlayers) < 1
) exitWith {
    [_trench, _unit] call FUNC(continueDiggingTrench);
};

[QGVAR(addDigger), [_trench, _unit, false]] call CBA_fnc_serverEvent;

private _finishCondition = {false};
_unit setVariable [QGVAR(diggingTrench), true];

private _digTime = 0;
switch (_trench getVariable [QGVAR(diggingType), nil]) do {
    case "UP" : {
        _finishCondition = ((_trench getVariable [QGVAR(progress), 0]) >= 1);
        _digTime = missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> (typeOf _trench) >> "ace_trenches_diggingDuration"), 20];
    };
    case "Down" : {
        _finishCondition = ((_trench getVariable [QGVAR(progress), 1]) <= 0);
        _digTime = missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> (typeOf _trench) >> "ace_trenches_removalDuration"), 20];
    };
    default {ERROR(format ["No value for _type, %1!", _type]);};
};

private _handle = [{
    params ["_args", "_handle"];
    _args params ["_trench", "_unit"];

    if (
        (_trench getVariable [QGVAR(nextDigger), ACE_player]) == ACE_player &&
        {count (_trench getVariable [QGVAR(diggers), []]) < 1} ||
        {!(_trench getVariable ["ace_trenches_digging", false])}
    ) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

}, 0.1, [_trench, _unit]] call CBA_fnc_addPerFrameHandler;

// Create progress bar
private _fnc_onFinish = {
    (_this select 0) params ["_unit"];

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};

private _fnc_onFailure = {
    (_this select 0) params ["_unit", "_trench"];

    [QGVAR(addDigger), [_trench, _unit, true]] call CBA_fnc_serverEvent;

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};
private _fnc_condition = {
    (_this select 0) params ["", "_trench", "_handle"];

    if (count (_trench getVariable [QGVAR(diggers),[]]) <= 1) exitWith {false};
    if (GVAR(stopBuildingAtFatigueMax) && {ace_advanced_fatigue_anReserve <= 0}) exitWith {false};
    true
};

[[_unit, _trench, _type, _handle], _fnc_onFinish, _fnc_onFailure, localize "STR_ace_trenches_DiggingTrench", _fnc_condition] call FUNC(progressBar);
[_unit] call FUNC(loopanimation);
