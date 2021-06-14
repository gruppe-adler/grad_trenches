#include "script_component.hpp"
/*
 * Author:  nomisum
 * Apply Fatigue on Client
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call grad_trenches_functions_fnc_applyFatigue
 *
 * Public: No
 */

// called every .1s on builder

params ["_trench", "_unit"];

 //Fatigue impact
 ace_advanced_fatigue_anReserve = (ace_advanced_fatigue_anReserve - (2 * GVAR(buildFatigueFactor))) max 0;
 ace_advanced_fatigue_anFatigue = (ace_advanced_fatigue_anFatigue + ((2 * GVAR(buildFatigueFactor))/2000)) min 0.8;

 if (GVAR(stopBuildingAtFatigueMax) && {ace_advanced_fatigue_anReserve <= 0}) exitWith {
     _trench setVariable ["ace_trenches_digging", false, true]; // also stops server PFH
     [QGVAR(addDigger), [_trench, _unit, true]] call CBA_fnc_serverEvent;
     _unit setVariable [QGVAR(diggingTrench), false];
 };
 