#include "script_component.hpp"
/*
 * Author: Nomisum, Salbei
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

 params ["_vehicle", "_player"];

private _actions = [];


_actions pushBack [
	[
		QGVAR(actionPlow),
		localize "STR_ACE_Trenches_functions_plow",
		"",
		{
			systemchat "test";
		},
		{true},
		{},
		[],
		{[0, 0, 0]},
		2,
		[false,false,false,false,false] //add run on hover (4th bit true)
	] call ace_interact_menu_fnc_createAction,
	[],
    _player
];


_actions