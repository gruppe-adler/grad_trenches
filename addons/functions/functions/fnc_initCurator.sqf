#include "script_component.hpp"
/*
 * Author: chris579
 * Initializes curator logics with Event Handlers.
 *
 * Arguments:
 * 0: Curator logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [Logic] call grad_trenches_functions_fnc_initCurator
 *
 * Public: No
 */

params [
    ["_logic", objnull, [objNull]]
];

_logic addEventHandler ["CuratorObjectEdited", {
    params ["", "_object"];

    if (isClass (configOf _object >> "CamouflagePositions1")) then {
        [{
            params ["_obj"];
            _obj setObjectTextureGlobal [0, surfaceTexture (getPos _obj)];
        }, _object] call CBA_fnc_execNextFrame;
    };
}];

_logic addEventHandler ["CuratorObjectPlaced", {
    params ["", "_object"];

    if (isClass (configOf _object >> "CamouflagePositions1")) then {
        [{
            params ["_obj"];
            _obj setObjectTextureGlobal [0, surfaceTexture (getPos _obj)];
        }, _object] call CBA_fnc_execNextFrame;
    };
}];
