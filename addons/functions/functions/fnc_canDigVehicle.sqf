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

params ["_vehicle"];

private _return = _vehicle call FUNC(canDig);

_return
