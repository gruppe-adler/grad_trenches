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

params ["_vehicle"];

if (!(isClass (configFile >> "CfgDigVehicles" >> typeOf _vehicle))) exitWith {
    diag_log format ["Vehicle Digging not supported on %1", typeOf _vehicle];
};

if (_vehicle getVariable [QGVAR(vehicleDiggingActionAdded), false]) exitWith {
    WARNING_1("attempt to add vehicle action more than once on %1", _vehicle);
};

_vehicle setVariable [QGVAR(vehicleDiggingActionAdded), true];

// building is on server only
if (isServer) then {
	[_vehicle] call FUNC(vehicleTrenchBuild);
};

if (hasInterface) then {
/*
	private _action = [
		"plow",
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
        [false,false,false,true,false], //add run on hover (4th bit true)
	] call ace_interact_menu_fnc_createAction;

	[_vehicle, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

	private _action1 = [
		QGVAR(actionLowerPlow),
		localize "STR_GRAD_Trenches_functions_lowerPlow",
		"",
		{
			_target setDamage 1;
		},
		{((_target getVariable [QGVAR(plowlowered), 0]) == 0) && {_player == driver _target}},
		{},
		[]
	] call ace_interact_menu_fnc_createAction;

	[_vehicle, 0, ["ACE_MainActions", QGVAR(plow)], _action1] call ace_interact_menu_fnc_addActionToObject;

*/






















	_vehicle addAction [
		localize "STR_GRAD_Trenches_functions_lowerPlow",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];

		    private _config = configFile >> "CfgDigVehicles" >> typeOf _target;
		    private _animation = getText (_config >> "animation");
		    private _plowLowered = getNumber (_config >> "plowLowered");
		    private _type = getText (_config >> "type");
		    if (_type == "animate") then {
		        _target animate [_animation, _plowLowered];
		    } else {
		        _target animatesource [_animation, _plowLowered];
		    };

		    _target setCruiseControl [7, false];    
		    _target setVariable [QGVAR(plowlowered), -1, true]; // animating state to prevent multi execution

		    [{
		    	params ["_target", "_type", "_animation", "_plowLowered"];
		    	if (_type == "animate") then {
		    		(_target animationPhase _animation == _plowLowered)
		    	} else {
		    		(_target animationSourcePhase _animation == _plowLowered)
		    	};
			},
		    {	
		    	params ["_target", "_type", "_animation", "_plowLowered"];
				_target setVariable [QGVAR(plowlowered), 1, true];
			}, [_target, _type, _animation, _plowLowered]] call CBA_fnc_waitUntilAndExecute;
		},
		nil,
		1.5,
		true,
		true,
		"",
		"", // _target, _this, _originalTarget
		50,
		false,
		"",
		""
	];

	_vehicle addAction [
		localize "STR_GRAD_Trenches_functions_raisePlow",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];

		    private _config = configFile >> "CfgDigVehicles" >> typeOf _target;
		    private _animation = getText (_config >> "animation");
		    private _plowRaised = getNumber (_config >> "plowRaised");
		    private _type = getText (_config >> "type");
		    if (_type == "animate") then {
		    	_target animate [_animation, _plowRaised];
		    } else {
		    	_target animatesource [_animation, _plowRaised];
			};
		    _target setCruiseControl [0, false];
		    _target setVariable [QGVAR(plowlowered), -1, true]; // animating state to prevent multi execution

		    [{
		    	params ["_target", "_type", "_animation", "_plowRaised"];
		    	if (_type == "animate") then {
		    		(_target animationPhase _animation == _plowRaised)
		    	} else {
		    		(_target animationSourcePhase _animation == _plowRaised)
		    	};
			},
		    {	
		    	params ["_target", "_type", "_animation", "_plowRaised"];
				_target setVariable [QGVAR(plowlowered), 0, true];
			}, [_target, _type, _animation, _plowRaised]] call CBA_fnc_waitUntilAndExecute;
		    
		},
		nil,
		1.5,
		true,
		true,
		"",
		"((_target getVariable ['grad_trenches_functions_plowlowered', 0]) == 1) && (call CBA_fnc_currentUnit) == driver _target", // _target, _this, _originalTarget
		10,
		false,
		"",
		""
	];
};
