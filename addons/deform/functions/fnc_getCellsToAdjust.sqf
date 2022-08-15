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

_min params [ ["_xMin", 0, [0]], ["_yMin", 0, [0]] ];
_max params [ ["_xMax", 0, [0]], ["_yMax", 0, [0]] ];

private _minCell = [_min] call FUNC(getPosCell);
private _maxCell = [_max] call FUNC(getPosCell);
if (_minCell isNotEqualTo _maxCell) then {
    _xMax = _xMax + _cellsize;
    _yMax = _yMax + _cellsize;
};

if (_areaToCover) then {
    _xMin = _xMin - _cellsize;
    _xMax = _xMax + _cellsize;
    _yMin = _yMin - _cellsize;
    _yMax = _yMax + _cellsize;
};

systemChat str [_xMin, _xMax, _yMin, _yMax];

private _cells = [];
private _xCord = _xMin;
private _yCord = _yMin;

for [{ _x = _xCord }, { _x <= _xMax }, { _x = _x + _cellsize }] do {
    for [{ _y = _yCord }, { _y <= _yMax }, { _y = _y + _cellsize }] do {
        _cells pushBack [_x, _y];
    };
};

_cells
