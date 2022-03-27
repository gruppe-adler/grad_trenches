#include "script_component.hpp"
#include "\z\ace\addons\common\script_component.hpp"
/*
 * Author: Ruthberg, commy2
 * Checks if a trench can be dug on the surface below an object (enough dust).
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * Can Dig <BOOL>
 *
 * Example:
 * [ACE_player] call grad_trenches_functions_fnc_canDig
 *
 * Public: No
 */

params ["_positionAGL"];

private _posASL = [0,0,0];

if (typeName _positionAGL == "OBJECT") then {
    _posASL = getPosASL _positionAGL;
};

if (typeName _positionAGL == "ARRAY") then {
    _posASL =  AGLtoASL _positionAGL;
};

if (surfaceIsWater _posASL || {isOnRoad _posASL}) exitWith {false};

private _surfaceClass = (surfaceType _posASL) select [1];
private _config = configFile >> "CfgSurfaces" >> _surfaceClass;
private _surfaceType = getText (_config >> "soundEnviron");
private _surfaceDust = getNumber (_config >> "dust");

TRACE_2("Surface",_surfaceType,_surfaceDust);

if (isNumber (_config >> "ACE_canDig")) then {
    (getNumber (_config >> "ACE_canDig")) == 1 // Return
} else {
    !(_surfaceType in DIG_SURFACE_BLACKLIST) && {(_surfaceDust >= 0.1) || {_surfaceType in DIG_SURFACE_WHITELIST}} // Return
};
