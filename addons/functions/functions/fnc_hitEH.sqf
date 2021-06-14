#include "script_component.hpp"
/*
 * Author: nomisum
 * Receiving and calculating Damage
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Multiplier <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, 1] call grad_trenches_functions_fnc_hitEH;
 *
 * Public: No
 */

params ["_trench", "_multiplier"];

if (_trench getVariable [QGVAR(hitHandler), false]) exitWith { 
    TRACE_1("hitEH","not adding hit handler, already there");
};

_trench setVariable [QGVAR(hitHandler), true, true];



_trench addEventHandler ["HitPart", {
    (_this select 0) params ["_trench", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];

    diag_log str _isDirect;

    diag_log str (_ammo select 2);

    if (!_isDirect) then {
        // add cooldown after indirect
        _ammo params ["", "", "_splashDamage", "", "_type"];

        // diag_log format ["direct Hit with %1", _ammo];

        if (_splashDamage > 1) then {
            // send fx to clients
            [vectorDir _trench, ASLToAGL _position] remoteExec [QFUNC(hitFX), [0,-2] select isDedicated];

            private _progress = _trench getVariable ["ace_trenches_progress", 0];
            private _multiplier = [configFile >> "CfgVehicles" >> typeOf _trench >> "grad_trenches_damageMultiplier", "NUMBER", 1] call CBA_fnc_getConfigEntry; 
            private _damage = (_splashDamage*_multiplier)/20; // 1 HE shell appr 25% decay depending on ammo type
            _progress = _progress - _damage;

            if (_progress > 0) then {
                private _lift = linearConversion [0, 1, _progress, -([configFile >> "CfgVehicles" >> typeOf _trench >> QGVAR(offset), "NUMBER", 2] call CBA_fnc_getConfigEntry), 0, true];
                _trench animateSource ["rise", _lift, true];
                _trench setVariable ["ace_trenches_progress", _progress, true];
            } else {
                deleteVehicle _trench;
            };
        };
    };
}];