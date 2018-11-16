/*
 * Author: Garth 'L-H' de Wet, Ruthberg, edited by commy2 for better MP and eventual AI support and esteldunedain
 * Removes trench
 *
 * Arguments:
 * 0: trench <OBJECT>
 * 1: unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, ACE_player] call ace_trenches_fnc_removeTrench
 *
 * Public: No
 */
 #include "script_component.hpp"

params ["_trench", "_unit",["_switchingDigger", false]];
TRACE_2("removeTrench",_trench,_unit);

private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];
if (_actualProgress <= 0) exitWith {};

// Mark trench as being worked on
_trench setVariable ["ace_trenches_digging", true, true];
_trench setVariable [QGVAR(diggingType), "DOWN", true];
private _diggerCount = _trench getVariable [QGVAR(diggerCount), 0];

if (_diggerCount > 0) then {
   if !(_switchingDigger) then {
      [_trench, _unit] call FUNC(addDigger);
   };
}else{
   _trench setVariable [QGVAR(diggerCount), 1,true];
};

private _removeTime = missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> (typeOf _trench) >>"ace_trenches_removalDuration"), 20];

private _placeData = _trench getVariable ["ace_trenches_placeData", [[], []]];
_placeData params ["", "_vecDirAndUp"];

if (count _vecDirAndUp == 0) then {
   _vecDirAndUp = [vectorDir _trench, vectorUp _trench];
};

// Create progress bar
private _fnc_onFinish = {
   (_this select 0) params ["_unit", "_trench"];
   _trench setVariable [QGVAR(diggingType), nil, true];

    // Remove trench
    deleteVehicle _trench;

    // Reset animation
    [_unit, "", 1] call EFUNC(common,doAnimation);
};
private _fnc_onFailure = {
   (_this select 0) params ["_unit", "_trench"];
   _trench setVariable ["ace_trenches_digging", false, true];
   _trench setVariable [QGVAR(diggingType), nil, true];

   // Save progress global
   private _progress = _trench getVariable ["ace_trenches_progress", 0];
   _trench setVariable ["ace_trenches_progress", _progress, true];

   // Reset animation
   [_unit, "", 1] call ace_common_fnc_doAnimation;
};
private _fnc_condition = {
   (_this select 0) params ["", "_trench"];

   if !(_trench getVariable ["ace_trenches_digging", false]) exitWith {false};
   if (_trench getVariable [QGVAR(diggerCount), 0] <= 0) exitWith {false};
   if (GVAR(stopBuildingAtFatigueMax) && (ace_advanced_fatigue_anReserve <= 0))  exitWith {false};
   true
};
[[_unit, _trench, false], _fnc_onFinish, _fnc_onFailure, localize "STR_ace_trenches_RemovingTrench", _fnc_condition] call FUNC(progressBar);

[{
  params ["_args", "_handle"];
  _args params ["_trench", "_unit", "_removeTime", "_vecDirAndUp"];
  private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];
  private _diggerCount = _trench getVariable [QGVAR(diggerCount), 0];

  if (_actualProgress <= 0) exitWith {
     [_handle] call CBA_fnc_removePerFrameHandler;
     _trench setVariable ["ace_trenches_digging", false, true];
     _trench setVariable [QGVAR(diggerCount), 0, true];
     deleteVehicle _trench;
 };

  if (
        !(_trench getVariable ["ace_trenches_digging", false]) ||
        (_diggerCount <= 0)
     ) exitWith {
    [_handle] call CBA_fnc_removePerFrameHandler;
    _trench setVariable ["ace_trenches_digging", false, true];
    _trench setVariable [QGVAR(diggerCount), ((_diggerCount -1) max 0), true];
  };

  private _boundingBox = boundingBoxReal _trench;
  _boundingBox params ["_lbfc"];                                         //_lbfc(Left Bottom Front Corner) _rtbc (Right Top Back Corner)
  _lbfc params ["", "", "_lbfcZ"];

  private _pos = (getPosWorld _trench);
  private _posDiff = (abs(((_trench getVariable [QGVAR(diggingSteps), 0]) * _diggerCount) + _lbfcZ))/(_removeTime*5);
  _pos set [2,((_pos select 2) - _posDiff)];

  _trench setPosWorld _pos;
  _trench setVectorDirAndUp _vecDirAndUp;

  //Fatigue impact
  ace_advanced_fatigue_anReserve = (ace_advanced_fatigue_anReserve - ((_removeTime /12) * GVAR(buildFatigueFactor))) max 0;
  ace_advanced_fatigue_anFatigue = (ace_advanced_fatigue_anFatigue + (((_removeTime /12) * GVAR(buildFatigueFactor))/1200)) min 1;

  // Save progress
  _trench setVariable ["ace_trenches_progress", (_actualProgress - ((1/(_removeTime *10)) * _diggerCount)), true];

  if (GVAR(stopBuildingAtFatigueMax) && (ace_advanced_fatigue_anReserve <= 0)) exitWith {
     [_handle] call CBA_fnc_removePerFrameHandler;
     _trench setVariable ["ace_trenches_digging", false, true];
     _trench setVariable [QGVAR(diggerCount), ((_diggerCount -1) max 0), true];
  };
},0.1,[_trench, _unit, _removeTime, _vecDirAndUp]] call CBA_fnc_addPerFrameHandler;

// Play animation
[_unit, "AinvPknlMstpSnonWnonDnon_medic4"] call ace_common_fnc_doAnimation;
