#include "script_component.hpp"
/*
 * Author: Salbei
 * Add or remove a unit to the global Variable.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Unit <OBJECT>
 * 2: IsRemoveMode <BOOLEAN> (optional)
 * 3: RemoveAll <BOOLEAN> (optional)
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, ACE_player, true, false] call grad_trenches_functions_fnc_handleDiggerToGVAR
 *
 * Public: No
 */

params ["_trench", "_unit", ["_isRemoveMode", false], ["_removeAll", false]];

private _diggingPlayers = _trench getVariable [QGVAR(diggers), []];

if (_removeAll) then {
    _diggingPlayers = [];
} else {
    if (_isRemoveMode) then {
        _diggingPlayers = _diggingPlayers - [_unit];
    } else {
        _diggingPlayers pushBackUnique _unit;
    };
};

if (count _diggingPlayers <= 0) then {
    [QGVAR(handleTrenchState), [_trench]] call CBA_fnc_serverEvent;
};

_trench setVariable [QGVAR(diggers), _diggingPlayers, true];
