class CfgWorldsTextures {
    class Default {
        surfaceTextureBasePath = "a3\map_data\";
        filePrefix = "co.paa";
    };

    class Altis: Default {
        surfaceTextureBasePath = "a3\map_data\";
		
    };
    class Stratis: Altis {};
    class Malden: Altis {};
	class VR: Altis {};
	class Tanoa {
		surfaceTextureBasePath = "A3\Map_Data_Exp\";
		filePrefix = ".paa";
	};

    class lythium: Default {
        surfaceTextureBasePath = "GBR\lythium\data\";
		filePrefix = ".paa";
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

    class Chernarus {
        surfaceTextureBasePath = "ca\CHERNARUS\data\";
        filePrefix = "detail_co.paa";
		
    };
    class mbg_celle2: Chernarus {};
	class Chernarus_Summer: Chernarus {};
	
	class Porto {
		surfaceTextureBasePath = "ca\desert2\data\";
		filePrefix = "detail_co.paa";
		
	};

    class Desert_E {
        surfaceTextureBasePath = "ca\Desert_E\data\";
        filePrefix = "co.paa";
		
    };

    class prei_khmaoch_luong {
        surfaceTextureBasePath = "A3\Map_Data_Exp\";
		filePrefix = ".paa";		
    };

    class ProvingGrounds_PMC {
        surfaceTextureBasePath = "ca\provinggrounds_pmc\Data\";
        filePrefix = "co.paa";
		
    };
	
	class Sara {
		surfaceTextureBasePath = "ca\sara\Data\";
		filePrefix = "detail_co.paa";
		
	};
	class Sara_dbe1 : Sara {};
	
	class SaraLite {
		surfaceTextureBasePath = "ca\saralite\Data\";
		filePrefix = ".paa";		
	};
	
	class Shapur_Baf {
		surfaceTextureBasePath = "ca\shapur_baf\Data\";
		filePrefix = "co.paa";
	};
	
	class Takistan {
		surfaceTextureBasePath = "ca\takistan\Data\";
		filePrefix = "co.paa";
	};
	
	class Mountains_ACR {
		surfaceTextureBasePath = "ca\afghan\Data\";
        filePrefix = "co.paa";
	};
	
	class utes {
		surfaceTextureBasePath = "ca\utes\Data\";
		filePrefix = "detail_co.paa";
		class Surfaces {
			class Default {
				pathList = "a3\map_data\default.paa";
			};			
		};
	};
	
	class Zargabad {
		surfaceTextureBasePath = "ca\zargabad\Data\";
		filePrefix = "_co.paa";
	};
};
