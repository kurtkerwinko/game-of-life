# Conway's Game of Life

[![Builds](https://github.com/kurtkerwinko/game-of-life/actions/workflows/builds.yml/badge.svg)](https://github.com/kurtkerwinko/game-of-life/actions/workflows/builds.yml)

This is written in Lua using the LÖVE game framework

## Installation

Replace `[VERSION]` with the latest version number (e.g. `1.0.0`)

### LÖVE
1. If you have LÖVE installed, download the `GameOfLife-[VERSION].love` from the latest release [here](https://github.com/kurtkerwinko/game-of-life/releases/latest)
2. Run `love GameOfLife-[VERSION].love`

### Windows
1. Download the `GameOfLife-[VERSION]-win32.zip` from the latest release [here](https://github.com/kurtkerwinko/game-of-life/releases/latest)
2. Extract the zip file
3. Run the `GameOfLife-[VERSION].exe` located inside the folder

### Linux
1. Download the `GameOfLife-[VERSION].AppImage` from the latest release [here](https://github.com/kurtkerwinko/game-of-life/releases/latest)
2. Add execute permissions to the downloaded file `AppImage`
    - `chmod +x GameOfLife-[VERSION].AppImage`
3. Run the AppImage
    - `./GameOfLife-[VERSION].AppImage`

## Controls
**r** - Reset cells  
**d** - Kill all cells  
**space** - Pause cells  
**p** - Toggle fullscreen  
**left-click** - Resurrect cell  
**right-click** - Kill cell  
