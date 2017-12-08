class CfgWorldsTextures {
    class Default {
        surfaceTextureBasePath = "a3\map_data\";
        filePrefix = "co.paa";
    };
    //Altis
    class Altis: Default {
        surfaceTextureBasePath = "a3\map_data\";
        camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d"};
    };

    // Bukovina
    class Bootcamp_ACR {
        surfaceTextureBasePath = "ca\Bootcamp_ACR\data\";
        filePrefix = "detail_co.paa";
        camouflageObjects[] = {"ca\plants_E2\clutter\c_summer_flowers.p3d"};
    };

    // Bystrica
    class Woodland_ACR {
        surfaceTextureBasePath = "ca\Bohemia\data\";
        filePrefix = "detail_co.paa";
        camouflageObjects[] = {"ca\plants2\clutter\c_fern.p3d"};
    };

    //Chernarus
    class Chernarus {
        surfaceTextureBasePath = "ca\CHERNARUS\data\";
        filePrefix = "detail_co.paa";
        camouflageObjects[] = {"CUP\Terrains\cup_terrains_worlds\Clutter\c_GrassCrookedGreen.p3d"};
    };

    //Celle
    class mbg_celle2: Chernarus {
        camouflageObjects[] = {};
    };

    //Chernarus Summer
	  class Chernarus_Summer: Chernarus {
        camouflageObjects[] = {};
    };

    //Lythium
    class lythium: Default {
        surfaceTextureBasePath = "GBR\lythium\data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d"};
    };

    //Malden
    class Malden: Altis {
        camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d"};
    };

  //Porto
	class Porto {
    		surfaceTextureBasePath = "ca\desert2\data\";
    		filePrefix = "detail_co.paa";
        camouflageObjects[] = {};
	};

    //Desert
    class Desert_E {
        surfaceTextureBasePath = "ca\Desert_E\data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {"ca\plants_E\Clutter\c_GrassDesert_GroupSoft_EP1.p3d"};
    };

    //Rahmadi
    class Intro: Chernarus {
         camouflageObjects[] = {"ca\plants\clutter_grass_flowers.p3d"};
    };

    //Prei Khmaoch Luong
    class prei_khmaoch_luong {
        surfaceTextureBasePath = "A3\Map_Data_Exp\";
		    filePrefix = ".paa";
        camouflageObjects[] = {"a3\vegetation_f_exp\clutter\grass\c_Grass_Tropic.p3d"};
    };

    //Proving Grounds
    class ProvingGrounds_PMC {
        surfaceTextureBasePath = "ca\provinggrounds_pmc\Data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {"ca\plants_pmc\Clutter\c_GrassTall_pmc.p3d"};
    };

  //Sahrani
	class Sara {
      surfaceTextureBasePath = "ca\sara\Data\";
      filePrefix = "detail_co.paa";
      camouflageObjects[] = {"ca\hotfix\ClutterFix_Grass_Long.p3d"};
	};

  //Shapur
	class Shapur_Baf {
		 surfaceTextureBasePath = "ca\shapur_baf\Data\";
		 filePrefix = "co.paa";
     camouflageObjects[] = {"ca\plants_E\Clutter\c_Brush_Hard_EP1.p3d"};
	};

  //Southern Sahrani
  class SaraLite {
     surfaceTextureBasePath = "ca\saralite\Data\";
     filePrefix = ".paa";
     camouflageObjects[] = {};
  };

  //Stratis
  class Stratis: Altis {
     camouflageObjects[] = {};
  };

  //Takistan
	class Takistan {
		 surfaceTextureBasePath = "ca\takistan\Data\";
		 filePrefix = "co.paa";
     camouflageObjects[] = {};
	};

  //Takistan Mountains
	class Mountains_ACR {
		 surfaceTextureBasePath = "ca\afghan\Data\";
     filePrefix = "co.paa";
     camouflageObjects[] = {};
	};

  //Tanoa
  class Tanoa : Altis{
     surfaceTextureBasePath = "A3\Map_Data_Exp\";
     camouflageObjects[] = {};
  };

  //United Sahrani
  class Sara_dbe1 : Sara {
     camouflageObjects[] = {};
  };

  //Utes
	class utes {
		surfaceTextureBasePath = "ca\utes\Data\";
		filePrefix = "detail_co.paa";
    camouflageObjects[] = {};
		class Surfaces {
			class Default {
				texturePath = "a3\map_data\gdt_beach_co.paa";
			};
		};
	};

  //Zargabad
	class Zargabad {
		surfaceTextureBasePath = "ca\zargabad\Data\";
		filePrefix = "co.paa";
	};
};
