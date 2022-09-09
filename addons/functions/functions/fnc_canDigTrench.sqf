#include "script_component.hpp"
/*
 * Author: Ruthberg, commy2, esteldunedain, Salbei
 * Checks if a unit can dig a trench.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Trench <OBJECT> (optional)
 *
 * Return Value:
 * Can dig <BOOL/NUMBER>
 *
 * Example:
 * [ACE_player] call grad_trenches_functions_fnc_canDigTrench
 *
 * Public: No
 */

params ["_unit", ["_trench", objNull]];

if !([_unit] call ace_trenches_fnc_hasEntrenchingTool) exitWith {false};

if (((getPosATL _unit) select 2) > 0.05) exitWith {false};

if !(_unit call FUNC(canDig)) exitWith {false};

if !(isNull _trench) exitWith {
    _trench call FUNC(canDig)
};

true
