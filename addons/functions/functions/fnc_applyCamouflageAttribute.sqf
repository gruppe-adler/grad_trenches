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
params ["_object", "_value"];

diag_log "Attribute value";
diag_log str(_value);
diag_log str(_object);

if ([false, true] select _value) then {
    diag_log "Placing camouflage";
    [_object] call FUNC(placeCamouflage);
} else {
    diag_log "Removing camouflage";
    [_object] call FUNC(deleteCamouflage);
};
