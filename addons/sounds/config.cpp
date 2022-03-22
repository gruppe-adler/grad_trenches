#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(ADDON);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { QMAINPATCH, "ace_trenches" };
        authors[] = { "Salbei" , "nomisum" };
        VERSION_CONFIG;
    };
};
