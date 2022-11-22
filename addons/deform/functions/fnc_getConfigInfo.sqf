#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * get the world positions of memPoints of a trench/trench network.
 *
 * Arguments:
 * 0: list of trench objects <ARRAY>
 *
 * Return Value:
 * Array of 3 arrays <ARRAY>
 *		0: borderLines <ARRAY>
 * 			each element of this array is an array of the following structure: [<ARRAY>, <ARRAY>]
 *		1: trenchFillingTriangles <ARRAY>
 * 			each element of this array is an array of the following structure: [<ARRAY>, <ARRAY>, <ARRAY>]
 *		2: openCorners <ARRAY>
 * 			each element of this array is an array in format PositionASL
 *
 * Example:
 * [[_tronch1]] call ELD_magicTriangle_scripts_fnc_getConfigInfo;
 *
 * Public: No
 */

params ["_trenches"];

private _blFromConfig = [];
private _tftFromConfig = [];
private _ocFromConfig = [];
{
	private _thisTrench = _x;
	private _blNames = getArray ((configOf _thisTrench) >> QEGVAR(assets,borderLines));
	private _blPositions = [];
	{
        diag_log str _x;
		private _thisblCoords = [_thisTrench modelToWorldWorld (_thisTrench selectionPosition [_x # 0, "Memory"]), _thisTrench modelToWorldWorld (_thisTrench selectionPosition [_x # 1, "Memory"])];
		_blPositions append [_thisblCoords];
	} foreach _blNames;

	private _tftNames = getArray ((configOf _thisTrench) >> QEGVAR(assets,fillingTriangles));
	private _tftPositions = [];
	{
		private _thistftCoords = [_thisTrench modelToWorldWorld (_thisTrench selectionPosition [_x # 0, "Memory"]), _thisTrench modelToWorldWorld (_thisTrench selectionPosition [_x # 1, "Memory"]), _thisTrench modelToWorldWorld (_thisTrench selectionPosition [_x # 2, "Memory"])];
		_tftPositions append [_thistftCoords];
	} foreach _tftNames;

	private _ocNames = getArray ((configOf _thisTrench) >> QEGVAR(assets,openCorners));
	private _ocPositions = [];
	{
		private _thisocCoords = (_thisTrench modelToWorldWorld (_thisTrench selectionPosition [_x, "Memory"]));
		_ocPositions append [_thisocCoords];
	} foreach _ocNames;

	_blFromConfig append _blPositions;
	_tftFromConfig append _tftPositions;
	_ocFromConfig append _ocPositions;

} foreach _trenches;

[_blFromConfig, _tftFromConfig, _ocFromConfig]
