#include "script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet, Ruthberg, edited by commy2 for better MP and eventual AI support, esteldunedain, Salbei
 * Starts the place process for trench.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Trench class <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player, "ACE_envelope_small"] call grad_trenches_deform_fnc_choosePos
 *
 * Public: No
 */

params ["_unit", "_trenchClass"];

// Load trench data
GVAR(trenchPlacementData) = getArray (configFile >> "CfgVehicles" >> _trenchClass >> "ace_trenches_placementData");
TRACE_1("",ace_trenches_trenchPlacementData);


// Prevent the placing unit from running
[_unit, "forceWalk", "GRAD_Trenches", true] call ace_common_fnc_statusEffect_set;
[_unit, "blockThrow", "GRAD_Trenches", true] call ace_common_fnc_statusEffect_set;

private _trench = createSimpleObject [_trenchClass, [0, 0, 0], true];
_trench hideObjectGlobal true;
GVAR(trench) = _trench;

// Prevent collisions with trench
["ace_common_enableSimulationGlobal", [_trench, false]] call CBA_fnc_serverEvent;

([_trench] call FUNC(getBBThatNeedsToBeDugOut)) params ["_boundingBox", "_zASL"];

_boundingBox params [
    ["_min", [], [[]], [2, 3]],
    ["_max", [], [[]], [2, 3]]
];

private _pegs = [];
{
    private _obj = createSimpleObject ["", [0, 0, 0], true];
    _obj attachTo [_trench, _x];

    _pegs pushBack _obj;
}forEach [_min, [_min #0, _max #1], [_max #0, _min #1], _max];

GVAR(digDirection) = 0;

GVAR(positionPFH) = [{
    params ["_args", "_handle"];
    _args params ["_unit", "_trench", "_pegs"];

    //Check if all helper objects are still there
    private _oneLost = false;
    {
        if (isNull _x) exitWith {
            _oneLost = true;
        };
    }forEach _pegs;

    if (_oneLost ||{isNull _trench}) exitWith {
        [_unit] call FUNC(placeCancel);
    };

    //Choose texture to indicate possibility of digging
    private _texture = "#(rgb,8,8,3)color(0,1,0,1)";
    if !([_unit, _trench] call FUNC(canDigDeformTrench)) then {
        _texture = "#(rgb,8,8,3)color(1,0,0,1)";
    };

    {
        _x setObjectTextureGlobal [1, _texture];
    }forEach _pegs;

    GVAR(trenchPlacementData) params ["_dx", "_dy", "_offset"];
    private _basePos = _unit modelToWorld [0, 4, 0];
    private _angle = GVAR(digDirection) + getDir _unit;

    // _v1 forward from the player, _v2 to the right, _v3 points away from the ground
    private _v3 = surfaceNormal _basePos;
    private _v2 = [sin _angle, +cos _angle, 0] vectorCrossProduct _v3;
    private _v1 = _v3 vectorCrossProduct _v2;

    // Stick the trench to the ground
    _basePos set [2, getTerrainHeightASL _basePos];
    private _minzoffset = 0;
    private _ix = 0;
    private _iy = 0;

    for [{_ix = -_dx/2},{_ix <= _dx/2},{_ix = _ix + _dx/3}] do {
        for [{_iy = -_dy/2},{_iy <= _dy/2},{_iy = _iy + _dy/3}] do {
            private _pos = _basePos vectorAdd (_v2 vectorMultiply _ix) vectorAdd (_v1 vectorMultiply _iy);
            _minzoffset = _minzoffset min ((getTerrainHeightASL _pos) - (_pos select 2));
        };
    };

    _basePos set [2, (_basePos select 2) + _minzoffset + _offset];
    TRACE_2("", _minzoffset, _offset);
    _trench setPosASL _basePos;
    _trench setVectorDirAndUp [_v1, _v3];
}, 0, [_unit, _trench, _pegs]]call CBA_fnc_addPerFrameHandler;

// Add mouse button action and hint
[localize "STR_ace_trenches_ConfirmDig", localize "STR_ace_trenches_CancelDig"] call ace_interaction_fnc_showMouseHint;

_unit setVariable [GVAR(Dig), [
    _unit, "DefaultAction",
    {GVAR(digPFH) != -1},
    {[_this select 0] call FUNC(confirmPos)}
] call ace_common_fnc_addActionEventHandler];

_unit setVariable [GVAR(isPlacing), true, true];
