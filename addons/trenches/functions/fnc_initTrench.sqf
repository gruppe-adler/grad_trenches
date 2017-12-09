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
    ["_object", objnull, [objNull]]
];

if (is3DEN) exitWith {
    _object addEventHandler ["Dragged3DEN", {
        params["_object"];
        private _texture = [_object] call FUNC(getSurfaceTexturePath);
        _object setObjectTexture [0, _texture];
    }];

    private _texture = [_object] call FUNC(getSurfaceTexturePath);
    _object setObjectTexture [0, _texture];
};

if (local _object) then {
    private _texture = [_object] call FUNC(getSurfaceTexturePath);
    _object setObjectTextureGlobal [0, _texture];
};
