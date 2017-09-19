if(!isServer) exitWith {};
params ["_obj"];
_config = configfile >> "CfgWorlds" >> (worldName) >> "OutsideTerrain" >> "Layers" >> "Layer0" >> "texture";

if (isText _config) then {
	_raw = getText _config;
	_splitArray = _raw splitString "\";
	_splitArray deleteAt ((count _splitArray)-1);
	_path = _splitArray joinString "\";

	[{
		params ["_args", "_handle"];
		_args params ["_path", "_obj"];
		
		if (isNil "_obj") exitWith {[_handle] call CBA_fnc_removePerFrameHandler;};
		
		_surface = surfaceType (getPos _obj);
		_oldSurface = _obj getVariable ["Grad_Trench_Surface",""];
		if (_surface != _oldSurface) then {
			
			_splitArray = _surface splitString "";
			if ((_splitArray select 0) == "#") then {
				_splitArray deleteAt 0;
			};
			
			if ((_splitArray select 0) == "G" && (_splitArray select 1) == "d" && (_splitArray select 2) == "t") then {
				for "_i" from 1 to 3 do {
					_splitArray deleteAt 0;
				};
			};
			
			_file = _splitArray joinString "";
			_texture = _path + "\" + _file + ".paa";
			
			_obj setObjectTextureGlobal [0, _texture];
			_obj setVariable ["Grad_Trench_Surface", _surface];
		};
	},1,[_path, _obj]] call CBA_fnc_addPerFrameHandler;

}else{
    diag_log "Grad Trench: No such config path!";
};
