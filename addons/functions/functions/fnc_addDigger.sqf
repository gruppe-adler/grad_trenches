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

[QGVAR(handleDiggerToGVAR), [_trench, _unit, false]] call CBA_fnc_serverEvent;

_unit setVariable [QGVAR(diggingTrench), true, true];

private _diggingType = _trench getVariable QGVAR(diggingType);
private _finishCondition = true;

// Non-case sensitive comparison for digging type
private _condition = if (!isNil "_diggingType" && {_diggingType == "DOWN"}) then {
    {
        params ["_trench"];

       _finishCondition = true;

        (_trench getVariable ["ace_trenches_progress", 1]) <= 0
    };
} else {
    {
        params ["_trench"];

        _finishCondition = false;

        (_trench getVariable ["ace_trenches_progress", 0]) >= 1
    }
};

private _handle = [
    {
        params ["_args", "_handle"];
        _args params ["_unit", "_trench", "_condition"];

        if (isNull _trench || {[_trench] call _condition} || {!alive _unit}) then {
            [_handle] call CBA_fnc_removePerFrameHandler;
        };

        if (_unit getVariable [QGVAR(diggingTrench), false] && {((_trench getVariable [QGVAR(diggers), []]) select 0) isEqualTo ([] call CBA_fnc_currentUnit)}) then {
            [_handle] call CBA_fnc_removePerFrameHandler;
            [_trench, _unit, true] call FUNC(continueDiggingTrench);
        };

        // Fatigue impact
        ace_advanced_fatigue_anReserve = (ace_advanced_fatigue_anReserve - (2 * GVAR(buildFatigueFactor))) max 0;
        ace_advanced_fatigue_anFatigue = (ace_advanced_fatigue_anFatigue + (GVAR(buildFatigueFactor) / 1000)) min 0.8; // 2 * GVAR(buildFatigueFactor) / 2000
    },
    0.1,
    [_unit, _trench, _condition]
] call CBA_fnc_addPerFrameHandler;

// Create progress bar
private _fnc_onFinish = {
    (_this select 0) params ["_unit", "_trench", "_finishCondition", "_handle"];

    _unit setVariable [QGVAR(diggingTrench), false, true];
    [_handle] call CBA_fnc_removePerFrameHandler;

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};

private _fnc_onFailure = {
    (_this select 0) params ["_unit", "_trench", "", "_handle"];

    [QGVAR(handleDiggerToGVAR), [_trench, _unit, true]] call CBA_fnc_serverEvent;
    [_handle] call CBA_fnc_removePerFrameHandler;
    _unit setVariable [QGVAR(diggingTrench), false, true];

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};
private _fnc_condition = {
    (_this select 0) params ["_unit", "_trench"];

    if !(_trench getVariable ["ace_trenches_digging", false]) exitWith {false};
    if (GVAR(stopBuildingAtFatigueMax) && {ace_advanced_fatigue_anReserve <= 0}) exitWith {false};
    if !(_unit getVariable [QGVAR(diggingTrench), false]) exitWith {false};
    if (count (_trench getVariable [QGVAR(diggers), []]) < 1) exitWith {false};

    true
};

[[_unit, _trench, _finishCondition, _handle], _fnc_onFinish, _fnc_onFailure, localize "STR_ace_trenches_DiggingTrench", _fnc_condition] call FUNC(progressBar);

[_unit] call FUNC(loopanimation);
