#include "script_component.hpp"
/*
 * Author: Seb
 * Creates a map marker for a created trench but only for sides friendly to the creator side
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Friendly side <SIDE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, side player] call grad_trenches_functions_fnc_createTrenchMarker
 *
 * Public: Yes
 */

params ["_trench", "_friendlySide"];

// Get trench size and direction
private _bbr = 0 boundingBoxReal _trench;
private _p1 = _bbr select 0;
private _p2 = _bbr select 1;
private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
private _direction = getDir _trench;

// Marker name unique to this trench object
private _markerNameStr = format ["grad_trenches_marker_%1", _trench];

// Create marker, but only for side of trench placer
private _marker = createMarker [_markerNameStr, _trench];
_marker setMarkerShapeLocal "RECTANGLE";
_marker setMarkerBrushLocal "SolidFull";
_marker setMarkerSizeLocal [_maxWidth / 2, _maxLength / 2];
_marker setMarkerDirLocal _direction;
_marker setMarkerColor "Color6_FD_F";
_trench setVariable [QGVAR(trenchMapMarker), _marker, true];
_trench setVariable [QGVAR(trenchSide), _friendlySide, true];

// JIP compatible hide marker for enemies
_trench remoteExec [QGVAR(setMarkerVisible), 0, _trench];
