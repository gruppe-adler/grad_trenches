class CfgWorldsTextures {
    class Default {
        surfaceTextureBasePath = "a3\map_data\";
        filePrefix = "co.paa";
    };

    class Altis: Default {
        surfaceTextureBasePath = "a3\map_data\";
    };
    class Stratis: Altis {};
    class Tanoa: Altis {};
    class Malden: Altis {};
	class VR: Altis {};

    class lythium: Default {
        surfaceTextureBasePath = "GBR\lythium\data\";
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

    class Desert_E {
        surfaceTextureBasePath = "ca\Desert_E\data\";
        filePrefix = "detail_co.paa";
    };

    class prei_khmaoch_luong {
        surfaceTextureBasePath = "A3\Map_Data_Exp\";
    };

    class ProvingGrounds_PMC {
        surfaceTextureBasePath = "CA\ProvingGrounds_PMC\Data\";
        filePrefix = "detail_co.paa";
    };
	
	class Sara {
		surfaceTextureBasePath = "ca\sara\Data\";
	};
	class Sara_dbe1 : Sara {};
	
	class SaraLite {
		surfaceTextureBasePath = "ca\saralite\Data\";
	};
	
	class Shapur_Baf {
		surfaceTextureBasePath = "ca\shapur_baf\Data\";
		filePrefix = "baf_asfalt_co.paa";
	};
	
	class Takistan {
		surfaceTextureBasePath = "ca\takistan\Data\";
		filePrefix = "tk_beton_co.paa";
		
	};
	
	class Mountains_ACR {
		surfaceTextureBasePath = "ca\afghan\Data\";
        filePrefix = "tk_asfalt_co.paa";
	};
	
	class utes {
		surfaceTextureBasePath = "ca\utes\Data\";
		filePrefix = "ut_skala_detail_co.paa";
	};
	
	class Zagrabad {
		surfaceTextureBasePath = "ca\zargabad\Data\";
		filePrefix = "zr_beton_co.paa";
	};
};
