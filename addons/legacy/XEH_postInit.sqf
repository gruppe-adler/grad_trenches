#include "script_component.hpp"

private _digVehicleConfigClasses = "true" configClasses (configFile >> "CfgDigVehicles");
{
  private _classname = configName _x;

  [_classname, "init", {
      [_this select 0] call FUNC(vehicleAction);
  }, true, [], true] call CBA_fnc_addClassEventHandler;
} forEach _digVehicleConfigClasses;


if (isServer) then {
    [QGVAR(spawnTrench), {_this call FUNC(spawnTrench);}] call CBA_fnc_addEventHandler;

    // add hit EH to preplaced trenches
    {
        // hitpart is local args, so must be applied everywhere
        if (GVAR(allowHitDecay)) then {
            [QEGVAR(common,hitEHAdd), [_object, GVAR(hitDecayMultiplier)]] call CBA_fnc_globalEventJIP;
        };
    } forEach (entities "ACE_envelope_small");
};

if (hasInterface) then {
    [QGVAR(digFXVehicleBlade), {_this call FUNC(digFXVehicleBlade);}] call CBA_fnc_addEventHandler;
    [QGVAR(continueDiggingTrench), {_this call FUNC(continueDiggingTrench);}] call CBA_fnc_addEventHandler;
};
