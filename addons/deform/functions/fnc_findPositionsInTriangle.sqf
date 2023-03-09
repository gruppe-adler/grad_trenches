#include "script_component.hpp"
/*
 * Author: Salbei
 * Replace clutter on triangles
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

params ["_lastPos", "_amount", "_spacing", "_posA", "_posB", "_middlePos", ["_oldReturn", []]];

private _return = [];
private _returnCheck = _oldReturn;

 for "_i" from 1 to (_amount * 2)  do {
	for "_o" from 1 to 15 do {
		private _newPos = _lastPos getPos [(_spacing + (random 1)), ((_dir + (random 360)) mod 360)];
		private _checkDistance = _returnCheck select {(_x distance _newPos) < _spacing};

		if (
			(_newPos inPolygon [_posA, _posB, _middlePos]) &&
			{_checkDistance isEqualTo []} &&
			{!((_newPos distance _posA) < _spacing)}
		) exitWith {
			_return pushBack _newPos;
			_returnCheck pushBack _newPos;
			_lastPos = _newPos;
		};
	};
};

if (_return isNotEqualTo []) then {
	_return = _return call BIS_fnc_arrayShuffle;
	_return deleteRange [4, count _return];
};

_return + _oldReturn
