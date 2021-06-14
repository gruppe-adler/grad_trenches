#include "script_component.hpp"
/*
 * Author: nomisum
 * Server receives hitPart Events from Clients and calulates
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Public: No
 */


params ["_trench", "_splashDamage"]

// send fx to clients
[vectorDir _trench, ASLToAGL _position] remoteExec [QFUNC(hitFX), [0,-2] select isDedicated];

private _progress = _trench getVariable ["ace_trenches_progress", 0];
private _multiplier = [configFile >> "CfgVehicles" >> typeOf _trench >> "grad_trenches_damageMultiplier", "NUMBER", 1] call CBA_fnc_getConfigEntry; 
private _damage = (_splashDamage*_multiplier)/20; // 1 HE shell appr 25% decay depending on ammo type
_progress = _progress - _damage;

if (_progress > 0) then {
    [_trench, _progress] call FUNC(setTrenchProgress);
} else {
    [_trench] call FUNC(deleteTrench);
};
