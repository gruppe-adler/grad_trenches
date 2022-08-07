#define TRENCHES_ACTIONS class ACE_Actions { \
        class ACE_MainActions { \
            distance = 10; \
            position = "[0,0,3.3]"; \
            class ACE_ContinueDiggingTrench { \
                statement = QUOTE([ARR_3(_target,_player,true)] call FUNC(continueDiggingTrench);); \
                distance = 10; \
            }; \
            class ACE_RemoveTrench { \
                statement = QUOTE([ARR_3(_target,_player,true)] call EFUNC(common,removeTrench);); \
                distance = 10; \
             };  \
            class GVAR(helpDigging) { \
                displayName = CSTRING(HelpDigging); \
                condition = QUOTE([ARR_2(_target,_player)] call EFUNC(common,canHelpDiggingTrench)); \
                statement = QUOTE([ARR_2(_target,_player)] call EFUNC(common,addDigger)); \
                priority = -1; \
                distance = 10; \
            }; \
            class GVAR(placeCamouflage) { \
                displayName = CSTRING(placeCamouflage); \
                condition = QUOTE([ARR_2(_target,_player)] call EFUNC(common,canPlaceCamouflage)); \
                statement = QUOTE([ARR_2(_target,_player)] call EFUNC(common,placeCamouflage)); \
                priority = -1; \
                distance = 10; \
            }; \
            class GVAR(removeCamouflage) { \
                displayName = CSTRING(removeCamouflage); \
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
            displayName = CSTRING(CamouflageAttribute); \
            tooltip = CSTRING(CamouflageAttributeTooltip); \
            expression = QUOTE([ARR_2(_this,_value)] call EFUNC(common,applyCamouflageAttribute)); \
            property = QUOTE(grad_trenches_camouflageTrench); \
        }; \
    }

class CfgVehicles {
    /*
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {

                delete ace_trenches_digEnvelopeSmall;
                delete ace_trenches_digEnvelopeBig;

                class ace_trenches {
                    displayName = "$STR_ACE_Trenches_EntrenchingToolName";
                    condition = QUOTE(_player call EFUNC(common,canDigTrench) && GVAR(allowDigging));
                    statement = "";
                    showDisabled = 0;
                    priority = 3;
                    exceptions[] = {"notOnMap", "isNotInside", "isNotSitting"};

                    class ace_trenches_digEnvelopefightinghole {
                        displayName = CSTRING(DigEnvelopefightinghole);
                        exceptions[] = {};
                        showDisabled = 0;
                        priority = 4;
                        statement = QUOTE([ARR_2({_this call FUNC(placeTrench)},[ARR_2(_this select 0,'GRAD_envelope_fightinghole')])] call CBA_fnc_execNextFrame);
                        condition = QUOTE(GVAR(allowDigging) && ([ARR_2(_target,_player)] call FUNC(canContinueDiggingTrench)) && GVAR(allowSmallEnvelope));
                    };
                };
            };
        };
    };
    */
    class ACE_envelope_big;
    class GRAD_envelope_fightinghole: ACE_envelope_big {
        displayName = CSTRING(EnvelopeFightingHoleName);
        descriptionShort = CSTRING(EnvelopeFightingHoleDescription);
        ace_trenches_diggingDuration = QGVAR(FightingHoleEnvelopeDigTime);
        ace_trenches_removalDuration = QGVAR(FightingHoleEnvelopeRemovalTime);
        GVAR(offset) = 1.5;
        ace_trenches_placementData[] = {10,2,0.20};
        ace_trenches_grassCuttingPoints[] = {{-1.5,-1,0},{1.5,-1,0}};
        GVAR(damageMultiplier) = QGVAR(fightingholeEnvelopeDamageMultiplier);

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

        TRENCHES_ACTIONS;
        TRENCHES_ATTRIBUTES;
    };
};
