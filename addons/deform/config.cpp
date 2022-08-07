#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(ADDON);
        units[] = {"GRAD_envelope_fightinghole"};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { QMAINPATCH, "ace_trenches", "grad_trenches_common", "grad_trenches_assets" };
        authors[] = { "Salbei"};
        VERSION_CONFIG;
    };
};

#include <Cfg3DEN.hpp>
#include <CfgEventHandlers.hpp>
#include <CfgVehicles.hpp>
