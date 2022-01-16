#include "script_component.hpp"
/*
 * Author: Ruthberg, commy2, esteldunedain, Salbei
 * Checks if a vehicle can dig a trench.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Trench <OBJECT> (optional)
 *
 * Return Value:
 * Can dig <BOOL/NUMBER>
 *
 * Example:
 * [ACE_player] call grad_trenches_functions_fnc_canDigVehicle
 *
 * Public: No
 */

params ["_vehicle", ["_trench", ""]];

private _return = _vehicle call FUNC(canDig);

if (_return isEqualType 0) then {
	_return = _return > 0;
};

if !(_return) exitWith {false};

if !(_trench isEqualTo "") then {
	_return = _trench call FUNC(canDig);

	if (_return isEqualType 0) then {
		_return = _return > 0;
	};
};

_return
