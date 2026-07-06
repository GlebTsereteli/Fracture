# Performance

## Overview

Fracture is built for speed, but the cost of a fracture call depends on the shape, the pattern, and the number of Pieces. This page covers what to expect and how to keep things fast.

As long as you avoid extreme cases like fracturing *many* instances at once or a very high Piece count, you should be fine. This is especially true under [YYC](https://manual.gamemaker.io/monthly/en/index.htm#t=Settings%2FYoYo_Compiler.htm).

## Keeping It Fast

- **Match the shape to the sprite.** Choose the :Convex: shape that best fits the sprite you're fracturing. Box is cheapest, then Circle, then Hull. Don't reach for Hull unless the sprite is genuinely irregular.
- **Lower the Piece count.** Piece count is the biggest performance killer. If performance is critical, drop columns/rows/cell counts as low as your design allows. Fewer Pieces means less geometry to calculate and fewer physics bodies to process.
- **Spread work across frames.** When fracturing many instances at once, consider doing it over several frames rather than all together. Fracture one shape per frame, or several per frame, depending on your frame budget.
- **Compile with YYC.** Fracture is CPU-bound at fracture time, when all the geometry is calculated. The [YoYo Compiler](https://manual.gamemaker.io/monthly/en/index.htm#t=Settings%2FYoYo_Compiler.htm) produces native machine code and is great at optimizing CPU operations. Use it for release builds where speed matters.

## Measuring Cost

Enable :FRACTURE_BENCHMARK: to log how long each fracture call takes (in milliseconds), and read the numbers for your own shape and pattern scenarios. It is enabled by default when running the game from the IDE.

At **60 FPS** you have a frame budget of **16.67 milliseconds**. Open the [Profiler](https://manual.gamemaker.io/lts/en/IDE_Tools/The_Debugger/The_Profiler.htm), check how much of that budget you have left, and gauge whether the fracture you want fits without pushing the frame over the limit. If a call eats more time than you have to spare, the game will micro-freeze on that frame.

Just watching the fracture happen is also a good tell. If you see a visible hitch or micro-freeze the moment an instance fractures, that call is too heavy for the frame it landed on.

## Looking Ahead

A huge goal for the next major version of the library is to separate geometry generation from physics Piece creation. This will unlock two large benefits:
- **Pre-generated patterns.** Cache a pool of patterns at game start and pick from them at fracture time. This massively speeds up mid-gameplay fracturing where it matters most.
- **Standalone geometry.** Fetch fracture geometry without creating physics bodies, opening the library up for custom effects and processing beyond physics debris.