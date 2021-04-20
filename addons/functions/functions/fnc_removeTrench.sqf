 #include "script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet, Ruthberg, edited by commy2 for better MP and eventual AI support and esteldunedain, Salbei
 * Removes trench
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Unit <OBJECT>
 * 2: SwitchingDigger <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, ACE_player] call grad_trenches_functions_fnc_removeTrench
 *
 * Public: No
 */

params ["_trench", "_unit", ["_switchingDigger", false, [true]]];
TRACE_2("removeTrench",_trench,_unit,_switchingDigger);

private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];
if (_actualProgress <= 0) exitWith {};

// Mark trench as being worked on
_trench setVariable ["ace_trenches_digging", true, true];
_trench setVariable [QGVAR(diggingType), "DOWN", true];
_unit setVariable [QGVAR(diggingTrench), true, true];

private _diggerCount = count (_trench getVariable [QGVAR(diggers), []]);

if (_diggerCount > 0 && {!(_switchingDigger)}) exitWith {
    [_trench, _unit] call FUNC(addDigger);
};

private _removeTime = missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> (typeOf _trench) >>"ace_trenches_removalDuration"), 20];
if (_removeTime isEqualTo -1) then {
    _removeTime = missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> (typeOf _trench) >>"ace_trenches_diggingDuration"), 20];
};

private _placeData = _trench getVariable ["ace_trenches_placeData", [[], []]];
_placeData params ["", "_vecDirAndUp"];

if (isNil "_vecDirAndUp" || {_vecDirAndUp isEqualTo []}) then {
    _vecDirAndUp = [vectorDir _trench, vectorUp _trench];
};

_trench setVariable [QGVAR(diggers), [_unit], true];

// Create progress bar
private _fnc_onFinish = {
    (_this select 0) params ["_unit", "_trench"];

    _trench setVariable ["ace_trenches_digging", false, true];
    _trench setVariable [QGVAR(diggingType), nil, true];
    _unit setVariable [QGVAR(diggingTrench), false, true];
    [QGVAR(addDigger), [_trench, _unit, false, true]] call CBA_fnc_serverEvent;
    
    // Remove map marker
    if (GVAR(createTrenchMarker)) then {deleteMarker (_trench getVariable [QGVAR(trenchMapMarker), ""])};
    
    // Remove trench
    deleteVehicle _trench;

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};
private _fnc_onFailure = {
    (_this select 0) params ["_unit", "_trench"];

    _trench setVariable ["ace_trenches_digging", false, true];
    _trench setVariable [QGVAR(diggingType), nil, true];
    _unit setVariable [QGVAR(diggingTrench), false, true];
    [QGVAR(addDigger), [_trench, _unit, true]] call CBA_fnc_serverEvent;

    // Save progress global
    private _progress = _trench getVariable ["ace_trenches_progress", 0];
    _trench setVariable ["ace_trenches_progress", _progress, true];

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};
private _fnc_condition = {
    (_this select 0) params ["", "_trench"];

    if !(_trench getVariable ["ace_trenches_digging", false]) exitWith {false};
    if (count (_trench getVariable [QGVAR(diggers),[]]) <= 0) exitWith {false};
    if (GVAR(stopBuildingAtFatigueMax) && (ace_advanced_fatigue_anReserve <= 0)) exitWith {false};

    true
};

[[_unit, _trench, false], _fnc_onFinish, _fnc_onFailure, localize "STR_ace_trenches_RemovingTrench", _fnc_condition] call FUNC(progressBar);

[{
    params ["_args", "_handle"];
    _args params ["_trench", "_unit", "_removeTime", "_vecDirAndUp"];

    private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];
    private _diggerCount = count (_trench getVariable [QGVAR(diggers),[]]);

    if (
        !(_trench getVariable ["ace_trenches_digging", false]) ||
        {_diggerCount <= 0}
    ) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
        _trench setVariable ["ace_trenches_digging", false, true];
        [QGVAR(addDigger), [_trench, _unit, false, true]] call CBA_fnc_serverEvent;
    };

    if (_actualProgress <= 0) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    private _pos = (getPosWorld _trench);
    private _posDiff = (_trench getVariable [QGVAR(diggingSteps), (([configFile >> "CfgVehicles" >> typeOf _trench >> QGVAR(offset), "NUMBER", 2] call CBA_fnc_getConfigEntry)/(_removeTime*10))]) * _diggerCount;
 
    _pos set [2, ((_pos select 2) - _posDiff)];
    _trench setPosWorld _pos;
    _trench setVectorDirAndUp _vecDirAndUp;

    _trench setVariable ["ace_trenches_progress", _actualProgress - ((1/_removeTime)/10) * _diggerCount, true];

    //Fatigue impact
    ace_advanced_fatigue_anReserve = (ace_advanced_fatigue_anReserve - (2 * GVAR(buildFatigueFactor))) max 0;
    ace_advanced_fatigue_anFatigue = (ace_advanced_fatigue_anFatigue + ((2 * GVAR(buildFatigueFactor))/2000)) min 1;

    // Save progress
    _trench setVariable ["ace_trenches_progress", (_actualProgress - ((1/(_removeTime *10)) * _diggerCount)), true];

    if (GVAR(stopBuildingAtFatigueMax) && (ace_advanced_fatigue_anReserve <= 0)) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
        _trench setVariable ["ace_trenches_digging", false, true];
        [QGVAR(addDigger), [_trench, _unit, true]] call CBA_fnc_serverEvent;
        _unit setVariable [QGVAR(diggingTrench), false];
    };
}, 0.1, [_trench, _unit, _removeTime, _vecDirAndUp]] call CBA_fnc_addPerFrameHandler;

// Play animation
[_unit] call FUNC(loopanimation);
