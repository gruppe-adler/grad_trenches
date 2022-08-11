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
    ["_trench", objNull],
    ["_boundingBox", [], [[]], [2]],
    ["_zASL", 0, 0]
];

getTerrainInfo params ["", "", "_cellsize"];
private _cells = [_boundingBox] call FUNC(getCellsToAdjst);
private _pos = getPosWorld _trench;

gridLines = [];

{
    //#ifdef DEBUG_MODE_FULL
        private _p1 = [_x, _y] vectorMultiply _cellsize;	  //bottom-left corner
        private _p2 = [_x, _y + 1] vectorMultiply _cellsize;  //top-left corner
        private _p3 = [_x + 1, _y] vectorMultiply _cellsize;  //bottom-right corner
        _p1 set [2, 0.1];
        _p2 set [2, 0.1];
        _p3 set [2, 0.1];

        gridLines pushBack [_p1, _p2, [1,0,0,1]];
        gridLines pushBack [_p1, _p3, [1,0,0,1]];
        gridLines pushBack [_p2, _p3, [0,1,0,1]];
    //#endif
    if !(_trench inArea [_x, _cellsize, _cellsize, 0, true]) then {
        private _obj = "GRAD_envelope_filler5m" createVehicle [0,0,0];
        _obj setPos _x;

    };
}forEach _cells;

//#ifdef DEBUG_MODE_FULL
    onEachFrame {
        {
            drawLine3d _x;
        } forEach _gridLines;
    };
//#endif

private _arr = _cells apply {[_x select 0, _x select 1, _zASL]};
setTerrainHeight _arr;

_cells
