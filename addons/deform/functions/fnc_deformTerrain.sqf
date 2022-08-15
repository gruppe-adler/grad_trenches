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
 * [boundingBox TrenchObj, 0] call grad_trenches_deform_fnc_deformTerrain;
 *
 * Public: No
 */

params [
    "_trench",
    "_boundingBox"
];

getTerrainInfo params ["", "", "_cellsize"];
private _cells = [_trench, _boundingBox, _cellsize, false] call FUNC(getCellsToAdjust);
private _cellsWithEdge = [_trench, _boundingBox, _cellsize, true] call FUNC(getCellsToAdjust);
private _pos = getPosWorld _trench;
private _depth = getNumber(configFile >> "CfgVehicles" >> ( typeOf _trench ) >> QGVAR(depth));
private _newHeight = (_pos select 2) - 0.624;
systemChat str (_pos select 2);
systemChat str _newHeight;

private _fillerObjects = [];

switch (true) do {
    /*
    case (_cellsize <= 1) : {

    };
    case (_cellsize <= 1) : {

    };
    case (_cellsize <= 1) : {

    };
    case (_cellsize <= 1) : {

    };
    */
    case (_cellsize < 5) : {
        {
            if !(_trench inArea [_x, _cellsize, _cellsize, 0, true]) then {
                private _obj = "GRAD_envelope_filler5m" createVehicle [0,0,0];
                _x set [2, _newHeight];
                _obj setPosWorld _x;
                [{(_this select 0) setObjectTextureGlobal [0, surfaceTexture (_this select 1)];}, [_obj, _x]] call CBA_fnc_execNextFrame;
                _fillerObjects pushBack _obj;
            };
        }forEach _cellsWithEdge;
    };
};

systemChat str (count _fillerObjects);
GRAD_fillerObjects = _fillerObjects;


private _arr = _cells apply {[_x select 0, _x select 1, (_pos select 2) - _depth]};
setTerrainHeight [_arr, false];

_cells
