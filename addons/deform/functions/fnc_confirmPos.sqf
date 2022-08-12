#include "script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet, Ruthberg, edited by commy2 for better MP and eventual AI support and esteldunedain
 * Confirms trench digging.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player] call grad_trenches_legacy_fnc_placeConfirm
 *
 * Public: No
 */

params ["_unit"];

// Enable running again
[_unit, "forceWalk", "ACE_Trenches", false] call ace_common_fnc_statusEffect_set;
[_unit, "blockThrow", "ACE_Trenches", false] call ace_common_fnc_statusEffect_set;

// Remove dig pfh
[GVAR(positionPFH)] call CBA_fnc_removePerFrameHandler;
GVAR(positionPFH) = -1;

// Remove mouse button actions
call ace_interaction_fnc_hideMouseHint;

[_unit, "DefaultAction", _unit getVariable [QGVAR(Dig), -1]] call ace_common_fnc_removeActionEventHandler;
_unit setVariable ["ace_trenches_isPlacing", false, true];

// Delete placement dummy and create real trench
if (isNull GVAR(trench)) exitWith {};

// Get the placment data and other important values from the preview trench
private _trenchClass = typeOf GVAR(trench);
private _posDiff = [configFile >> "CfgVehicles" >> _trenchClass >> QGVAR(offset), "NUMBER", 2] call CBA_fnc_getConfigEntry;
private _pos = GVAR(trench) modelToWorldWorld [0,0,0];
private _vecDirAndUp = [vectorDir GVAR(trench), vectorUp GVAR(trench)];

// Delete preview trench
{
    deleteVehicle _x;
}forEach (attachedObjects GVAR(trench));
deleteVehicle GVAR(trench);

[QGVAR(createTrench), [_trenchClass, _posDiff, _pos, _vecDirAndUp, _unit]] call CBA_fnc_serverEvent;
