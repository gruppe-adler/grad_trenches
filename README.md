# Gruppe Adler Trenches

This mod adds textures to ACE trenches based on the current ground texture. When placing a trench you can already see a preview how the trench will look like when placing it. Players can also camouflage their trenches with small bushes.

![a.jpg](https://i.imgur.com/vUGCXHy.jpg)  
More images can be found [here](https://github.com/gruppe-adler/grad_trenches#more-images).

## Features
- Supported on 22 Maps (Vanilla, CUP and more)
- Custom map config, add your own map if it is not supported
- Camouflage your trench with small bushes

### Supported maps
- Altis
- Stratis
- Malden
- Tanoa
- Lythium
- Bukovina
- Bystrica4
- Chernarus
- Celle
- Porto
- Desert
- Rahmadi
- Prei Khmaoch Luong
- Proving Grounds
- Sahrani
- United Sahrani
- Southern Sahrani
- Shapur
- Takistan
- Takistan Mountains
- Utes
- Zargabad

## Requirements
- Arma3 1.76 or later
- [ACE3](https://github.com/acemod/ACE3) 3.11.0 or later
- [CBA_A3](https://github.com/CBATeam/CBA_A3) 3.4.1 or later

## Downloads
#### GitHub
Downloads can be found under [Releases](https://github.com/gruppe-adler/grad_trenches/releases).  
Currently this mod is shipped **without server key**. Please open an [issue](https://github.com/gruppe-adler/grad_trenches/issues/new) if you need one.

#### Steam Workshop
Support for Steam Worshop is currently in progress, sorry for that.

## Bugs and Contributions
Contributions and bug reports are well appreciated. Feel free to fork this project or to create issues.
#### Bugreports
When encountering an error message when placing a trench please atatch your RPT-File so we can directly analyze the problem.

## Add own map
It is not possible to automaticially get the path to the ground texture. Therefore maps have to be included in a config to work with GRAD trenches. This config is located [here](addons/trenches/CfgWorldsTextures.hpp).


**We will take Altis as an example:**  
Adding a map by your own can be done by any additional mod. You don't have to edit the source. Just create a mod and add `grad_trenches` to `requiredAddons` in your `CfgPatches`.

Then create a config and add this skeleton to it

```cpp
class CfgWorldsTextures {
    class Altis {
        surfaceTextureBasePath = "";
        filePrefix = "";
    };
};
```

The class name is the map name that can be found out by using the `worldName` command.

Now you have to fill in `surfaceTextureBasePath`. Usually this path can be found at  
`configfile >> "CfgWorlds" >> "Altis" >> "OutsideTerrain" >> "Layers" >> "Layer0" >> "texture"`  
when leaving out the file name of the texture.  
On Altis the result is `A3\Map_Data\gdt_seabed_co.paa`. We will strip out the file name and will get this config as a result:
```cpp
class CfgWorldsTextures {
    class Altis {
        surfaceTextureBasePath = "A3\Map_Data\";
        filePrefix = "";
    };
};
```
**Make sure to keep the trailing backslash.**

The texture name for `gdt seabed` is missing the extension `_co.paa`. Therefore we have to set this as the file prefix leaving out the leading underscore.
```cpp
class CfgWorldsTextures {

    class Altis {

        surfaceTextureBasePath = "A3\Map_Data\";

        filePrefix = "co.paa";

    };

};
```

#### Exceptional case: Texture name is different to file name
Some maps like Utes just have one texture name that is different to the file name. For this purpose it is possible to hardcode single textures along with their absolute file paths.
```cpp
class utes {
    surfaceTextureBasePath = "ca\utes\Data\";
    filePrefix = "detail_co.paa";

    class Surfaces {
        class Default {
            texturePath = "a3\map_data\gdt_beach_co.paa";
        };         
    };
};
```
In this case `Default` is the ground texture name.

## More images
![b.jpg](https://i.imgur.com/ahEza0A.jpg)

