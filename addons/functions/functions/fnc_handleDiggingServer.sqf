#include "script_component.hpp"
/*
 * Author: Salbei
 * Handle digging on Server, including multi dig.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 * 1: Unit <OBJECT>
 * 2: State <BOOLEAN>
 * 3: Initiator <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj, ACE_player] call grad_trenches_fnc_handleDiggingServer
 *
 * Public: No
 */

if !(isServer) exitWith {};
params ["_trench", "_unit", ["_state", false], ["_initiator", false]];

if (_initiator) then {
    if (_state) then {
        [
            {
                params ["_trench"];

                private _handle = [
                    {
                        params ["_args", "_handle"];
                        _args params ["_trench", "_unit", "_digTime"];

                        private _diggingPlayers = _trench getVariable [QGVAR(diggers), []];
                        _diggingPlayers = _diggingPlayers - [objNull];

                        if !(_diggingPlayers isEqualTo (_trench getVariable [QGVAR(diggers), []])) then {
                            [QGVAR(addDigger), [_trench, _unit, true]] call CBA_fnc_serverEvent;
                        };

                        if (
                            !(_trench getVariable ["ace_trenches_digging", false])
                            || {(count _diggingPlayers) < 1}
                        ) exitWith {
                            [_handle] call CBA_fnc_removePerFrameHandler;
                        };

                        systemChat format ["Tick: %1, Time: %2", (_trench getVariable ["ace_trenches_progress", 0]) + ((1/_digTime)/10) * count _diggingPlayers, time];

                        _trench setVariable ["ace_trenches_progress", (_trench getVariable ["ace_trenches_progress", 0]) + ((1/_digTime)/10) * count _diggingPlayers, true];
                    },
                    0.1,
                    _this
                ] call CBA_fnc_addPerFrameHandler;

                _trench setVariable [QGVAR(pfh), _handle];
            },[
                _trench,
                _unit,
                missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> (typeOf _trench) >> "ace_trenches_diggingDuration"), 20]
            ],
            0.1,
        ] call CBA_fnc_waitAndExecute;
    }else{
        [_trench getVariable QGVAR(pfh)] call CBA_fnc_removePerFrameHandler;
    };
};
