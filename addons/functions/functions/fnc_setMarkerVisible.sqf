/*
 * Author: Seb
 * Sets a marker to visible depending on player side.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * _trench remoteExec ["grad_trenches_functions_fnc_setMarkerVisible", 0, _trench];
 *
 * Public: No
 */


// Spawn necessary for JIP, as you must wait until player object exists to determine its side.
_this spawn {
    waitUntil {!isNull player};
    params ["_trench"];
    // Make marker invisible for sides enemy to placer.
    if ([side group player, _trench getVariable QGVAR(trenchSide)] call BIS_fnc_sideIsEnemy) then {
        (_trench getVariable [QGVAR(trenchMapMarker), ""]) setMarkerAlpha 0;
    };
};
