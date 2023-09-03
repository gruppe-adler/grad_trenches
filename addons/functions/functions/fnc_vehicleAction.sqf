#include "script_component.hpp"

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
		    _target setVariable ["grad_trenches_functions_plowlowered", -1, true]; // animating state to prevent multi execution

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
				_target setVariable ["grad_trenches_functions_plowlowered", 1, true];
			}, [_target, _type, _animation, _plowLowered]] call CBA_fnc_waitUntilAndExecute;
		},
		nil,
		1.5,
		true,
		true,
		"",
		"((_target getVariable ['grad_trenches_functions_plowlowered', 0]) == 0) && _this == driver _target", // _target, _this, _originalTarget
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
		    _target setVariable ["grad_trenches_functions_plowlowered", -1, true]; // animating state to prevent multi execution

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
				_target setVariable ["grad_trenches_functions_plowlowered", 0, true];
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
