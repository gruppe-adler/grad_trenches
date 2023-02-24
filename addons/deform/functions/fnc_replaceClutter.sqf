#include "script_component.hpp"
/*
 * Author: Salbei
 * Replace clutter on triangles
 *
 * Arguments:
 * 0: Array filled with the corners and object of the triangles <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[[0,0,0], [0,1,0], [1,1,0]], TriangleObject]] call grad_trenches_deform_fnc_replaceClutter
 *
 * Public: No
 */

params ["_trianglesPositionsAndObjects"];

{
    _x params ["_trianglePositions", "_triangleObject"];
    _trianglePositions params ["_posA", "_posB", "_posC"];

    private _pos = getPos _triangleObject;
    private _dir = getDir _triangleObject;
    private _vectorDir = vectorDir _triangleObject;
    private _vectorUp = vectorUp _triangleObject;

    private _surfaceType = surfaceType _pos;

    // Remove any starting # from texture name
    private _index = _surfaceType find "#";
    if (_index > -1) then {
        private _str = _surfaceType splitString "";
        _str deleteAt _index;
        _surfaceType = _str joinString "";
    };

createVehicle ["Sign_Arrow_Cyan_F", (_posA vectorAdd [0,0,0.01]),  [], 0, "CAN_COLLIDE"];
createVehicle ["Sign_Arrow_Blue_F", (_posB vectorAdd [0,0,0.01]),  [], 0, "CAN_COLLIDE"];
createVehicle ["Sign_Arrow_F", (_posC vectorAdd [0,0,0.01]),  [], 0, "CAN_COLLIDE"];

    // Get clutter objects type and probability
    private _clutterCharacter = getText (configfile >> "CfgSurfaces" >> _surfaceType >> "character");
    private _clutterObjectsType = getArray (configfile >> "CfgSurfaceCharacters" >> _clutterCharacter >> "names");
    private _clutterProbability = getArray (configfile >> "CfgSurfaceCharacters" >> _clutterCharacter >> "probability");

    // Calculate area of triangle
    private _lengthA = _posA distance _posB;
    private _lengthB = _posB distance _posC;
    private _lengthC = _posC distance _posA;
    private _area = 0.25 * sqrt ((_lengthA + _lengthB + _lengthC) * (-_lengthA + _lengthB + _lengthC) * (_lengthA - _lengthB + _lengthC) * (_lengthA + _lengthB - _lengthC));

    // Get amount and positions
    private _density = getNumber (configfile >> "CfgWorlds" >> worldname >> "clutterGrid");
    private _amount = (floor (_area/_density)) max 1;
    private _spacing = (_lengthA max _lengthB max _lengthC)/_amount;

    private _middlePos = _posB vectorAdd ((_posC vectorDiff _posB) vectorMultiply 0.5);
    private _dir = _posA getDir _posB;

    private _posArray = [_posA, _amount, _spacing, _posA, _posB, _middlePos] call FUNC(findPositionsInTriangle);
    _posArray = [_posA, _amount, _spacing, _posA, _posC, _middlePos, _posArray] call FUNC(findPositionsInTriangle);

    // Populate the triangle with clutter
    {
        private _num = ((floor random 100) +1)/100;
        private _attachPos = _triangleObject worldToModelVisual _x;


	    createVehicle ["Sign_Arrow_Pink_F", _x,  [], 0, "CAN_COLLIDE"];
        createVehicle ["Sign_Arrow_F", _attachPos,  [], 0, "CAN_COLLIDE"];


        /*
        {
            _num = _num -_x;

            if (_num <= 0) exitWith {
                private _type = _clutterObjectsType select _forEachIndex;
                private _clutter = createSimpleObject [getText (configfile >> "CfgWorlds" >> worldname>> "Clutter" >> _type >> "model"), [0,0,0], false];

                private _scaleMax = getNumber (configfile >> "CfgWorlds" >> worldname >> "Clutter" >> _type >> "scaleMax");
                private _scaleMin = getNumber (configfile >> "CfgWorlds" >> worldname >> "Clutter" >> _type >> "scaleMin");

                private _scale = linearConversion [
                    0,
                    1,
                    (random 1),
                    _scaleMin,
                    _scaleMax,
                    true
                ];

                _clutter setObjectScale _scale;
                _clutter attachTo [_triangleObject, _attachPos];
                _clutter setVectorDirAndUp [_vectorDir, _vectorUp];

                //Add check if clutter is in contact with triangle
                //private _clutterPos = getPosASL _clutter;
                //private _intersects = lineIntersectsWith [_clutterPos, (_clutterPos vectorAdd [0,0,-0.25]), _clutter, objNull, false];

            };
        }forEach _clutterProbability;
        */
    }forEach _posArray;
}forEach _trianglesPositionsAndObjects;
