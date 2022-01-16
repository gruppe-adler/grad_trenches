 #include "script_component.hpp"
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

// waitUntil necessary for JIP, as you must wait until player object exists to determine its side.
params ["_trench"];

[
    {!isNull player},
    {
        params ["_trench"];

        if ([side group player, _trench getVariable QGVAR(trenchSide)] call BIS_fnc_sideIsEnemy) then {
            (_trench getVariable [QGVAR(trenchMapMarker), ""]) setMarkerAlphaLocal 0;
        };
    },
    [_trench]
] call CBA_fnc_waitUntilAndExecute;
