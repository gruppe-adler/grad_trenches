#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * calculates whether two points lie on the same side of a line in 2d space.
 * does some rounding fuckery to fit my needs.
 *
 * Arguments:
 * 0: position of the first point in question in format Position2d or Position3d <ARRAY>
 * 1: position of the second point in question in format Position2d or Position3d <ARRAY>
 * 2: position of the first point of the line in format Position2d or Position3d <ARRAY>
 * 3: position of the second point of the line in format Position2d or Position3d <ARRAY>
 *
 * Return Value:
 * whether the points lie on the same side of the line <BOOLEAN>
 *
 * Example:
 * [[3,3], [1,1], [1,7], [7,1]] call ELD_magicTriangle_scripts_fnc_sameSide;
 *
 * Public: No
 */

params ["_p1", "_p2", "_p1Line", "_p2Line"];

// are 2d or 3d vectors
// does some rounding fuckery to fit my needs, do not use for unrelated stuff
// a and b are the end points of the line
private _vector = [_p2Line # 0 - _p1Line # 0, _p2Line # 1 - _p1Line # 1];
private _cp1 = _vector vectorCrossProduct ([_p1 # 0 - _p1Line # 0, _p1 # 1 - _p1Line # 1]);
private _cp2 = _vector vectorCrossProduct ([_p2 # 0 - _p1Line # 0, _p2 # 1 - _p1Line # 1]);

(((_cp1 #2) * (_cp2 #2)) > 0.001)
