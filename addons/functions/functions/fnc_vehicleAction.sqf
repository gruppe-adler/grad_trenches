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

	private _dir1 = getDir _object1;
	private _dir2 = getDir _object2;

	if ((abs(_dir1 - _dir2)) > 10) exitWith { hint "angle not fitting"; };

	if (getPos _object1 inArea [_object modelToWorld [0,3,0], 2, 2, getDir _object1, true, -1]) then {
		_object2 attachTo [];
	};
}];


_vehicle addAction [
	"Lower Plow",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];

    private _config = configFile >> "CfgDigVehicles" >> typeOf _target;
    private _animation = getText (_config >> "animation");
    private _plowLowered = getNumber (_config >> "plowLowered");
    _target animate [_animation, _plowLowered];
    _target setCruiseControl [7, false];
    _target setVariable ["grad_trenches_functions_plowlowered", true, true];
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
    _target animate [_animation, _plowRaised];
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
