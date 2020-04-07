#define TRENCHES_ACTIONS class ACE_Actions { \
        class ACE_MainActions { \
            distance = 10; \
            class ACE_ContinueDiggingTrench { \
                statement = QUOTE([ARR_2(_target,_player)] call FUNC(continueDiggingTrench);); \
            }; \
            class ACE_RemoveTrench { \
                statement = QUOTE([ARR_2(_target,_player)] call FUNC(removeTrench);); \
             };  \
            class GVAR(helpDigging) { \
                displayName = CSTRING(HelpDigging); \
                condition = QUOTE([ARR_2(_target,_player)] call FUNC(canHelpDiggingTrench)); \
                statement = QUOTE([ARR_2(_target,_player)] call FUNC(addDigger)); \
                priority = -1; \
            }; \
            class GVAR(placeCamouflage) { \
                displayName = CSTRING(placeCamouflage); \
                condition = QUOTE([ARR_2(_target,_player)] call FUNC(canPlaceCamouflage)); \
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

#define TRENCHES_ATTRIBUTES class Attributes { \
        class GVAR(camouflageAttribute) { \
            control = "CheckboxNumber"; \
            defaultValue = "0"; \
            displayName = CSTRING(CamouflageAttribute); \
            tooltip = CSTRING(CamouflageAttributeTooltip); \
            expression = QUOTE([ARR_2(_this,_value)] call FUNC(applyCamouflageAttribute)); \
            property = QUOTE(grad_trenches_camouflageTrench); \
        }; \
    }

class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {

                delete ace_trenches_digEnvelopeSmall;
                delete ace_trenches_digEnvelopeBig;

                class ace_trenches {
                    displayName = "$STR_ACE_Trenches_EntrenchingToolName";
                    condition = QUOTE(_player call FUNC(canDigTrench) && GVAR(allowDigging));
                    statement = "";
                    showDisabled = 0;
                    priority = 3;
                    // icon = "z\ace\addons\trenches\UI\w_entrchtool_ca.paa";
                    exceptions[] = {"notOnMap", "isNotInside", "isNotSitting"};

                    class ace_trenches_digEnvelopeSmall {
                        displayName = "$STR_ace_trenches_DigEnvelopeSmall";
                        exceptions[] = {};
                        showDisabled = 0;
                        priority = 4;
                        statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'ACE_envelope_small')])] call CBA_fnc_execNextFrame);
                        condition = QUOTE(GVAR(allowDigging) && ([ARR_2(_target,_player)] call ace_trenches_fnc_canContinueDiggingTrench) && GVAR(allowSmallEnvelope));
                    };
                    class ace_trenches_digEnvelopeBig: ace_trenches_digEnvelopeSmall {
                        displayName = "$STR_ace_trenches_DigEnvelopeBig";
                        statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'ACE_envelope_big')])] call CBA_fnc_execNextFrame);
                        condition = QUOTE(GVAR(allowDigging) && ([ARR_2(_target,_player)] call ace_trenches_fnc_canContinueDiggingTrench) && GVAR(allowBigEnvelope));
                    };
                    class grad_trenches_digEnvelopeShort: ace_trenches_digEnvelopeBig {
                        displayName = CSTRING(DigEnvelopeShort);
                        statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'GRAD_envelope_short')])] call CBA_fnc_execNextFrame);
                        condition = QUOTE(GVAR(allowDigging) && ([ARR_2(_target,_player)] call ace_trenches_fnc_canContinueDiggingTrench) && GVAR(allowShortEnvelope));
                    };
                    class grad_trenches_digEnvelopeGiant: ace_trenches_digEnvelopeBig {
                        displayName = CSTRING(DigEnvelopeGiant);
                        statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'GRAD_envelope_giant')])] call CBA_fnc_execNextFrame);
                        condition = QUOTE(GVAR(allowDigging) && ([ARR_2(_target,_player)] call ace_trenches_fnc_canContinueDiggingTrench) && GVAR(allowGiantEnvelope));
                    };
                    class grad_trenches_digEnvelopeVehicle: ace_trenches_digEnvelopeBig {
                        displayName = CSTRING(DigEnvelopeVehicle);
                        statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'GRAD_envelope_vehicle')])] call CBA_fnc_execNextFrame);
                        condition = QUOTE(GVAR(allowDigging) && ([ARR_2(_target,_player)] call ace_trenches_fnc_canContinueDiggingTrench) && GVAR(allowVehicleEnvelope));
                    };
                    class grad_trenches_digEnvelopeLongNameEmplacment: ace_trenches_digEnvelopeBig {
                        displayName = CSTRING(DigEnvelopeLong);
                        statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'GRAD_envelope_long')])] call CBA_fnc_execNextFrame);
                        condition = QUOTE(GVAR(allowDigging) && ([ARR_2(_target,_player)] call ace_trenches_fnc_canContinueDiggingTrench) && GVAR(allowLongEnvelope));
                    };
                };
            };
        };
    };

    class BagFence_base_F;
    class ACE_envelope_small: BagFence_base_F {
        ace_trenches_noGeoClass = QUOTE(ACE_envelope_small_noGeo);
        ace_trenches_placementData[] = {8,1.1,0};
        editorCategory = "EdCat_Things";
        editorSubcategory = "EdSubcat_Military";
        GVAR(isTrench) = 1;
        ace_trenches_diggingDuration = QGVAR(smallEnvelopeDigTime);

        class CamouflagePositions01 {
            center[] = {0, 1.3, 0};
            left[] = {1.3, -0.8, 0.4};
            right[] = {-1.3,-0.8,0.4};
        };

        TRENCHES_ACTIONS;
        TRENCHES_ATTRIBUTES;
    };
    class ACE_envelope_big: BagFence_base_F {
        ace_trenches_noGeoClass = QUOTE(ACE_envelope_big_noGeo);
        editorCategory = "EdCat_Things";
        editorSubcategory = "EdSubcat_Military";
        GVAR(isTrench) = 1;
        ace_trenches_diggingDuration = QGVAR(bigEnvelopeDigTime);

        class CamouflagePositions01 {
            center[] = {-0.4, 0.4, 0.2};
            left[] = {-1.75, 0.2, 0.2};
            right[] = {1.75, 0.2, 0.2};
        };

        TRENCHES_ACTIONS;
        TRENCHES_ATTRIBUTES;
    };

    class GRAD_envelope_giant: ACE_envelope_big {
        author = QAUTHOR;
        displayName = CSTRING(EnvelopeGiantName);
        descriptionShort = CSTRING(EnevlopeGiantDescription);
        scope = 2;
        ace_trenches_diggingDuration = QGVAR(giantEnvelopeDigTime);
        ace_trenches_removalDuration = 30;
        ace_trenches_noGeoClass = QUOTE(GRAD_envelope_giant_noGeo);
        ace_trenches_placementData[] = {8,1.1,0.20};
        ace_trenches_grassCuttingPoints[] = {{-1.5,-1,0},{1.5,-1,0}};

        editorCategory = "EdCat_Things";
        editorSubcategory = "EdSubcat_Military";

        class CamouflagePositions01 {
            left1[] = {-0.5, 0.3, 0.5};
            left2[] = {-2.7, 0.3, 0.5};
            right1[] = {2.7, 0.15, 0.35};
            right2[] = {4.9, -0.5, -0.15};
        };
    };

    class GRAD_envelope_vehicle: ACE_envelope_big {
        author = QAUTHOR;
        displayName = CSTRING(EnvelopeVehicleName);
        descriptionShort = CSTRING(EnevlopeVehicleDescription);
        scope = 2;
        ace_trenches_diggingDuration = QGVAR(vehicleEnvelopeDigTime);
        ace_trenches_removalDuration = 60;
        ace_trenches_noGeoClass = QUOTE(GRAD_envelope_vehicle_noGeo);
        ace_trenches_placementData[] = {10,1.1,0.20};
        ace_trenches_grassCuttingPoints[] = {{-1.5,-1,0},{1.5,-1,0}};

        editorCategory = "EdCat_Things";
        editorSubcategory = "EdSubcat_Military";

        class CamouflagePositions01 {};
        class Attributes {};
    };

    class GRAD_envelope_short: ACE_envelope_big {
        author = QAUTHOR;
        displayName = CSTRING(EnvelopeShortName);
        descriptionShort = CSTRING(EnevlopeShortDescription);
        scope = 2;
        ace_trenches_diggingDuration = QGVAR(shortEnvelopeDigTime);
        ace_trenches_removalDuration = 10;
        ace_trenches_noGeoClass = QUOTE(GRAD_envelope_short_noGeo);
        ace_trenches_placementData[] = {10,1.1,0.20};
        ace_trenches_grassCuttingPoints[] = {{-1.5,-1,0},{1.5,-1,0}};

        editorCategory = "EdCat_Things";
        editorSubcategory = "EdSubcat_Military";

        class CamouflagePositions01 {
            right[] = {1.1,0.2,0.2};
            left[] = {-1.1,0.1,0.2};
        };
    };
    class GRAD_envelope_long: ACE_envelope_big {
        author = QAUTHOR;
        displayName = CSTRING(EnvelopeLongName);
        descriptionShort = CSTRING(EnevlopeLongDescription);
        scope = 2;
        ace_trenches_diggingDuration = QGVAR(longEnvelopeDigTime);
        ace_trenches_removalDuration = 10;
        ace_trenches_noGeoClass = QUOTE(GRAD_envelope_long_noGeo);
        ace_trenches_placementData[] = {10,2,0.20};
        ace_trenches_grassCuttingPoints[] = {{-1.5,-1,0},{1.5,-1,0}};

        editorCategory = "EdCat_Things";
        editorSubcategory = "EdSubcat_Military";

        class CamouflagePositions01 {
            right[] = {1.1,0.2,0.2};
            left[] = {-1.1,0.1,0.2};
        };
    };
};
