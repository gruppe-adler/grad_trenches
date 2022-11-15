#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * more or less calculates if two 2d lines intersect. i have no clue what it actually does.
 * at the moment it works so investigating what this does is not that important.
 *
 * Arguments:
 * 0: x Position of first point of line 1 <NUMBER>
 * 1: y Position of first point of line 1 <NUMBER>
 * 2: x Position of second point of line 1 <NUMBER>
 * 3: y Position of second point of line 1 <NUMBER>
 * 4: x Position of first point of line 2 <NUMBER>
 * 5: y Position of first point of line 2 <NUMBER>
 * 6: x Position of second point of line 2 <NUMBER>
 * 7: y Position of second point of line 2 <NUMBER>
 *
 * Return Value:
 * whether the lines intersect or not or something similar, idk <BOOLEAN>
 *
 * Example:
 * [1,1,5,5,1,5,5,1] call ELD_magicTriangle_scripts_fnc_linesIntersect;
 *
 * Public: No
 */

scopename "linesIntersect";
params ["_x1", "_y1", "_x2", "_y2", "_x3", "_y3", "_x4", "_y4"];

// http://thirdpartyninjas.com/blog/2008/10/07/line-segment-intersection/
// true if intersect, false if no intersect or coincident
// with a bit of extra room for no collision with matching corners

private _denominator = ((_y4 - _y3) * (_x2 - _x1)) - ((_x4 - _x3) * (_y2 - _y1));


if (_denominator < 0.0001 && _denominator > -0.0001) then {
	false breakOut "linesIntersect";
	//if (!_coincident) //exitwith {hint "BOING!!"; false};
};

private _numerator1 = ((_x4 - _x3) * (_y1 - _y3)) - ((_y4 - _y3) * (_x1 - _x3));
private _numerator2 = ((_x2 - _x1) * (_y1 - _y3)) - ((_y2 - _y1) * (_x1 - _x3));

private _u1 = _numerator1 / _denominator;
private _u2 = _numerator2 / _denominator;

if (0.0001 <= _u1 && _u1 <= 0.9999 && 0.0001 <= _u2 && _u2 <= 0.9999) exitWith {true};

// i believe these are just random default values because things being nil or null or whatever thends to break everything without throwing any errors
private _ac = 100;
private _ab = 50;
private _bc = 0;

if (_x1 == _x3 && _y1 == _y3) then {
	_ac = [_x1, _y1] distance2D [_x2, _y2];
	_ab = [_x1, _y1] distance2D [_x4, _y4];
	_bc = [_x4, _y4] distance2D [_x2, _y2];
} else {
	if (_x1 == _x4 && _y1 == _y4) then {
		_ac = [_x1, _y1] distance2D [_x2, _y2];
		_ab = [_x1, _y1] distance2D [_x3, _y3];
		_bc = [_x3, _y3] distance2D [_x2, _y2];
	} else {
		if (_x2 == _x3 && _y2 == _y3) then {
			_ac = [_x2, _y2] distance2D [_x1, _y1];
			_ab = [_x2, _y2] distance2D [_x4, _y4];
			_bc = [_x4, _y4] distance2D [_x1, _y1];
		} else {
			if (_x2 == _x4 && _y2 == _y4) then {
				_ac = [_x2, _y2] distance2D [_x1, _y1];
				_ab = [_x2, _y2] distance2D [_x3, _y3];
				_bc = [_x3, _y3] distance2D [_x1, _y1];
			} else {
				false breakOut "linesIntersect";
			};
		};
	};
};

private _diff1 = _ac + _bc - _ab;
private _diff2 = _ab + _bc - _ac;

//i think this was some form of ellipse check that i made to get rid of lines that have a matching start point, different length and a very small angle between them.
//i dont remember why this was necessary or if it actually fixed what it was supposed to fix, but i don't wanna test if i need it right now.

//when i eventually test it i'd start with a test that counts how often the condition is triggered on average, if its not a lot take a look at individual cases.
//thinking back a bit more the problem this was meant to solve might have also been solved by the opposite side check, which would make this redundant.

if (_diff1 < 0.02 || _diff2 < 0.02) then {true breakOut "linesIntersect";};

false;
