#include "script_component.hpp"
/*
 * Author: chris579
 * Initializes a trench placed in 3DEN.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj] call grad_trenches_functions_fnc_initTrench3DEN
 *
 * Public: No
 */

params [
    ["_object", objnull, [objNull]]
];

private _initTrench = {
    params ["_object"];
    _object addEventHandler ["Dragged3DEN", {
        params ["_object"];

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
    [_initTrench] spawn {
        params ["_initTrench"];

        {
            if (isNumber (configFile >> "CfgVehicles" >> (typeOf _x) >> QGVAR(isTrench))) then {
                [_x] call _initTrench;
            };
        } forEach (all3DENEntities select 0);
    };
} else {
    [_object] call _initTrench;
};