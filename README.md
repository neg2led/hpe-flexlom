# KCORES-FlexibleLOM-Adapter
[![Build Status](https://travis-ci.com/neg2led/hpe-flexlom.svg?branch=master)](https://travis-ci.com/neg2led/hpe-flexlom)

![KiCad raytraced board render](KCORES-FlexibleLOM-Adapter/KCORES-FlexibleLOM-Adapter.png)

This is just a straight-up copy of the [KCORES-FlexibleLOM-Adapter](https://github.com/KCORES/KCORES-FlexibleLOM-Adapter) repo, but I've added a makefile and whatnot using KiKit for JLCPCB fab.

## Repository Structure
- `KCORES-FlexibleLOM-Adapter` contains the main schematics and board drawing
- `KCORES-FlexibleLOM-AdapterS/KCORES-FlexibleLOM-Adapter.pretty` contains the board-specific footprints

## Building
Simply call `make` in the top-top level directory. The `build` directory will then contain:

- the main board
- A panelized version of said board
- zipped gerbers for the boards you can directly use for manufacturing
- zipped gerbers and SMT assembly BOM/position files for JLCPCB's SMT assembly service for the single-board version.

Makefile uses [Jan Mrázek](https://github.com/yaqwsx)'s [KiKit](https://github.com/yaqwsx/KiKit), which I cannot recommend enough, and therefore has to be available on your system.

Jan's [jlcparts](https://yaqwsx.github.io/jlcparts/) app was also extremely useful in narrowing down part choices based on what JLCPCB have available.

-----
### **IMPORTANT NOTE:** If you give JLCPCB these files as-is, *please* verify the orientation of every part before submitting.
