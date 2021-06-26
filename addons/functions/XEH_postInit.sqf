#include "script_component.hpp"

if (isServer) then {
    [QGVAR(addDigger), {_this call FUNC(addDigger);}] call CBA_fnc_addEventHandler;
    [QGVAR(addTrenchToDecay), {_this call FUNC(decayPFH);}] call CBA_fnc_addEventHandler;
    [QGVAR(resetDecay), {_this call FUNC(resetDecay);}] call CBA_fnc_addEventHandler;
    [QGVAR(hitPart), {_this call FUNC(hitPart);}] call CBA_fnc_addEventHandler;
    [QGVAR(spawnTrench), {_this call FUNC(spawnTrench);}] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    [QGVAR(hitFX), {_this call FUNC(hitFX);}] call CBA_fnc_addEventHandler;
    [QGVAR(applyFatigue), {_this call FUNC(applyFatigue);}] call CBA_fnc_addEventHandler;
    [QGVAR(digFX), {_this call FUNC(digFX);}] call CBA_fnc_addEventHandler;
};
