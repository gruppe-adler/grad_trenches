#include "script_component.hpp"
/*
 * Author: chris579, Salbei
 * Inititializes a trench.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj] call grad_trenches_functions_fnc_initTrench
 *
 * Public: No
 */

params [
    ["_object", objNull, [objNull]]
];

if (is3DEN) exitWith {
    [_object] call FUNC(initTrench3DEN);
};

if (isServer) then {
   _object setVariable ["ace_trenches_progress", 1, true];

    if (GVAR(allowTrenchDecay)) then {
       [_object, GVAR(timeoutToDecay), GVAR(decayTime)] call FUNC(decayPFH);
    };

    if (GVAR(allowHitDecay)) then {
       [_object, GVAR(hitDecayMultiplier)] remoteExec [QFUNC(hitEH), 0, true];
    };
};


if (local _object) then {
    // Has to be delayed to ensure MP compatibility (vehicle spawned in same frame as texture is applied)
    [{
        params ["_obj"];
        _obj setObjectTextureGlobal [0, surfaceTexture (getPos _obj)];
    }, _object] call CBA_fnc_execNextFrame;
};
