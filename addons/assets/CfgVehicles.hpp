class CBA_Extended_EventHandlers;

class CfgVehicles {
    class BagFence_base_F;
    class GRAD_envelope_short: BagFence_base_F {
        model = QPATHTOF(data\trench_short.p3d);
        hiddenSelections[] = {"camo_1"};
        hiddenSelectionsTextures[] = {"x\grad_trenches\addons\assets\data\zemlia.paa","x\grad_trenches\addons\assets\data\zemlia.paa"};
        editorPreview = QPATHTOF(data\trench_short.paa);

        class AnimationSources
        {
            class rise
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = 0;		// Initial phase when object is created.
            };
        };
    };
    class ACE_envelope_small: BagFence_base_F {
        model = QPATHTOF(data\trench_small.p3d);
        hiddenSelections[] = {"camo_1"};
        hiddenSelectionsTextures[] = {"x\grad_trenches\addons\assets\data\zemlia.paa","x\grad_trenches\addons\assets\data\zemlia.paa"};
        editorPreview = QPATHTOF(data\trench_small.paa);

        class AnimationSources
        {
            class rise
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = 0;		// Initial phase when object is created.
            };
        };
    };
    class ACE_envelope_big: BagFence_base_F {
        model = QPATHTOF(data\trench_big.p3d);
        hiddenSelections[] = {"camo_1"};
        hiddenSelectionsTextures[] = {"x\grad_trenches\addons\assets\data\zemlia.paa","x\grad_trenches\addons\assets\data\zemlia.paa"};
        editorPreview = QPATHTOF(data\trench_big.paa);

        class AnimationSources
        {
            class rise
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = 0;		// Initial phase when object is created.
            };
        };
    };
    class GRAD_envelope_giant: BagFence_base_F {
        model = QPATHTOF(data\trench_giant.p3d);
        hiddenSelections[] = {"camo_1"};
        hiddenSelectionsTextures[] = {"x\grad_trenches\addons\assets\data\zemlia.paa","x\grad_trenches\addons\assets\data\zemlia.paa"};
        editorPreview = QPATHTOF(data\trench_giant.paa);

        class AnimationSources
        {
            class rise
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = 0;		// Initial phase when object is created.
            };
        };
    };
    class GRAD_envelope_vehicle: BagFence_base_F {
        model = QPATHTOF(data\trench_vehicle.p3d);
        hiddenSelections[] = {"camo_1"};
        hiddenSelectionsTextures[] = {"x\grad_trenches\addons\assets\data\zemlia.paa","x\grad_trenches\addons\assets\data\zemlia.paa"};
        editorPreview = QPATHTOF(data\trench_vehicle.paa);

        class AnimationSources
        {
            class rise
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = 0;		// Initial phase when object is created.
            };
        };
    };
    class GRAD_envelope_long: BagFence_base_F {
        model = QPATHTOF(data\trench_long.p3d);
        hiddenSelections[] = {"camo_1"};
        hiddenSelectionsTextures[] = {"x\grad_trenches\addons\assets\data\zemlia.paa"};
        editorPreview = QPATHTOF(data\trench_long.paa);

        class AnimationSources
        {
            class rise
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = 0;		// Initial phase when object is created.
            };
        };
    };
    class GRAD_envelope_fightinghole: BagFence_base_F {
        model = QPATHTOF(data\trench_fightinghole.p3d);
        hiddenSelections[] = {"texture_01", "texture_02", "texture_03", "texture_04"};
        hiddenSelectionsTextures[] = {"x\grad_trenches\addons\assets\data\zemlia.paa", "x\grad_trenches\addons\assets\data\zemlia.paa", "x\grad_trenches\addons\assets\data\zemlia.paa", "x\grad_trenches\addons\assets\data\zemlia.paa"};
        //editorPreview = QPATHTOF(data\trench_fightinghole.paa);

        class AnimationSources
        {
            class rise
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = -0.4;	    // Initial phase when object is created.
            };
            class drop
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = 1.22;	// Initial phase when object is created.
            };
        };
    };
    class GRAD_envelope_filler: BagFence_base_F {
        model = QPATHTOF(data\trench_filler.p3d);
        hiddenSelections[] = {"velka"};
        hiddenSelectionsTextures[] = {"x\grad_trenches\addons\assets\data\zemlia.paa"};
        scope = 1;
        //editorPreview = QPATHTOF(data\trench_fightinghole.paa);
    };
    class GRAD_trenches_peg: BagFence_base_F {
        model = QPATHTOF(data\peg.p3d);
        hiddenSelections[] = {"camo_1","camo_2"};
		hiddenSelectionsTextures[] = {"a3\structures_f\data\wood\woodbroken_co.paa","a3\structures_f\data\wood\woodbroken_co.paa"};
        scope = 1;
        //editorPreview = QPATHTOF(data\trench_fightinghole.paa);
    };
};
