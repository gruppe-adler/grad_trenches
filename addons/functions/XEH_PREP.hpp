PREP(addDigger);
PREP(applyCamouflageAttribute);
PREP(automaticFilePath);
PREP(canHelpDiggingTrench);
PREP(canPlaceCamouflage);
PREP(canRemoveCamouflage);
PREP(continueDiggingTrench);
PREP(deleteCamouflage);
PREP(initTrench);
PREP(initTrench3DEN);
PREP(placeCamouflage);
PREP(placeConfirm);
PREP(placeTrench);
PREP(progressBar);
PREP(removeCamouflage);
PREP(removeTrench);

if ("surfaceTexture" in (uiNamespace getVariable ["Intercept_cba_capabilities",[]])) then {
    #ifdef DISABLE_COMPILE_CACHE
        DFUNC(getSurfaceTexturePath) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,getSurfaceTexturePathNative).sqf);
    #else
        [QPATHTOF(functions\DOUBLES(fnc,getSurfaceTexturePathNative).sqf), QFUNC(getSurfaceTexturePath)] call CBA_fnc_compileFunction;
    #endif
} else {
    PREP(getSurfaceTexturePath);
};
