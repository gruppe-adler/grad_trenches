#include "script_component.hpp"
/*
 * Author: Zade, Salbei
 * Gets the positions of a selection in a model
 *
 * Arguments:
 * 0: OBJECT <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj] call grad_trenches_deform_fnc_getBBThatNeedsToBeDugOut;
 *
 * Public: No
 */

params [
    "_obj"
];

private _boundingBox = _obj selectionPosition ["drop", "Geometry", "BoundingBox"];

_boundingBox params [
    ["_min", [], [[]], [3]],
    ["_max", [], [[]], [3]]
];

_min params [ ["_x1", 0, [0]], ["_y1", 0, [0]], ["_z1", 0, [0]] ];
_max params [ ["_x2", 0, [0]], ["_y2", 0, [0]], ["_z2", 0, [0]] ];

private _xmin = _x1 min _x2;
private _xmax = _x1 max _x2;

private _ymin = _y1 min _y2;
private _ymax = _y1 max _y2;

private _zmin = _z1 min _z2;

[
    [
        [_xmin, _ymin, 0],
        [_xmax, _ymax, 0]
    ],
    _zmin
]
