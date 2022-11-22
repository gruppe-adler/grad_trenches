#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * finds terrain points that need to be lowered for the passed objects to fit into the hole
 *
 * Arguments:
 * 0: list of trench objects <ARRAY>
 *
 * Return Value:
 * array of positions of points to be lowered in format Position2d <ARRAY>
 *
 * Example:
 * [[_tronch1, _tronch2]] call ELD_magicTriangle_scripts_fnc_makeManyHole;
 *
 * Public: No
 */

params ["_tronches"];

private _pointsToModify = [];
{
	_pointsToModify = _pointsToModify + ([_x] call FUNC(makeSingleHole));
} foreach _tronches;

private _pointsToModify2 = [];
{
	_pointsToModify2 pushbackunique _x;
} foreach _pointsToModify;

_pointsToModify2
