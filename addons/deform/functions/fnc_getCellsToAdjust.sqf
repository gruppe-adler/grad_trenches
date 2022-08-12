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
 * [boundingBox TrenchObj, false] call grad_trenches_deform_fnc_fnc_getCellsToAdjust;
 *
 * Public: No
 */

params [
    ["_relativeBB", [], [[]], [2]],
    ["_areaToCover", false, [false]],
    ["_cellsize", 0, [0]]
];

private _boundingBox = _relativeBB apply { _obj modelToWorld _x };
_boundingBox params [
    ["_min", [], [[]], [2, 3, 0]],
    ["_max", [], [[]], [2, 3, 0]]
];

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

diag_log format ["xMin: %1, yMin: %2, xMax: %3, yMax: %4", _xmin, _ymin, _xmax, _ymax];

private _cells = [];

private _x = _xmin;
private _y = _ymin;
while {_x <= _xmax} do {
    while {_y <= _ymax} do {
        _cells pushBack [_x, _y];
    };
};

_cells
