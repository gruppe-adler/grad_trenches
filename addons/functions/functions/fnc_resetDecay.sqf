#include "script_component.hpp"
/*
 * Author: Salbei
 * Starts removing trenches after a given time
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Timeout To Decay <NUMBER>
 * 2: Decay Time <NUMBER>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [TrenchObj, 7200, 1800] call grad_trenches_functions_fnc_decayPFH;
 *
 * Public: No
 */

params ["_trench"];

if !(isServer) exitWith {};

{
	_x params ["_obj"];

	if (_trench isEqualTo _obj) exitWith {
		GVAR(decayArray) set [_forEachIndex, [_trench, GVAR(timeoutToDecay), GVAR(decayTime), GVAR(decayTime)]];
	};
}forEach GVAR(decayArray);