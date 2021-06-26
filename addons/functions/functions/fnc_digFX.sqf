params ["_vehicle"];

private _count = 0;

switch (typeof _vehicle) do { 
    case "trench_short" : {  _count = 7; }; 
    case "trench_small" : {  _count = 5; }; 
    case "trench_big" : {  _count = 7; }; 
    case "trench_giant" : {  _count = 11; }; 
    case "trench_vehicle" : {  _count = 13; }; 
    case "trench_long" : {  _count = 15; }; 
    default {  /*...code...*/ }; 
};

for "_i" from 1 to _count do {
    private _vector = (vectorDir _vehicle) vectorMultiply 1;
    private _ps1 = "#particlesource" createVehicleLocal [0,0,0]; 

    private _prefix = if (_count < 10) then { "0" } else { "" };
    private _selectionName = "fxSource" + _prefix + str _count;
    private _position = (_vehicle modelToWorld (_vehicle selectionPosition _selectionName);
    _ps1 setPos _position;
    _ps1 setParticleParams [   
     "\A3\Data_F\ParticleEffects\Universal\Mud", "", "SpaceObject",   
     1, 10, [0,1,-2.5], _vector, 1, 10, 1, 0.2, [0.1, 0.1],   
     [[1, 1, 1 ,1]],   
     [0, 1], 1, 0, "", "", _ps1, 0, true, .1];   
    _ps1 setParticleRandom [2, [1.5, 0.1, 2], [2, 2, 4], 0, 1, [0, 0, 0, 0], 0, 0];   
    _ps1 setParticleCircle [3.2, [1,-1,2]];
    _ps1 setDropInterval 0.005;  
    [{ deleteVehicle (_this select 0); }, [_ps1], 0.1] call CBA_fnc_waitAndExecute; 
};

