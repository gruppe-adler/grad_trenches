#include "script_component.hpp"
/*
 * Author: Salbei, Elkano
 * Starts removing trenches after a given time.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Timeout To Decay <NUMBER> (optional)
 * 2: Decay Time <NUMBER> (optional)
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, 7200, 1800] call grad_trenches_functions_fnc_decayPFH;
 *
 * Public: No
 */

params ["_trench", ["_timeoutToDecay", 7200], ["_decayTime", 1800]];

if (!isServer || {isNull _trench} || {!GVAR(allowTrenchDecay)}) exitWith {};

if (isNil QGVAR(decayArray)) then {
    GVAR(decayArray) = [];
};

// Don't add the same trench twice; This means that the PFH must have already been added, so exit
if (_trench in (GVAR(decayArray) apply {_x select 0})) exitWith {};

GVAR(decayArray) pushBack [_trench, _timeoutToDecay, _decayTime];

if !(isNil QGVAR(decayPFH)) exitWith {};

GVAR(decayPFH) = [{
    if (GVAR(decayArray) isEqualTo []) exitWith {
        [GVAR(decayPFH)] call CBA_fnc_removePerframeHandler;
        GVAR(decayPFH) = nil;
    };

    private _newArray = [];

    {
        _x params ["_trench", "_timeoutToDecay", "_decayTimeMax"];

        if (isNull _trench) then {
            continue;
        };

        if (count (_trench getVariable [QGVAR(diggers), []]) >= 1) then {
            _newArray pushBack [_trench, _timeoutToDecay, _decayTimeMax];
        } else {
            if (_timeoutToDecay <= 10) then {
                // If there are players in the area and CBA setting enabled, reset trench decay
                if (GVAR(playersInAreaRadius) isNotEqualTo 0 && {(((ASLToAGL getPosASL _trench) nearEntities ["CAManBase", GVAR(playersInAreaRadius)]) select {isPlayer _x}) isNotEqualTo []}) then {
                    _newArray pushBack [_trench, GVAR(timeoutToDecay), GVAR(decayTime)];
                    continue;
                };

                private _progress = _trench getVariable ["ace_trenches_progress", 0];
                _progress = _progress - (10 / (_decayTimeMax max 10)); // In case _decayTimeMax is set to 0

                if (_progress <= 0) then {
                    deleteVehicle _trench;
                } else {
                    [_trench, _progress, 1] call FUNC(setTrenchProgress);

                    if (GVAR(allowEffects)) then {
                        [QGVAR(digFX), [_trench]] call CBA_fnc_globalEvent;
                    };

                    _newArray pushBack [_trench, 0, _decayTimeMax];
                };
            } else {
                _newArray pushBack [_trench, _timeoutToDecay - 10, _decayTimeMax];
            };
        };
    } forEach GVAR(decayArray);

    GVAR(decayArray) = _newArray;
}, 10, []] call CBA_fnc_addPerFrameHandler;
