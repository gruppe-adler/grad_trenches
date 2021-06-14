#include "script_component.hpp"

WHITELIST_CRV = ["B_APC_Tracked_01_CRV_F"];

if (isServer) then {
    [QGVAR(addDigger), {_this call FUNC(addDiggerToGVAR);}] call CBA_fnc_addEventHandler;
    [QGVAR(addTrenchToDecay), {_this call FUNC(decayPFH);}] call CBA_fnc_addEventHandler;
    [QGVAR(resetDecay), {_this call FUNC(resetDecay);}] call CBA_fnc_addEventHandler;
};