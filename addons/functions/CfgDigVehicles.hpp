class CfgDigVehicles {

    class B_APC_Tracked_01_CRV_F {
        type = "animate";
        animation = "moveplow";
        selection = "plow";
        plowRaised = 0;
        plowLowered = 0.9;
        distanceToTrench = 3;
    };

    class B_T_APC_Tracked_01_CRV_F {
        type = "animate";
        animation = "moveplow";
        selection = "plow";
        plowRaised = 0;
        plowLowered = 0.9;
        distanceToTrench = 3;
    };

    class gm_ge_army_bpz2a0 {
        type = "source";
        animation = "dozer_blade_elev_source";
        selection = "dozer_blade_elev";
        plowRaised = 0;
        plowLowered = .7;
        distanceToTrench = 3;
    };

    class gm_ge_army_bpz2a0_base : gm_ge_army_bpz2a0 {};
    class gm_ge_army_bpz2a0_des : gm_ge_army_bpz2a0 {};
    class gm_ge_army_bpz2a0_oli : gm_ge_army_bpz2a0 {};
    class gm_ge_army_bpz2a0_ols : gm_ge_army_bpz2a0 {};
    class gm_ge_army_bpz2a0_olw : gm_ge_army_bpz2a0 {};
    class gm_ge_army_bpz2a0_trp : gm_ge_army_bpz2a0 {};
    class gm_ge_army_bpz2a0_un : gm_ge_army_bpz2a0 {};
    class gm_ge_army_bpz2a0_wdl : gm_ge_army_bpz2a0 {};
    class gm_ge_army_bpz2a0_wds : gm_ge_army_bpz2a0 {};
    class gm_ge_army_bpz2a0_win : gm_ge_army_bpz2a0 {};
    class gm_ge_army_bpz2a0_wiw : gm_ge_army_bpz2a0 {};


    class gm_dk_army_bpz2a0 {
        type = "source";
        animation = "dozer_blade_elev_source";
        selection = "dozer_blade_elev";
        plowRaised = 0;
        plowLowered = .7;
        distanceToTrench = 3;
    };

    class gm_dk_army_bpz2a0_base : gm_dk_army_bpz2a0 {};
    class gm_dk_army_bpz2a0_des : gm_dk_army_bpz2a0 {};
    class gm_dk_army_bpz2a0_tan : gm_dk_army_bpz2a0 {};
    class gm_dk_army_bpz2a0_un : gm_dk_army_bpz2a0 {};
    class gm_dk_army_bpz2a0_wdl : gm_dk_army_bpz2a0 {};
    class gm_dk_army_bpz2a0_win : gm_dk_army_bpz2a0 {};

    class PRACS_M88 {
        type = "animate";
        animation = "Blade";
        selection = "Blade";
        plowRaised = 0;
        plowLowered = 0.93;
        distanceToTrench = 3;
    };
};
