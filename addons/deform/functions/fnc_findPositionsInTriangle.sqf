#include "script_component.hpp"
/*
 * Author: Salbei
 * Replace clutter on trinagles
 *
 * Arguments:
 * 0: Array filled with the corners and object of the triangles <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[[0,0,0], [0,1,0], [1,1,0]], TriangleObject]] call grad_trenches_deform_fnc_findPositionsInTriangle
 *
 * Public: No
 */

params ["_posA", "_posB", "_posC", "_amount", "_area", "_spacing"];

private _lastPos = _posA;
private _return = [];
for "_i" from 1 to _amount do {
    private _check = true;
    while {_check} do {
        private _newPos = _lastPos getPos [_spacing, random 360];
        if (_newPos inPolygon [_posA, _posB, _posC]) then {
            _check = false;
            _return pushBack _newPos;
            _lastPos = _newPos;
        };
    };
};

_return
