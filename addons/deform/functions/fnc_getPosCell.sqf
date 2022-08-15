#include "script_component.hpp"
/*
 * Author: Salbei
 * Returns the cell of a given position
 *
 * Arguments:
 * 0: Position <ARRAY>
 * 1: Cellsize <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player] call ace_trenches_fnc_getPosCell
 *
 * Public: No
 */

params ["_pos", ["_cellsize", -1]];

if (_cellsize isEqualTo -1) then {
    _cellsize = getTerrainInfo select 2;
};

_pos params ["_originalX", "_originalY"];

private _cellX = (floor (_originalX / _cellsize)) * _cellsize;
private _cellY = (floor (_originalY / _cellsize)) * _cellsize;

[_cellX, _cellY, 0]
