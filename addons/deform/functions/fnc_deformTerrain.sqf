#include "script_component.hpp"
/*
 * Author: Zade, Salbei
 * Changes the terrain height in an area around an object
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [boundingBox TrenchObj, 0] call grad_trenches_deform_fnc_deformTerrain;
 *
 * Public: No
 */

params [
    "_trench",
    "_boundingBox",
    "_zASL"
];

getTerrainInfo params ["", "", "_cellsize"];
private _cells = [_trench, _boundingBox, _cellsize, true] call FUNC(getCellsToAdjust);
private _pos = getPosWorld _trench;
private _depth = getNumber(configFile >> "CfgVehicles" >> ( typeOf _trench ) >> QGVAR(depth));
if (_cellsize < 5) then {
    {
        if !(_trench inArea [_x, _cellsize, _cellsize, 0, true]) then {
            private _obj = "GRAD_envelope_filler5m" createVehicle [0,0,0];
            _x set [2, -0.1];
            _obj setPosWorld _x;
        };
    }forEach _cells;
} else {

};

diag_log format ["Depth: %1, Pos: %2 = %3", _depth, (_pos select 2)];

private _arr = _cells apply {[_x select 0, _x select 1, (_pos select 2) - _depth]};
setTerrainHeight [_arr, false];

_cells
