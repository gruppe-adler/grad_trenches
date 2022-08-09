#include "script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet, Ruthberg, edited by commy2 for better MP and eventual AI support, esteldunedain, Salbei
 * Continue process of digging trench.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Unit <OBJECT>
 * 2: SwitchingDigger <BOOLEAN> (optional)
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, ACE_player] call grad_trenches_deform_fnc_continueDeformingTrench
 *
 * Public: No
 */

params ["_trench", "_unit", ["_switchingDigger", false, [true]]];
TRACE_2("continueDiggingTrench",_trench,_unit,_switchingDigger);

private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];
if (_actualProgress >= 1) exitWith {};


// Mark trench as being worked on
_trench setVariable ["ace_trenches_digging", true, true];
_trench setVariable [QGVAR(diggingType), "UP", true];
_unit setVariable [QGVAR(diggingTrench), true, true];

private _diggerCount = count (_trench getVariable [QGVAR(diggers), []]);

if (_diggerCount > 0 && {!_switchingDigger}) exitWith {
    [_trench, _unit] call EFUNC(common,addDigger);
};

private _digTime = missionNamespace getVariable [getText (configOf _trench >> "ace_trenches_diggingDuration"), 20];

_trench setVariable [QGVAR(diggers), [_unit], true];

// Create progress bar
private _fnc_onFinish = {
    (_this select 0) params ["_unit", "_trench"];

    _trench setVariable ["ace_trenches_digging", false, true];
    _trench setVariable [QGVAR(diggingType), nil, true];
    _unit setVariable [QGVAR(diggingTrench), false, true];
    [QEGVAR(common,handleDiggerToGVAR), [_trench, _unit, false, true]] call CBA_fnc_serverEvent;

    // Save progress global
    _trench setVariable ["ace_trenches_progress", 1, true];

    // Reset animation
    [_unit, "", 1] call ace_common_fnc_doAnimation;
};
private _fnc_onFailure = {
    (_this select 0) params ["_unit", "_trench"];

    _trench setVariable ["ace_trenches_digging", false, true];
    _trench setVariable [QGVAR(diggingType), nil, true];
    _unit setVariable [QGVAR(diggingTrench), false, true];
    [QEGVAR(common,handleDiggerToGVAR), [_trench, _unit, true]] call CBA_fnc_serverEvent;

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

[[_unit, _trench], _fnc_onFinish, _fnc_onFailure, localize "STR_ace_trenches_DiggingTrench", _fnc_condition] call EFUNC(common,progressBar);

if (_actualProgress == 0) then {
    // Remove grass
    {
        private _trenchGrassCutter = createVehicle ["Land_ClutterCutter_medium_F", [0, 0, 0], [], 0, "NONE"];
        private _cutterPos = AGLToASL (_trench modelToWorld _x);
        _cutterPos set [2, getTerrainHeightASL _cutterPos];
        _trenchGrassCutter setPosASL _cutterPos;
        deleteVehicle _trenchGrassCutter;
    } forEach getArray (configOf _trench >> "ace_trenches_grassCuttingPoints");
};

[{
    params ["_args", "_handle"];
    _args params ["_trench", "_unit", "_digTime"];

    private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];
    private _diggerCount = count (_trench getVariable [QGVAR(diggers), []]);

    if (
        !(_trench getVariable ["ace_trenches_digging", false]) ||
        {_diggerCount <= 0}
    ) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
        _trench setVariable ["ace_trenches_digging", false, true];
        [QEGVAR(common,handleDiggerToGVAR), [_trench, _unit, true]] call CBA_fnc_serverEvent;
    };

    if (_actualProgress >= 1) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    private _newProgress = _actualProgress + (_diggerCount / _digTime);

    [_trench, _newProgress, 1.5] call EFUNC(common,setTrenchProgress); // Not too fast so animation is still visible
    [_trench, _newProgress, 1.5, "drop", [configOf _trench >> QGVAR(offset1), "NUMBER", 2] call CBA_fnc_getConfigEntry] call EFUNC(common,setTrenchProgress); // Not too fast so animation is still visible
    [QEGVAR(common,applyFatigue), [_trench, _unit], _unit] call CBA_fnc_targetEvent;

    // Show special effects
    if (GVAR(allowEffects)) then {
        [QEGVAR(common,digFX), [_trench]] call CBA_fnc_globalEvent;

        [_trench] call EFUNC(common,playSound);
    };

}, 1, [_trench, _unit, _digTime]] call CBA_fnc_addPerFrameHandler;

// Play animation
[_unit] call EFUNC(common,loopanimation);

[QEGVAR(common,resetDecay), [_trench]] call CBA_fnc_serverEvent;
