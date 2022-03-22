#include "script_component.hpp"
/*
 * Author: Salbei
 * Digging trenches with vehicles.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Trench Class <STRING>
 * 2: Offset <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle ACE_player, ACE_player, [0,0,0]] call grad_trenches_functions_fnc_bpzBuild
 *
 * Public: No
 */

params ["_vehicle", "_trenchClass", "_offset"];

 
private _vehicle = vehicle player,    
private _trenchClass = "GRAD_envelope_vehicle";    
private _offset = [0,5,-5];    
private _trench = _trenchClass createVehicle [0,0,0];     
private _digTime = 10;     
   
[_trench, 0] call grad_trenches_functions_fnc_setTrenchProgress;    
_trench attachTo [_vehicle, _offset];     
_trench setObjectTexture [0, surfaceTexture getPos _vehicle];   
   
_vehicle setCruiseControl [7, false];   
     
[{     
    params ["_args", "_handle"];     
    _args params ["_vehicle", "_trench", "_digTime"];     
     
    private _actualProgress = _trench getVariable ["ace_trenches_progress", 0];     
     
    if (     
        isNull _vehicle ||     
        !(alive _vehicle) ||     
        _actualProgress >= 1     
    ) exitWith {     
        hint "isnull vehicle stuff";   
        [_handle] call CBA_fnc_removePerFrameHandler; _trench disableCollisionWith _vehicle;    
        detach _trench;     
        _trench setVariable ["ace_trenches_placeData", [getPos _trench, [vectorDir _trench, vectorUp _trench]], true];     
        _vehicle setCruiseControl [0, false];   
    };     
 
    private _speed = speed _vehicle;   
    private _diff = 1/(_digTime*10);     
     
    if (_speed > 1) then {     
        [_trench, _actualProgress + _diff, 0.7] call grad_trenches_functions_fnc_setTrenchProgress;   
        _trench setObjectTexture [0, surfaceTexture position _vehicle];    hint "raise"; 
    } else {     
        if (_speed < -0.5) then {     
            hint "speed lower -0.5";   
           [_handle] call CBA_fnc_removePerFrameHandler;     
            detach _trench;     
            _trench setVariable ["ace_trenches_placeData", [getPos _trench, [vectorDir _trench, vectorUp _trench]], true];     
            _vehicle setCruiseControl [0, false];   
        };   
    };     
}, 0.1, [_vehicle, _trench, _digTime]] call CBA_fnc_addPerFrameHandler;   