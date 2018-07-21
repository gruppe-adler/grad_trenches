/*
    @Authors
        Marc 'Salbei' Heinze
    @Arguments
        ?
    @Return Value
        ?
    @Example
        ?
*/

#include "script_component.hpp"

params ["_unit", "_trench"];

private _delay = ((missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> (typeof _trench) >>"ace_trenches_diggingDuration"), 20]) * (_trench getVariable ["ace_trenches_progress", 0] / 10));
_trench setVariable [QGVAR(diggerCount), ((_trench getVariable QGVAR(diggerCount))+1)];

[{
    params ["_args", "_handle"];
    _args params ["_unit", "_trench"];

    if ((_trench getVariable [QGVAR(diggerCount), 1]) == 1) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
        [_trench, _unit] call FUNC(continueDiggingTrench);
    };

    private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];
    if(_actualProgress == 1) exitWith {};

    // Mark trench as being worked on
    _trench setVariable ["ace_trenches_digging", true, true];

    private _digTime = missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> (typeof _trench) >>"ace_trenches_diggingDuration"), 20];
    private _digTimeLeft = _digTime * (1 - _actualProgress);

    private _placeData = _trench getVariable ["ace_trenches_placeData", [[], []]];
    _placeData params ["_basePos", "_vecDirAndUp"];

    private _trenchId = _unit getVariable ["ace_trenches_isDiggingId", -1];
    if(_trenchId < 0) then {
        _trenchId = ace_trenches_trenchId;
        _unit setVariable ["ace_trenches_isDiggingId", _trenchId, true];
        ace_trenches_trenchId = ace_trenches_trenchId + 1;
    };

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
},_delay,_this] call CBA_fnc_addPerFrameHandler;
