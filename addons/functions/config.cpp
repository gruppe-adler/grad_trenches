#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(ADDON);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { QMAINPATCH, "ace_trenches" };
        authors[] = { "Salbei", "chris579" };
        VERSION_CONFIG;
    };
};

#include <Cfg3DEN.hpp>
#include <CfgEventHandlers.hpp>
#include <CfgVehicles.hpp>
#include <CfgWorldsTextures.hpp>
