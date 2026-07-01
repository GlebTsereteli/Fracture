# Rendering

## Overview

Compared to naive alternatives like [baking sprites](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Sprites/Sprite_Manipulation/sprite_create_from_surface.htm) or [drawing primitives](https://manual.gamemaker.io/lts/en/#t=GameMaker_Language%2FGML_Reference%2FDrawing%2FPrimitives%2Fdraw_primitive_begin.htm), Fracture builds a frozen vertex buffer at fracture time and renders Pieces by submitting [parts](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Primitives/vertex_submit_ext.htm) of that buffer.

This page covers how that system works and where its limits are.

## The Renderer

All Pieces are drawn by a single internal renderer object, `__objFractureRenderer`. It's a [singleton](https://en.wikipedia.org/wiki/Singleton_pattern), created automatically when needed and fully managed by the system.

Drawing everything through the renderer is what makes fading Pieces affordable. Vertex buffers don't respect to `image_alpha`, so fading requires a shader. Applying that per Piece would mean setting and resetting a shader for... well, every single Piece. That doesn't scale.

---

So instead: the renderer first sets the shader once, then loops over every Piece, builds a matrix from its position and rotation, passes its alpha as a uniform, and submits its geometry through the shader. Once every Piece has been submitted, the shader is reset.

This avoids stacking a shader set/reset per Piece, cutting overhead and significantly improving performance at higher Piece counts.

## No Depth Sorting

Drawing everything in a single pass comes with a downside: Fracture only supports one shared Layer and Depth, so Pieces can't be depth sorted with other instances in the room.

But this isn't normally an issue! Fracture targets sidescrollers, space-like games, and other perspectives where depth sorting is not a concern.

:::tip
Use :.Layer(): or :.Depth(): to control the layer or depth Pieces are drawn at.
:::

## The Frozen Vertex Buffer

When an instance fractures, Fracture builds the resulting Pieces' geometry as a single [frozen](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Primitives/vertex_freeze.htm) vertex buffer, never to be altered again.

Fracturing an instance into 50 Pieces creates one buffer, not fifty. All Pieces from the same fracture call share that buffer, with each Piece drawn by [submitting its part](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Primitives/vertex_submit_ext.htm) of it.

The buffer stays alive as long as any of its Pieces exist, and is freed automatically once the last one is destroyed - all managed internally without any manual cleanup.
