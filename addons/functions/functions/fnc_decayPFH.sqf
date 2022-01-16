#include "script_component.hpp"
/*
 * Author: Salbei, Elkano, johnb43
 * Starts removing trenches after a given time.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Timeout To Decay <NUMBER> (optional)
 * 2: Decay Time <NUMBER> (optional)
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, 7200, 1800] call grad_trenches_functions_fnc_decayPFH;
 *
 * Public: No
 */

params ["_trench", ["_timeoutToDecay", 7200], ["_decayTime", 1800]];

if (!isServer || {isNull _trench} || {!GVAR(allowTrenchDecay)}) exitWith {};

if (isNil QGVAR(decayArray)) then {
	GVAR(decayArray) = [];
};

// Don't add the same trench twice; This means that the PFH must have already been added, so exit
if (_trench in (GVAR(decayArray) apply {_x select 0})) exitWith {};

GVAR(decayArray) pushBack [_trench, _timeoutToDecay, _decayTime, _decayTime];

if !(isNil QGVAR(decayPFH)) exitWith {};

GVAR(decayPFH) = [{
	if (GVAR(decayArray) isEqualTo []) exitWith {
		[GVAR(decayPFH)] call CBA_fnc_removePerframeHandler;
		GVAR(decayPFH) = nil;
	};

	private _newArray = [];

	{
		_x params ["_trench", "_timeoutToDecay", "_decayTime", "_decayTimeMax"];

		if (isNull _trench) then {
			continue;
		};

		if (count (_trench getVariable [QGVAR(diggers),[]]) >= 1) then {
			_newArray pushBack [_trench, _timeoutToDecay, _decayTime, _decayTimeMax];
		} else {
			if (_timeoutToDecay <= 10) then {
				_timeoutToDecay = 0;

				_decayTime = (_decayTime - 10) max 0;

				private _progress = _trench getVariable ["ace_trenches_progress", 0];
				_progress = _progress - (10 / _decayTimeMax);

				if (_progress <= 0 || {_decayTime <= 0}) then {
					deleteVehicle _trench;
				} else {
					[_trench, _progress, 1] call FUNC(setTrenchProgress);

					_newArray pushBack [_trench, _timeoutToDecay, _decayTime, _decayTimeMax];
				};
			} else {
				_newArray pushBack [_trench, _timeoutToDecay - 10, _decayTime, _decayTimeMax];
			};
		};
	} forEach GVAR(decayArray);

	GVAR(decayArray) = _newArray;
}, 10, []] call CBA_fnc_addPerFrameHandler;
