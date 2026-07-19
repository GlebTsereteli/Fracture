# Settings

## Overview

This section covers the Settings methods that configure how Fracture Pieces are created, behave and render, from their physics and initial impulse to how they fade over time.

---
#### Per-Fracture Settings

Per-fracture settings apply to Pieces created by the next fracturing call, then reset to their defaults automatically.
- [.Physics()](#physics) controls the :physics properties: (collision group, density, restitution, friction, damping), letting you define different-feeling Piece "materials".
- [.Mass()](#mass) overrides the density-derived mass, so Pieces of any size get the same mass.
- [.Impulse()](#impulse) controls the impulse strength and origin, producing fractures ranging from gentle nudges to explosive shatters.
- [.Fade()](#fade) controls how Pieces fade out and destroy themselves over time.

Per-fracture settings never persist. Each fracturing call consumes them and restores the defaults, so tweaks can't leak into later calls. Reusable configs live in your own code, not in Fracture.

---
#### Global Settings

Global settings persist until changed.
- [.RenderAt()](#renderat) controls the layer or depth all Pieces render on.

---
::: tip FLUENT INTERFACE
Fracture utilizes a [Fluent Interface](https://en.wikipedia.org/wiki/Fluent_interface) pattern, so all Settings methods are chainable and can be combined in a single expression before a fracturing call.

```js
// Configure physics and impulse, then fracture
Fracture
.Physics({ // [!code highlight]
	density: 2,
	restitution: 0.4
})
.Impulse(2, mouse_x, mouse_y) // [!code highlight]
.ConvexVoronoi(inst, FRACTURE_CONVEX_HULL, 12);
```
:::

## Per-Fracture

### `.Physics()`

> `Fracture.Physics(config)` ➜ :Struct:.:Fracture:

Sets the [physics fixture properties](https://manual.gamemaker.io/beta/en/GameMaker_Language/GML_Reference/Physics/Fixtures/Fixtures.htm#:~:text=physics_fixture_add_point-,Setting%20Properties,-In%20order%20for) (collision group, density, restitution, friction, damping) applied to the next fracturing call, letting you define different-feeling Piece "materials". Existing Pieces are not affected.

Takes a struct so you can define different Piece materials or feels (stone, rubber, etc) as reusable configs and pass them in as needed.

Any omitted fields remain at their current values. :Physics properties: reset to their defaults after the next fracturing call.

| Parameter | Type | Description |
| --- | --- | --- |
| `config` | :Struct: | The physics configuration struct for Fracture Pieces |

Accepted `config` fields:

| Field | Type | Description |
| --- | --- | --- |
| `collisionGroup` | :Real: | The Piece fixture [collision group](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/Fixtures/physics_fixture_set_collision_group.htm). [Default: :FRACTURE_DEFAULT_COLLISION_GROUP:] |
| `density` | :Real: | The Piece fixture [density](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/Fixtures/physics_fixture_set_density.htm). [Default: :FRACTURE_DEFAULT_DENSITY:] |
| `restitution` | :Real: | The Piece fixture [restitution](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/Fixtures/physics_fixture_set_restitution.htm). [Default: :FRACTURE_DEFAULT_RESTITUTION:] |
| `friction` | :Real: | The Piece fixture [friction](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/Fixtures/physics_fixture_set_friction.htm). [Default: :FRACTURE_DEFAULT_FRICTION:] |
| `linearDamping` | :Real: | The Piece fixture [linear damping](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/Fixtures/physics_fixture_set_linear_damping.htm). [Default: :FRACTURE_DEFAULT_LINEAR_DAMPING:] |
| `angularDamping` | :Real: | The Piece fixture [angular damping](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/Fixtures/physics_fixture_set_angular_damping.htm). [Default: :FRACTURE_DEFAULT_ANGULAR_DAMPING:] |

Defaults are defined by the [Defaults: Physics](/api/config#defaults-physics) config macros.

:::code-group
```js [Literal]
// Set physics properties, then fracture into rubbery Pieces
Fracture.Physics({ // [!code highlight]
	density: 0.8,
	friction: 1.2,
	restitution: 0.9
})
.ConvexGrid(wheelInstance, FRACTURE_CONVEX_CIRCLE, 4, 4);
```
```js [Global]
// Somewhere in your global material definitions
global.stoneFixture = {
	density: 4,
	friction: 0.9,
	restitution: 0.05
};

// Set physics properties, then fracture into heavy stone Pieces
Fracture.Physics(global.stoneFixture) // [!code highlight]
.ConvexRadial(boulderInstance, FRACTURE_CONVEX_HULL, 16);
```
:::

---
### `.Mass()`

> `Fracture.Mass(mass)` ➜ :Struct:.:Fracture:

Sets the [mass](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/physics_mass_properties.htm) applied to Pieces in the next fracturing call. Existing Pieces are not affected.

By default a Piece's mass comes from its density and area, so smaller Pieces are lighter. Setting a mass overrides that, giving every Piece the same mass regardless of its size.

This can be useful when you fracture instances at wildly different scales and want them all to feel the same.

The mass resets after the next fracturing call, returning Pieces to density-derived mass.

| Parameter | Type | Description |
| --- | --- | --- |
| `mass` | :Real: | The mass applied to each Fracture Piece, or `undefined` to derive it from density and area |

:::code-group
```js [Example]
// Every Piece weighs the same, no matter how big the instance is
Fracture
.Mass(0.5) // [!code highlight]
.ConvexVoronoi(inst, FRACTURE_CONVEX_HULL, 10);
```
:::

---
### `.Impulse()`

> `Fracture.Impulse(strength, [x], [y])` ➜ :Struct:.:Fracture:

Sets the impulse strength and origin applied to all Pieces in the next fracturing call, producing fractures ranging from gentle nudges to explosive shatters. Existing Pieces are not affected.

The impulse pushes Pieces outward from the origin at fracture time. The instance center is used if no origin is provided.

`strength` is applied in newtons via [physics_apply_impulse](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/Forces/physics_apply_impulse.htm), so its feel depends on your world's [pixel-to-meter ratio](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/The_Physics_World/physics_world_create.htm) and each Piece's density (set via :.Physics():) or mass (set via :.Mass():). Experiment to find values that feel good for your game.

The impulse resets to its default after the next fracturing call. The default strength is defined in :FRACTURE_DEFAULT_IMPULSE_STRENGTH:, and the default origin is the instance center.

| Parameter | Type | Description |
| --- | --- | --- |
| `strength` | :Real: | The strength of the impulse applied to Fracture Pieces |
| `[x]` | :Real: | The world x position of the impulse origin [Default: instance center] |
| `[y]` | :Real: | The world y position of the impulse origin [Default: instance center] |

:::code-group
```js [Example]
// Blast Pieces from the instance center
Fracture.Impulse(1).ConvexRadial(inst, FRACTURE_CONVEX_CIRCLE, 16); // [!code highlight]

// Blast Pieces from a specific point (e.g. explosion position)
Fracture.Impulse(1.5, x, y).ConvexVoronoi(inst, FRACTURE_CONVEX_HULL, 10); // [!code highlight]
```
:::

---
### `.Fade()`

> `Fracture.Fade(config)` ➜ :Struct:.:Fracture:

Sets how Pieces created by the next fracturing call fade out and destroy themselves over time. Existing Pieces are not affected.

Each Piece picks a random delay and fade speed from the configured ranges on creation, so a single fracture produces Pieces that fade at slightly different times and rates.

Any omitted fields remain at their current values. Fade properties reset to their defaults after the next fracturing call.

| Parameter | Type | Description |
| --- | --- | --- |
| `config` | :Struct: | The fade configuration struct for Fracture Pieces |

Accepted `config` fields:

| Field | Type | Description |
| --- | --- | --- |
| `afterSettle` | :Bool: | Begin fading only once a Piece has come to rest (`true`) or immediately after its delay (`false`). [Default: :FRACTURE_DEFAULT_FADE_AFTER_SETTLE:] |
| `delay` | :Real: | Sets both `delayFrom` and `delayTo` to a single value. |
| `delayFrom` | :Real: | Minimum random delay in steps before a Piece begins fading. [Default: :FRACTURE_DEFAULT_FADE_DELAY_FROM:] |
| `delayTo` | :Real: | Maximum random delay in steps before a Piece begins fading. [Default: :FRACTURE_DEFAULT_FADE_DELAY_TO:] |
| `speed` | :Real: | Sets both `speedFrom` and `speedTo` to a single value. |
| `speedFrom` | :Real: | Minimum random alpha decrease per step while a Piece fades. [Default: :FRACTURE_DEFAULT_FADE_SPEED_FROM:] |
| `speedTo` | :Real: | Maximum random alpha decrease per step while a Piece fades. [Default: :FRACTURE_DEFAULT_FADE_SPEED_TO:] |

Explicit `delayFrom`/`delayTo` and `speedFrom`/`speedTo` take precedence over `delay`/`speed`.

Defaults are defined by the [Defaults: Fade](/api/config#defaults-fade) config macros.

::: tip
Set both speed values to `0` to disable fading, so Pieces persist until cleared with :.Clear():. Note that :.ForceFade(): also has no effect on speed-`0` Pieces, since they have no fade rate to apply.
:::

:::code-group
```js [Examples]
// Fade quickly right after fracturing, ignoring settle
Fracture.Fade({ // [!code highlight]
	afterSettle: false,
	delay: 0,
	speed: 0.1
})
.ConvexVoronoi(inst, FRACTURE_CONVEX_HULL, 30);

// Long-lived debris that lingers before a slow fade
Fracture.Fade({ // [!code highlight]
	delayFrom: 120,
	delayTo: 240,
	speed: 0.01
})
.ConvexBrick(inst, FRACTURE_CONVEX_BOX, 6, 4);

// Uniform timing, no variation between Pieces
Fracture.Fade({ // [!code highlight]
	delay: 60,
	speed: 0.02
})
.ConvexGrid(inst, FRACTURE_CONVEX_BOX, 5, 5);

// Persistent Pieces that never fade on their own
Fracture.Fade({ // [!code highlight]
	speed: 0
})
.ConvexRadial(inst, FRACTURE_CONVEX_CIRCLE, 12);

// Wide random spread for a staggered fade
Fracture.Fade({ // [!code highlight]
	delayFrom: 10,
	delayTo: 90,
	speedFrom: 0.015,
	speedTo: 0.05
})
.ConvexHex(inst, FRACTURE_CONVEX_HULL, 8, 8);
```
:::

## Global

### `.RenderAt()`

> `Fracture.RenderAt(layerOrDepth)` ➜ :Struct:.:Fracture:

Sets the layer or depth to render **all** Fracture Pieces on, persisting until changed.

Pass a :Real: for a depth, or a layer ID or name for a layer. Anything else throws an error.

| Parameter | Type | Description |
| --- | --- | --- |
| `layerOrDepth` | :Real:, :Id.Layer: or :String: | The depth value, or the layer ID or name, to render all Fracture Pieces on |

:::code-group
```js [Layer]
// Render Pieces on the "Debris" layer, by name or by ID
Fracture.RenderAt("Debris"); // [!code highlight]
Fracture.RenderAt(layer_get_id("Debris")); // [!code highlight]
```
```js [Depth]
// Somewhere in your macros script
#macro DEPTH_DEBRIS 1000

// Render Pieces at 'DEPTH_DEBRIS'
Fracture.RenderAt(DEPTH_DEBRIS); // [!code highlight]
```
:::