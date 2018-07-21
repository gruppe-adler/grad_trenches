/*
 * Author: Garth 'L-H' de Wet, Ruthberg, edited by commy2 for better MP and eventual AI support and esteldunedain
 * Confirms trench dig
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player] call ace_trenches_fnc_placeConfirm
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit"];

// enable running again
[_unit, "forceWalk", "ACE_Trenches", false] call ace_common_fnc_statusEffect_set;

// remove dig pfh
[ace_trenches_digPFH] call CBA_fnc_removePerFrameHandler;
ace_trenches_digPFH = -1;

// remove mouse button actions
call ace_interaction_fnc_hideMouseHint;

[_unit, "DefaultAction", _unit getVariable ["ace_trenches_Dig", -1]] call ace_common_fnc_removeActionEventHandler;

_unit setVariable ["ace_trenches_isPlacing", false, true];

// Delete placement dummy and create real trench
params ["_unit"];
if (isNull ace_trenches_trench) exitWith {};

private _trenchTexture = (getObjectTextures ace_trenches_trench) select 0;
private _vecDirAndUp = [(vectorDir ace_trenches_trench), (vectorUp ace_trenches_trench)];
deleteVehicle ace_trenches_trench;

private _trench = createVehicle [ace_trenches_trenchClass, ace_trenches_trenchPos, [], 0, "NONE"];
_trench setObjectTextureGlobal [0,_trenchTexture];
_trench setVectorDirAndUp _vecDirAndUp;

private _boundingBox = boundingBoxReal _trench;
_boundingBox params ["_lbfc", "_rtbc"];                                         //_lbfc(Left Bottom Front Corner) _rtbc (Right Top Back Corner)
_lbfc params ["", "", "_lbfcZ"];
_rtbc params ["", "", "_rtbcZ"];

private _centerBox = boundingCenter _trench;
_centerBox params ["", "", "_centerBoxZ"];

private _heightFromCenter = _centerBoxZ - _lbfcZ;
private _heightFromCenterDiff = _centerBoxZ - _rtbcZ;

diag_log format ["Trench: BoundingBox: LBFCZ: %1, RTBCZ: %2, HFC: %3, HFCD: %4", _lbfcZ, _rtbcZ, _heightFromCenter, _heightFromCenterDiff];

private _newPos = _trench modelToWorld [0,0,_heightFromCenterDiff];
private _posDiff = ((getPos _trench) select 2) - (_newPos select 2);
_trench setVariable [QGVAR(diggingSteps), (_posDiff /100)];
_trench setPos _newPos;

_trench setVariable ["ace_trenches_placeData", [_newPos, _vecDirAndUp], true];

[_trench, _unit] call FUNC(continueDiggingTrench);
