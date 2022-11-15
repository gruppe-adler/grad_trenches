#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * calculates whether a point lies inside a triangle, with mildly less arguments than pointInTriangle.
 *
 * Arguments:
 * 0: position of the point in question in format Position2d or Position3d <ARRAY>
 * 1: array of positions of the corners of the triangle in format Position2d or Position3d <ARRAY>
 *
 * Return Value:
 * whether the point lies inside the triangle <BOOLEAN>
 *
 * Example:
 * [[3,3], [[1,1], [1,7], [7,1]]] call ELD_magicTriangle_scripts_fnc_pointInTriangleLA;
 *
 * Public: No
 */

params ["_p1", "_t"];

[_p1, _t # 0, _t # 1, _t # 2] call FUNC(pointInTriangle);
