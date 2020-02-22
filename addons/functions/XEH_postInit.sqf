#include "script_component.hpp"

[QGVAR(addDigger), {_this call FUNC(handleDiggingServer)}] call CBA_fnc_addEventHandler;
[QGVAR(handleDiggingServer), {_this call FUNC(addDiggerToGVAR)}] call CBA_fnc_addEventHandler;