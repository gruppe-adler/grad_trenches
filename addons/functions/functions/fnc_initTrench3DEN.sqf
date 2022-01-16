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

        _object setObjectTexture [0, surfaceTexture (getPos _object)];

        {
            private _pos = _x getVariable [QGVAR(positionData), [0,0,0]];
            _x attachTo [_object, _pos];
        } forEach (_object getVariable [QGVAR(camouflageObjects), []]);
    }];

    _object setObjectTexture [0, surfaceTexture (getPos _object)];

    if (((_object get3DENAttribute QUOTE(grad_trenches_camouflageTrench)) select 0) isEqualTo 1) then {
        [_object, 1] call FUNC(applyCamouflageAttribute);
    };
};

// If no object is given apply this to all trenches in 3den
if (isNull _object) then {
    [_initTrench] spawn {
        params ["_initTrench"];

        {
            if (isNumber (configOf _x >> QGVAR(isTrench))) then {
                [_x] call _initTrench;
            };
        } forEach (all3DENEntities select 0);
    };
} else {
    [_object] call _initTrench;
};
