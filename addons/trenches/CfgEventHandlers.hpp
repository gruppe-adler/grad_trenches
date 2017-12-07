#define CAMOUFLAGE_DELETE class GVAR(camouflageDelete) { \
        deleted = QUOTE(if (isServer) then {_this call FUNC(deleteCamouflage)}); \
    }

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_Deleted_EventHandlers {
    class ACE_envelope_small {
        CAMOUFLAGE_DELETE;
    };

    class ACE_envelope_big {
        CAMOUFLAGE_DELETE;
    };
};
