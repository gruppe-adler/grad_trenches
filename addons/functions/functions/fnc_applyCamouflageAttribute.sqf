#include "script_component.hpp"
/*
 * Author:  Christian 'chris5790' Klemm
 * Apply camouflage attribute to trench.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Value <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, 1] call grad_trenches_functions_fnc_applyCamouflageAttribute
 *
 * Public: No
 */

params ["_trench", "_value"];

if (_value isEqualTo 1) then {
    private _camouflageObjects = [configFile >> "CfgWorldsTextures" >> worldName >> "camouflageObjects", "ARRAY", []] call CBA_fnc_getConfigEntry;

    if (_camouflageObjects isEqualTo []) exitWith {
        TRACE_1("No camouflage objects available for this terrain", _camouflageObjects);
    };

    private _statusNumber = _trench getVariable [QGVAR(trenchCamouflageStatus), 0];
    _statusNumber = _statusNumber + 1;

    private _placedObjects = [];
    private _camouflageObjectsArray = _trench getVariable [QGVAR(camouflageObjects), []];

    {
        private _obj = createSimpleObject [selectRandom _camouflageObjects, [0,0,0]];
        private _array = getArray _x;
        _obj attachTo [_trench, _array];
        _obj setVariable [QGVAR(positionData), _array, true];

        _placedObjects pushBack _obj;
    } forEach (configProperties [configOf _trench >> "CamouflagePositions" + str _statusNumber]);

    // pushFront
    reverse _camouflageObjectsArray;
    _camouflageObjectsArray pushBack _placedObjects;
    reverse _camouflageObjectsArray;

    _trench setVariable [QGVAR(camouflageObjects), _camouflageObjectsArray, true];
    _trench setVariable [QGVAR(trenchCamouflageStatus), _statusNumber];
} else {
    [_trench] call FUNC(deleteCamouflage);
};
