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
