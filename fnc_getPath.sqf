_config = configfile >> "CfgWorlds" >> (worldName) >> "OutsideTerrain" >> "Layers" >> "Layer0" >> "texture";
_path "";
if (isText _config) then {
	_raw = getText _config;
	_splitArray = _raw splitString "\";
	_splitArray deleteAt ((count _splitArray)-1);
	_path = _splitArray joinString "\";
}else{
    diag_log "Grad Trench: No such config path!";
};

_path;
