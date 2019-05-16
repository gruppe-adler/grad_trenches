/*
 * Author: Garth 'L-H' de Wet, Ruthberg, edited by commy2 for better MP and eventual AI support, esteldunedain
 * Starts the place process for trench.
 *
 * Arguments:
 * 0: unit <OBJECT>
 * 1: Trench class <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player, "ACE_envelope_small"] call ace_trenches_fnc_placeTrench
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_trenchClass"];


//Load trench data
private _trenchPlacementData = getArray (configFile >> "CfgVehicles" >> _trenchClass >> "ace_trenches_placementData");
TRACE_1("", _trenchPlacementData);

// prevent the placing unit from running
[_unit, "forceWalk", "ACE_Trenches", true] call ace_common_fnc_statusEffect_set;

// create the trench
//private _trench = createSimpleObject [_trenchClass, [0, 0, 0]];
private _trench = [
    [
        _trenchClass,
        getText (configFile >> "CfgVehicles" >> _trenchClass >> "model")
    ],
    ace_player modelToWorldWorld [0,2,0],
    getDir ace_player,
    true,
    true
] call BIS_fnc_createSimpleObject;
ace_trenches_trench = _trench;

// prevent collisions with trench
["ace_common_enableSimulationGlobal", [_trench, false]] call CBA_fnc_serverEvent;

GVAR(currentSurface) = "";

// pfh that runs while the dig is in progress
ace_trenches_digPFH = [{
    (_this select 0) params ["_unit", "_trench"];

    // Cancel if the helper object is gone
    if (isNull _trench) exitWith {
        [_unit] call ace_trenches_fnc_placeCancel;
    };

    // Cancel if the place is no longer suitable
    private _checkVar = [_unit] call ace_trenches_fnc_canDigTrench;
    if ((typeName _checkVar) == "Number") then {
      if (_checkVar > 0) then {
         _checkVar = true;
      }else{
         _checkVar = false;
      };
    };

    if !(_checkVar) exitWith {
        [_unit] call ace_trenches_fnc_placeCancel;
    };

    // Update trench position
    _trenchPlacementData params ["_dx", "_dy", "_offset"];
    private _basePos = _unit modelToWorldWorld [0,2,0];
    private _angle = getDir _unit;

    if (surfaceType (position _trench) != GVAR(currentSurface)) then {
        GVAR(currentSurface) = surfaceType (position _trench);
        _trench setObjectTextureGlobal [0, [_trench] call FUNC(getSurfaceTexturePath)];
    };
}, 0, [_unit, _trench]] call CBA_fnc_addPerFrameHandler;

// add mouse button action and hint
[localize "STR_ace_trenches_ConfirmDig", localize "STR_ace_trenches_CancelDig"] call ace_interaction_fnc_showMouseHint;

_unit setVariable ["ace_trenches_Dig", [
    _unit, "DefaultAction",
    {ace_trenches_digPFH != -1},
    {[_this select 0] call FUNC(placeConfirm)}
] call ace_common_fnc_addActionEventHandler];

_unit setVariable ["ace_trenches_isPlacing", true, true];
