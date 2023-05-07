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

private _config = configFile >> "CfgDigVehicles" >> typeOf _vehicle;
private _distanceToTrench = getNumber (_config >> "distanceToTrench");

[{
    params ["_args", "_handle"];
    _args params ["_vehicle", "_distanceToTrench"];

    if (
        isNull _vehicle ||
        !(alive _vehicle)
    ) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    // hardcoded values, adjust if vehicle_trench.p3d changes!
    #define trenchHorizontalOffset -0.227
    #define trenchVerticalOffset -2.25 
    
    #define vehicleNotTiltedValue 0.99

    // save performance
    if ((_vehicle getVariable ["grad_trenches_functions_plowlowered", 0] == 0) && !(_vehicle getVariable [QGVAR(isDigging), false])) exitWith {};

    // init digging
    if (!(_vehicle getVariable [QGVAR(isDigging), false])) then {

        // can dig vehicle on this position
        if (!([_vehicle modelToWorld [trenchHorizontalOffset,_distanceToTrench,0]] call FUNC(canDig))) exitWith {};

        // only work when vehicle is not tilted
        if (vectorUp _vehicle select 2 < vehicleNotTiltedValue) exitWith {};

        private _speed = speed _vehicle;
        if (_speed > 1) then {   

            _vehicle setVariable [QGVAR(isDigging), true, true];
            private _trench = "GRAD_envelope_vehicle" createVehicle [0,0,0];
            [_trench, 0] call FUNC(setTrenchProgress);
            _vehicle setVariable [QGVAR(trenchDigged), _trench, true];

            [{
                params ["_vehicle", "_trench", "_distanceToTrench"];
                _trench setObjectTextureGlobal [0, surfaceTexture getPos _vehicle];
                _trench attachTo [_vehicle, [trenchHorizontalOffset,_distanceToTrench,trenchVerticalOffset]];
            }, [_vehicle, _trench, _distanceToTrench], 0.2] call CBA_fnc_waitAndExecute;
        };

    } else {
        private _trench = _vehicle getVariable [QGVAR(trenchDigged), objNull];
        private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];

        if (!([_vehicle modelToWorld [trenchHorizontalOffset,_distanceToTrench,0]] call FUNC(canDig))) exitWith {
            detach _trench;
            _vehicle setVariable [QGVAR(trenchDigged), objNull, true];
            _vehicle setVariable [QGVAR(isDigging), false, true];
            _trench setVariable ["ace_trenches_placeData", [getPos _trench, [vectorDir _trench, vectorUp _trench]], true];
        };

        private _speed = speed _vehicle;
        private _digTime = missionNameSpace getVariable [QGVAR(vehicleTrenchBuildSpeed), 5];
        private _diff = 1/(_digTime*10);

        if (_speed > 1) then {
            [_trench, _actualProgress + _diff, 0.7] call FUNC(setTrenchProgress);
            _trench setObjectTextureGlobal [0, surfaceTexture position _vehicle];
            [QGVAR(digFX), [_trench]] call CBA_fnc_globalEvent;
            [QGVAR(digFXVehicleBlade), [_vehicle]] call CBA_fnc_globalEvent;            
        } else {
            if (_speed < -0.5 || (vectorUp _vehicle select 2 < vehicleNotTiltedValue)) then {
                detach _trench;
                _vehicle setVariable [QGVAR(trenchDigged), objNull, true];
                _vehicle setVariable [QGVAR(isDigging), false, true];
                _trench setVariable ["ace_trenches_placeData", [getPos _trench, [vectorDir _trench, vectorUp _trench]], true];
            };
        };
    };

}, 0.1, [_vehicle, _distanceToTrench]] call CBA_fnc_addPerFrameHandler;
