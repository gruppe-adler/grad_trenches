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

params ["_vehicle", "_trenchClass", "_offset"];

private _trench = _trenchClass createVehicle [0,0,0];
_trench animateSource ["rise", 0, true];
_trench attachTo [_vehicle, _offset];
_trench setObjectTexture [0, surfaceTexture getPos _vehicle];
_trench setVariable ["ace_trenches_progress", 0, true];

private _digTime = missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> _trenchClass >>"ace_trenches_diggingDuration"), 20];

[{
    params ["_args", "_handle"];
    _args params ["_vehicle", "_trench", "_digTime"];

	private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];

    if (
		isNull _vehicle ||
		!(alive _vehicle) ||
		_actualProgress >= 1
	) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
		detach _trench;
   		_trench setVariable ["ace_trenches_placeData", [getPos _trench, [vectorDir _trench, vectorUp _trench]], true];
    };

	if (_actualProgress <= 0) exitWith {
		[_handle] call CBA_fnc_removePerFrameHandler;
		deleteVehicle _trench;
	};

	private _speedLimit = 15;
    private _speed = speed _vehicle;

    if (_speed > _speedLimit) then {
      _vehicle setVelocity ((velocity _vehicle) vectorMultiply ((_speedLimit / _speed) - 0.00001));
    };

	private _animationPhase = _trench animationSourcePhase "rise";
    private _diff = _trench getVariable [QGVAR(diggingSteps), ([configOf _trench >> QGVAR(offset), "NUMBER", 2] call CBA_fnc_getConfigEntry) / (_digTime * 10)];

	if (_speed > 1) then {
		_trench animateSource ["rise", _animationPhase + _diff, true];

		_trench setVariable ["ace_trenches_progress", _actualProgress + ((1 / _digTime) / 10) , true];
		_trench setObjectTexture [0, surfaceTexture position _vehicle];
    } else {
		if (_speed < -0.5) then {
			_trench animateSource ["rise", _animationPhase - _diff, true];
    		_trench setVariable ["ace_trenches_progress", _actualProgress - ((1 / _digTime) / 10), true];
			_trench setObjectTexture [0, surfaceTexture position _vehicle];
		};
	};
}, 0.1, [_vehicle, _trench, _digTime]] call CBA_fnc_addPerFrameHandler;
