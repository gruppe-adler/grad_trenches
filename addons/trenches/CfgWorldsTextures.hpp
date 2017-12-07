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

    //Stratis
    class Stratis: Altis {};

    //Malden
    class Malden: Altis {};

    //Tanoa
	class Tanoa : Altis{
		surfaceTextureBasePath = "A3\Map_Data_Exp\";
	};

    //Lythium
    class lythium: Default {
        surfaceTextureBasePath = "GBR\lythium\data\";
		    filePrefix = "co.paa";
    };

    // Bukovina
    class Bootcamp_ACR {
        surfaceTextureBasePath = "ca\Bootcamp_ACR\data\";
        filePrefix = "detail_co.paa";
    };

    // Bystrica
    class Woodland_ACR {
        surfaceTextureBasePath = "ca\Bohemia\data\";
        filePrefix = "detail_co.paa";
    };

    //Chernarus
    class Chernarus {
        surfaceTextureBasePath = "ca\CHERNARUS\data\";
        filePrefix = "detail_co.paa";
    };

    //Celle
    class mbg_celle2: Chernarus {};

    //Chernarus Summer
	  class Chernarus_Summer: Chernarus {};

  //Porto
	class Porto {
		surfaceTextureBasePath = "ca\desert2\data\";
		filePrefix = "detail_co.paa";
	};

    //Desert
    class Desert_E {
        surfaceTextureBasePath = "ca\Desert_E\data\";
        filePrefix = "co.paa";
    };

    //Rahmadi
    class Intro: Chernarus {};

    //Prei Khmaoch Luong
    class prei_khmaoch_luong {
        surfaceTextureBasePath = "A3\Map_Data_Exp\";
		    filePrefix = ".paa";
    };

    //Proving Grounds
    class ProvingGrounds_PMC {
        surfaceTextureBasePath = "ca\provinggrounds_pmc\Data\";
        filePrefix = "co.paa";
    };

  //Sahrani
	class Sara {
		surfaceTextureBasePath = "ca\sara\Data\";
		filePrefix = "detail_co.paa";
	};

  //United Sahrani
	class Sara_dbe1 : Sara {};

  //Southern Sahrani
	class SaraLite {
		surfaceTextureBasePath = "ca\saralite\Data\";
		filePrefix = ".paa";
	};

  //Shapur
	class Shapur_Baf {
		surfaceTextureBasePath = "ca\shapur_baf\Data\";
		filePrefix = "co.paa";
	};

  //Takistan
	class Takistan {
		surfaceTextureBasePath = "ca\takistan\Data\";
		filePrefix = "co.paa";
	};

  //Takistan Mountains
	class Mountains_ACR {
		surfaceTextureBasePath = "ca\afghan\Data\";
    filePrefix = "co.paa";
	};

  //Utes
	class utes {
		surfaceTextureBasePath = "ca\utes\Data\";
		filePrefix = "detail_co.paa";
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
