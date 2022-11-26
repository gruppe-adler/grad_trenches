#include "script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet, Ruthberg, edited by commy2 for better MP and eventual AI support, esteldunedain, Salbei
 * Starts the place process for trench.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Trench class <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player, "ACE_envelope_small"] call grad_trenches_deform_fnc_choosePos
 *
 * Public: No
 */

params ["_trench", "_unit"];

if !("ACE_EntrenchingTool" in items _unit) exitWith {false};
if ((_trench getVariable ["ace_trenches_progress", 0]) >= 1) exitWith {false};

// Prevent removing/digging trench by more than one person
if (_trench getVariable ["ace_trenches_digging", false]) exitWith {false};

true

