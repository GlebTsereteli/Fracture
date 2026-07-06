# Upcoming Features

The following list of ideas includes features that might or might not be introduced in the future. There's no guaranteed order to these. If you have a feature you'd like to suggest, please open a :New Issue: with the `feature` label.

- **Cutting shapes**. Split an instance along a line instead of fracturing the whole thing. `.ConvexCut()` cuts through a world point along a direction angle. `.Cut()` combines [collision_line_list()](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Movement_And_Collisions/Collisions/collision_line_list.htm) and [physics_raycast()](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/physics_raycast.htm) to cut every instance a line passes through.
- **More convex patterns**. `.ConvexSpiral()`, `.ConvexShatter()`, `.ConvexRecursive()`, etc.
- **Hull caching**. Convex hulls from [sprite_get_convex_hull()](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Sprites/Sprite_Information/sprite_get_convex_hull.htm) cached via GML code generation, both automatically on fracture and through separate caching utilities.
- **Piece cap**. A global limit on live Pieces to keep heavy scenes from accumulating too many bodies. Destroy oldest Pieces as new ones come in.
- **Affectors**. Forces applied to Pieces after a fracture. `.Blast()` for a one-shot radial impulse, `.Push()` for sustained pushing force, `.Erase()` for removal.
- **Delta-based settle detection**. Detect settled Pieces by tracking position deltas across frames instead of relying on `phy_sleeping`.
- **Piece outlines**. Draw outlines around Pieces for a stylized look. Configurable thickness, (inside/outside?), color and alpha.
- **Weighted seams**. User-defined weak points the fracture prefers to break along, delivered through a mask sprite or some other distribution system.
- **Multi-fixture Pieces**. Support Pieces built from multiple fixtures, allowing for more precise circular pieces.
- **Negative scale**. Support for instances with negative `image_xscale` and `image_yscale`.
- **Recursive re-fracturing**. Fracture a Piece again on secondary impact, with a depth cap.
- **Separate geometry from physics**. Split geometry generation from physics Piece creation. Enables caching a pool of patterns at game start to pick from at fracture time, and fetching geometry without creating physics bodies for custom effects beyond physics debris.
- **Concave fracturing**. Fracturing concave sprites. A complex multi-part process involving automatic concave hull generation from the sprite, outline simplification, triangulation, and the fracture itself.
- **Text and Tilemap modules**. Fracturing text strings and tilemaps.
- **Chunk removal**. Stateful removal of regions from an instance.