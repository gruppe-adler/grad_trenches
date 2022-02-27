#include "script_component.hpp"
/*
 * Author: chris579
 * Removes camouflage from a trench.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, Unit] call grad_trenches_functions_fnc_removeCamouflage
 *
 * Public: No
 */

params ["_trench", "_unit"];

private _fnc_onFinish = {
    (_this select 0) params ["_unit", "_trench"];
    [_trench] call FUNC(deleteCamouflage);

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};

private _fnc_onFailure = {
    (_this select 0) params ["_unit"];
    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};

[CAMOUFLAGE_DURATION, [_unit, _trench], _fnc_onFinish, _fnc_onFailure, LLSTRING(removeCamouflageProgress)] call ace_common_fnc_progressBar;

[_unit, "AinvPknlMstpSnonWnonDnon_medic4"] call ace_common_fnc_doAnimation;
