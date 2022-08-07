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

// Prevent the placing unit from running
[_unit, "forceWalk", "GRAD_Trenches", true] call ace_common_fnc_statusEffect_set;
[_unit, "blockThrow", "GRAD_Trenches", true] call ace_common_fnc_statusEffect_set;

private _trench = createSimpleObject [_trenchClass, [0, 0, 0], true];

private _ret = [_trench] call FUNC(getBBThatNeedsToBeDugOut);
_ret params ["_boundingBox", "_zASL"];

deleteVehicle _trench;

_boundingBox params [
    ["_min", [], [[]], [2, 3]],
    ["_max", [], [[]], [2, 3]]
];

private _offsetArray = [_min, [_min #0, _max #1], [_max #0, _min #1], _max];
private _pegs = [];
private _playerPos = (getPosWorld _unit) vectorAdd [0,2,0];
{
    private _obj = createSimpleObject ["", [0, 0, 0], true];
    _obj setPosWorld (_playerPos) vectorAdd _x;

    _pegs pushBack _obj;
}forEach _offsetArry;

GVAR(positionPFH) = [{
    params ["_args", "_handle"];
    _args params ["_pegs", "_offsetArray"];

    //Check if all helper objects are still there
    private _oneLost = false;
    {
        if (isNull _x) exitWith {
            _oneLost = true;
        };
    }forEach _pegs;

    if (isNull _trench) exitWith {
        [_unit] call FUNC(placeCancel);
    };

    //Choose texture to indicate possibility of digging
    private _texture = "#(rgb,8,8,3)color(0,1,0,1)";
    if !([_unit, _trench] call EFUNC(common,canDigTrench)) exitWith {
        _texture = "#(rgb,8,8,3)color(1,0,0,1)";
    };


}, 0, [_pegs, _offsetArray]]call CBA_fnc_addPerFrameHandler;
