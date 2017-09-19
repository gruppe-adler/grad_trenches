class CBA_Extended_EventHandlers;

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
    };
    class ACE_envelope_big: BagFence_base_F {
        model = QPATHTOF(data\ace_envelope_big4.p3d);
		hiddenSelections[] = {"velka"};
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
