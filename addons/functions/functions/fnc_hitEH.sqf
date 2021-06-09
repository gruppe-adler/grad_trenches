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
    (_this select 0) params ["_vehicle", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];


    if (_isDirect) then {
        _ammo params ["", "", "_splashDamage", "", "_type"];

        TRACE_1("hitEH", format ["direct Hit with " + str _ammo]);

        if (_splashDamage > 1) then {
            // send fx to clients
            [vectorDir _vehicle, ASLToAGL _position] remoteExec [FUNC(hitFX), [0,-2] select isDedicated];

            private _progress = _trench getVariable ["ace_trenches_progress", 0];
            private _damage = _splashDamage/20; // 1 HE shell appr 25% decay depending on ammo type
            _progress = _progress - _damage;

            if (_progress > 0) then {
                private _lift = (_progress/1) * [configFile >> "CfgVehicles" >> typeOf _trench >> QGVAR(offset), "NUMBER", 2] call CBA_fnc_getConfigEntry;
                _trench animateSource ["rise", _lift, true];
                _trench setVariable ["ace_trenches_progress", _progress, true];
            } else {
                deleteVehicle _trench;
            };
        };
    };
}];