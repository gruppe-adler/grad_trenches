#define COMPONENT functions
#include "\x\grad_trenches\addons\main\script_mod.hpp"
#include "\x\grad_trenches\addons\main\script_macros.hpp"

#define CAMOUFLAGE_DURATION 5
#define CAMOUFLAGE_3DEN_ATTRIBUTE QGVAR(camouflageTrench)
#define DEFAULT_TEXTURE QPATHTOEF(assets,data\zemlia.paa)
#define IS_TRENCH(OBJ) isClass (configFile >> "CfgVehicles" >> typeOf OBJ >> "CamouflagePositions01")