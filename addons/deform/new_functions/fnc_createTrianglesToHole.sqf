#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * fill the area around a trench up to the provided outer border with fillers
 *
 * Arguments:
 * 0: borderLines of the trench. positions in format PositionASL <ARRAY>
 * 1: list of lines that form the outer border of the hole. positions in format PositionASL <ARRAY>
 * 2: list of trenchFillingTriangles. positions in format PositionASL <ARRAY>
 *
 * Return Value:
 * Array of positions (ASL) and filler objects.<ARRAY>
 *		each element of this array is an array of the following structure: [[<ARRAY>, <ARRAY>, <ARRAY>], <OBJECT>]. 
 *
 * Example:
 *	[[
		[[1992.79,5574.74,5.89199],[1994.45,5573.92,5.89613]],
		[[1994.45,5573.92,5.89613],[1995.06,5570.57,5.89764]],
		[[1993.85,5568.91,5.89462],[1995.06,5570.57,5.89764]],
		[[1992.13,5569.88,5.89032],[1993.85,5568.91,5.89462]],
		[[1991.43,5573.21,5.88856],[1992.13,5569.88,5.89032]],
		[[1991.43,5573.21,5.88856],[1992.79,5574.74,5.89199]]
	],[
		[[1996,5580,5.91],[2000,5576,5.91]],
		[[1992,5580,5.9],[1996,5580,5.91]],
		[[2000,5568,5.9],[2000,5572,5.91]],
		[[2000,5572,5.91],[2000,5576,5.91]],
		[[1996,5564,5.89],[2000,5568,5.9]],
		[[1992,5564,5.91],[1996,5564,5.89]],
		[[1988,5568,5.89],[1992,5564,5.91]],
		[[1988,5568,5.89],[1988,5572,5.89]],
		[[1988,5572,5.89],[1988,5576,5.89]],
		[[1988,5576,5.89],[1992,5580,5.9]],
		[[2000,5564,5.9],[2000,5568,5.9]],
		[[1996,5564,5.89],[2000,5564,5.9]],
		[[1988,5580,5.89],[1992,5580,5.9]],
		[[1988,5576,5.89],[1988,5580,5.89]]
	],[
		[[1992.79,5574.74,5.89199],[1994.45,5573.92,5.89613],[1995.06,5570.57,5.89764]],
		[[1992.79,5574.74,5.89199],[1995.06,5570.57,5.89764],[1993.85,5568.91,5.89462]],
		[[1992.79,5574.74,5.89199],[1993.85,5568.91,5.89462],[1992.13,5569.88,5.89032]],
		[[1992.79,5574.74,5.89199],[1992.13,5569.88,5.89032],[1991.43,5573.21,5.88856]]
	]] call ELD_magicTriangle_scripts_fnc_createTrianglesToHole;
 *
 * Public: No
 */





//TODO remove z coordinate from point comparisons when it's not needed

params ["_borderLines", "_terrainLines", "_trenchFillingTriangles"];


{_x sort true} foreach _terrainLines;

private _terrainPoints = [];

{
	_terrainPoints pushBackUnique (_x # 0);
	_terrainPoints pushBackUnique (_x # 1);
} foreach _terrainLines;



private _triangles = [];
private _usedSides = [];
_usedSides append _terrainLines;
// isEqualTo will deep compare arrays
// + array will deep copy arrays


_usedSides append _borderLines;



//_triangles append _trenchFillingTriangles;






//_triangles = [];
private _running = true;
private _count = 0;



// g = 0;
// l = 0;
// h = 0;




// _possibleStartSides now in format [[[pos1, pos2], posOtherside], [[pos1b, pos2b], posOthersideb]]
private _possibleStartSides = [];

{_x sort true} foreach _borderLines;
{
	private _thisBL = _x;
	private _extraPoint = [];
	private _found = false;
	{
		private _thisTFT = _x;
		private _sides = [[_thisTFT # 0, _thisTFT # 1], [_thisTFT # 1, _thisTFT # 2], [_thisTFT # 2, _thisTFT # 0]];
		{_x sort true} foreach _sides;
		if ((_sides # 0) isEqualTo _thisBL) then {
			_extraPoint = _thisTFT # 2;
			_found = true;
			break;
		};
		if ((_sides # 1) isEqualTo _thisBL) then {
			_extraPoint = _thisTFT # 0;
			_found = true;
			break;
		};
		if ((_sides # 2) isEqualTo _thisBL) then {
			_extraPoint = _thisTFT # 1;
			_found = true;
			break;
		};
	} foreach _trenchFillingTriangles;
	if (!_found) throw "check trench configs, tft or bl not set up correctly";
	
	private _thisPSS = [_thisBL, _extraPoint];
	
	_possibleStartSides append [_thisPSS];
	
} foreach _borderLines;



//part of experimental ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
private _trenchPoints = [];

{
	_trenchPoints pushBackUnique (_x # 0);
	_trenchPoints pushBackUnique (_x # 1);
} foreach _borderLines;





// TestTriangle = [];
GVAR(startTime) = diag_tickTime;

while {_running} do {
	
	/*
	{_x sort true} foreach _usedSides;
	_possibleStartSides = [];
	{
		_i = _x;
		_count = {_i isEqualTo _x} count _usedSides;
		if (_count == 1) then {
			_possibleStartSides append [_i];
		};
	} foreach _usedSides;
	_possibleStartSides = _possibleStartSides - _terrainLines;
	*/

	//f = _possibleStartSides;

	// repeatable block start
	private _newPossibleStartSides = [];
	{
		private _possibleTriangles = [];
		private _thisPSS = + _x;
		private _line = _thisPSS # 0;
		private _extraPoint = _thisPSS # 1;
		{
			//timing thing
			// g = g + 1;
			// if (g == 10) then {
			// 	TestTriangle = [_x, _extraPoint, _line #0, _line #1];
			// };
			
			//first check, does it go backwards into what it came from?
			if ([_x, _extraPoint, _line #0, _line #1] call FUNC(sameSide)) then { 
				continue;
			};
			
			
			
			private _thisPT = [_line #0, _line #1, _x];  // _thisPossibleTriangle
			private _sides = [[_thisPT # 0, _thisPT # 1], [_thisPT # 1, _thisPT # 2], [_thisPT # 2, _thisPT # 0]];
			{_x sort true} foreach _sides;
			private _allowed = true;
			
			
			
			
			
			
			
			
			{ // compare with other used sides and sides consisting of two times the same point
				private _i = _x;
				private _count2 = {_i isEqualTo _x} count _usedSides; // there is another _count a layer higher
				if (_count2 > 1 || (_i # 0) isEqualTo (_i # 1)) then {
					_allowed = false;
					break;
				};
			} foreach _sides;
			
			if (!_allowed) then {
				continue;
			};
			
			
			// check if triangle is extremely flat
			private _sa = (_thisPT # 0) distance2D (_thisPT # 1); 
			private _sb = (_thisPT # 1) distance2D (_thisPT # 2); 
			private _sc = (_thisPT # 2) distance2D (_thisPT # 0);
			/*if ((_sb == 0) || (_sc == 0)) then { //checking this because once i got an error zero divisor on the angle calculation -- probably fixed, removing this code
				_allowed = false;
				continue;
			};*/
			private _angle1 = acos (((_sb ^ 2) + (_sc ^ 2) - (_sa ^ 2)) / (2 * _sb * _sc));
			if (_angle1 < 3 || _angle1 > 177) then {
				_allowed = false;
				continue;
			};
			
			
			//part of experimental ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			
			{	//check if any terrain or trench points are in the triangle
				
				if ((!(_x in _thisPT)) && (_x inPolygon _thisPT)) then {
					_allowed = false;
					break;
				};
			} foreach (_terrainPoints + _trenchPoints);
			
			
			if (!_allowed) then {
				continue;
			};
			
			
			{ // check if triangle intersects terrain lines
				if (([_x # 0, _extraPoint, _line #0, _line #1] call FUNC(sameSide)) && {[_x # 1, _extraPoint, _line #0, _line #1] call FUNC(sameSide)}) then { 
					continue;
				};
				private _x1 = (_x # 0) # 0;
				private _y1 = (_x # 0) # 1;
				private _x2 = (_x # 1) # 0;
				private _y2 = (_x # 1) # 1;
				private _t2 = _thisPT;
				private _int1 = ([_x1, _y1, _x2, _y2, (_t2 # 0) # 0, (_t2 # 0) # 1, (_t2 # 1) # 0, (_t2 # 1) # 1] call FUNC(linesIntersect)) || ([_x1, _y1, _x2, _y2, (_t2 # 1) # 0, (_t2 # 1) # 1, (_t2 # 2) # 0, (_t2 # 2) # 1] call FUNC(linesIntersect)) || ([_x1, _y1, _x2, _y2, (_t2 # 2) # 0, (_t2 # 2) # 1, (_t2 # 0) # 0, (_t2 # 0) # 1] call FUNC(linesIntersect));
				if (_int1) then {
					_allowed = false;
					
					break;
				};
			} foreach _terrainLines;
			
			
			if (!_allowed) then {
				continue;
			};
			
			
			// check if one side of the triangle covers 2 terrainlines at once.   added to fix a very specific bug.
			
			private _p1 = [(_thisPT # 1 # 0 + _thisPT # 2 # 0)/2, (_thisPT # 1 # 1 + _thisPT # 2 # 1)/2];
			private _p2 = [(_thisPT # 0 # 0 + _thisPT # 2 # 0)/2, (_thisPT # 0 # 1 + _thisPT # 2 # 1)/2];
			private _p3 = [(_thisPT # 0 # 0 + _thisPT # 1 # 0)/2, (_thisPT # 0 # 1 + _thisPT # 1 # 1)/2];
			{
				private _x2d = [_x # 0, _x # 1];
				if ((_p1 isEqualTo _x2d) || (_p2 isEqualTo _x2d) || (_p3 isEqualTo _x2d)) then {
					_allowed = false;
					
					break;
				};
			} foreach _terrainPoints;
			
			
			if (!_allowed) then {
				continue;
			};
			
			{ //check if triangle intersects any other triangle (overused and probably expensive)
				// l = l + 1;
					
				if ((([_x # 0, _extraPoint, _line #0, _line #1] call FUNC(sameSide)) && {[_x # 1, _extraPoint, _line #0, _line #1] call FUNC(sameSide)}) && {[_x # 2, _extraPoint, _line #0, _line #1] call FUNC(sameSide)}) then { 
					continue;
				};
				// h = h + 1;
				
				if ([_thisPT, _x] call FUNC(triangleIntersect)) then {
					_allowed = false;
					break;
				};
			} foreach _triangles;// + _trenchFillingTriangles;// no longer necessary
			
			
			if (!_allowed) then {
				continue;
			};
			
			
			
			
			if (_allowed) then {
				_possibleTriangles append [_thisPT];
			};
			
		} foreach (_terrainPoints + _trenchPoints); //experimental thing here --------------------------------------------------------------------------------------------------------------------------------------------------
		
		if ((count _possibleTriangles) == 0) then {
			continue;
		};
		
		//s = _possibleTriangles;
		
		
		private _possibleTrianglesSorted = [_possibleTriangles, [], {
			private _sa = (_x # 0) distance2D (_x # 1);
			private _sb = (_x # 1) distance2D (_x # 2);
			private _sc = (_x # 2) distance2D (_x # 0);
			selectMin [acos (((_sb ^ 2) + (_sc ^ 2) - (_sa ^ 2)) / (2 * _sb * _sc)), acos (((_sa ^ 2) + (_sc ^ 2) - (_sb ^ 2)) / (2 * _sa * _sc)), acos (((_sa ^ 2) + (_sb ^ 2) - (_sc ^ 2)) / (2 * _sa * _sb))];
		}, "DESCEND"] call BIS_fnc_sortBy;
		
		
		private _finaltriangle = _possibleTrianglesSorted # 0;
		//_finaltrianglestill in format [_line #0, _line #1, thirdpoint];
		
		private _sides = [[_finalTriangle # 0, _finalTriangle # 1], [_finalTriangle # 1, _finalTriangle # 2], [_finalTriangle # 2, _finalTriangle # 0]];
		{_x sort true} foreach _sides;
		private _sn0 = [_finalTriangle # 1, _finalTriangle # 2];
		_sn0 sort true;
		private _sn1 = [_finalTriangle # 0, _finalTriangle # 2];
		_sn1 sort true;
		private _sn2 = [_finalTriangle # 1, _finalTriangle # 0];
		_sn2 sort true;
		
		if (!(_sn0 in _usedSides)) then {
			_newPossibleStartSides append [[_sn0, _finalTriangle # 0]];
		};
		if (!(_sn1 in _usedSides)) then {
			_newPossibleStartSides append [[_sn1, _finalTriangle # 1]];
		};
		if (!(_sn2 in _usedSides)) then {
			//this should never happen, i have it here just to be sure
			_newPossibleStartSides append [[_sn2, _finalTriangle # 2]];
		};
		
		
		
		/*
		
		if (_finaltriangle isEqualTo [[1992,5536,9.34],[1997.15,5534.67,8.75883],[1996,5540,9.7]]) then {l = [(_sn0 in _usedSides), (_sn1 in _usedSides), (_sn2 in _usedSides)];};
		*/
		
		
		
		_usedSides append _sides;
		_triangles append [_finaltriangle];
		
		
		// make used triangle sides list and blacklist sides from being used more than 2 times, put _borderLines into it as well as the sides of the hole in the ground.
	} foreach _possibleStartSides;


	/*
	{_x sort true} foreach _usedSides;
	_possibleStartSides = [];
	{
		_i = _x;
		_count = {_i isEqualTo _x} count _usedSides;
		if (_count == 1) then {
			_possibleStartSides append [_i];
		};
	} foreach _usedSides;
	_possibleStartSides = _possibleStartSides - _terrainLines;
	*/
	
	_possibleStartSides = + _newPossibleStartSides;
	
	if ((count _possibleStartSides) == 0) then {
		_running = false;
	};
	_count = _count + 1;
	if (_count == 6) exitwith {msg = "triangle creation ended with possible sides left"};
};

GVAR(endTime) = diag_tickTime;







// triangles = _triangles;
// d = [];

private _trianglesPositionsAndObjects = [];

{
	private _obj = _x call FUNC(createTriangle);
	_obj setObjectTextureGlobal [0, surfaceTexture getpos _obj];
	// d append [_obj];
	_trianglesPositionsAndObjects append [[_x, _obj]]
} foreach _triangles;

_trianglesPositionsAndObjects;
