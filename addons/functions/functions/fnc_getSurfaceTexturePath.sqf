/*
    @Authors
        Christian 'chris5790' Klemm
		Salbei
    @Arguments
        ?
    @Return Value
        ?
    @Example
        ?
*/
#include "script_component.hpp"
params [
    ["_object", objnull, [objNull]]
];
if (isNull _object) exitWith {};

private _defaultTexture = "x\grad_trenches\addons\assets\data\zemlia.paa";

if !(isText (configFile >> "CfgWorldsTextures" >> worldName >> "surfaceTextureBasePath")) exitWith {_defaultTexture};

private _surfaceType = surfaceType (position _object);

private _getTexturePath = {
    params["_surfaceType", "_basePath", "_suffix"];

    // remove leading #
    private _parsedSurfaceType = _surfaceType select [1, count _surfaceType];
    // check for overridden surface paths
    private _overrideCfg = configFile >> "CfgWorldsTextures" >> worldName >> "Surfaces" >> _parsedSurfaceType >> "texturePath";
    if (isText (_overrideCfg)) exitWith {
        getText(_overrideCfg)
    };
    // get config file wildcard
    private _fileWildcard = getText(configfile >> "CfgSurfaces" >> _parsedSurfaceType >> "files");
    // remove * in file wildcard
    private _fileNameArr = _fileWildcard splitString "";
    if (_fileNameArr find "*" > -1) then {
        _fileNameArr deleteAt (_fileNameArr find "*");
    };

    format["%1%2%3", _basePath, (_fileNameArr joinString ""), _suffix];
};

private _result = [];

private _basePath = getText (configFile >> "CfgWorldsTextures" >> "Altis" >> "surfaceTextureBasePath");
if ((_surfaceType find "#Gdt" == -1) || {worldName == "Tanoa"} || {worldName == "Enoch"}) then {
   _basePath = getText (configFile >> "CfgWorldsTextures" >> worldName >> "surfaceTextureBasePath")
};
_result = [_surfaceType, _basePath, getText(configFile >> "CfgWorldsTextures" >> worldName >> "suffix")] call _getTexturePath;


if (isNil {_result} || _result isEqualTo []) then {
    _result = _defaultTexture;
    diag_log format ["GRAD_Trenches: Type: %1, Position: %2, WorldName: %3, SurfaceType: %4, Texture: %5", (typeof _object), (position _object), worldName, _surfaceType, _result];
};

_result;
