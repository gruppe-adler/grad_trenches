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

    if (isClass (configFile >> "CfgVehicles" >> typeOf _object >> "CamouflagePositions01")) then {
        private _texture = [_object] call FUNC(getSurfaceTexturePath);
        _object setObjectTextureGlobal [0, _texture];
    };
}];
