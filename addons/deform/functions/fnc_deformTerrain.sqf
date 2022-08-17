#include "script_component.hpp"
/*
 * Author: DerZade, Salbei
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
private _cells = [_trench, _cellsize, 1.5, false] call FUNC(getCellsToAdjust);
private _cellsWithEdge = [_trench, _cellsize, 1.5, true] call FUNC(getCellsToAdjust);
private _pos = getPosWorld _trench;
private _depth = getNumber(configFile >> "CfgVehicles" >> ( typeOf _trench ) >> QGVAR(depth));
private _halfCellsize = _cellsize/2;
private _newHeight = (_pos select 2) - _halfCellsize + 0.003;
private _fillerObjects = [];

systemChat str (_pos select 2);
systemChat str _newHeight;
/*
switch (true) do {
    case (_cellsize <= 1) : {

    };
    case (_cellsize <= 1) : {

    };
    case (_cellsize <= 1) : {

    };
    case (_cellsize <= 1) : {

    };

    case (_cellsize < 5) : {
*/
        {
            private _pos = [(_x # 0) + _halfCellsize, ( _x # 1) + _halfCellsize, _newHeight];
            if !(_trench inArea [_pos, _cellsize + 0.1, _cellsize + 0.1, 0, true, _cellsize]) then {
                private _obj = "GRAD_envelope_filler" createVehicle _pos;
                _obj setVectorDirAndUp [[0,0,0],[0,0,0]];
                _obj setPosWorld _pos;
                _obj setObjectScale _cellsize;
                [{(_this select 0) setObjectTextureGlobal [0, surfaceTexture (_this select 1)];}, [_obj, _x]] call CBA_fnc_execNextFrame;
                _fillerObjects pushBack _obj;

                //systemChat str (getTerrainHeight _pos);
            };
        }forEach _cellsWithEdge;
/*
    };
};
*/
GRAD_fillerObjects = _fillerObjects;

private _arr = _cells apply {[_x select 0, _x select 1, (_pos select 2) - _depth]};
setTerrainHeight [_arr, false];

_cells
