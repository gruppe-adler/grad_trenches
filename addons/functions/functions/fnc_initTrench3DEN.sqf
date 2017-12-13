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

_initTrench = {
    params["_object"];
    _object addEventHandler ["Dragged3DEN", {
        params["_object"];
        private _texture = [_object] call FUNC(getSurfaceTexturePath);
        _object setObjectTexture [0, _texture];
        {
            private _pos = _x getVariable [QGVAR(positionData), [0,0,0]];
            _x attachTo [_object, _pos];
        } forEach (_object getVariable [QGVAR(camouflageObjects), []]);
    }];

    private _texture = [_object] call FUNC(getSurfaceTexturePath);
    _object setObjectTexture [0, _texture];
};

// If no object is given apply this to all trenches in 3den
if (isNull _object) then {
    {
        diag_log str(_x);
        diag_log typeOf _x;
        if(typeOf _x in ["ACE_envelope_small", "ACE_envelope_big", "GRAD_envelope_gigant"]) then {
            [_x] call _initTrench;
        };
    } forEach (all3DENEntities select 0);
} else {
    [_object] call _initTrench;
}
