/*
    @Authors
        Christian 'chris5790' Klemm
    @Arguments
        ?
    @Return Value
        ?
    @Example
        ?
*/
#include "script_component.hpp"

params ["_trench"];

{
    deleteVehicle _x;
} forEach (_trench getVariable [QGVAR(camouflageObjects), []]);
_trench setVariable [QGVAR(camouflageObjects), nil, true];
