#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"

private _digVehicleConfigClasses = "true" configClasses (configFile >> "CfgDigVehicles");
{
  private _classname = configName _x;

  [_classname, "init", {
      [_this select 0] call FUNC(vehicleAction);
  }, true, [], true] call CBA_fnc_addClassEventHandler;
} forEach _digVehicleConfigClasses;


if (isServer) then {
    [QGVAR(addDigger), {_this call FUNC(addDigger);}] call CBA_fnc_addEventHandler;
    [QGVAR(handleDiggerToGVAR), {_this call FUNC(handleDiggerToGVAR);}] call CBA_fnc_addEventHandler;
    [QGVAR(handleTrenchState), {_this call FUNC(handleTrenchState);}] call CBA_fnc_addEventHandler;
    [QGVAR(addTrenchToDecay), {_this call FUNC(decayPFH);}] call CBA_fnc_addEventHandler;
    [QGVAR(resetDecay), {_this call FUNC(resetDecay);}] call CBA_fnc_addEventHandler;
    [QGVAR(hitPart), {_this call FUNC(hitPart);}] call CBA_fnc_addEventHandler;
    [QGVAR(hitEHAdd), {_this call FUNC(hitEHAdd);}] call CBA_fnc_addEventHandler;
    [QGVAR(spawnTrench), {_this call FUNC(spawnTrench);}] call CBA_fnc_addEventHandler;

    // add hit EH to preplaced trenches
    {
        // hitpart is local args, so must be applied everywhere
        if (GVAR(allowHitDecay)) then {
            [QGVAR(hitEHAdd), [_object, GVAR(hitDecayMultiplier)]] call CBA_fnc_globalEventJIP;
        };
    } forEach (entities "ACE_envelope_small");
};

if (hasInterface) then {
    [QGVAR(hitFX), {_this call FUNC(hitFX);}] call CBA_fnc_addEventHandler;
    [QGVAR(applyFatigue), {_this call FUNC(applyFatigue);}] call CBA_fnc_addEventHandler;
    [QGVAR(digFX), {_this call FUNC(digFX);}] call CBA_fnc_addEventHandler;
    [QGVAR(digFXVehicleBlade), {_this call FUNC(digFXVehicleBlade);}] call CBA_fnc_addEventHandler;
    [QGVAR(hitEHAdd), {_this call FUNC(hitEHAdd);}] call CBA_fnc_addEventHandler;
    [QGVAR(continueDiggingTrench), {_this call FUNC(continueDiggingTrench);}] call CBA_fnc_addEventHandler;
};



[LLSTRING(settingCategory), QGVAR(textureLockKey), [LLSTRING(lockTextureKey), LLSTRING(lockTextureKeyToolTip)], {}, {
    if (GVAR(allowTextureLock)) then {
        private _unit = [] call CBA_fnc_currentUnit;

        if (_unit getVariable ["ace_trenches_isPlacing", false] && {!(_unit getVariable [QGVAR(lockTexture), false])}) then {
            private _trench = ace_trenches_trench;
            _unit setVariable [QGVAR(lockTexture), true];
            _unit setVariable [QGVAR(lockTexturePos), (getPosASL _unit)];

            [{

                params ["_unit"];
                (((getPosASL _unit) distance2D (_unit getVariable QGVAR(lockTexturePos))) >= GVAR(textureLockDistance))

            }, {

                params ["_unit", "_trench"];
                _unit setVariable [QGVAR(lockTexture), false];
                _unit setVariable [QGVAR(lockTexturePos), nil];
                _trench setVariable [QGVAR(lockedTexture), nil];

            }, [_unit], 120, {

                params ["_unit", "_trench"];
                _unit setVariable [QGVAR(lockTexture), false];
                _unit setVariable [QGVAR(lockTexturePos), nil];
                _trench setVariable [QGVAR(lockedTexture), nil];

            }] call CBA_fnc_waitUntilAndExecute;
        };
    };
}, [DIK_L, [false, false, false]]] call CBA_fnc_addKeybind;
