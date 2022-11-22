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

    private

    private _surface = surfaceTexture getPos _trinagleObject;

    // Remove any starting #
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

    private _density = getNumber (configfile >> "CfgWorlds" >> worldname >> "clutterGrid");

    // Populate the triangle with clutter
    for "_i" from 1 to floor (_area/_density) do {
        private _num = ((floor random 100) +1)/100;
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
            };
        }forEach _clutterProbability;
    };
}forEach _trianglesPositionsAndObjects;



