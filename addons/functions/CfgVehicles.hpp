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
                class grad_trenches_digEnvelopeGigant: ace_trenches_digEnvelopeBig {
                    displayName = CSTRING(DigEnvelopeGigant);
                    statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'GRAD_envelope_gigant')])] call CBA_fnc_execNextFrame);
                };
            };
        };
    };

    class BagFence_base_F;
    class ACE_envelope_small: BagFence_base_F {
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
        editorCategory = "EdCat_Things";
        editorSubcategory = "EdSubcat_Military";

        class CamouflagePositions {
            center[] = {-0.4, 0.4, 0.2};
            left[] = {-1.75, 0.2, 0.2};
            right[] = {1.75, 0.2, 0.2};
        };

        TRENCHES_ACTIONS;
    };

    class GRAD_envelope_gigant: ACE_envelope_big {
        author = QAUTHOR;
        displayName = CSTRING(EnvelopeGigantName);
        descriptionShort = CSTRING(EnevlopeGigantDescription);
        scope = 2;
        ace_trenches_diggingDuration = 30;
        ace_trenches_removalDuration = 20;
        ace_trenches_noGeoClass = QUOTE(GRAD_envelope_gigant_noGeo);
        ace_trenches_placementData[] = {6,1.1,0.20};
        ace_trenches_grassCuttingPoints[] = {{-1.5,-1,0},{1.5,-1,0}};

        editorCategory = "EdCat_Things";
        editorSubcategory = "EdSubcat_Military";

        class CamouflagePositions {
            left1[] = {-0.5, 0.3, 0.5};
            left2[] = {-2.7, 0.3, 0.5};
            right1[] = {2.7, 0.15, 0.35};
            right2[] = {4.9, -0.5, -0.15};
        };
    };
};
