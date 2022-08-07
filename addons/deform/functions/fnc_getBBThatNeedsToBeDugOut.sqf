#include "script_component.hpp"
/*
 * Author: Zade, Salbei
 * Changes the terrain height in an area
 *
 * Arguments:
 * 0: Position <POSITION>
 * 1: X-Cordinat <NUMBER>
 * 2: Y-Cordinat <NUMBER>
 * 3: Desired Terrain Height <NUMBER>
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
    ["_obj", objectNull, [objectNull]]
];

private _relativeBB = _obj selectionPosition [SELECTION_NAME, "Memory", "BoundingBox"];
private _boundingBox = _relativeBB apply { _x modelToWorld _obj };

_boundingBox  params [
    ["_min", [], [[]], [3]],
    ["_max", [], [[]], [3]]
];

_min params [ ["_x1", 0, [0]], ["_y1", 0, [0]], ["_z1", 0, [0]] ];
_max params [ ["_x2", 0, [0]], ["_y2", 0, [0]], ["_z2", 0, [0]] ];

private _xmin = _x1 min _x2;
private _xmax = _x1 max _x2;

private _ymin = _y1 min _y2;
private _ymax = _y1 max _y2;

private _zmin = AGLToASL (_z1 min _z2);

[
    [
        [_xmin, _ymin],
        [_xmax, _ymax]
    ],
    _zmin
]
