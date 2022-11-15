#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * create a triangle filler object from an array of 3 points.
 *
 * Arguments:
 * 0: Position of corner in format PositionASL <ARRAY>
 * 1: Position of corner in format PositionASL <ARRAY>
 * 2: Position of corner in format PositionASL <ARRAY>
 *
 * Return Value:
 * triangle filler object <OBJECT>
 *
 * Example:
 * [[1991.94,5567.88,6.89202],[1994.63,5571.75,6.89802],[1995.49,5567,6.89769]] call ELD_magicTriangle_scripts_fnc_createTriangle;
 *
 * Public: No
 */




//TODO when reworking this function use setObjectScale to scale the boundingbox according to the largest side of the triangle 






//this procedure sorts the points so the object doesn't get turned inside out
private _posAVG = ((_this # 0) vectorAdd ((_this # 1) vectorAdd (_this # 2))) vectorMultiply (1/3);



_this = [_this, [_posAVG], {
	private _diff = _x vectorDiff _input0;
	_diff # 1 atan2 _diff # 0
}, "DESCEND"] call BIS_fnc_sortBy;




params ["_pos1", "_pos2", "_pos3"];


private _triangleClass = "Triangle";

private _cellsize = getTerrainInfo#2;
if (_cellsize > 5) then {
	_triangleClass = "TriangleLarge";
};


private _triangleObject = createVehicle [_triangleClass, ASLtoAGL _pos1,  [], 0, "CAN_COLLIDE"];
_triangleObject setvectordirandup [[0,1,0], [0,0,1]];

private _pos2Diff = _pos2 vectorDiff (_triangleObject modelToWorldWorld (_triangleObject selectionPosition ["Corner_2_Pos", "Memory"]));
_triangleObject animate ["Corner_2_LR", _pos2Diff # 0, true];
_triangleObject animate ["Corner_2_FB", _pos2Diff # 1, true];
_triangleObject animate ["Corner_2_UD", _pos2Diff # 2, true];


private _pos3Diff = _pos3 vectorDiff (_triangleObject modelToWorldWorld (_triangleObject selectionPosition ["Corner_3_Pos", "Memory"]));
_triangleObject animate ["Corner_3_LR", _pos3Diff # 0, true];
_triangleObject animate ["Corner_3_FB", _pos3Diff # 1, true];
_triangleObject animate ["Corner_3_UD", _pos3Diff # 2, true];


_triangleObject;


//c setpos (_triangleObject modelToWorld (_triangleObject selectionPosition ["Corner_3_Pos", "Memory"]));


//_triangleObject animate [Corner_3_LR, 1]