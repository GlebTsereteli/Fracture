# Convex Fracturing

## Overview

This section covers Convex fracturing methods, the library's core functionality. Each one breaks an instance into a set of physics Pieces using a different pattern, from clean :Grid:s and :Brick:s to more organic :Voronoi: shatters.

---

All :Patterns: take an instance to fracture, a [Shape](#shapes) to define how Pieces are clipped, and a set of custom parameters per pattern. They share the same set of base behaviors:
- Pieces are created from the source instance's sprite, each with its own geometry.
- Each Piece is created with the per-fracture :Physics:, :Mass:, :Impulse: and :Fade: settings configured beforehand.
- The source instance is destroyed automatically after fracturing.
- An array of the created :Piece: instances is returned.

::: danger REQUIREMENTS
Fracture expects Room Physics enabled, a valid sprite, and non-negative scale on the instance. See :Requirements: for the full list.
:::

---

See [Shapes](#shapes) below before diving into the patterns.

::: tip LOOKING AHEAD
Pattern methods are prefixed with `Convex` because they clip to convex boundaries. Future modules will introduce their own prefixed methods for non-convex fracturing.
:::

## Shapes

Every Convex pattern method takes a mandatory shape constant as its second parameter: :FRACTURE_CONVEX_BOX:, :FRACTURE_CONVEX_CIRCLE: or :FRACTURE_CONVEX_HULL:.

The shape determines how the source instance is interpreted, how the resulting Pieces are clipped, and how expensive the fracture is.

> Shape constants are defined in the `FractureConstants` script.

::: tip SHAPE PERFORMANCE
Shapes are not equal in speed, and it's always best to match the shape to the sprite of the instance you're fracturing.

:Box: is cheapest, then :Circle:, then :Hull:. Don't reach for Hull unless the sprite is truly irregular.
:::

---
### Box

<img src="/FRACTURE_CONVEX_BOX.png" alt="FRACTURE_CONVEX_BOX" style="float: left; width: 120px; margin-right: 16px; margin-top: 16px;">

`FRACTURE_CONVEX_BOX` treats the instance as a rectangle of the full sprite area, and is the fastest since Pieces (in most patterns) are not clipped against anything.

<div style="clear: both;"></div>

---
### Circle

<img src="/FRACTURE_CONVEX_CIRCLE.png" alt="FRACTURE_CONVEX_CIRCLE" style="float: left; width: 120px; margin-right: 16px; margin-top: 16px;">

`FRACTURE_CONVEX_CIRCLE` treats the instance as a circle bounded by the sprite, and is slower since every Piece is clipped against the circle boundary.

<div style="clear: both;"></div>

---
### Hull

<img src="/FRACTURE_CONVEX_HULL.png" alt="FRACTURE_CONVEX_HULL" style="float: left; width: 120px; margin-right: 16px; margin-top: 16px;">

`FRACTURE_CONVEX_HULL` treats the instance as the [Convex Hull](https://en.wikipedia.org/wiki/Convex_hull) of its sprite, and is the slowest since every Piece is clipped against the convex hull.

<div style="clear: both;"></div>

The first fracture of a given sprite and subimage is the slowest - it fetches the convex hull via [sprite_get_convex_hull()](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Sprites/Sprite_Information/sprite_get_convex_hull.htm). It then caches it for reuse on later calls, making them faster.

## Patterns

Patterns define how an instance is divided into :Pieces:. Each one produces a distinct look, from regular :Grid: and :Brick: layouts to more organic :Radial: bursts and :Voronoi: shatters.

All patterns start with the same `inst` and `shape` parameters, followed by pattern-specific configs. They destroy the source instance and return an array of the created Pieces.

---

Fracture ships with 7 patterns:
- :Grid:. Uniform rows and columns, with optional noise for organic variation.
- :Brick:. Offset rows or columns, like a brick wall.
- :Diamond:. A lattice of rhombi.
- :Hex:. Hexagonal tiling, flat-topped or pointy-topped.
- :Radial:. Wedges radiating from a point, with an optional custom origin.
- :Slice:. Parallel cuts at a fixed or random angle.
- :Voronoi:. Organic cells from scattered seeds, with adjustable noise.

---

::: warning MIND THE SIZE
Pieces need room to exist. Fracturing an instance too small or with too many rows/columns/cells leaves Pieces without enough space to form, producing overlapping or degenerate geometry.

Make sure to match the pattern's detail to the instance size and keep counts reasonable.
:::

---
### `.ConvexGrid()`

> `Fracture.ConvexGrid(inst, shape, cols, rows, [noiseX], [noiseY])` ➜ :Array: of :Piece:

<PatternRow pattern="Grid"/>

Fractures the given convex instance into a grid of Pieces clipped to the shape boundary, defined by the number of columns and rows.

Optional noise offsets the grid vertices to produce more organic-looking Pieces. Set both to `0` for a perfectly regular grid.

| Parameter | Type | Description |
| --- | --- | --- |
| `inst` | :Id.Instance: | The instance to fracture |
| `shape` | :Real: | The convex shape constant (:FRACTURE_CONVEX_BOX:, :FRACTURE_CONVEX_CIRCLE: or :FRACTURE_CONVEX_HULL:) |
| `cols` | :Real: | The number of columns |
| `rows` | :Real: | The number of rows |
| `[noiseX]` | :Real: | The horizontal grid noise intensity, from 0 to 1 [Default: `1`] |
| `[noiseY]` | :Real: | The vertical grid noise intensity, from 0 to 1 [Default: `noiseX`] |

:::code-group
```js [Example]
// Fill the full sprite area with a clean grid
Fracture.ConvexGrid(inst, FRACTURE_CONVEX_BOX, 6, 4, 0); // [!code highlight]

// A noisy grid clipped to the circle boundary
Fracture.ConvexGrid(inst, FRACTURE_CONVEX_CIRCLE, 5, 5); // [!code highlight]

// A grid clipped to the convex hull, more noise on the x axis
Fracture.ConvexGrid(inst, FRACTURE_CONVEX_HULL, 6, 6, 1, 0.4); // [!code highlight]
```
:::

---
### `.ConvexBrick()`

> `Fracture.ConvexBrick(inst, shape, cols, rows, [horizontal])` ➜ :Array: of :Piece:

<PatternRow pattern="Brick"/>

Fractures the given convex instance into a brick pattern of Pieces clipped to the shape boundary, defined by the number of columns and rows.

Horizontal layout offsets every other row, vertical layout offsets every other column.

| Parameter | Type | Description |
| --- | --- | --- |
| `inst` | :Id.Instance: | The instance to fracture |
| `shape` | :Real: | The convex shape constant (:FRACTURE_CONVEX_BOX:, :FRACTURE_CONVEX_CIRCLE: or :FRACTURE_CONVEX_HULL:) |
| `cols` | :Real: | The number of columns |
| `rows` | :Real: | The number of rows |
| `[horizontal]` | :Bool: | Whether bricks are laid horizontally (`true`) or vertically (`false`) [Default: `true`] |

:::code-group
```js [Example]
// A classic horizontal brick wall
Fracture.ConvexBrick(inst, FRACTURE_CONVEX_BOX, 6, 4); // [!code highlight]

// Vertical bricks clipped to the circle boundary
Fracture.ConvexBrick(inst, FRACTURE_CONVEX_CIRCLE, 4, 6, false); // [!code highlight]

// Horizontal bricks clipped to the convex hull
Fracture.ConvexBrick(inst, FRACTURE_CONVEX_HULL, 5, 5); // [!code highlight]
```
:::

---
### `.ConvexDiamond()`

> `Fracture.ConvexDiamond(inst, shape, cols, rows)` ➜ :Array: of :Piece:

<PatternRow pattern="Diamond"/>

Fractures the given convex instance into a diamond pattern of Pieces clipped to the shape boundary, defined by the number of columns and rows.

| Parameter | Type | Description |
| --- | --- | --- |
| `inst` | :Id.Instance: | The instance to fracture |
| `shape` | :Real: | The convex shape constant (:FRACTURE_CONVEX_BOX:, :FRACTURE_CONVEX_CIRCLE: or :FRACTURE_CONVEX_HULL:) |
| `cols` | :Real: | The number of columns |
| `rows` | :Real: | The number of rows |

:::code-group
```js [Example]
// A 6x6 diamond lattice filling the full sprite area
Fracture.ConvexDiamond(inst, FRACTURE_CONVEX_BOX, 6, 6); // [!code highlight]

// Diamonds clipped to the circle boundary
Fracture.ConvexDiamond(inst, FRACTURE_CONVEX_CIRCLE, 5, 5); // [!code highlight]

// Diamonds clipped to the convex hull
Fracture.ConvexDiamond(inst, FRACTURE_CONVEX_HULL, 4, 4); // [!code highlight]
```
:::

---
### `.ConvexHex()`

> `Fracture.ConvexHex(inst, shape, cols, rows, [flat])` ➜ :Array: of :Piece:

<PatternRow pattern="Hex"/>

Fractures the given convex instance into a [Hexagonal](https://en.wikipedia.org/wiki/Hexagonal_tiling) pattern of Pieces clipped to the shape boundary, defined by the number of columns and rows.

| Parameter | Type | Description |
| --- | --- | --- |
| `inst` | :Id.Instance: | The instance to fracture |
| `shape` | :Real: | The convex shape constant (:FRACTURE_CONVEX_BOX:, :FRACTURE_CONVEX_CIRCLE: or :FRACTURE_CONVEX_HULL:) |
| `cols` | :Real: | The number of columns |
| `rows` | :Real: | The number of rows |
| `[flat]` | :Bool: | Whether hexagons are flat-topped (`true`) or pointy-topped (`false`) [Default: `true`] |

:::code-group
```js [Example]
// Flat-topped hexagons filling the full sprite area
Fracture.ConvexHex(inst, FRACTURE_CONVEX_BOX, 6, 6); // [!code highlight]

// Pointy-topped hexagons clipped to the circle boundary
Fracture.ConvexHex(inst, FRACTURE_CONVEX_CIRCLE, 5, 5, false); // [!code highlight]

// Flat-topped hexagons clipped to the convex hull
Fracture.ConvexHex(inst, FRACTURE_CONVEX_HULL, 8, 8); // [!code highlight]
```
:::

---
### `.ConvexRadial()`

> `Fracture.ConvexRadial(inst, shape, pieceCount, [angleNoise], [originX], [originY])` ➜ :Array: of :Piece:

<PatternRow pattern="Radial"/>

Fractures the given convex instance into a radial pattern of Pieces clipped to the shape boundary, defined by the number of Pieces.

Optional noise varies the angular size of each Piece, and an optional point sets the radial origin. The instance center is used if no origin is provided.

| Parameter | Type | Description |
| --- | --- | --- |
| `inst` | :Id.Instance: | The instance to fracture |
| `shape` | :Real: | The convex shape constant (:FRACTURE_CONVEX_BOX:, :FRACTURE_CONVEX_CIRCLE: or :FRACTURE_CONVEX_HULL:) |
| `pieceCount` | :Real: | The number of Pieces |
| `[angleNoise]` | :Real: | The angular noise intensity, from 0 to 1 [Default: `0`] |
| `[originX]` | :Real: | The world-space x position of the radial origin [Default: instance center] |
| `[originY]` | :Real: | The world-space y position of the radial origin [Default: instance center] |

:::code-group
```js [Example]
// An even radial burst from the center
Fracture.ConvexRadial(inst, FRACTURE_CONVEX_BOX, 12); // [!code highlight]

// A noisy radial burst clipped to the circle boundary
Fracture.ConvexRadial(inst, FRACTURE_CONVEX_CIRCLE, 16, 0.5); // [!code highlight]

// A radial burst originating from the mouse, clipped to the convex hull
Fracture.ConvexRadial(inst, FRACTURE_CONVEX_HULL, 14, 0, mouse_x, mouse_y); // [!code highlight]
```
:::

---
### `.ConvexSlice()`

> `Fracture.ConvexSlice(inst, shape, pieceCount, [cutAngle])` ➜ :Array: of :Piece:

<PatternRow pattern="Slice"/>

Fractures the given convex instance into a series of parallel slices clipped to the shape boundary, defined by the number of Pieces.

A fixed angle produces consistent results, a random angle produces natural-looking variation.

| Parameter | Type | Description |
| --- | --- | --- |
| `inst` | :Id.Instance: | The instance to fracture |
| `shape` | :Real: | The convex shape constant (:FRACTURE_CONVEX_BOX:, :FRACTURE_CONVEX_CIRCLE: or :FRACTURE_CONVEX_HULL:) |
| `pieceCount` | :Real: | The number of Pieces |
| `[cutAngle]` | :Real: | The angle of the slice cuts in degrees [Default: `random(360)`] |

:::code-group
```js [Example]
// Vertical slices filling the full sprite area
Fracture.ConvexSlice(inst, FRACTURE_CONVEX_BOX, 8, 90); // [!code highlight]

// Randomly angled slices clipped to the circle boundary
Fracture.ConvexSlice(inst, FRACTURE_CONVEX_CIRCLE, 6); // [!code highlight]

// Horizontal slices clipped to the convex hull
Fracture.ConvexSlice(inst, FRACTURE_CONVEX_HULL, 10, 0); // [!code highlight]
```
:::

---
### `.ConvexVoronoi()`

> `Fracture.ConvexVoronoi(inst, shape, pieceCount, [noise])` ➜ :Array: of :Piece:

<PatternRow pattern="Voronoi"/>

Fractures the given convex instance into a [Voronoi](https://en.wikipedia.org/wiki/Voronoi_diagram) pattern of Pieces clipped to the shape boundary, defined by the number of cells.

Optional noise randomizes seed positions. `0` produces a perfect grid, `1` is most organic.

| Parameter | Type | Description |
| --- | --- | --- |
| `inst` | :Id.Instance: | The instance to fracture |
| `shape` | :Real: | The convex shape constant (:FRACTURE_CONVEX_BOX:, :FRACTURE_CONVEX_CIRCLE: or :FRACTURE_CONVEX_HULL:) |
| `pieceCount` | :Real: | The number of Voronoi cells |
| `[noise]` | :Real: | The seed noise intensity, from 0 to 1 [Default: `1`] |

:::code-group
```js [Example]
// A fully organic shatter filling the full sprite area
Fracture.ConvexVoronoi(inst, FRACTURE_CONVEX_BOX, 20); // [!code highlight]

// A semi-regular shatter clipped to the circle boundary
Fracture.ConvexVoronoi(inst, FRACTURE_CONVEX_CIRCLE, 12, 0.5); // [!code highlight]

// A near-grid shatter clipped to the convex hull
Fracture.ConvexVoronoi(inst, FRACTURE_CONVEX_HULL, 16, 0.2); // [!code highlight]
```
:::