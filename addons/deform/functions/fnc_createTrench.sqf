#include "script_component.hpp"
/*
 * Author: Salbei
 * Changes the terrain height in an area
 *
 * Arguments:
 * 0: Position <POSITION>
 * 1: X-Cordinat <NUMBER>
 * 2: Y-Cordinat <NUMBER>
 * 3: Desired Terrain Height <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [getPosWorld TrenchObj, 50, 50, getTerrainHeight getPosWorld TrenchObj -1] call grad_trenches_deform_fnc_deformTerrain;
 *
 * Public: No
 */
