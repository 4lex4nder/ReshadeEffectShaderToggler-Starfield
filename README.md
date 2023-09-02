# ReshadeEffectShaderToggler-Starfield
REST config for Starfield

## Requirements
* REST version included here
* [ReShade](https://reshade.me/) >= 5.9.1
* Use FSR2

## What does it do
* Applies effects before the UI is rendered by default. 
* There is a group for applying effects before the game renders things like fog and water.

## Notes
* If you make active use of the group that applies effects before fog, note that you need to have a resolution scale of 100%, otherwise havoc ensues.

## Batteries included
Some extra stuff

### sf_common.fxh
If you know your way around shaders, you can use this header file to access some game engine data in your ReShade effects. Including:
* Motion vectors
* Normal buffer
* Albedo

### sf_crashpad.fx
A helper shader providing the game's normals and motion vectors in known formats (DRME/Launchpad).
