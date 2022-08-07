#include "script_component.hpp"
/*
 * Author: Zade, Salbei
 * Changes the terrain height in an area around an object
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj] call grad_trenches_deform_fnc_deformTerrain;
 *
 * Public: No
 */


params [
    ["_obj", objectNull, [objectNull]]
];

private _ret = [_obj] call FUNC(getBBThatNeedsToBeDugOut);
_ret params ["_bb", "_zASL"];
private _cells = [_bb] call FUNC(getCellsToAdjst);

private _arr = _cells apply {[_x select 0, _x select 1, _zASL]};
setTerrainHeight _arr;

_cells
