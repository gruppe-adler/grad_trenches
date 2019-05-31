class CBA_Extended_EventHandlers;

class CfgVehicles {
    class BagFence_base_F;
    class GRAD_envelope_short: BagFence_base_F {
        model = QPATHTOF(data\trench_short.p3d);
        hiddenSelections[] = {"velka"};
    };
    class ACE_envelope_small: BagFence_base_F {
        model = QPATHTOF(data\trench_small.p3d);
        hiddenSelections[] = {"velka"};
    };
    class ACE_envelope_big: BagFence_base_F {
        model = QPATHTOF(data\trench_big.p3d);
        hiddenSelections[] = {"velka"};
    };
    class GRAD_envelope_giant: BagFence_base_F {
        model = QPATHTOF(data\trench_giant.p3d);
        hiddenSelections[] = {"velka"};
    };
    class GRAD_envelope_vehicle: BagFence_base_F {
        model = QPATHTOF(data\trench_vehicle.p3d);
        hiddenSelections[] = {"velka"};
    };
};
