#include "script_component.hpp"
/*
 * Author: Salbei
 * Plays audio for digging.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, ACE_player] call grad_trenches_functions_fnc_playSound
 *
 * Public: No
 */

params ["_trench"];

private _sound = str (selectRandom [1,2,3,4,5,6,7]);
playSound3D ["x\grad_trenches\addons\sounds\dig" + _sound + ".ogg", _trench, false, getPosASL _trench, 1, 1, 100];
