#define TRENCHES_ACTIONS class ACE_Actions { \
        class ACE_MainActions { \
            distance = 10; \
            position = "[0,0,3.3]"; \
            class GVAR(ContinueDiggingTrench) { \
                displayName = CSTRING(ContinueDiggingTrench); \
                condition = QUOTE([ARR_2(_target,_player)] call ace_trenches_fnc_canContinueDiggingTrench); \
                statement = QUOTE([ARR_3(_target,_player,true)] call FUNC(continueDiggingTrench);); \
                distance = 10; \
            }; \
            class GVAR(RemoveTrench) { \
                displayName = CSTRING(RemoveEnvelope); \
                condition = QUOTE([ARR_2(_target,_player)] call ace_trenches_fnc_canRemoveTrench); \
                statement = QUOTE([ARR_3(_target,_player,true)] call EFUNC(common,removeTrench);); \
                distance = 10; \
             };  \
            class GVAR(helpDigging) { \
                displayName = ECSTRING(common,HelpDigging); \
                condition = QUOTE([ARR_2(_target,_player)] call EFUNC(common,canHelpDiggingTrench)); \
                statement = QUOTE([ARR_2(_target,_player)] call EFUNC(common,addDigger)); \
                priority = -1; \
                distance = 10; \
            }; \
            class GVAR(placeCamouflage) { \
                displayName = ECSTRING(common,placeCamouflage); \
                condition = QUOTE([ARR_2(_target,_player)] call EFUNC(common,canPlaceCamouflage)); \
                statement = QUOTE([ARR_2(_target,_player)] call EFUNC(common,placeCamouflage)); \
                priority = -1; \
                distance = 10; \
            }; \
            class GVAR(removeCamouflage) { \
                displayName = ECSTRING(common,removeCamouflage); \
                condition = QUOTE([_target] call EFUNC(common,canRemoveCamouflage)); \
                statement = QUOTE([ARR_2(_target,_player)] call EFUNC(common,removeCamouflage)); \
                priority = -1; \
                distance = 10; \
            }; \
        }; \
    }

#define TRENCHES_ATTRIBUTES class Attributes { \
        class GVAR(camouflageAttribute) { \
            control = "CheckboxNumber"; \
            defaultValue = "0"; \
            displayName = ECSTRING(common,CamouflageAttribute); \
            tooltip = ECSTRING(common,CamouflageAttributeTooltip); \
            expression = QUOTE([ARR_2(_this,_value)] call EFUNC(common,applyCamouflageAttribute)); \
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
                    condition = QUOTE(_player call EFUNC(common,canDigTrench) && EGVAR(common,allowDigging));
                    statement = "";
                    showDisabled = 0;
                    priority = 3;
                    exceptions[] = {"notOnMap", "isNotInside", "isNotSitting"};

                    class ace_trenches_digEnvelopeSmall {
                        displayName = CSTRING(DigEnvelopeSmall);
                        exceptions[] = {};
                        showDisabled = 0;
                        priority = 4;
                        statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'ACE_envelope_small')])] call CBA_fnc_execNextFrame);
                        condition = QUOTE(EGVAR(common,allowDigging) && ([ARR_2(_target,_player)] call FUNC(canContinueDiggingTrench)) && GVAR(allowSmallEnvelope));
                    };
                    class ace_trenches_digEnvelopeBig: ace_trenches_digEnvelopeSmall {
                        displayName = CSTRING(DigEnvelopeBig);
                        statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'ACE_envelope_big')])] call CBA_fnc_execNextFrame);
                        condition = QUOTE(EGVAR(common,allowDigging) && ([ARR_2(_target,_player)] call FUNC(canContinueDiggingTrench)) && GVAR(allowBigEnvelope));
                    };
                    class grad_trenches_digEnvelopeShort: ace_trenches_digEnvelopeBig {
                        displayName = CSTRING(DigEnvelopeShort);
                        statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'GRAD_envelope_short')])] call CBA_fnc_execNextFrame);
                        condition = QUOTE(EGVAR(common,allowDigging) && ([ARR_2(_target,_player)] call FUNC(canContinueDiggingTrench)) && GVAR(allowShortEnvelope));
                    };
                    class grad_trenches_digEnvelopeGiant: ace_trenches_digEnvelopeBig {
                        displayName = CSTRING(DigEnvelopeGiant);
                        statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'GRAD_envelope_giant')])] call CBA_fnc_execNextFrame);
                        condition = QUOTE(EGVAR(common,allowDigging) && ([ARR_2(_target,_player)] call FUNC(canContinueDiggingTrench)) && GVAR(allowGiantEnvelope));
                    };
                    class grad_trenches_digEnvelopeVehicle: ace_trenches_digEnvelopeBig {
                        displayName = CSTRING(DigEnvelopeVehicle);
                        statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'GRAD_envelope_vehicle')])] call CBA_fnc_execNextFrame);
                        condition = QUOTE(EGVAR(common,allowDigging) && ([ARR_2(_target,_player)] call FUNC(canContinueDiggingTrench)) && GVAR(allowVehicleEnvelope));
                    };
                    class grad_trenches_digEnvelopeLongNameEmplacment: ace_trenches_digEnvelopeBig {
                        displayName = CSTRING(DigEnvelopeLong);
                        statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'GRAD_envelope_long')])] call CBA_fnc_execNextFrame);
                        condition = QUOTE(EGVAR(common,allowDigging) && ([ARR_2(_target,_player)] call FUNC(canContinueDiggingTrench)) && GVAR(allowLongEnvelope));
                    };
                };
            };
        };
    };

    class BagFence_base_F;
    class ACE_envelope_small: BagFence_base_F {
        author = QAUTHOR;
        displayName = CSTRING(EnvelopeSmallName);
        descriptionShort = CSTRING(EnvelopeSmallDescription);
        EGVAR(common,offset) = -0.585;
        ace_trenches_placementData[] = {8,1.1,0};
        editorCategory = "EdCat_Things";
        editorSubcategory = "EdSubcat_Military";
        GVAR(isTrench) = 1;
        ace_trenches_diggingDuration = QGVAR(smallEnvelopeDigTime);
        ace_trenches_removalDuration = QGVAR(smallEnvelopeRemovalTime);
        scopecurator = 2;
        scope = 2;
        GVAR(damageMultiplier) = QGVAR(smallEnvelopeDamageMultiplier);

        class CamouflagePositions1 {};

        TRENCHES_ACTIONS;

        class Attributes {};
    };
    class ACE_envelope_big: ACE_envelope_small{
        displayName = CSTRING(EnvelopeBigName);
        descriptionShort = CSTRING(EnvelopeBigDescription);
        ace_trenches_diggingDuration = QGVAR(bigEnvelopeDigTime);
        ace_trenches_removalDuration = QGVAR(bigEnvelopeRemovalTime);
        EGVAR(common,offset) = -1.53;
        GVAR(damageMultiplier) = QGVAR(bigEnvelopeDamageMultiplier);

        class CamouflagePositions1 {
            a[] = {0, 0.9, 3.4};
            b[] = {3, -1, 3.3};
            c[] = {-3, -1, 3.1};
        };

        class CamouflagePositions2 {
            a[] = {1.5, -0.5, 4};
            b[] = {-1.5, -0.5, 4};
        };

        TRENCHES_ACTIONS;
        TRENCHES_ATTRIBUTES;
    };

    class GRAD_envelope_giant: ACE_envelope_big {
        displayName = CSTRING(EnvelopeGiantName);
        descriptionShort = CSTRING(EnvelopeGiantDescription);
        ace_trenches_diggingDuration = QGVAR(giantEnvelopeDigTime);
        ace_trenches_removalDuration = QGVAR(giantEnvelopeRemovalTime);
        EGVAR(common,offset) = -1.82;
        ace_trenches_placementData[] = {8,1.1,0.20};
        ace_trenches_grassCuttingPoints[] = {{-1.5,-1,0},{1.5,-1,0}};
        GVAR(damageMultiplier) = QGVAR(giantEnvelopeDamageMultiplier);

        class CamouflagePositions1 {
            a[] = {4.4, 0, 3};
            b[] = {1.5, 0.5, 3.9};
            c[] = {-2.1, 0.9, 3.4};
            d[] = {-4.6, 0, 3};
        };

        class CamouflagePositions2 {};

        class ACE_MainActions {
            position = "[0,0,3.1]";
        };

    };

    class GRAD_envelope_vehicle: ACE_envelope_big {
        displayName = CSTRING(EnvelopeVehicleName);
        descriptionShort = CSTRING(EnvelopeVehicleDescription);
        ace_trenches_diggingDuration = QGVAR(vehicleEnvelopeDigTime);
        ace_trenches_removalDuration = QGVAR(vehicleEnvelopeRemovalTime);
        EGVAR(common,offset) = -2;
        ace_trenches_placementData[] = {10,1.1,0.20};
        ace_trenches_grassCuttingPoints[] = {{-1.5,-1,0},{1.5,-1,0}};
        GVAR(damageMultiplier) = QGVAR(vehicleEnvelopeDamageMultiplier);

        class CamouflagePositions1 {
            a[] = {3.9, 2.5, 3.5};
            b[] = {3.9, -2.5, 4.3};
            c[] = {-3.5, -2.5, 4.3};
            d[] = {-3, 2.5, 3.5};
        };

        class CamouflagePositions2 {};

        class ACE_MainActions {
            position = "[0,0,3.1]";
        };
    };

    class GRAD_envelope_short: ACE_envelope_big {
        displayName = CSTRING(EnvelopeShortName);
        descriptionShort = CSTRING(EnvelopeShortDescription);
        ace_trenches_diggingDuration = QGVAR(shortEnvelopeDigTime);
        ace_trenches_removalDuration = QGVAR(shortEnvelopeRemovalTime);
        EGVAR(common,offset) = -1.2;
        ace_trenches_placementData[] = {10,1.1,0.20};
        ace_trenches_grassCuttingPoints[] = {{-1.5,-1,0},{1.5,-1,0}};
        GVAR(damageMultiplier) = QGVAR(shortEnvelopeDamageMultiplier);

        class CamouflagePositions1 {
            a[] = {1.7, 0.7, 3.1};
            b[] = {-1.4, 0.8, 3.2};
        };

        class CamouflagePositions2 {};

        class ACE_MainActions {
            position = "[0,0,3.5]";
        };
    };
    class GRAD_envelope_long: ACE_envelope_big {
        displayName = CSTRING(EnvelopeLongName);
        descriptionShort = CSTRING(EnvelopeLongDescription);
        ace_trenches_diggingDuration = QGVAR(longEnvelopeDigTime);
        ace_trenches_removalDuration = QGVAR(longEnvelopeRemovalTime);
        EGVAR(common,offset) = -1.72;
        ace_trenches_placementData[] = {10,2,0.20};
        ace_trenches_grassCuttingPoints[] = {{-1.5,-1,0},{1.5,-1,0}};

        class CamouflagePositions1 {
            a[] = {6.7, 0, 3.2};
            b[] = {3, 0.5, 3.1};
            c[] = {-2.2, -0.9, 4};
            d[] = {-3, 0.5, 3.1};
            e[] = {-6.9, -0.1, 3.1};
        };

        class CamouflagePositions2 {};

        class ACE_MainActions {
            position = "[0,-2,3.5]";
        };
    };
};