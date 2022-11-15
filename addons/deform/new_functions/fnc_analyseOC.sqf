#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * analyse open corners and merge close ones.
 *
 * Arguments:
 *	0: borderLines <ARRAY>
 * 			each element of this array is an array of the following structure: [<ARRAY>, <ARRAY>]
 *	1: trenchFillingTriangles <ARRAY>
 * 			each element of this array is an array of the following structure: [<ARRAY>, <ARRAY>, <ARRAY>]
 *	2: openCorners <ARRAY>
 * 			each element of this array is an array in format PositionASL
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
 * ([[_tronch1]] call ELD_magicTriangle_scripts_fnc_getConfigInfo) call ELD_magicTriangle_scripts_fnc_analyseOC;
 *
 * Public: No
 */

params ["_blFromConfig", "_tftFromConfig", "_ocFromConfig"];

#define MAX_OC_DISTANCE 0.4//maximum distance at which corners will be merged

//oc stands for open corner
private _analysingOC = ((count _ocFromConfig) > 0);
private _leftOverOC = [];

private _errorEndScript = false;
while {_analysingOC} do {
	private _thisOC = _ocFromConfig # 0;
	private _ocListCompare = + _ocFromConfig;
	_ocListCompare deleteAt 0;
	private _found = false;
	private _matchingOC = [];
	for "_i" from 0 to ((count _ocListCompare) - 1) do {
		private _compOC = _ocListCompare # _i;
		if ((_thisOC vectorDistance _compOC) < MAX_OC_DISTANCE) then {
			_found = true;
			_matchingOC = _compOC;
			_ocListCompare deleteAt _i;
			break;
		};
	};

	if (!_found) then {
		_leftOverOC append [_thisOC];
		_ocFromConfig = + _ocListCompare;
	} else {
		private _newPos = ((_thisOC vectorAdd _matchingOC) vectormultiply 0.5);

		for "_i" from 0 to ((count _blFromConfig) - 1) do {
			private _thisElement = _blFromConfig # _i;
			for "_k" from 0 to ((count _thisElement) - 1) do {
				if (((_thisElement # _k) isEqualTo _thisOC) || ((_thisElement # _k) isEqualTo _matchingOC)) then {
					_thisElement set [_k, _newPos];
					_blFromConfig set [_i, _thisElement];
				};
			};
		};

		for "_i" from 0 to ((count _tftFromConfig) - 1) do {
			private _thisElement = _tftFromConfig # _i;
			for "_k" from 0 to ((count _thisElement) - 1) do {
				if (((_thisElement # _k) isEqualTo _thisOC) || ((_thisElement # _k) isEqualTo _matchingOC)) then {
					_thisElement set [_k, _newPos];
					_tftFromConfig set [_i, _thisElement];
				};
			};
		};

		_ocFromConfig = + _ocListCompare;
	};
	_analysingOC = ((count _ocFromConfig) > 0);
};

[_blFromConfig, _tftFromConfig, _leftOverOC];


