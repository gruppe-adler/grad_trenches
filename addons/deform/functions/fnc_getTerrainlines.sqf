#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * get the borders of a hole that is made by lowering the passed points.
 *
 * Arguments:
 * 0: array of positions of lowered points in format Position2d <ARRAY>
 *
 * Return Value:
 * Array of lines <ARRAY>
 * 		each element of this array is an array of the following structure: [<ARRAY>, <ARRAY>]
 * 			each element of this array is an array in format PositionASL
 *
 * Example:
 * [[[1996,5564],[2000,5564]]] call ELD_magicTriangle_scripts_fnc_getTerrainLines;
 *
 * Public: No
 */

params ["_points"];
// points come in as 2d points

private _pointsComp = + _points;
for "_i" from 0 to ((count _pointsComp) - 1) do {(_pointsComp # _i) deleteAt 2;};

private _cellsize = getTerrainInfo#2;

private _borderpoints = [];
{
	private _tests = [[_x # 0, _x # 1 + _cellsize], [_x # 0 + _cellsize, _x # 1], [_x # 0 + _cellsize, _x # 1 - _cellsize], [_x # 0, _x # 1 - _cellsize], [_x # 0 - _cellsize, _x # 1], [_x # 0 - _cellsize, _x # 1 + _cellsize]];
	{
		if (!(_x in _pointsComp)) then {
			_borderpoints pushbackunique _x;
		};
	} foreach _tests;

} foreach _points;

private _borderLines = [];
private _borderpointsCompare = + _borderpoints;
{
	private _thisBP = _x;
	private _heightThis = getTerrainHeight _x;
	private _tests = [[_x # 0, _x # 1 + _cellsize], [_x # 0 + _cellsize, _x # 1], [_x # 0 + _cellsize, _x # 1 - _cellsize], [_x # 0, _x # 1 - _cellsize], [_x # 0 - _cellsize, _x # 1], [_x # 0 - _cellsize, _x # 1 + _cellsize]];
	{
		if ((_x in _borderpointsCompare)) then {
			private _height = getTerrainHeight _x;
			_borderLines pushback [(_x + [_height]), (_thisBP + [_heightThis])];
		};
	} foreach _tests;
	_borderpointsCompare = _borderpointsCompare - [_x];
} foreach _borderpoints;

_borderLines;
