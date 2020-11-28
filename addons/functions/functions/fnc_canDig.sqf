#include "script_component.hpp"
#include "\z\ace\addons\common\script_component.hpp"
/*
 * Author: Ruthberg, commy2
 * Checks if the player can dig on the surface below (enough dust).
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * Can Dig <BOOL>
 *
 * Example:
 * [ACE_player] call ace_common_fnc_canDig
 *
 * Public: No
 */

params ["_object"];

private _posASL = getPosASL _object;

if (surfaceIsWater _posASL || {isOnRoad _object}) exitWith {false};

private _surfaceClass = (surfaceType _posASL) select [1];
private _config = configFile >> "CfgSurfaces" >> _surfaceClass;
private _surfaceType = getText (_config >> "soundEnviron");
private _surfaceDust = getNumber (_config >> "dust");

TRACE_2("Surface",_surfaceType,_surfaceDust);

if (isNumber (_config >> "ACE_canDig")) then {
    (getNumber (_config >> "ACE_canDig")) == 1 // return
} else {
    !(_surfaceType in DIG_SURFACE_BLACKLIST) && {(_surfaceDust >= 0.1) || {_surfaceType in DIG_SURFACE_WHITELIST}} // return
};