#include "script_component.hpp"
/*
 * Author: Salbei
 * Replace clutter on trinagles
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
    _x params ["_trinaglePositions", "_trinagleObject"];
    _trinaglePositions params ["_posA", "_posB", "_posC"];

    private _pos = getPos _trinagleObject;
    private _dir = getDir _trinagleObject;
    private _vectorDir = vectorDir _trinagleObject;
    private _vectorUp = vectorUp _trinagleObject;

    private _surfaceType = surfaceType _pos;

    // Remove any starting # from texture name
    private _index = _surfaceType find "#";
    if (_index > -1) then {
        private _str = _surfaceType splitString "";
        _str deleteAt _index;
        _surfaceType = _str joinString "";
    };

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
    private _amount = floor (_area/_density);
    private _posArray = [_posA, _posB, _posC, _amount, _area, (_lengthA max _lengthB max _lengthC)/_amount] call FUNC(findPositionsInTriangle);


    GRAD_CLUTTER = [];
    diag_log format ["Pos Array Count: %1", count _posArray];
    // Populate the triangle with clutter
    for "_i" from 1 to _amount do {
        private _num = ((floor random 100) +1)/100;
        private _attachPos = _trinagleObject worldToModelVisual(_posArray select _i);

        if (!isNil "_attachPos") then {
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
                    _clutter attachTo [_trinagleObject, _attachPos];
                    _clutter setVectorDirAndUp [_vectorDir, _vectorUp];

                    GRAD_CLUTTER pushBack _clutter;
                };
            }forEach _clutterProbability;
        } else { diag_log format ["GRAD Clutter, no pos found, Index: %1, Value: %2", _i, _posArray select _i]};
    };
}forEach _trianglesPositionsAndObjects;
