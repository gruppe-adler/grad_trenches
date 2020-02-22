#include "\z\ace\addons\main\script_macros.hpp"
#include <\a3\editor_f\Data\Scripts\dikCodes.h>

#define KPATCH(PVAR) DOUBLES(PREFIX,PVAR)
#define QKPATCH(PVAR) QUOTE(KPATCH(PVAR))
#define MAINPATCH KPATCH(main)
#define QMAINPATCH QUOTE(MAINPATCH)
#define QCOMPONENT QUOTE(COMPONENT)
#define QADDON QUOTE(ADDON)
#define AUTHOR Gruppe Adler
#define QAUTHOR QUOTE(AUTHOR)

#ifdef DISABLE_COMPILE_CACHE
   #define PREP_W_INTERCEPT(fncName,fncNameIntercept,capabilityString) if (capabilityString in (uiNamespace getVariable ["Intercept_cba_capabilities", []])) then { \
       DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncNameIntercept).sqf) \
   } else { PREP(fncName); }
#else
   #define PREP_W_INTERCEPT(fncName,fncNameIntercept,capabilityString) if (capabilityString in (uiNamespace getVariable ["Intercept_cba_capabilities", []])) then { \
       [QPATHTOF(functions\DOUBLES(fnc,fncNameIntercept).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction \
   } else { PREP(fncName); }
#endif
