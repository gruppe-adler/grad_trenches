#define CAMOUFLAGE_DELETE class GVAR(camouflageDelete) { \
        deleted = QUOTE(if (isServer) then {_this call FUNC(deleteCamouflage)}); \
    }

#define TRENCH_INIT class GVAR(trenchInit) { \
        init = QUOTE(_this call FUNC(initTrench)); \
    }

class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preStart));
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_Deleted_EventHandlers {
    class ACE_envelope_small {
        CAMOUFLAGE_DELETE;
    };

    class ACE_envelope_big {
        CAMOUFLAGE_DELETE;
    };

    class GRAD_envelope_gigant {
        CAMOUFLAGE_DELETE;
    };

    class GRAD_envelope_vehicle {
        CAMOUFLAGE_DELETE;
    };
};

class Extended_Init_EventHandlers {
    class ACE_envelope_small {
        TRENCH_INIT;
    };

    class ACE_envelope_big {
        TRENCH_INIT;
    };

    class GRAD_envelope_gigant {
        TRENCH_INIT;
    };

    class GRAD_envelope_vehicle {
        TRENCH_INIT;
    };
};
