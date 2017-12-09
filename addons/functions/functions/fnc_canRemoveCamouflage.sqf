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

(count (_trench getVariable [QGVAR(camouflageObjects), []]) > 0)
