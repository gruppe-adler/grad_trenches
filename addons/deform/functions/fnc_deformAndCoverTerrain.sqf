#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * init a trench/trench network. has to be executed in a scheduled environment.
 *
 * Arguments:
 * 0: list of trench objects <ARRAY>
 *
 * Return Value:
 * either "done" or "open corner" if a trench network that is not setup correctly was passed <STRING>
 *
 * Example:
 * [[_tronch1]] call grad_trenches_deform_fnc_fullyInitTrenchesWithIntersect;
 *
 * Public: No
 */

if (!canSuspend) exitWith {};

params ["_trenches"];

(([_trenches] call FUNC(getConfigInfo)) call FUNC(analyseOC)) params ["_blFromConfig", "_tftFromConfig", "_leftOverOC"];

if ((count _leftOverOC) > 0) exitwith {systemChat "open corner"}; // stop if open corner

private _pointsToModify = [_trenches] call FUNC(makeManyHole);
private _terrainLines = [_pointsToModify] call FUNC(getTerrainlines);
private _terrainPoints = [];

{
	_terrainPoints pushBackUnique ((_x # 0) select [0,2]);
	_terrainPoints pushBackUnique ((_x # 1) select [0,2]);
} foreach _terrainLines;

private _PTMForList = [];
{
	_PTMForList pushBackUnique (_x select [0,2]);
} foreach _pointsToModify;

private _allAffectedTP = (_terrainPoints + _PTMForList);//bad var name
private _clashingCoveredTrenches = [];

for "_i" from 0 to ((count GVAR(coveredTrenchList)) - 1) do {
	if ((count (_PTMForList arrayIntersect ((GVAR(coveredTrenchList) # _i # 5) + (GVAR(coveredTrenchList) # _i # 1)))) > 0) then {
		_clashingCoveredTrenches append [_i];
	};
};

//setup for data storage
private _trenchesAdd = [];
private _PTMForListAdd = [];
private _trianglesPositionsAndObjectsAdd = [];
private _tftFromConfigAdd = [];
private _blFromConfigAdd = [];
private _trenchPointsAdd = [];
private _terrainPointsAdd = [];
private _terrainPointsForList = + _terrainPoints;
private _PTMForListToNotLower = [];

// this is all done assuming that the trench objects do not intersect or get too close to each other or anything
private _trianglesToDelete = [];
{
	private _thisCTLEntry = (GVAR(coveredTrenchList) # _x);

	_trenchesAdd append (_thisCTLEntry # 0);
	_PTMForListAdd append (_thisCTLEntry # 1);
	_tftFromConfigAdd append (_thisCTLEntry # 3);
	_blFromConfigAdd append (_thisCTLEntry # 6);
	_trenchPointsAdd append (_thisCTLEntry # 7);

	_terrainPointsAdd append ((_thisCTLEntry # 5) - _PTMForList);

	_terrainPointsForList = _terrainPointsForList - ((_thisCTLEntry # 5) + (_thisCTLEntry # 1));

	_PTMForListToNotLower append (_PTMForList arrayIntersect (_thisCTLEntry # 1));

	private _clashTP = _PTMForList arrayIntersect ((_thisCTLEntry # 5) + (_thisCTLEntry # 1));

	private _bpFromConfig3d = [];
	{
		_bpFromConfig3d pushBackUnique (_x#0);
		_bpFromConfig3d pushBackUnique (_x#1);
	} foreach _blFromConfig;

	private _deletedTriangles = [];
	{
		private _thisTrianglePos = _x # 0;
		private _thisTrianglePos2d = _thisTrianglePos apply {_x select [0, 2];};
		private _deleteThisTriangle = ((count (_clashTP arrayIntersect _thisTrianglePos2d)) > 0);
		{
			_deleteThisTriangle = _deleteThisTriangle || (_x inPolygon _thisTrianglePos);
		} forEach _bpFromConfig3d;

		if (!_deleteThisTriangle) then {
			//this is probably expensive processing wise but it only gets run once per triangle
			//ellipse check cause i can't think of anything cheaper that makes sense
			{
				private _side = [_thisTrianglePos2d#0, _thisTrianglePos2d#1];
				private _sideLength = (_side#0) distance2D (_side#1);
				private _lA = (_side#0) distance2D _x;
				private _lB = (_side#1) distance2D _x;
				if ((_lA + _lB - _sideLength) < 0.2) then {
					_deleteThisTriangle = true;
				} else {
					_side = [_thisTrianglePos2d#0, _thisTrianglePos2d#2];
					_sideLength = (_side#0) distance2D (_side#1);
					_lA = (_side#0) distance2D _x;
					_lB = (_side#1) distance2D _x;
					if ((_lA + _lB - _sideLength) < 0.2) then {
						_deleteThisTriangle = true;
					} else {
						_side = [_thisTrianglePos2d#1, _thisTrianglePos2d#2];
						_sideLength = (_side#0) distance2D (_side#1);
						_lA = (_side#0) distance2D _x;
						_lB = (_side#1) distance2D _x;
						if ((_lA + _lB - _sideLength) < 0.2) then {
							_deleteThisTriangle = true;
						};
					};
				};
				if (_deleteThisTriangle) then {break;};
			} forEach _bpFromConfig3d;
		};

		if (_deleteThisTriangle) then {
			_deletedTriangles append [_thisTrianglePos];
			_trianglesToDelete append [_x # 1];
		} else {
			_trianglesPositionsAndObjectsAdd append [_x];
		};
	} foreach (_thisCTLEntry # 2);

	private _openLines = [];
	private _openPoints = [];
	private _deletedTrianglesLines = [];
	{
		private _lines = [[_x # 0, _x # 1], [_x # 1, _x # 2], [_x # 2, _x # 0]];
		{_x sort true} foreach _lines;
		_deletedTrianglesLines append _lines;
	} foreach _deletedTriangles;

	{
		private _thisDTL = _x;
		private _cnt = {_thisDTL isEqualTo _x} count _deletedTrianglesLines;
		if (_cnt == 1) then {
			// if the line in question does not connect to any clash points
			if (!((((_x # 0) select [0,2]) in _clashTP) || (((_x # 1) select [0,2]) in _clashTP))) then {
				_openLines append [_thisDTL];
			};
		};
	} foreach _deletedTrianglesLines;

	// this part removes all terrain lines that lie in the affected area
	private _TPForTLRemoval = _allAffectedTP arrayIntersect ((_thisCTLEntry # 1));
	private _terrainLinesNew = [];
	{
		if (!((((_x # 0) select [0,2]) in _TPForTLRemoval) || (((_x # 1) select [0,2]) in _TPForTLRemoval))) then {
			_terrainLinesNew append [_x];
		};
	} foreach _terrainLines;
	_terrainLines = _terrainLinesNew;

	{_x sort true} foreach _terrainLines;

	// getTerrainHeight is inaccurate and returns slightly different results after a neighboring point has been modified. here i am overriding the z value of places that have been measured before with the old value to prevent them being seen as seperate points
	private _tl2d = _terrainLines apply {[[_x#0#0, _x#0#1], [_x#1#0, _x#1#1]]};
	{
		// Current result is saved in variable _x
		if (!([[_x#0#0, _x#0#1], [_x#1#0, _x#1#1]] in _tl2d)) then {
			private _thisLine = _x;
			{
				if ([_thisLine#0#0,_thisLine#0#1] isEqualTo (_x#0 select [0,2])) then {
					_x set [0, _thisLine#0];
				};
				if ([_thisLine#0#0,_thisLine#0#1] isEqualTo (_x#1 select [0,2])) then {
					_x set [1, _thisLine#0];
				};
				if ([_thisLine#1#0,_thisLine#1#1] isEqualTo (_x#0 select [0,2])) then {
					_x set [0, _thisLine#1];
				};
				if ([_thisLine#1#0,_thisLine#1#1] isEqualTo (_x#1 select [0,2])) then {
					_x set [1, _thisLine#1];
				};
			} forEach _terrainlines;
			_terrainLines pushBack _x;
		};
	} forEach _openLines;


	// _terrainLines append _openLines;
	// _terrainLines = _terrainLines arrayIntersect _terrainLines;

	GVAR(coveredTrenchList) set [_x, [[], [], [], [], [], [], [], []]];
} foreach _clashingCoveredTrenches;

//remember to redo below this point EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE is done


private _positionsAndHeights = [];

private _cellsize = getTerrainInfo#2;

{
	private _height = getTerrainHeight _x;
	private _newPosAndHeight = + _x;
	_newPosAndHeight set [2, _height - _cellsize];
	_positionsAndHeights append [_newPosAndHeight];
} foreach (_PTMForList - _PTMForListToNotLower);

private _trianglesPositionsAndObjects = [_blFromConfig, _terrainLines, _tftFromConfig] call FUNC(createTrianglesToHole);
[_trianglesPositionsAndObjects] call FUNC(replaceClutter);

setTerrainHeight [_positionsAndHeights, false];

{
    deleteVehicle _x;
} foreach _trianglesToDelete;

private _trenchPoints = [];
{
	_trenchPoints pushBackUnique (_x # 0);
	_trenchPoints pushBackUnique (_x # 1);
} foreach _blFromConfig;

// recalculate terrainlines by finding all triangle lines that connect to two terrain points
_terrainLines = [];
private _terrainPointsForListFinal = _terrainPointsForList + _terrainPointsAdd;
//_allLines = [];
{
	private _lines = [[_x # 0 # 0, _x # 0 # 1], [_x # 0 # 1, _x # 0 # 2], [_x # 0 # 2, _x # 0 # 0]];
	{
		if ((((_x # 0) select [0,2]) in _terrainPointsForListFinal) && (((_x # 1) select [0,2]) in _terrainPointsForListFinal)) then {
			private _line = _x;
			_line sort true;
			_terrainLines pushBackUnique _line;
		};
	} foreach _lines;

} foreach (_trianglesPositionsAndObjects + _trianglesPositionsAndObjectsAdd);

private _thisTrenchListEntry = [
    _trenches + _trenchesAdd,
    (_PTMForList - _PTMForListToNotLower) + _PTMForListAdd,
    _trianglesPositionsAndObjects + _trianglesPositionsAndObjectsAdd,
    _tftFromConfig + _tftFromConfigAdd,
    _terrainLines,
    _terrainPointsForListFinal,
    _blFromConfig + _blFromConfigAdd,
    _trenchPoints + _trenchPointsAdd
];

GVAR(coveredTrenchList) append [_thisTrenchListEntry];
