#include "script_component.hpp"
/*
 * Author: Salbei
 * Add or remove a unit to the global Variable.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Unit <OBJECT>
 * 2: IsRemoveMode <BOOLEAN> (optional)
 * 3: RemoveAll <BOOLEAN> (optional)
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, ACE_player, true, false] call grad_trenches_functions_fnc_handleDiggerToGVAR
 *
 * Public: No
 */

 params ["_trench"];

_trench setVariable ["ace_trenches_digging", false, true];
_trench setVariable [QGVAR(diggingType), nil, true];