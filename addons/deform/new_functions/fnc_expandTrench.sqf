#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * expand a trench. TODO this documentation
 *
 * Arguments:
 * 0: list of trench objects <ARRAY>
 *
 * Return Value:
 * either "done" or "open corner" if a trench network that is not setup correctly was passed <STRING>
 *
 * Example:
 * [[_tronch1]] call ELD_magicTriangle_scripts_fnc_initTrench;
 *
 * Public: No
 */

if (!canSuspend) exitWith {};
params ["_oldTrenches", "_newTrenches"];
// dunno yet if more than one oldTrench makes sense

([_newTrenches] call FUNC(getConfigInfo)) params ["_blFromConfig", "_tftFromConfig", "_ocFromConfig"];


