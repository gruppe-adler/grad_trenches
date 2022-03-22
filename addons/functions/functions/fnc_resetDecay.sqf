#include "script_component.hpp"
/*
 * Author: Salbei
 * Resets the decay on a trench.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj] call grad_trenches_functions_fnc_resetDecay;
 *
 * Public: No
 */

if !(isServer) exitWith {};

params ["_trench"];

{
    if (_trench isEqualTo (_x select 0)) exitWith {
        GVAR(decayArray) set [_forEachIndex, [_trench, GVAR(timeoutToDecay), GVAR(decayTime)]];
    };
} forEach GVAR(decayArray);
