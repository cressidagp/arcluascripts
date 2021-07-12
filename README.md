# ArcLuaScripts

## Introduction

ArcLuaScripts its a NON-OFFICIAL scripting project for ArcEmu just for learning purposes. Its NOT intended as a replace for ArcEmu official plugins, its a complement.

WARNING: this stuff its experimental, use it at your own risk. Feel free to [open tickets to report bugs.](https://github.com/cressidagp/arcluascripts/issues/new) Feedback its apreciated.


## Features

Lua scripts for Instances, Bosses, Creatures, GameObjects, Gossips, Quests, DummySpells and a couple of gm/dev commands.

Scripts folder has been organizated per map id, with the hope of a multi interpreter feature could eventually be implemented.

All script has been writed to prevent [variable collision.](http://arcemu.org/forums/index.php?showtopic=19907)

Bosses has been scripted in [modular way.](http://arcemu.org/forums/index.php?showtopic=21127)


## Requirements

To run properly require the contents of 0Misc folder from [ArcEmu github repository.](https://github.com/arcemu/arcemu/tree/master/src/scripts/lua/0Misc)

Also require [ArcDB world database.](https://github.com/DarkAngel39/ArcDB/tree/master/main_db)


## Instalation

1. Copy all files from scripts folder in to your ArcEmu scripts folder.

2. Apply arcluascripts.sql to your world database (for ArcDB only, i may do for NCDB if i can find it).


## Credits to

* Trinity for texts, sound ids, timers, spell ids and some inspiration.
* DarkAngel39 for his instance progression system.
* Hypersniper for his lua guides and some job in the lua engine.
* Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
* ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

## Links

* [ArcEmu Forums](http://www.arcemu.org/forums/)
* [ArcEmu Github](https://github.com/arcemu)
* [ArcEmu Wiki](https://arcemu.fandom.com/wiki/Arcemu_Wiki)