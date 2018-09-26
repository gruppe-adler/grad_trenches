class CfgWorldsTextures {
    class Default {
        surfaceTextureBasePath = "a3\map_data\";
        filePrefix = "co.paa";
    };

    //Altis
    class Altis: Default {
    camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d" /*, "A3\plants_f\Clutter\c_Thistle_Thorn_Green.p3d"*/};
    };

    //Baranow
    class Baranow {
        surfaceTextureBasePath = "WW2\TerrainsIF_t\Worlds\IF_Surfaces_t\staszow\";
        filePrefix = "_co.paa";
        camouflageObjects[] = {};
    };

    //Bray-Dunes
    class SWU_Dunkirk_Bray_Dunes_1940 {
        surfaceTextureBasePath = "WW2\TerrainsWW2_swurvin\Surfaces_t\";
        filePrefix = "co.paa";
        camouflageObjects[] = {};
    };

    // Bukovina
    class Bootcamp_ACR {
        surfaceTextureBasePath = "ca\Bootcamp_ACR\data\";
        filePrefix = "detail_co.paa";
        camouflageObjects[] = {"ca\plants2\clutter\c_GrassBunch.p3d"};
    };

    // Bystrica
    class Woodland_ACR {
        surfaceTextureBasePath = "ca\Bohemia\data\";
        filePrefix = "detail_co.paa";
        camouflageObjects[] = {"ca\plants2\clutter\c_weed3.p3d"};
    };

    //Chernarus
    class Chernarus {
        surfaceTextureBasePath = "ca\CHERNARUS\data\";
        filePrefix = "detail_co.paa";
        camouflageObjects[] = {"ca\plants2\clutter\c_weed3.p3d"};
    };

    //Celle
    class mbg_celle2: Chernarus {
        camouflageObjects[] = {};
    };

    //Chernarus Summer
    class Chernarus_Summer: Chernarus {
        camouflageObjects[] = {"ca\plants2\clutter\c_weed3.p3d"};
    };

    //Chernarus Winter
    class Chernarus_Winter {
        surfaceTextureBasePath = "\chernarus_winter\data\";
        filePrefix = "detail_co.paa";
        camouflageObjects[] = {};
    };

    //Colleville
    class Colleville {
        surfaceTextureBasePath = "WW2\TerrainsIF_t\Worlds\IF_Surfaces_t\staszow\";
        filePrefix = "co.paa";
        camouflageObjects[] = {};
    };

    //Desert
    class Desert_E {
        surfaceTextureBasePath = "ca\Desert_E\data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {"ca\plants_E\Clutter\c_Brush_Hard_EP1.p3d"};
    };

    //G.O.S Al Rayak
    class pja310 {
        surfaceTextureBasePath = "mak\projetA3-10\Data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {/*"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d" ,*/ "A3\plants_f\Clutter\c_Thistle_Thorn_Green.p3d"};
    };

    //G.O.S Leskovets
    class pja314 {
        surfaceTextureBasePath = "MAK\projetA3014\data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {/*"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d" ,*/ "A3\plants_f\Clutter\c_Thistle_Thorn_Green.p3d"};
    };

    //Ivachev
    class Ivachev {
        surfaceTextureBasePath = "WW2\TerrainsIF_t\Worlds\IF_Surfaces_t\staszow\";
        filePrefix = "co.paa";
        camouflageObjects[] = {};
    };

    // Kerama
    class kerama {
        surfaceTextureBasePath = "Kerama\data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {/*"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d" ,*/ "A3\plants_f\Clutter\c_Thistle_Thorn_Green.p3d"};
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
        class Surfaces {
            class GdtForestMalden {
                texturePath = "a3\map_malden\data\gdt_forest_malden_co.paa";
            };
        };
    };

    //Napf
    class Napf {
        surfaceTextureBasePath = "momo\Napf\data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {/*"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d" ,*/ "A3\plants_f\Clutter\c_Thistle_Thorn_Green.p3d"};
    };

    //Montherme
    class SWU_Ardennes_1940 {
        surfaceTextureBasePath = "WW2\TerrainsWW2_swurvin\Surfaces_t\";
        filePrefix = "co.paa";
        camouflageObjects[] = {};
    };

    //Montherme Winter
    class SWU_Ardennes_1944_Winter {
        surfaceTextureBasePath = "WW2\TerrainsWW2_swurvin\Surfaces_t\";
        filePrefix = "co.paa";
        camouflageObjects[] = {};
    };

    //Rahmadi
    class Intro: Chernarus {
        camouflageObjects[] = {"ca\plants\clutter_grass_flowers.p3d"};
    };

    //Ruha
    class ruha {
        surfaceTextureBasePath = "ruha\ruha\data\";
        filePrefix = "co.paa";
    };

    //Panovo
    class Panovo {
        surfaceTextureBasePath = "WW2\TerrainsIF_t\Worlds\IF_Surfaces_t\staszow\";
        filePrefix = "co.paa";
        camouflageObjects[] = {};
    };

    //Porto
    class Porto {
        surfaceTextureBasePath = "ca\desert2\data\";
        filePrefix = "detail_co.paa";
        camouflageObjects[] = {};
    };

    //Prei Khmaoch Luong
    class prei_khmaoch_luong {
        surfaceTextureBasePath = "\blud_prei_art\data\ground\";
        filePrefix = "co.paa";
        camouflageObjects[] = {"a3\vegetation_f_exp\clutter\grass\c_Grass_Tropic.p3d"};
    };

    //Proving Grounds
    class ProvingGrounds_PMC {
        surfaceTextureBasePath = "ca\provinggrounds_pmc\Data\";
        filePrefix = "co.paa";
        camouflageObjects[] = {};
    };

    //Sahrani
    class Sara {
        surfaceTextureBasePath = "ca\sara\Data\";
        filePrefix = "detail_co.paa";
        camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d"};
        class Surfaces {
            class mesto {
                texturePath = "ca\sara\Data\mesto_co.paa";
            };
        };
    };

    //Sark
    class Hyde_Sark {
        surfaceTextureBasePath = "WW2\TerrainsWW2_Hyde\Surfaces_t\";
        filePrefix = "co.paa";
        camouflageObjects[] = {};
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
        filePrefix = "detail_co.paa";
        camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d"};
    };

    class Staszow {
        surfaceTextureBasePath = "WW2\TerrainsIF_t\Worlds\IF_Surfaces_t\staszow\";
        filePrefix = "co.paa";
        camouflageObjects[] = {};
    };

    //Stratis
    class Stratis: Altis {
        camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d"};
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
        camouflageObjects[] = {"A3\Vegetation_F_Exp\Clutter\Grass\c_GrassBunch_HI.p3d"};
    };

    //United Sahrani
    class Sara_dbe1 : Sara {
        camouflageObjects[] = {"A3\plants_f\Clutter\c_Thistle_Thorn_Brown.p3d"};
    };

    //Utes
    class utes {
        surfaceTextureBasePath = "ca\utes\Data\";
        filePrefix = ".paa";
        camouflageObjects[] = {"CUP\Terrains\cup_terrains_worlds\Clutter\c_GrassCrookedForest.p3d"};
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
        camouflageObjects[] = {"ca\plants_E\Clutter\c_Brush_Soft_EP1.p3d"};
    };
};
