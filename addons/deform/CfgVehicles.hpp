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
                class ace_trenches {
                    class ace_trenches_digEnvelopefightinghole {
                        displayName = CSTRING(DigEnvelopefightinghole);
                        exceptions[] = {};
                        showDisabled = 0;
                        priority = 4;
                        statement = QUOTE([ARR_2({_this call FUNC(choosePos)},[ARR_2(_this select 0,'GRAD_envelope_fightinghole')])] call CBA_fnc_execNextFrame);
                        condition = QUOTE(EGVAR(common,allowDigging) && ([ARR_2(_target,_player)] call FUNC(canContinueDeformingTrench)) && GVAR(allowFightingholeEnvelope));
                    };
                };
            };
        };
    };

    class BagFence_base_F;
    class GRAD_envelope_fightinghole: BagFence_base_F {
        author = "Salbei";
        displayName = CSTRING(EnvelopeFightingHoleName);
        descriptionShort = CSTRING(EnvelopeFightingHoleDescription);
        scope = 2;
        scopecurator = 2;
        editorCategory = "EdCat_Things";
        editorSubcategory = "EdSubcat_Military";
        GVAR(isTrench) = 1;
        ace_trenches_diggingDuration = QGVAR(FightingHoleEnvelopeDigTime);
        ace_trenches_removalDuration = QGVAR(FightingHoleEnvelopeRemovalTime);
        GVAR(offset) = -0.4;
        GVAR(offset1) = 1.22;
        GVAR(depth) = 1.5;
        GVAR(placementData)[] = {10,2,-0.01};
        GVAR(grassCuttingPoints)[] = {{-1.5,-1,0},{1.5,-1,0}};
        GVAR(damageMultiplier) = QGVAR(fightingholeEnvelopeDamageMultiplier);

        class EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers {};
        };

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
