#include "script_component.hpp"
/*
* Author: nomisum
* Animates a trench to correct progress position. Always instant.
*
* Arguments:
* 0: Trench <OBJECT>
* 1: Progress <NUMBER 0-1>
*
* Return Value:
* None
*
* Example:
* [TrenchObj, 0.5] call grad_trenches_functions_fnc_setTrenchProgress
*
* Public: No
*/

params ["_trench", "_progress"];

private _offset = [configFile >> "CfgVehicles" >> typeOf _trench >> QGVAR(offset), "NUMBER", 2] call CBA_fnc_getConfigEntry;

diag_log format ["_progress %1", _progress];

private _lift = (linearConversion 
    [0, 1, 
    _progress, 
    -_offset, 
    0,
    true
    ]);

_trench animateSource ["rise", _lift, true];
