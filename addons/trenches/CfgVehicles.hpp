class CBA_Extended_EventHandlers;

#define TRENCHES_ACTIONS class ACE_Actions { \
        class ACE_MainActions { \
            class GVAR(placeCamouflage) { \
                displayName = CSTRING(placeCamouflage); \
                condition = QUOTE([_target] call FUNC(canPlaceCamouflage)); \
                statement = QUOTE([ARR_2(_target,_player)] call FUNC(placeCamouflage)); \
                priority = -1; \
            }; \
            class GVAR(removeCamouflage) { \
                displayName = CSTRING(removeCamouflage); \
                condition = QUOTE([_target] call FUNC(canRemoveCamouflage)); \
                statement = QUOTE([ARR_2(_target,_player)] call FUNC(removeCamouflage)); \
                priority = -1; \
            }; \
        }; \
    }

class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class ace_trenches_digEnvelopeSmall {
                    statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'ACE_envelope_small')])] call CBA_fnc_execNextFrame);
                };
                class ace_trenches_digEnvelopeBig {
                    statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'ACE_envelope_big')])] call CBA_fnc_execNextFrame);
                };
            };
        };
    };

    class BagFence_base_F;
    class ACE_envelope_small: BagFence_base_F {
        model = QPATHTOF(data\ace_envelope_small4.p3d);
		hiddenSelections[] = {"velka"};
        editorCategory = "EdCat_Things";
        editorSubcategory = "EdSubcat_Military";

        class CamouflagePositions {
            center[] = {0, 1.3, 0};
            left[] = {1.3, -0.8, 0.4};
            right[] = {-1.3,-0.8,0.4};
        };
        TRENCHES_ACTIONS;
    };
    class ACE_envelope_big: BagFence_base_F {
        model = QPATHTOF(data\ace_envelope_big4.p3d);
		hiddenSelections[] = {"velka"};
        editorCategory = "EdCat_Things";
        editorSubcategory = "EdSubcat_Military";

        class CamouflagePositions {
            center[] = {-0.4, 0.4, 0.2};
            left[] = {-1.75, 0.2, 0.2};
            right[] = {1.75, 0.2, 0.2};
        };

        TRENCHES_ACTIONS;
    };

	class ACE_envelope_small_noGeo: BagFence_base_F {
        model = QPATHTOF(data\ace_envelope_small4_nogeo.p3d);
		hiddenSelections[] = {"velka"};
    };
    class ACE_envelope_big_noGeo: BagFence_base_F {
        model = QPATHTOF(data\ace_envelope_big4_nogeo.p3d);
		hiddenSelections[] = {"velka"};
    };
};
