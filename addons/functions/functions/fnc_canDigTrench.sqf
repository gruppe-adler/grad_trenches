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

private _return = true;

{
	if !(_x isEqualTo "") then {
		_return = _x call ace_common_fnc_canDig;

		systemChat str _return;

		if (_return isEqualType 0) then {
			_return = _return > 0;
		};

		if !(_return) exitWith {};
	};
}forEach [_unit, _trench];

_return