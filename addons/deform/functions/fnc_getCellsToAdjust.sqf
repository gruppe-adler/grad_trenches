#include "script_component.hpp"
/*
 * Author: Zade, Salbei
 * Changes the terrain height in an area
 *
 * Arguments:
 * 0: Boundingbox <ARRAY>
 * 1: Area to cover <ARRAY>
 *
 * Return Value:
 * Terrain cells in area
 *
 * Example:
 * [boundingBox TrenchObj, [[50,100], [50,100]]] call grad_trenches_deform_fnc_deformTerrain;
 *
 * Public: No
 */

params [
    ["_bb", [], [[]], [2]],
    ["_areaToCover", false, [false]]
];

_boundingBox  params [
    ["_min", [], [[]], [2, 3]],
    ["_max", [], [[]], [2, 3]]
];

getTerrainInfo params ["", "", "_cellsize"];

_min params [ ["_xmin", 0, [0]], ["_ymin", 0, [0]] ];
_max params [ ["_xmax", 0, [0]], ["_ymax", 0, [0]] ];

private _xmin = floor (_xmin / _cellsize);
private _xmax = ceil (_xmax / _cellsize);

private _ymin = floor (_ymin / _cellsize);
private _ymax = ceil (_ymax / _cellsize);

if (_areaToCover) then {
    _xmin = _xmin - _cellsize;
    _xmax = _xmax + _cellsize;
    _ymin = _ymin - _cellsize;
    _ymax = _ymax + _cellsize;
};

private _cells = [];

private _x = _xmin;
private _y = _ymin;
while {_x <= _xmax} do {
    while {_y <= _ymax} do {
        _cells pushBack [_x, _y];
    };
};

_cells
