#include "script_component.hpp"
/*
 * Author: nomisum
 * Receiving and calculating Damage.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Multiplier <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, 1] remoteExec ["grad_trenches_functions_fnc_hitEHAdd"];
 *
 * Public: No
 */

params ["_trench", "_multiplier"];

if (_trench getVariable [QGVAR(hitHandler), false]) exitWith {
    TRACE_1("hitEH","not adding hit handler, already there");
};

_trench setVariable [QGVAR(hitHandler), true];

// Only fires on shooters client
_trench addEventHandler ["HitPart", {
    (_this select 0) params ["_trench", "", "_projectile", "_position", "", "", "_ammo", "", "", "", "_isDirect"];

    // Filter locally and broadcast only when necessary
    if (!_isDirect && {!(_trench getVariable [QGVAR(hitCoolDown), false])}) then {
        _ammo params ["_hitValue", "_indirectHitValue", "_splashDamage"];

        // Add cooldown after indirect hit
        _trench setVariable [QGVAR(hitCoolDown), true];

        [{
            params ["_trench"];

            if (!isNull _trench) then {
                _trench setVariable [QGVAR(hitCoolDown), false];
            };
        }, [_trench], 1] call CBA_fnc_waitAndExecute;

        if (_splashDamage > 1) then {
            // Larger HE shells should do way more damage than e.g. HE ammo of an APC that has higher cadency
            private _damageNormalized = (_hitValue + _indirectHitValue + _splashDamage) / 3000; // 3000 is arbitrary value

            // Reduce effect for grenades
            if (_projectile isKindOf "Grenade") then {
                _damageNormalized = _damageNormalized * 0.1;
            };

            [QGVAR(hitPart), [_trench, _position, _damageNormalized]] call CBA_fnc_serverEvent;
        };
    };
}];
