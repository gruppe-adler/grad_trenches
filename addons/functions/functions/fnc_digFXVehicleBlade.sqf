#include "script_component.hpp"
/*
 * Author: nomisum
 * Displaying Dig FX on Digging Vehicle Blade.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle] call grad_trenches_functions_fnc_digFXVehicleBlade;
 *
 * Public: No
 */

params ["_vehicle"];

private _config = configFile >> "CfgDigVehicles" >> typeOf _vehicle;
private _selection = getText (_config >> "selection");
private _particleSource = "#particlesource" createVehicleLocal [0,0,0];
private _selectionPosition = (_vehicle selectionPosition _selection);
_selectionPosition set [1, _selectionPosition select 1 + 0.5];
private _position = _vehicle modelToWorld _selectionPosition;
_particleSource setPos _position;
_particleSource setParticleParams [
 "\A3\Data_F\ParticleEffects\Universal\Mud", "", "SpaceObject",
 1, 10, [0,0,0], [0,0,1], 1, 10, 1, 0.2, [0.05],
 [[1, 1, 1 ,1]],
 [0, 1], 1, 0, "", "", _particleSource, getDir _vehicle, true, .1];
_particleSource setParticleRandom [2, [0, 2, 0.1], [0.1, 0.1, 0.2], 0, 2, [0, 0, 0, 0], 0, 0];
_particleSource setParticleCircle [0.1, [0,0,0.3]];
_particleSource setDropInterval 0.005;

[{
    deleteVehicle _this;
}, _particleSource, 0.1] call CBA_fnc_waitAndExecute;