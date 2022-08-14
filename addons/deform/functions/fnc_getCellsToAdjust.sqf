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
 * [trench, boundingBox TrenchObj, 4, false] call grad_trenches_deform_fnc_fnc_getCellsToAdjust;
 *
 * Public: No
 */

params [
    "_trench",
    ["_relativeBB", [], [[]], [2]],
    ["_cellsize", 0, [0]],
    ["_areaToCover", false, [false]]
];

private _boundingBox = _relativeBB apply { _trench modelToWorld _x };
_boundingBox params [
    ["_min", [], [[]], [2, 3, 0]],
    ["_max", [], [[]], [2, 3, 0]]
];

_min params [ ["_xmin", 0, [0]], ["_ymin", 0, [0]] ];
_max params [ ["_xmax", 0, [0]], ["_ymax", 0, [0]] ];

if (_areaToCover) then {
    _xmin = _xmin - _cellsize;
    _xmax = _xmax + _cellsize;
    _ymin = _ymin - _cellsize;
    _ymax = _ymax + _cellsize;
};

private _cells = [];
private _xCord = _xmin;
private _yCord = _ymin;

for [{ _x = _xCord }, { _x <= _xmax }, { _x = _x + 1 }] do {
    for [{ _y = _yCord }, { _y <= _ymax }, { _y = _y + 1 }] do {
        _cells pushBack [_x, _y];
    };
};

_cells
