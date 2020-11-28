#include "script_component.hpp"
/*
 * Author: Ruthberg, commy2, esteldunedain, Salbei
 * Checks if a unit can dig a trench.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Trench <OBJECT>
 *
 * Return Value:
 * Can dig <BOOL/NUMBER>
 *
 * Example:
 * [ACE_player] call grad_trenches_functions_fnc_canDigTrench
 *
 * Public: No
 */

params ["_unit", ["_trench", ""]];

if !("ACE_EntrenchingTool" in (_unit call ace_common_fnc_uniqueItems)) exitWith {false};

private _return = _unit call FUNC(canDig);

if (_return isEqualType 0) then {
	_return = _return > 0;
};

if !(_return) exitWith {false};
if ((getPosATL _unit) select 2 > 0.05) exitWith {false};

if !(_trench isEqualTo "") then {
	_return = _trench call FUNC(canDig);

	if (_return isEqualType 0) then {
		_return = _return > 0;
	};
};

_return