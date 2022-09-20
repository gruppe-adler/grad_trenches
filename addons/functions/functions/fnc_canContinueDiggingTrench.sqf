#include "script_component.hpp"
/*
 * Author: SzwedzikPL, Salbei
 * Checks if a unit can continue digging a trench
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * Can continue <BOOL>
 *
 * Example:
 * [TrenchObj, ACE_player] call grad_trenches_functions_fnc_canContinueDiggingTrench
 *
 * Public: No
 */

params ["_trench", "_unit"];

if !([_unit] call ace_trenches_fnc_hasEntrenchingTool) exitWith {false};
if ((_trench getVariable ["ace_trenches_progress", 0]) >= 1) exitWith {false};

// Prevent removing/digging trench by more than one person
if (_trench getVariable ["ace_trenches_digging", false]) exitWith {false};

true
