<img width="1280" height="300" alt="banner github" src="https://github.com/user-attachments/assets/29668536-5044-4def-b90a-257c614f94dd" />

<h1 align="center">Fracture v1.0.0</h1>
<p align="center">
  Procedural physics destruction for <a href="https://releases.gamemaker.io/release-notes/2026/0"> GameMaker LTS 2026</a>
</p>

<br/>

Fracture is a [Free and Open Source](https://en.wikipedia.org/wiki/Free_and_open-source_software) GameMaker library for breaking objects into [Box2D physics](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Physics/Physics.htm) pieces using a variety of fracture patterns.

Add procedural physics-based destruction to your game with minimal setup. The library does the heavy lifting for you - geometry, physics and rendering are all handled internally.

* ℹ️ Download the `.yymps` local package from the [latest release](https://github.com/glebtsereteli/Fracture/releases/latest/) page.
* ℹ️ Refer to the [Documentation](https://glebtsereteli.github.io/Fracture/) for installation instructions, usage examples, and full API reference.
* ℹ️ See the [Getting Started](https://glebtsereteli.github.io/Fracture/pages/home/gettingStarted/gettingStarted#getting-started) page to fracture your first instance.

# Features

- **7 Fracture Patterns**. Shatter instances with [Grid](https://glebtsereteli.github.io/Fracture/pages/api/fracture/overview), [Brick](https://glebtsereteli.github.io/Fracture/pages/api/fracture/overview), [Diamond](https://glebtsereteli.github.io/Fracture/pages/api/fracture/overview), [Hex](https://glebtsereteli.github.io/Fracture/pages/api/fracture/overview), [Radial](https://glebtsereteli.github.io/Fracture/pages/api/fracture/overview), [Slice](https://glebtsereteli.github.io/Fracture/pages/api/fracture/overview), and [Voronoi](https://glebtsereteli.github.io/Fracture/pages/api/fracture/overview), most with optional controls to dial in the look.
- **3 Convex Shapes**. Fracture instances as a [Box](https://glebtsereteli.github.io/Fracture/pages/topics/performance#shape-cost), [Circle](https://glebtsereteli.github.io/Fracture/pages/topics/performance#shape-cost), or [Hull](https://glebtsereteli.github.io/Fracture/pages/topics/performance#shape-cost) to match any convex sprite, with every Piece clipped to the shape boundary.
- **Physics & Impulse**. Define Piece "materials" through [physics properties](https://glebtsereteli.github.io/Fracture/pages/api/fracture/settings#physics) and blow Pieces apart with an explosive [impulse](https://glebtsereteli.github.io/Fracture/pages/api/fracture/settings#impulse) from any origin.
- **Automatic Fading**. Pieces fade out and destroy themselves automatically, with randomized [delay and speed](https://glebtsereteli.github.io/Fracture/pages/api/fracture/settings#fade) for staggered, natural-looking debris.
- **Efficient Rendering**. Pieces share a single ([frozen](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Primitives/vertex_freeze.htm)) [vertex buffer](https://glebtsereteli.github.io/Fracture/pages/topics/rendering#the-vertex-buffer) per fracture and draw in one pass, outclassing naive sprite baking or primitive drawing.
- **Lifecycle Control**. Command existing Pieces at any time: [clear](https://glebtsereteli.github.io/Fracture/pages/api/fracture/overview) them instantly, [force a fade](https://glebtsereteli.github.io/Fracture/pages/api/fracture/overview), or [pause and resume](https://glebtsereteli.github.io/Fracture/pages/api/fracture/overview) them alongside your game's own pause flow.
- **Fluent Settings**. Chain [.Physics()](https://glebtsereteli.github.io/Fracture/pages/api/fracture/settings#physics), [.Impulse()](https://glebtsereteli.github.io/Fracture/pages/api/fracture/settings#impulse) and [.Fade()](https://glebtsereteli.github.io/Fracture/pages/api/fracture/settings#fade) before any fracture call, with per-fracture settings auto-resetting between calls.

# Credits
- Created and maintained by [Gleb Tsereteli](https://github.com/GlebTsereteli).
- Promo art by Gleb's wife [Kate](https://www.linkedin.com/in/kate-ivanova22/?isSelfProfile=false) ❣️
- Initially created as a submission for [TabularElf](https://tabelf.link/)'s [CookBook Jam #6](https://itch.io/jam/cookbook-jam-6).
- [Animal Pack Remastered](https://kenney.nl/assets/animal-pack-remastered) demo graphics by [Kenney](https://kenney.nl/).
- [Asset Bundles](https://gamemaker.io/en/bundles) demo graphics by [GameMaker](https://gamemaker.io/en).
- [runtile-for-gamemaker](https://github.com/attic-stuff/runtile-for-gamemaker) by [attic-stuff](https://github.com/attic-stuff), adapted to work with objects for the `Walls` demo.
