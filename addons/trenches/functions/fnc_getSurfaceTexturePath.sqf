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

private _getTexturePath = {
    params["_surfaceType", "_basePath", "_filePrefix"];

    // remove leading #
    private _parsedSurfaceType = _surfaceType select [1, count _surfaceType];
    // check for overridden surface paths
    private _localCfg = configFile >> "CfgWorldsTextures" >> worldName;
    if(isClass (_localCfg >> _parsedSurfaceType)) then {
        _basePath = getText(_localCfg >> _parsedSurfaceType >> "surfaceTextureBasePath");
        _filePrefix = getText(_localCfg >> _parsedSurfaceType >> "filePrefix");
    };
    // get config file wildcard
    private _fileWildcard = getText(configfile >> "CfgSurfaces" >> _parsedSurfaceType >> "files");
    // remove * in file wildcard
    private _fileNameArr = _fileWildcard splitString "";
    if(_fileNameArr find "*" > -1) then {
        _fileNameArr deleteAt (_fileNameArr find "*");
    };

    format["%1%2%3", _basePath, (_fileNameArr joinString ""), _filePrefix];
};

private _basePath = getText (configFile >> "CfgWorldsTextures" >> "Altis" >> "surfaceTextureBasePath");
if((_surfaceType find "#Gdt" == -1) || {worldName == "Tanoa"}) then {
    _basePath = getText (configFile >> "CfgWorldsTextures" >> worldName >> "surfaceTextureBasePath")
};

private _result = [_surfaceType, _basePath, getText(configFile >> "CfgWorldsTextures" >> worldName >> "filePrefix")] call _getTexturePath;
diag_log format ["Grad_Trenches: Position: %1,WorldName: %2 ,SurfaceType: %3, Texture: %4", (position ACE_player), worldName ,_surfaceType, _defaultTexture];

if(isNil {_result}) then {
    _result = _defaultTexture;
};

_result;
