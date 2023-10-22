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
_unit setVariable [QGVAR(helpingFunctionRunning), true];

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

[
    {
        params ["_args", "_handle"];
        _args params ["_unit", "_trench", "_condition","_finishCondition"];

        if (isNull _trench || {[_trench] call _condition} || {!alive _unit}) exitWith {

            [_handle] call CBA_fnc_removePerFrameHandler;
            _unit setVariable [QGVAR(diggingTrench), false, true];
            [QGVAR(handleDiggerToGVAR), [_trench, _unit, true]] call CBA_fnc_serverEvent;
        };

        if (_unit getVariable [QGVAR(diggingTrench), false] && {((_trench getVariable [QGVAR(diggers), []]) select 0) isEqualTo ([] call CBA_fnc_currentUnit)}) exitWith {

            [_handle] call CBA_fnc_removePerFrameHandler;

            if (_finishCondition) then {
                [{_this call FUNC(continueDiggingTrench);}, [_trench, _unit, true]] call CBA_fnc_ExecNextFrame;
            } else {
                [{_this call FUNC(continueDiggingTrench);}, [_trench, _unit, true]] call CBA_fnc_ExecNextFrame;
            };

            _unit setVariable [QGVAR(helpingFunctionRunning), false];
        };

        if !(_unit getVariable [QGVAR(diggingTrench), false]) exitWith {

            [_handle] call CBA_fnc_removePerFrameHandler;
            [QGVAR(handleDiggerToGVAR), [_trench, _unit, true]] call CBA_fnc_serverEvent;
        };

        // Fatigue impact
        [QGVAR(applyFatigue), [_trench, _unit], _unit] call CBA_fnc_targetEvent;
    },
    0.1,
    [_unit, _trench, _condition, _finishCondition]
] call CBA_fnc_addPerFrameHandler;

// Create progress bar
private _fnc_onFinish = {
    (_this select 0) params ["_unit", "_trench", ""];

    _unit setVariable [QGVAR(diggingTrench), false, true];

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};

private _fnc_onFailure = {
    (_this select 0) params ["_unit", "_trench", ""];

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};
private _fnc_condition = {
    (_this select 0) params ["_unit", "_trench"];

    if !(_trench getVariable ["ace_trenches_digging", false]) exitWith {false};
    if (GVAR(stopBuildingAtFatigueMax) && {ace_advanced_fatigue_anReserve <= 0}) exitWith {false};
    if !(_unit getVariable [QGVAR(diggingTrench), false]) exitWith {false};
    if (count (_trench getVariable [QGVAR(diggers), []]) < 1) exitWith {false};
    if !(_unit getVariable [QGVAR(helpingFunctionRunning), false]) exitWith {false};

    true
};

[[_unit, _trench, _finishCondition], _fnc_onFinish, _fnc_onFailure, localize "STR_ace_trenches_DiggingTrench", _fnc_condition] call FUNC(progressBar);

[_unit] call FUNC(loopanimation);
