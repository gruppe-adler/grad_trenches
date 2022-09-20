#include "script_component.hpp"
/*
 * Author: Salbei
 * Check if unit can help digging trench.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * Can Help Digging Trench <BOOL>
 *
 * Example:
 * [TrenchObj, ACE_player] call grad_trenches_functions_fnc_canHelpDiggingTrench
 *
 * Public: No
 */

params ["_trench", "_unit"];

if !([_unit] call ace_trenches_fnc_hasEntrenchingTool) exitWith {false};
if ((_trench getVariable ["ace_trenches_progress", 0]) >= 1) exitWith {false};
if !(_trench getVariable ["ace_trenches_digging", false]) exitWith {false};
if (count (_trench getVariable [QGVAR(diggers), []]) < 1) exitWith {false};

true
