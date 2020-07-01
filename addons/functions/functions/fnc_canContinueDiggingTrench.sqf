#include "script_component.hpp"
/*
 * Author: SzwedzikPL, Salbei
 * Checks if a unit can continue digging a trench
 *
 * Arguments:
 * 0: trench <OBJECT>
 * 1: unit <OBJECT>
 *
 * Return Value:
 * Can continue <BOOL>
 *
 * Example:
 * [TrenchObj, ACE_player] call ace_trenches_fnc_canContinueDiggingTrench
 *
 * Public: No
 */

params ["_trench", "_unit"];

if !("ACE_EntrenchingTool" in (_unit call ace_common_fnc_uniqueItems)) exitWith {false};
if ((_trench getVariable ["ace_trenches_progress", 0]) >= 1) exitWith {false};

// Prevent removing/digging trench by more than one person
if (_trench getVariable ["ace_trenches_digging", false]) exitWith {false};

true