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
params [
    ["_object", objnull, [objNull]]
];
if (isNull _object) exitWith {};

private _defaultTexture = "z\ace\addons\apl\data\zr_plevel_co.paa";

if !(isNil QGVAR(automaticFileSetup) && isText (configFile >> "CfgWorldsTextures" >> worldName >> "surfaceTextureBasePath")) exitWith {_defaultTexture};

private _surfaceType = surfaceType (position _object);

private _getTexturePath = {
    params["_surfaceType", "_basePath", "_filePrefix"];

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

    format["%1%2%3", _basePath, (_fileNameArr joinString ""), _filePrefix];
};

private _result = [];

if !(isNil QGVAR(automaticFileSetup)) then {
   GVAR(automaticFileSetup) params ["_basePath", "_filePrefix"];
   _result = [_surfaceType, _basePath, _filePrefix] call _getTexturePath;
}else{
   private _basePath = getText (configFile >> "CfgWorldsTextures" >> "Altis" >> "surfaceTextureBasePath");
   if ((_surfaceType find "#Gdt" == -1) || {worldName == "Tanoa"}) then {
       _basePath = getText (configFile >> "CfgWorldsTextures" >> worldName >> "surfaceTextureBasePath")
   };
    _result = [_surfaceType, _basePath, getText(configFile >> "CfgWorldsTextures" >> worldName >> "filePrefix")] call _getTexturePath;
};

if (isNil {_result} || _result isEqualTo []) then {
    _result = _defaultTexture;
    diag_log format ["GRAD_Trenches: Type: %1, Position: %2, WorldName: %3, SurfaceType: %4, Texture: %5", (typeof _object), (position _object), worldName, _surfaceType, _result];
};

_result;
