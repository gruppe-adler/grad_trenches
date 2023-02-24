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
        GVAR(borderLines)[] = {{"p1", "p2"}, {"p2", "p3"}, {"p3", "p4"}, {"p4", "p5"}, {"p5", "p6"}, {"p6", "p1"}};
        GVAR(fillingTriangles)[] = {{"p1", "p2", "p3"}, {"p1", "p3", "p4"}, {"p1", "p4", "p5"}, {"p1", "p5", "p6"}};
        GVAR(openCorners)[] = {};
        //editorPreview = QPATHTOF(data\trench_fightinghole.paa);

        class AnimationSources
        {
            class drop
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = 1.22;	// Initial phase when object is created.
            };
            class rise
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = -0.4;	    // Initial phase when object is created.
            };
        };
    };
    /*
    class GRAD_trenches_peg: BagFence_base_F {
        model = QPATHTOF(data\peg.p3d);
        hiddenSelections[] = {"camo_1","camo_2"};
		hiddenSelectionsTextures[] = {"a3\structures_f\data\wood\woodbroken_co.paa","a3\structures_f\data\wood\woodbroken_co.paa"};
        scope = 1;
        //editorPreview = QPATHTOF(data\trench_fightinghole.paa);
    };
    */
    class Rocks_base_F;
	class GRAD_trenches_triangle_filler: Rocks_base_F
	{
		scope				= 1;										/// makes the lamp invisible in editor
		scopeCurator		= 1;											/// makes the lamp visible in Zeus
		displayName			= "Magic Triangle";									/// displayed in Editor
		model				= QPATHTOF(data\triangle_filler.p3d);	/// simple path to model
		hiddenSelections[] = {"camo"}; /// what selection in model could have different textures
		hiddenSelectionsTextures[] = {"\a3\missions_f_aow\data\img\textures\grass\grass_01_co.paa"}; /// what texture is going to be used

		armor				= 5000;	/// just some protection against missiles, collisions and explosions

		class Hitpoints {};
		class AnimationSources {
			class Corner_1_UD_source
			{
				source = user; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_1_LR_source
			{
				source = user; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_1_FB_source
			{
				source = user; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_2_UD_source
			{
				source = user; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_2_LR_source
			{
				source = user; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_2_FB_source
			{
				source = user; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_3_UD_source
			{
				source = user; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_3_LR_source
			{
				source = user; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
			class Corner_3_LR_source_FB_source
			{
				source = user; // "user" = custom source = not controlled by some engine value
				initPhase = 0; // Initial value of animations based on this source
				animPeriod = 1; // Coefficient for duration of change of this animation
				sound = "GenericDoorsSound"; /// Selects sound class from CfgAnimationSourceSounds that is going to be used for sounds of doors
			};
		};
	};

    class GRAD_trenches_triangleLarge_filler: GRAD_trenches_triangle_filler
	{
		displayName			= "Magic Triangle (larger anim range)";									/// displayed in Editor
		model				= QPATHTOF(data\triangleLarge_filler.p3d);	/// simple path to model
		hiddenSelections[] = {"camo"}; /// what selection in model could have different textures
		hiddenSelectionsTextures[] = {"\a3\missions_f_aow\data\img\textures\grass\grass_01_co.paa"}; /// what texture is going to be used

	};
};
