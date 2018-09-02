/*
    @Authors
        Marc 'Salbei' Heinze
    @Arguments
        - _unit, is the unit that helps digging
		- _trench, the trench that is beeing dug
    @Return Value
        None
*/

#include "script_component.hpp"

params ["_unit", "_trench"];

if ((_trench getVariable [QGVAR(diggerCount), 1]) < 1) exitWith {[_trench, _unit] call FUNC(continueDiggingTrench);};
_trench setVariable [QGVAR(diggerCount), ((_trench getVariable QGVAR(diggerCount))+1), true];

private _handle = [{
   params ["_args", "_handle"];
    _args params ["_unit", "_trench"];

    if ((_trench getVariable [QGVAR(diggerCount), 1]) <= 1) exitWith {
      [_handle] call CBA_fnc_removePerFrameHandler;
      [_trench, _unit] call FUNC(continueDiggingTrench);
   };
},1,_this] call CBA_fnc_addPerFrameHandler;

private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];
private _digTime = missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> (typeof _trench) >>"ace_trenches_diggingDuration"), 20];
private _digTimeLeft = _digTime * (1 - _actualProgress);

// Create progress bar
private _fnc_onFinish = {
    (_this select 0) params ["_unit", "_trench", "_handle"];
    [_handle] call CBA_fnc_removePerFrameHandler;
    _trench setVariable [QGVAR(diggerCount), 0,true];

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};

private _fnc_onFailure = {
    (_this select 0) params ["_unit", "_trench", "_handle"];

    [_handle] call CBA_fnc_removePerFrameHandler;
    private _count = (_trench getVariable QGVAR(diggerCount));
    _trench setVariable [QGVAR(diggerCount), (_count-1),true];

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};

[(_digTimeLeft + 0.5), [_unit, _trench, _handle], _fnc_onFinish, _fnc_onFailure, localize "STR_ace_trenches_DiggingTrench"] call ace_common_fnc_progressBar;

[_unit, "AinvPknlMstpSnonWnonDnon_medic4"] call ace_common_fnc_doAnimation;
