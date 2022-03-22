#include "script_component.hpp"
/*
 * Author:  nomisum
 * Apply Fatigue on Client. Called every 1s on builder.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, ACE_player] call grad_trenches_functions_fnc_applyFatigue
 *
 * Public: No
 */

params ["_trench", "_unit"];

// Fatigue impact
ace_advanced_fatigue_anReserve = (ace_advanced_fatigue_anReserve - (GVAR(buildFatigueFactor) * 20)) max 0;
ace_advanced_fatigue_anFatigue = (ace_advanced_fatigue_anFatigue + (GVAR(buildFatigueFactor) / 100)) min 0.8;

if (GVAR(stopBuildingAtFatigueMax) && {ace_advanced_fatigue_anReserve <= 0}) exitWith {
    _trench setVariable ["ace_trenches_digging", false, true]; // Also stops server PFH
    [QGVAR(handleDiggerToGVAR), [_trench, _unit, true]] call CBA_fnc_serverEvent;
    _unit setVariable [QGVAR(diggingTrench), false];
};
