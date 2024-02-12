# ArcLuaScripts

## Status

At the momment im cleaning up this. Many blizzlike scripts will be ported to Plugins or APE.
Will return to development of Ruby Sanctum (i mean to finish Halion) after that.

## Introduction

ArcLuaScripts its a NON-OFFICIAL scripting project for ArcEmu just for learning purposes. Its NOT intended as a replace for ArcEmu official plugins, its a complement.

I had started this project for myself, but use it if you want. In that case i hope you enjoy it as much as i enjoyed ArcEmu.

WARNING: this wont expand too much since lua resources are very limited but i will push it to his limits.

Feel free to [open tickets to report bugs.](https://github.com/cressidagp/arcluascripts/issues/new)


## Features

Lua scripts for Instances, Bosses, Creatures, GameObjects, Gossips and Quests. The main focus is set at Ruby Sanctum.

All script has been writed to prevent variable collision. Bosses has been scripted in modular way.

* AI Summons loaded from database
* AI Out of Combat Cast loaded from database
* There are some others script wich are uncompleted or gonna be ported to APE

The Ruby Sanctum  | Status
:-- | :--
Baltharus | :heavy_check_mark:
Saviana | :heavy_check_mark:
Zarithian | :heavy_check_mark:
Halion | :x:


## Requirements

To run properly require the contents of 0Misc folder from [ArcEmu github repository.](https://github.com/arcemu/arcemu/tree/master/src/scripts/lua/0Misc)

Also require [db world database.](https://github.com/arcemu/db)


## Instalation

1. Copy all files from scripts folder in to your ArcEmu scripts folder.

2. Apply arcluascripts.sql to your world database (for db only).


## Credits to

* Trinity for texts, sound ids, timers, spell ids and some inspiration.
* DarkAngel39 for his instance progression system.
* Marforius for ArcAddons who make my life much easier.
* Hypersniper for his lua guides and some job in the lua engine.
* Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
* ArcEmu developers for ArcEmu and A.L.E, specially to dfighter1985.


## Useful Links

* [ArcEmu Github](https://github.com/arcemu)
* [Work in progress community wiki](https://arcemu.fandom.com/wiki/Arcemu_Wiki)