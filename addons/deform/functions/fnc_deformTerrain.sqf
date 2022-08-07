#include "script_component.hpp"
/*
 * Author: Salbei
 * Changes the terrain height in an area
 *
 * Arguments:
 * 0: Position <POSITION>
 * 1: X-Cordinat <NUMBER>
 * 2: Y-Cordinat <NUMBER>
 * 3: Desired Terrain Height <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [getPosWorld TrenchObj, 50, 50, getTerrainHeight getPosWorld TrenchObj -1] call grad_trenches_functions_fnc_deformTerrain;
 *
 * Public: No
 */


params ["_pos", "_xCord", "_yCord", "_desiredTerrainHeight"];
private _newPositions = [];

for "_xStep" from 0 to _xCord do
{
    for "_yStep" from 0 to _yCord do
    {
        private _newHeight = _pos vectorAdd [_xStep, _yStep, 0];
        _newHeight set [2, _desiredTerrainHeight];
        _newPositions pushBack _newHeight;
    };
};

setTerrainHeight [_newPositions, false];

//Alternativ
/*
params ["_trench", "_desiredTerrainHeight"];

private _boundingBoxReal = 2 boundingBoxReal _trench;
_boundingBoxReal params ["_xyz1", "_xyz2"];

private _pos = _trench modelToWorldVisualWorld (_xyz1);
_pos set [0, (_pos select 1) - 5];
_pos set [1, (_pos select 1) - 5];
_pos set [2,0];

private _xCord = (abs ((_xyz1 select 0) - (_xyz2 select 0))) -10;
private _yCord = (abs ((_xyz1 select 1) - (_xyz2 select 1))) -10;

private _newPositions = [];

for "_xStep" from 0 to _xCord do
{
    for "_yStep" from 0 to _yCord do
    {
        private _newHeight = _pos vectorAdd [_xStep, _yStep, 0];
        _newHeight set [2, _desiredTerrainHeight];
        _newPositions pushBack _newHeight;
    };
};

setTerrainHeight [_newPositions, false];
*/
