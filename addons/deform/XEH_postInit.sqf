if (isServer) then {
    [QGVAR(createTrench), {_this call FUNC(createTrench);}] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    [QGVAR(continueDeformingTrench), {_this call FUNC(continueDeformingTrench);}] call CBA_fnc_addEventHandler;
};
