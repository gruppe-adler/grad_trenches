#include "script_component.hpp"
/*
 * Author: Salbei
 * Digging trenches with vehicles.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Trench Class <STRING>
 * 2: Offset <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle ACE_player, ACE_player, [0,0,0]] call grad_trenches_functions_fnc_bpzBuild
 *
 * Public: No
 */

params ["_vehicle"];

// private _vehicle = vehicle player,
// private _trenchClass = "GRAD_envelope_vehicle";
// private _offset = [0,5,-5];

[{
    params ["_args", "_handle"];
    _args params ["_vehicle"];

    if (
        isNull _vehicle ||
        !(alive _vehicle)
    ) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    // save performance
    if (!(_vehicle getVariable ["grad_trenches_functions_plowlowered", false]) && !(_vehicle getVariable [QGVAR(isDigging), false])) exitWith {};

    // init digging
    if (!(_vehicle getVariable [QGVAR(isDigging), false])) then {

        if (_speed > 1) then {

            // can dig vehicle on this position
            if (!([_vehicle] call FUNC(canDigVehicle))) exitWith {};

            _vehicle setVariable [QGVAR(isDigging), true, true];
            private _trench = "GRAD_envelope_vehicle" createVehicle [0,0,0];
            [_trench, 0] call grad_trenches_functions_fnc_setTrenchProgress;
            _trench attachTo [_vehicle, [0,3,-5]];
            _trench setObjectTextureGlobal [0, surfaceTexture getPos _vehicle];
            _vehicle setVariable [QGVAR(trenchDigged), _trench, true];
        };

    } else {
        private _trench = _vehicle getVariable [QGVAR(trenchDigged), objNull];
        private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];

        if (_actualProgress >= 1 || (!([_vehicle] call FUNC(canDigVehicle)))) exitWith {
            detach _trench;
            _vehicle setVariable [QGVAR(trenchDigged), objNull, true];
            _vehicle setVariable [QGVAR(isDigging), false, true];
            _trench setVariable ["ace_trenches_placeData", [getPos _trench, [vectorDir _trench, vectorUp _trench]], true];
        };

        private _speed = speed _vehicle;
        private _digTime = 10;
        private _diff = 1/(_digTime*10);

        if (_speed > 1) then {
            [_trench, _actualProgress + _diff, 0.7] call grad_trenches_functions_fnc_setTrenchProgress;
            _trench setObjectTextureGlobal [0, surfaceTexture position _vehicle];
        } else {
            if (_speed < -0.5) then {
                detach _trench;
                _vehicle setVariable [QGVAR(trenchDigged), objNull, true];
                _vehicle setVariable [QGVAR(isDigging), false, true];
                _trench setVariable ["ace_trenches_placeData", [getPos _trench, [vectorDir _trench, vectorUp _trench]], true];
            };
        };
    };

}, 0.1, [_vehicle, _offset]] call CBA_fnc_addPerFrameHandler;
