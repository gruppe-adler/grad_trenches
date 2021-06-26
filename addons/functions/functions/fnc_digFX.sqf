#include "script_component.hpp"
/*
 * Author: nomisum
 * Displaying Dig FX on Digging
 *
 * Arguments:
 * 0: Trench <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj] call grad_trenches_functions_fnc_digFX;
 *
 * Public: No
 */

params ["_vehicle"];

private _selections = (_vehicle selectionNames "Memory") select {(_x find "fxSource") isEqualTo 0};

{
    private _vector = (vectorDir _vehicle) vectorMultiply 1;
    private _ps1 = "#particlesource" createVehicleLocal [0,0,0]; 

    private _prefix = if (_i < 10) then { "0" } else { "" };
    private _selectionName = "fxSource" + _prefix + str _i;
    private _position = (_vehicle modelToWorld (_vehicle selectionPosition _selectionName));
    _ps1 setPos _position;
    _ps1 setParticleParams [   
     "\A3\Data_F\ParticleEffects\Universal\Mud", "", "SpaceObject",   
     1, 10, [0,0,-2.5], [0,0,0], 1, 10, 1, 0.2, [0.1, 0.1],   
     [[1, 1, 1 ,1]],   
     [0, 1], 1, 0, "", "", _ps1, 0, true, .1];   
    _ps1 setParticleRandom [2, [0.5, 0.5, 0.1], [0.1, 0.1, 0.2], 0, 1, [0, 0, 0, 0], 0, 0];   
    _ps1 setParticleCircle [0.3, [0,0,0.3]];
    _ps1 setDropInterval 0.005;  
    [{ deleteVehicle (_this select 0); }, [_ps1], 0.1] call CBA_fnc_waitAndExecute; 
} forEach _selections;
