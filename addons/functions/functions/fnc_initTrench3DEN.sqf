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

private _initTrench = {
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

    if (((_object get3DENAttribute QUOTE(grad_trenches_camouflageTrench)) select 0) isEqualTo 1) then {
        [_object] call FUNC(placeCamouflage);
    };
};

// If no object is given apply this to all trenches in 3den
if (isNull _object) then {
    {
        if (getNumber(configFile >> "CfgVehicles" >> typeOf _x >> QGVAR(isTrench)) == 1) then {
            [_x] call _initTrench;
        };
    } forEach (all3DENEntities select 0);
} else {
    [_object] call _initTrench;
};
