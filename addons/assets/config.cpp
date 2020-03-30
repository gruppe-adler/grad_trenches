#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(ADDON);
        units[] = {"ACE_envelope_small","ACE_envelope_big"};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { QMAINPATCH, "ace_trenches" };
        authors[] = { "Salbei", "chris579" };
        VERSION_CONFIG;
    };
};

#include <CfgVehicles.hpp>