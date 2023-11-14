# Game of Life

[![Builds](https://github.com/kurtkerwinko/game-of-life/actions/workflows/builds.yml/badge.svg)](https://github.com/kurtkerwinko/game-of-life/actions/workflows/builds.yml)

This is written in Lua using the LÖVE game framework

## Installation

Download the required package from the latest release [here](https://github.com/kurtkerwinko/game-of-life/releases/latest)

Replace `[VERSION]` with the latest version number (e.g. `1.0.0`)

### LÖVE
1. If you have LÖVE `v11.x` installed, download the `GameOfLife-[VERSION].love`
2. Run `love GameOfLife-[VERSION].love`

### Windows
1. Download the `GameOfLife-[VERSION]-win32.zip`
2. Extract the zip file
3. Run the `GameOfLife-[VERSION].exe` located inside the folder

### Linux
1. Download the `GameOfLife-[VERSION].AppImage`
2. Add execute permissions to the downloaded file `AppImage`
    - `chmod +x GameOfLife-[VERSION].AppImage`
3. Run the AppImage
    - `./GameOfLife-[VERSION].AppImage`

## Controls
Reset cells - <kbd>r</kbd>
Kill all cells - <kbd>d</kbd>
Pause cells - <kbd>space</kbd>
Toggle fullscreen - <kbd>p</kbd>
Resurrect cell - Hover on cell and <kbd>left-click</kbd>
Kill cell - Hover on cell and <kbd>right-click</kbd>
