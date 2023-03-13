#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * finds terrain points that need to be lowered for the passed object to fit into the hole
 *
 * Arguments:
 * 0: trench object <OBJECT>
 * 1: padding factor <NUMBER> (optional, default 0.3)
 *		how much padding is used. do not use this parameter externally.
 *
 * Return Value:
 * array of positions of points to be lowered in format Position2d <ARRAY>
 *
 * Example:
 * [_tronch1] call ELD_magicTriangle_scripts_fnc_makeSingleHole;
 *
 * Public: No
 */


params ["_trenchObject", ["_paddingFactor", 0.3]];


private _minBBoxSize = 1.5;


private _cellsize = getTerrainInfo#2;
private _bbx = boundingBoxReal _trenchObject;
private _p1 = _bbx # 0;
private _p2 = _bbx # 1;




_p2 set [2, _p1 # 2];

//experimental
// works for now
private _padding = _paddingFactor * _cellsize;
_p1 = _p1 vectordiff [_padding, _padding, 0];
_p2 = _p2 vectoradd [_padding, _padding, 0];

//experimental end
private _xWidth = (_p2 # 0) - (_p1 # 0);
private _yWidth = (_p2 # 1) - (_p1 # 1);

if (_xWidth < (_minBBoxSize * _cellsize)) then {
	_diff = ((_minBBoxSize * _cellsize) - _xWidth) / 2;
	_p1 set [0, _p1 # 0 - _diff];
	_p2 set [0, _p2 # 0 + _diff];
};

if (_yWidth < (_minBBoxSize * _cellsize)) then {
	_diff = ((_minBBoxSize * _cellsize) - _yWidth) / 2;
	_p1 set [1, _p1 # 1 - _diff];
	_p2 set [1, _p2 # 1 + _diff];
};

private _bbxCenter  = ((_p1) vectoradd (_p2)) vectorMultiply 0.5;
private _bbxCenterWorld = _trenchObject modelToWorldWorld _bbxCenter;
private _area = [_bbxCenterWorld, abs (_p1 # 0 - _bbxCenter # 0), abs (_p1 # 1 - _bbxCenter # 1), getdir _trenchObject, true, -1];
private _bbsr = _bbx # 2;

_bbxCenterWorld apply {round (_x / _cellsize)} params ["_x0", "_y0"];
private _step = ceil(_bbsr / _cellsize) + 1;


private _pointsToModify = [];
//hint "BOING!!";

for "_x" from (_x0 - _step) to (_x0 + _step) do {
	for "_y" from (_y0 - _step) to (_y0 + _step) do {
		private _pos1 = [_x, _y] vectorMultiply _cellsize;
		if (_pos1 inArea _area) then {
			_pointsToModify append [ + _pos1];
		};
	};
};

//temp? fix for a bug that makes the hole too small

private _polygon = ([_pointsToModify] call FUNC(getTerrainPolygon)) apply {[_x # 0, _x # 1, 0]};

private _p1r = _trenchObject modelToWorldWorld [_bbx#0#0, _bbx#0#1,0];
private _p2r = _trenchObject modelToWorldWorld [_bbx#1#0, _bbx#1#1,0];
private _p3r = _trenchObject modelToWorldWorld [_bbx#0#0, _bbx#1#1,0];
private _p4r = _trenchObject modelToWorldWorld [_bbx#1#0, _bbx#0#1,0];


private _holeFits = (_p1r inPolygon _polygon) && (_p2r inPolygon _polygon) && (_p3r inPolygon _polygon) && (_p4r inPolygon _polygon);

if (!_holeFits) then {
	if (_paddingFactor < 0.4) then {
		_pointsToModify = [_trenchObject, 0.55] call FUNC(makeSingleHole);
	} else {
		hint "makeSingleHole is still broken";
	};
};

_pointsToModify;
