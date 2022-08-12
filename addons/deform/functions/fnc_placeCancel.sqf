#include "script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet, Ruthberg, edited by commy2 for better MP and eventual AI support, Salbei
 * Cancels trench dig
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Key <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player] call ace_trenches_fnc_placeCancel
 *
 * Public: No
 */

params ["_unit", "_key"];

if (_key != 1 || {GVAR(digPFH) == -1}) exitWith {};

// enable running again
[_unit, "forceWalk", "GRAD_Trenches", false] call ace_common_fnc_statusEffect_set;
[_unit, "blockThrow", "GRAD_Trenches", false] call ace_common_fnc_statusEffect_set;

{
    deleteVehicle _x;
}forEach attachedObjects GVAR(trench);


// delete placement dummy
deleteVehicle GVAR(trench);

// remove digment pfh
[GVAR(positionPFH)] call CBA_fnc_removePerFrameHandler;
GVAR(positionPFH) = -1;

// remove mouse button actions
call ace_interaction_fnc_hideMouseHint;

[_unit, "DefaultAction", _unit getVariable [QGVAR(Dig), -1]] call ace_common_fnc_removeActionEventHandler;

_unit setVariable [QGVAR(isPlacing), false, true];
