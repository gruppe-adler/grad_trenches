#include "script_component.hpp"

params ["_vehicle"];

if (!(isClass (configFile >> "CfgDigVehicles" >> typeOf _vehicle))) exitWith {
    diag_log "Vehicle Digging not supported";
};

if (_vehicle getVariable ["GRAD_trenches_vehicleDiggingActionAdded", false]) exitWith {};
_vehicle setVariable ["GRAD_trenches_vehicleDiggingActionAdded", true];

// building is on server only
if (isServer) then {
	[_vehicle] call FUNC(bpzBuild);
};

// needs to be local to driver, thats why everyone get this
_vehicle addEventHandler ["EpeContactStart", {
	params ["_object1", "_object2", "_selection1", "_selection2", "_force"];

	if (typeOf _object2 != "GRAD_envelope_vehicle") exitWith {};
	if (!(_object1 getVariable ["grad_trenches_functions_plowlowered", false])) exitWith {};

	private _dir1 = getDir _object1;
	private _dir2 = getDir _object2;
	private _config = configFile >> "CfgDigVehicles" >> typeOf _object1;
    private _distanceToTrench = getNumber (_config >> "distanceToTrench");

	if ((abs(_dir1 - _dir2)) > 15) exitWith { systemchat "angle not fitting"; };

	// if vehicle is inside trench
	if ((getPos _object1) inArea [(_object2 modelToWorld [-0.15,-_distanceToTrench,0]), 1, 1, getDir _object2, true, -1]) then {

		// check which trench is larger and attach the larger one, delete the other
		private _trench = _object1 getVariable ["grad_trenches_functions_trenchDigged", objNull];
		private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];

		if (_object2 getVariable ["ace_trenches_progress", 0] > _actualProgress) then {
			deleteVehicle _trench;
			_object2 attachTo [_object1, [-0.15,_distanceToTrench,-5]];
			_object1 setVariable ["grad_trenches_functions_isDigging", true, true];
			_object1 setVariable ["grad_trenches_functions_trenchDigged", _object2, true];
		} else {
			deleteVehicle _object2;
			_trench attachTo [_object1, [-0.15,_distanceToTrench,-5]];
			_object1 setVariable ["grad_trenches_functions_isDigging", true, true];
			_object1 setVariable ["grad_trenches_functions_trenchDigged", _trench, true];
		};
	};
}];


_vehicle addAction [
	"Lower Plow",
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

	    [{
	    	params ["_target", "_animation", "_plowLowered"];
	    	(_target animationPhase _animation == _plowLowered)
		},
	    {	
	    	params ["_target", "_animation", "_plowLowered"];
			_target setVariable ["grad_trenches_functions_plowlowered", true, true];
		}, [_target, _animation, _plowLowered]] call CBA_fnc_waitUntilAndExecute;
	},
	nil,
	1.5,
	true,
	true,
	"",
	"!(_target getVariable ['grad_trenches_functions_plowlowered', false])", // _target, _this, _originalTarget
	50,
	false,
	"",
	""
];

_vehicle addAction [
	"Raise Plow",
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
	    _target setVariable ["grad_trenches_functions_plowlowered", false, true];
	},
	nil,
	1.5,
	true,
	true,
	"",
	"(_target getVariable ['grad_trenches_functions_plowlowered', false])", // _target, _this, _originalTarget
	50,
	false,
	"",
	""
];
