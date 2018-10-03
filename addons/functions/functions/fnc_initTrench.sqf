/*
    @Authors
        Christian 'chris5790' Klemm
    @Arguments
        ?
    @Return Value
        ?
    @Example
        ?
*/
#include "script_component.hpp"
params [
    ["_object", objNull, [objNull]]
];
if (isServer) then {
   _object setVariable ["ace_trenches_progress", 1, true];
};

if (is3DEN) exitWith {
    [_object] call FUNC(initTrench3DEN);
};

if (local _object) then {
    // Has to be spawned to ensure MP compatibility
    _object spawn {
        private _texture = [_this] call FUNC(getSurfaceTexturePath);
        _this setObjectTextureGlobal [0, _texture];
    };
};
