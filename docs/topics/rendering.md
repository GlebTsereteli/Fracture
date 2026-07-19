# Rendering

## Overview

Compared to naive alternatives like [baking sprites](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Sprites/Sprite_Manipulation/sprite_create_from_surface.htm) or [drawing primitives](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Primitives/Primitives_And_Vertex_Formats.htm), Fracture builds shared frozen vertex buffers and renders Pieces by submitting [parts](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Primitives/vertex_submit_ext.htm) of those buffers.

This page covers how that system works and where its limits are.

## The Renderer

All Pieces are drawn by an internal renderer object, `__FractureRenderer`. It's a [singleton](https://en.wikipedia.org/wiki/Singleton_pattern), created automatically when needed and fully managed by the system.

Drawing everything through the renderer is what makes [fading Pieces](/topics/pieces#settling-and-fading) affordable. Vertex buffers respect neither [image_alpha](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Sprites/Sprite_Instance_Variables/image_alpha.htm) nor [draw_set_alpha()](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Colour_And_Alpha/draw_set_alpha.htm), so fading requires a shader.

---

Applying a shader per Piece would mean setting and resetting it for... well, *every single Piece*. That certainly doesn't scale very well.

So instead: the renderer first sets the shader once, then loops over every Piece, builds a matrix from its position and rotation, passes its alpha as a uniform, and submits its geometry through the shader. Once every Piece has been submitted, the shader is reset.

This avoids stacking a shader set/reset per Piece, cutting overhead and significantly improving performance at higher Piece counts.

## No Depth Sorting

Drawing everything in a single pass comes with a downside: Fracture only supports one shared layer or depth, so Pieces can't be depth sorted with other instances in the room.

But this isn't normally an issue! Fracture targets sidescrollers, space shooters, and other perspectives where depth sorting is not a concern.

:::tip
Use :.RenderAt(): to control the layer or depth Pieces are drawn at.
:::

## The Vertex Buffer

When an instance fractures, Fracture builds the resulting Pieces' geometry as a single ([frozen](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Primitives/vertex_freeze.htm)) [vertex buffer](https://manual.gamemaker.io/monthly/en/Additional_Information/Guide_To_Primitives_And_Vertex_Building.htm), never to be altered again.

Fracturing an instance into 50 Pieces creates one buffer, not fifty. All Pieces from the same fracture call share that buffer, with each Piece drawn by [submitting its part](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Primitives/vertex_submit_ext.htm) of it.

The buffer stays alive as long as any of its Pieces exist, and is freed automatically once the last one is destroyed - all managed internally without any manual cleanup.
