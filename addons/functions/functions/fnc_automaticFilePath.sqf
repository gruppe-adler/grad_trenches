if (isText (configFile >> "CfgWorldsTextures" >> worldName >> "surfaceTextureBasePath")) exitWith {};

if !(isText (configfile >> "CfgWorlds" >> worldName >> "OutsideTerrain" >> "Layers" >> "Layer0" >> "texture")) exitWith {
   diag_log ["GRAD Trenches: Found no OutsideTerrain texture for Map %1, automatic file path not possible!", worldName];
};
private _path = getText (configfile >> "CfgWorlds" >> worldName >> "OutsideTerrain" >> "Layers" >> "Layer0" >> "texture");

private _split = _path splitString "\";
private _texture = _split select (count _split -1);
_split = _split - _texture;
_path = _split joinString "\";

_split = _texture splitString "_";
private _filePrefix = _split select (count _split -1);

GVAR(automaticFileSetup) = [_path, _filePrefix];
publicVariable QGVAR(automaticFileSetup);
