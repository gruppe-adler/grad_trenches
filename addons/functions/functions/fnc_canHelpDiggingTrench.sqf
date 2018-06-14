/*
    @Authors
        Marc 'Salbei' Heinze
    @Arguments
        ?
    @Return Value
        ?
    @Example
        ?
*/

#include "script_component.hpp"

params ["_trench", "_unit"];

if !("ACE_EntrenchingTool" in items _unit) exitWith {false};
if ((_trench getVariable ["ace_trenches_progress", 0]) >= 1) exitWith {false};
if !(_trench getVariable ["ace_trenches_digging", false]) exitWith {false};
if ((_trench getVariable ["ace_trenches_diggerCount", 0]) <= 1) exitWith {false};

true
