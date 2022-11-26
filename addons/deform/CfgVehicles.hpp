#define TRENCHES_ACTIONS class ACE_Actions { \
        class ACE_MainActions { \
            distance = 10; \
            class GVAR(ContinueDiggingTrench) { \
                displayName = CSTRING(ContinueDiggingTrench); \
                condition = QUOTE([ARR_2(_target,_player)] call ace_trenches_fnc_canContinueDiggingTrench); \
                statement = QUOTE([ARR_3(_target,_player,true)] call FUNC(continueDiggingTrench);); \
                distance = 10; \
            }; \
            class GVAR(RemoveTrench) { \
                displayName = CSTRING(RemoveEnvelope); \
                condition = QUOTE([ARR_2(_target,_player)] call ace_trenches_fnc_canRemoveTrench); \
                statement = QUOTE([ARR_3(_target,_player,true)] call FUNC(removeDeformTrench);); \
                distance = 10; \
             };  \
            class GVAR(helpDigging) { \
                displayName = ECSTRING(common,HelpDigging); \
                condition = QUOTE([ARR_2(_target,_player)] call EFUNC(common,canHelpDiggingTrench)); \
                statement = QUOTE([ARR_2(_target,_player)] call EFUNC(common,addDigger)); \
                priority = -1; \
                distance = 10; \
            }; \
        }; \
    }

class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class ace_trenches {
                    class ace_trenches_digEnvelopefightinghole {
                        displayName = CSTRING(DigEnvelopeFightingHole);
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
        EGVAR(common,offset) = -0.4;
        EGVAR(common,offset1) = 1.22;
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
            position = "[0,0,3.5]";
        };

        TRENCHES_ACTIONS;
    };
};
