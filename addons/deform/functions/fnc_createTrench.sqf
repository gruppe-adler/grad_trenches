#include "script_component.hpp"
/*
* Author: nomisum, Salbei
* Spawns a Trench local to Server.
*
* Arguments:
* 0: TrenchClass <STRING>
* 1: PosDiff <NUMBER 0-1>
* 2: Pos <ARRAY>
* 3: VecDirAndUp <NESTED ARRAY>
* 4: Unit <OBJECT>
*
* Return Value:
* None
*
* Example:
* [TypeOf TrenchObj, 0.5, [0,0,0], [[0,0,0], [0,0,0]], ace_player] call grad_trenches_legacy_fnc_spawnTrench
*
* Public: No
*/

params ["_trenchClass", "_posDiff", "_pos", "_vecDirAndUp", "_unit"];

// Create a new trench, that is globally visible
private _trench = createVehicle [_trenchClass, [0,0,0], [], 0, "CAN_COLLIDE"];
private _digTime = missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> _trenchClass >> "ace_trenches_diggingDuration"), 20];

_trench setVariable [QGVAR(diggingSteps), _posDiff / (_digTime * 10), true];
[_trench, 0, 0] call EFUNC(common,setTrenchProgress); // Animate to down under initially

_trench setVectorDirAndUp _vecDirAndUp;
_pos set [2, 0.01]; // Trench should sit below zero, to prevent glitches with the terrain
_trench setObjectTextureGlobal [0, surfaceTexture _pos];
_trench setPosATL _pos; // Prevent glitches by setting position last, prepare on 0,0,0 - move - rest is done by animation

[QEGVAR(common,addTrenchToDecay), [_trench, GVAR(timeoutToDecay), GVAR(decayTime)]] call CBA_fnc_serverEvent;

if (GVAR(createTrenchMarker)) then {
    [_trench, side _unit] call EFUNC(common,createTrenchMarker);
};

TRACE_1("Server spawning trench at ", _pos);

([_trench] call FUNC(getBBThatNeedsToBeDugOut)) params ["_boundingBox"];

[_trench, _boundingBox] call FUNC(deformTerrain);

[QGVAR(continueDeformingTrench), [_trench, _unit, false], _unit] call CBA_fnc_targetEvent;
