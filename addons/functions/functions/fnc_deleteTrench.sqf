#include "script_component.hpp"
/*
 * Author: nomisum
 * Safely handles Trench Deletion, manages Variables
 *
 * Arguments:
 * 0: Trench <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj] call grad_trenches_functions_fnc_deleteTrench
 *
 * Public: No
 */

params ["_trench"];

_trench setVariable ["ace_trenches_digging", false, true];
_trench setVariable [QGVAR(diggingType), nil, true];
_unit setVariable [QGVAR(diggingTrench), false, true];
[QGVAR(addDigger), [_trench, _unit, false, true]] call CBA_fnc_serverEvent;

// Remove map marker
if (GVAR(createTrenchMarker)) then {deleteMarker (_trench getVariable [QGVAR(trenchMapMarker), ""])};

//Remove attached items
{
    deleteVehicle _x;
} forEach attachedObjects _trench;

// Remove trench
deleteVehicle _trench;