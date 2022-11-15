#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * calculates whether a point lies inside a triangle.
 *
 * Arguments:
 * 0: position of the point in question in format Position2d or Position3d <ARRAY>
 * 1: position of a corner of the triangle in format Position2d or Position3d <ARRAY>
 * 2: position of a corner of the triangle in format Position2d or Position3d <ARRAY>
 * 3: position of a corner of the triangle in format Position2d or Position3d <ARRAY>
 *
 * Return Value:
 * whether the point lies inside the triangle <BOOLEAN>
 *
 * Example:
 * [[3,3], [1,1], [1,7], [7,1]] call ELD_magicTriangle_scripts_fnc_pointInTriangle;
 *
 * Public: No
 */

params ["_p1", "_a", "_b", "_c"];

([_p1, _a, _b, _c] call FUNC(sameSide)) && ([_p1, _b, _a, _c] call FUNC(sameSide)) && ([_p1, _c, _a, _b] call FUNC(sameSide));
