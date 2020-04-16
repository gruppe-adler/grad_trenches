#include "script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet, Ruthberg, edited by commy2 for better MP and eventual AI support and esteldunedain
 * Confirms trench dig
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player] call ace_trenches_fnc_placeConfirm
 *
 * Public: No
 */

params ["_unit"];

// enable running again
[_unit, "forceWalk", "ACE_Trenches", false] call EFUNC(common,statusEffect_set);
[_unit, "blockThrow", "ACE_Trenches", false] call EFUNC(common,statusEffect_set);

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

private _trenchClass = typeOf ace_trenches_trench;
private _pos = ace_trenches_trench modelToWorldWorld [0,0,0];
private _vecDirAndUp = [(vectorDir ace_trenches_trench), (vectorUp ace_trenches_trench)];
deleteVehicle ace_trenches_trench;

private _trench = createVehicle [_trenchClass, _pos, [], 0, "CAN_COLLIDE"];
private _digTime = missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> _trenchClass >>"ace_trenches_diggingDuration"), 20];

_trench setObjectTextureGlobal [0,[_trench] call FUNC(getSurfaceTexturePath)];
_trench setPosWorld _pos;
systemChat str(_pos);
trench_oldPos = _pos;

private _posDiff = _pos select 2;
_pos set [2, - (_posDiff)];
_trench setPosWorld _pos;

systemChat format ["posDiff: %1, DigTime: %2, R: %3", _posDiff, _digTime, (_posDiff/(_digTime*10))];

_trench setVariable [QGVAR(diggingSteps), (_posDiff/(_digTime*10)),true];
_trench setVectorDirAndUp _vecDirAndUp;

_trench setVariable ["ace_trenches_placeData", [_pos, _vecDirAndUp], true];
_trench setVariable ["ace_trenches_progress", 0, true];

[_trench, _unit, false] call FUNC(continueDiggingTrench);
