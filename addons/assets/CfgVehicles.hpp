class CBA_Extended_EventHandlers;

class CfgVehicles {
    class BagFence_base_F;
    class ACE_envelope_small: BagFence_base_F {
        model = QPATHTOF(data\trench_small.p3d);
        hiddenSelections[] = {"velka"};
    };
    class ACE_envelope_big: BagFence_base_F {
        model = QPATHTOF(data\trench_big.p3d);
        hiddenSelections[] = {"velka"};
    };
    class GRAD_envelope_gigant: BagFence_base_F {
        model = QPATHTOF(data\trench_gigant.p3d);
        hiddenSelections[] = {"velka"};
    };
    class GRAD_envelope_vehicle: BagFence_base_F {
        model = QPATHTOF(data\trench_vehicle.p3d);
        hiddenSelections[] = {"velka"};
    };

    class ACE_envelope_small_noGeo: BagFence_base_F {
        model = QPATHTOF(data\trench_small_nogeo.p3d);
        hiddenSelections[] = {"velka"};
    };
    class ACE_envelope_big_noGeo: BagFence_base_F {
        model = QPATHTOF(data\trench_big_nogeo.p3d);
        hiddenSelections[] = {"velka"};
    };
    class GRAD_envelope_gigant_noGeo: BagFence_base_F {
        scope = 1;
        model = QPATHTOF(data\trench_gigant_nogeo.p3d);
        hiddenSelections[] = {"velka"};
    };
    class GRAD_envelope_vehicle_noGeo: BagFence_base_F {
        scope = 1;
        model = QPATHTOF(data\trench_vehicle_nogeo.p3d);
        hiddenSelections[] = {"velka"};
    };
};
