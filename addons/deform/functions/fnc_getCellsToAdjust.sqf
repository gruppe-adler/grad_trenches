#include "script_component.hpp"
/*
 * Author: DerZade, Salbei, EL_D148L0
 * Changes the terrain height in an area
 *
 * Arguments:
 * 0: Trench Object <OBJECT>
 * 0: Cellsize <NUMBER>
 * 0: Minimal Boundingbox Size <NUMBER>
 * 3: Area to cover <BOOLEAN>
 *
 * Return Value:
 * Terrain cells in area
 *
 * Example:
 * [trench, getTerrainInfo # 2, 1.5, false] call grad_trenches_deform_fnc_fnc_getCellsToAdjust;
 *
 * Public: No
 */

params [
    "_trenchObject",
    ["_cellsize", -1],
    ["_minBBoxSize", 1.5],
    ["_areaToCover", false, [false]]
];

if (_cellsize isEqualTo -1) then {
	_cellsize = getTerrainInfo # 2;
};

//Get object bounding box
private _bbx = 2 boundingBoxReal _trenchObject;
_bbx params ["_minBB", "_maxBB", "_boundingSphereRadius"];
_minBB params ["_xMinBB", "_yMinBB", "_zMinBB"];
_maxBB params ["_xMaxBB", "_yMaxBB"];

private _xWidth = (_xMaxBB) - (_xMinBB);
private _yWidth = (_yMaxBB) - (_yMinBB);

if (_xWidth < (_minBBoxSize * _cellsize)) then {
	_diff = ((_minBBoxSize * _cellsize) - _xWidth) / 2;
	_xMinBB = _xMinBB - _diff;
	_xMaxBB = _xMaxBB + _diff;
};

if (_yWidth < (_minBBoxSize * _cellsize)) then {
	_diff = ((_minBBoxSize * _cellsize) - _yWidth) / 2;
	_yMinBB = _yMinBB - _diff;
	_yMaxBB = _yMaxBB + _diff;
};

if (_areaToCover) then {
    _xMinBB = _xMinBB - _cellsize;
    _xMaxBB = _xMaxBB + _cellsize;
    _yMinBB = _yMinBB - _cellsize;
    _yMaxBB = _yMaxBB + _cellsize;
};

private _bbxCenter  = boundingCenter _trenchObject;
_bbxCenter set [2, _zMinBB-1] ;
private _bbxCenterWorld = _trenchObject modelToWorldWorld _bbxCenter;

private _area = [_bbxCenterWorld, abs (_xMinBB - _bbxCenter # 0), abs (_yMinBB - _bbxCenter # 1), getDir _trenchObject, true, -1];

_bbxCenterWorld apply {round (_x / _cellsize)} params ["_x0", "_y0"];
private _step = ceil (_boundingSphereRadius / _cellsize);

private _cells = [];

for "_x" from (_x0 - _step) to (_x0 + _step) do {
	for "_y" from (_y0 - _step) to (_y0 + _step) do {
		private _pos1 = [_x, _y] vectorMultiply _cellsize;
		if (_pos1 inArea _area) then {
			_cells append [ + _pos1];
		};
	};
};

_cells;
