![Logo](https://i.imgur.com/xSd30e4.jpg)

<p align="center">
    <a href="https://github.com/gruppe-adler/grad_trenches/releases/latest">
        <img src="https://img.shields.io/github/release/gruppe-adler/grad_trenches.svg" alt="GRAD Trenches Version">
    </a>
    <a href="https://github.com/gruppe-adler/grad_trenches/issues">
        <img src="https://img.shields.io/github/issues-raw/gruppe-adler/grad_trenches.svg?style=flat-square&label=Issues" alt="GRAD Trenches Issues">
    </a>
    <a href="https://github.com/gruppe-adler/grad_trenches/releases">
        <img src="https://img.shields.io/github/downloads/gruppe-adler/grad_trenches/total.svg?style=flat-square&label=Downloads" alt="GRAD Trenches Downloads">
    </a>
    <a href="http://steamcommunity.com/sharedfiles/filedetails/?id=1224892496">
        <img src="https://img.shields.io/badge/Steam-Workshop-lightgrey.svg?style=flat-square" alt="Steam Workshop">
    </a>
    <a href="https://forums.bistudio.com/forums/topic/212208-grad-trenches/">
        <img src="https://img.shields.io/badge/BIF-Thread-lightgrey.svg?style=flat-square" alt="BIF Thread">
    </a>
    <a href="https://github.com/gruppe-adler/grad_trenches/blob/master/LICENSE">
        <img src="https://img.shields.io/badge/License-GPLv2-red.svg?style=flat-square" alt="GRAD Trenches License">
    </a>
</p>

<p align="center">
    <sup><strong>Visit Gruppe Adler on <a href="https://www.gruppe-adler.de/">our Website</a> | <a 
    href="https://www.youtube.com/user/gruppeadler">YouTube</a> | <a href="https://twitter.com/Gruppe_Adler">Twitter</a></strong></sup>
</p>

This mod adds textures to ACE trenches based on the current ground texture. When placing a trench you can already see a preview how the trench will look like when placing it. Players can also camouflage their trenches with small bushes.

More images can be found [here](https://github.com/gruppe-adler/grad_trenches#more-images).

## Features
- Supported on 22 Maps (Vanilla, CUP and more)
- Custom map config, add your own map if it is not supported
- Camouflage your trench with small bushes

### Supported maps
- [Altis](https://arma3.com/features/terrain)
- [Stratis](https://arma3.com/features/terrain)
- [Malden](https://arma3.com/dlc/malden)
- [Tanoa](https://arma3.com/apex)
- [Lythium](https://forums.bistudio.com/forums/topic/144930-wip-ffaa-v6-spanish-army-mod/)
- [Bukovina](http://cup-arma3.org/terrains)
- [Bystrica](http://cup-arma3.org/terrains)
- [Chernarus](http://cup-arma3.org/terrains)
- [Celle](http://www.armaholic.com/page.php?id=16585)
- [Porto](http://cup-arma3.org/terrains)
- [Desert](http://cup-arma3.org/terrains)
- [Rahmadi](http://cup-arma3.org/terrains)
- [Prei Khmaoch Luong](https://forums.bistudio.com/forums/topic/206159-prei-khmaoch-luong/)
- [Proving Grounds](http://cup-arma3.org/terrains)
- [Sahrani](http://cup-arma3.org/terrains)
- [United Sahrani](http://cup-arma3.org/terrains)
- [Southern Sahrani](http://cup-arma3.org/terrains)
- [Shapur](http://cup-arma3.org/terrains)
- [Takistan](http://cup-arma3.org/terrains)
- [Takistan Mountains](http://cup-arma3.org/terrains)
- [Utes](http://cup-arma3.org/terrains)
- [Zargabad](http://cup-arma3.org/terrains)

## Requirements
- Arma 3 1.76 or later
- [ACE3](https://github.com/acemod/ACE3) 3.11.0 or later
- [CBA_A3](https://github.com/CBATeam/CBA_A3) 3.5.0 or later

## Downloads
#### GitHub
Downloads can be found under [Releases](https://github.com/gruppe-adler/grad_trenches/releases).  

#### Steam Workshop
Support for Steam Workshop is currently in progress, sorry for that.

## License
This project is licensed under **GPLv2**.  
We kindly request to not upload this mod to Armaholic or other mirrors for Arma 3 mods.  
Plus, we ask you to not create mirrors in Steam Workshop. However, it is ok to include this mod into your mod pack on Steam Workshop.

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
![a.jpg](https://i.imgur.com/vUGCXHy.jpg)  
![b.jpg](https://i.imgur.com/ahEza0A.jpg)
![Altis](https://i.imgur.com/nPBdWCO.jpg)
![Chernarus](https://i.imgur.com/bi5TbBQ.jpg)
![Takistan](https://i.imgur.com/FwTX2yA.jpg)
![Summer Chernarus](https://i.imgur.com/lYi5EOx.jpg)
