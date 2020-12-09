
#include "script_component.hpp"

params ["_display"];

_display displayAddEventHandler ["MouseButtonDown", {[[] call CBA_fnc_currentUnit, _this select 1] call FUNC(placeCancel)}];
