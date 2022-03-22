#include "script_component.hpp"
/*
 * Author: chris579, Salbei
 * Places camouflage on a trench.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Unit <OBJECT> (optional)
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, Unit] call grad_trenches_functions_fnc_placeCamouflage
 *
 * Public: No
 */

params [
    ["_trench", objnull, [objnull]],
    ["_unit", objnull, [objnull]]
];

private _camouflageObjects = [configFile >> "CfgWorldsTextures" >> worldName >> "camouflageObjects", "ARRAY", []] call CBA_fnc_getConfigEntry;

if (isNull _trench || {_camouflageObjects isEqualTo []}) exitWith {};

private _fnc_onFinish = {
    (_this select 0) params ["_unit", "_trench"];

    [_trench, 1] call FUNC(applyCamouflageAttribute);

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};

private _fnc_onFailure = {
    (_this select 0) params ["_unit"];
    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};

if (isNull _unit) exitWith {
    [[objnull, _trench]] call _fnc_onFinish;
};

[CAMOUFLAGE_DURATION, [_unit, _trench], _fnc_onFinish, _fnc_onFailure, LLSTRING(placeCamouflageProgress)] call ace_common_fnc_progressBar;

[_unit, "AinvPknlMstpSnonWnonDnon_medic4"] call ace_common_fnc_doAnimation;
