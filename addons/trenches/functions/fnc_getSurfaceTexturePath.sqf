/*
    @Authors
        Christian 'chris5790' Klemm
		Marc 'Salbei' Heinze
    @Arguments
        ?
    @Return Value
        ?
    @Example
        ?
*/
#include "script_component.hpp"

private _defaultTexture = "z\ace\addons\apl\data\zr_plevel_co.paa";

if(!isText (configFile >> "CfgWorldsTextures" >> worldName >> "surfaceTextureBasePath")) exitWith {_defaultTexture};

private _surfaceType = surfaceType (position ACE_player);

if (isArray (configFile >> "CfgWorldsTextures" >> worldName >> "pathList")) then {
	{
		if ((_x select 0) == _surfaceType) exitWith {_defaultTexture = _x select 1;};
	}forEach (getArray (configFile >> "CfgWorldsTextures" >> worldName >> "pathList"));
};

if !(_defaultTexture == "z\ace\addons\apl\data\zr_plevel_co.paa") exitWith {_defaultTexture};

private _getTexturePath = {
    params["_surfaceType", "_basePath"];

    // remove leading #
    private _parsedSurfaceType = _surfaceType select [1, count _surfaceType];
    // get config file wildcard
    private _fileWildcard = getText(configfile >> "CfgSurfaces" >> _parsedSurfaceType >> "files");
    // remove * in file wildcard
    private _fileNameArr = _fileWildcard splitString "";
    if(_fileNameArr find "*" > -1) then {
        _fileNameArr deleteAt (_fileNameArr find "*");
    };

    format["%1%2%3", _basePath, (_fileNameArr joinString ""), getText(configFile >> "CfgWorldsTextures" >> worldName >> "filePrefix")];
};

private _basePath = getText (configFile >> "CfgWorldsTextures" >> "Altis" >> "surfaceTextureBasePath");
if(_surfaceType find "#Gdt" == -1) then {
    _basePath = getText (configFile >> "CfgWorldsTextures" >> worldName >> "surfaceTextureBasePath")
};

[_surfaceType, _basePath] call _getTexturePath;
