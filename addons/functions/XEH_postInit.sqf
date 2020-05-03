#include "script_component.hpp"

if (isServer) then {
    [QGVAR(addDigger), {_this call FUNC(addDiggerToGVAR);}] call CBA_fnc_addEventHandler;
};