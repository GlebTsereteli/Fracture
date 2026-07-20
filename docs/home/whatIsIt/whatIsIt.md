![alt text](<banner.png>)

<h1 align="center">Fracture v1.0.0</h1>
<p align="center">
  Procedural physics destruction for <a href="https://releases.gamemaker.io/release-notes/2026/0"> GameMaker LTS 2026</a>
</p>

## What Is Fracture?

Fracture is a [Free and Open Source](https://en.wikipedia.org/wiki/Free_and_open-source_software) GameMaker library for breaking objects into [Box2D physics](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Physics/Physics.htm) pieces using a variety of fracture patterns.

Add procedural physics-based destruction to your game with minimal setup. The library does the heavy lifting for you - geometry, physics and rendering are all handled internally.

```js
// Shatter into 10 organic pieces, blown outwards from the mouse
Fracture.Impulse(2, mouse_x, mouse_y).ConvexVoronoi(id, FRACTURE_CONVEX_HULL, 10);

// Break a crate into a 6x6 grid of heavy, barely-bouncy chunks
Fracture.Physics({ density: 4, restitution: 0.1 }).ConvexGrid(id, FRACTURE_CONVEX_BOX, 6, 6);

// Slice a circle into 10 radial wedges that linger before fading
Fracture.Fade({ delay: 120, speed: 0.005 }).ConvexRadial(id, FRACTURE_CONVEX_CIRCLE, 10);
```

* ℹ️ Download the `.yymps` local package from the [latest release](https://github.com/glebtsereteli/Fracture/releases/latest/) page.
* ℹ️ See the [Getting Started](https://glebtsereteli.github.io/Fracture/home/gettingStarted) page to fracture your first instance.

## Features

- **7 Fracture Patterns**. Shatter instances with [Grid](https://glebtsereteli.github.io/Fracture/api/fracture/convexFracturing#convexgrid), [Brick](https://glebtsereteli.github.io/Fracture/api/fracture/convexFracturing#convexbrick), [Diamond](https://glebtsereteli.github.io/Fracture/api/fracture/convexFracturing#convexdiamond), [Hex](https://glebtsereteli.github.io/Fracture/api/fracture/convexFracturing#convexhex), [Radial](https://glebtsereteli.github.io/Fracture/api/fracture/convexFracturing#convexradial), [Slice](https://glebtsereteli.github.io/Fracture/api/fracture/convexFracturing#convexslice), and [Voronoi](https://glebtsereteli.github.io/Fracture/api/fracture/convexFracturing#convexvoronoi), most with optional controls to dial in the look.
- **3 Convex Shapes**. Fracture instances as a [Box](https://glebtsereteli.github.io/Fracture/api/fracture/convexFracturing#box), [Circle](https://glebtsereteli.github.io/Fracture/api/fracture/convexFracturing#circle), or [Hull](https://glebtsereteli.github.io/Fracture/api/fracture/convexFracturing#hull) to match any convex sprite, with every Piece clipped to the shape boundary.
- **Physics & Impulse**. Define Piece "materials" through [physics properties](https://glebtsereteli.github.io/Fracture/api/fracture/settings#physics) and blow Pieces apart with an explosive [impulse](https://glebtsereteli.github.io/Fracture/api/fracture/settings#impulse) from any origin.
- **Automatic Fading**. Pieces fade out and destroy themselves automatically, with randomized [delay and speed](https://glebtsereteli.github.io/Fracture/api/fracture/settings#fade) for staggered, natural-looking debris.
- **Efficient Rendering**. Pieces share a single ([frozen](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Primitives/vertex_freeze.htm)) [vertex buffer](https://glebtsereteli.github.io/Fracture/topics/rendering#the-vertex-buffer) per fracture and draw in one pass, outclassing naive sprite baking or primitive drawing.
- **Lifecycle Control**. Command existing Pieces at any time: [clear](https://glebtsereteli.github.io/Fracture/api/fracture/lifecycle#clear) them instantly, [force a fade](https://glebtsereteli.github.io/Fracture/api/fracture/lifecycle#forcefade), or [pause and resume](https://glebtsereteli.github.io/Fracture/api/fracture/lifecycle#pause) them alongside your game's pause flow.
- **Fluent Settings**. Chain [.Physics()](https://glebtsereteli.github.io/Fracture/api/fracture/settings#physics), [.Mass()](https://glebtsereteli.github.io/Fracture/api/fracture/settings#mass), [.Impulse()](https://glebtsereteli.github.io/Fracture/api/fracture/settings#impulse) and [.Fade()](https://glebtsereteli.github.io/Fracture/api/fracture/settings#fade) before any fracture call to customize how Pieces feel, weigh, scatter and disappear.

## Looking Ahead

Fracture began as a submission to the sixth Cookbook library jam, so its scope was deliberately limited to convex fracturing with 3 shapes and 7 patterns.

But the plans reach much further! Here are some of the things I'd like to add:
- **Concave fracturing**. Support for arbitrary sprite shapes, not just convex ones.
- **Cutting shapes**. Split an instance along a line instead of shattering it whole, with plans for multiple cuts.
- **Geometry/physics separation**. Fetch raw Piece geometry for custom effects without creating physics bodies, opening up non-physics workflows.
- **Caching**. Cache hulls and pools of pre-generated geometry, keeping things as fast as possible at runtime.
- **Stylistic extras**. Piece outlines, weighted seams, and recursive re-fracturing.

See the full list on the [Upcoming Features](https://glebtsereteli.github.io/Fracture/upcoming-features) page.

## Credits
- Created and maintained by [Gleb Tsereteli](https://github.com/GlebTsereteli).
- Promo art by Gleb's wife [Kate](https://www.linkedin.com/in/kate-ivanova22/?isSelfProfile=false) ❣️
- Initially created as a submission for [TabularElf](https://tabelf.link/)'s [CookBook Jam #6](https://itch.io/jam/cookbook-jam-6).
- [runtile-for-gamemaker](https://github.com/attic-stuff/runtile-for-gamemaker) by [attic-stuff](https://github.com/attic-stuff), adapted to objects for the `Walls` demo.
- [Puzzle Pack 2](https://kenney.nl/assets/puzzle-pack-2) and [Shape Characters](https://kenney.nl/assets/shape-characters) by [Kenney](https://kenney.nl/).
- [Asset Bundles](https://gamemaker.io/en/bundles) by [GameMaker](https://gamemaker.io/en).
