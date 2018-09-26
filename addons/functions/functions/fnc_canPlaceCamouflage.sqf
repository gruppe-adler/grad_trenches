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

params ["_trench", "_unit"];

if !(GVAR(allowCamouflage)) exitWith {false};
if (GVAR(camouflageRequireEntrenchmentTool) && {!("ACE_EntrenchingTool" in items _unit)}) exitWith {false};

(count (_trench getVariable [QGVAR(camouflageObjects), []]) == 0) &&
{count (getArray (configFile >> "CfgWorldsTextures" >> worldName >> "camouflageObjects")) > 0} &&
{count (configProperties [configFile >> "CfgVehicles" >> (typeof _trench) >> "CamouflagePositions"]) > 0}
