# Settings

## Overview

This section covers the Settings methods that configure how Fracture Pieces are created and rendered.
* [Physics](#physics) controls the physics properties (collision group, density, restitution, friction, damping) applied to Pieces created by the next fracturing call, letting you define different-feeling Piece "materials".
* [Impulse](#impulse) controls the impulse strength and origin applied to Pieces created by the next fracturing call, from gentle nudges to explosive shatters.
* [Rendering](#rendering) controls the layer or depth all Pieces render on, persisting until changed.

::: tip AUTO RESET
If [FRACTURE_AUTO_RESET](/api/config) is enabled, :Physics: and :Impulse: settings reset automatically after any core Fracture method. This keeps per-fracture tweaks from leaking into later calls.
:::

::: tip FLUENT INTERFACE
Fracture utilizes a [Fluent Interface](https://en.wikipedia.org/wiki/Fluent_interface) pattern, so all Settings methods are chainable and can be combined in a single expression before a fracturing call.

```js
// Configure physics and impulse, then fracture
Fracture
.Physics({ // [!code highlight]
	density: 2,
	restitution: 0.4
})
.Impulse(60, mouse_x, mouse_y) // [!code highlight]
.ConvexVoronoi(inst, FRACTURE_CONVEX_HULL, 24);
```
:::

## Physics

Physics methods control the [physics fixture properties](https://manual.gamemaker.io/beta/en/GameMaker_Language/GML_Reference/Physics/Fixtures/Fixtures.htm#:~:text=physics_fixture_add_point-,Setting%20Properties,-In%20order%20for) (collision group, density, restitution, friction, damping) applied to Pieces created by the next fracturing call, letting you define different-feeling Piece "materials".

### `.Physics()`

> `Fracture.Physics(config)` ➜ :Struct:.:Fracture:

Sets the physics properties applied to future Fracture Pieces. Existing Pieces are not affected.

Takes a struct so you can define different Piece materials or feels (glass, wood, stone) as reusable configs and pass them in as needed.

Any omitted fields remain at their current values.

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

::: tip
If :FRACTURE_AUTO_RESET: is enabled, physics properties reset automatically after any core Fracture method. Call :.PhysicsReset(): to reset them manually.
:::

:::code-group
```js [Literal]
// Set physics properties
Fracture.Physics({ // [!code highlight]
	density: 0.8,
	friction: 1.2,
	restitution: 0.9
});

// Fracture into rubbery Pieces that bounce on impact
Fracture.ConvexGrid(wheelInstance, FRACTURE_CONVEX_CIRCLE, 4, 4);
```
```js [Global]
// Somewhere in your global material definitions
global.glassFixture = {
	density: 0.5,
	friction: 0.1,
	restitution: 0.05
};

// Set physics properties, then fracture into glass Pieces
Fracture
.Physics(global.glassFixture)
.ConvexRadial(windowInstance, FRACTURE_CONVEX_BOX, 16); // [!code highlight]
```
:::

---
### `.PhysicsReset()`

> `Fracture.PhysicsReset()` ➜ :Struct:.:Fracture:

Resets all Fracture physics properties to their default values. Existing Pieces are not affected.

Defaults are defined by the `FRACTURE_DEFAULT_*` config macros.

::: tip
If :FRACTURE_AUTO_RESET: is enabled, this is called automatically after any core Fracture method.
:::

## Impulse

Controls the impulse strength and origin applied to Pieces created by the next fracturing call, from gentle nudges to explosive shatters.

### `.Impulse()`

> `Fracture.Impulse(strength, [x], [y])` ➜ :Struct:.:Fracture:

Sets the impulse strength and origin applied to all Pieces in the next fracturing call. Existing Pieces are not affected.

The impulse pushes Pieces outward from the origin at fracture time. The instance center is used if no origin is provided.

`strength` is applied in newtons via [physics_apply_impulse](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/Forces/physics_apply_impulse.htm), so its feel depends on your world's [pixel-to-meter ratio](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/The_Physics_World/physics_world_create.htm) and each Piece's density (set via :.Physics():). Experiment to find values that feel good for your game.

::: tip
If :FRACTURE_AUTO_RESET: is enabled, the impulse resets automatically after any core Fracture method. Call :.ImpulseReset(): to reset it manually.
:::

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
### `.ImpulseReset()`

> `Fracture.ImpulseReset()` ➜ :Struct:.:Fracture:

Resets the impulse strength and origin to their default values. Existing Pieces are not affected.

The default strength is defined by the :FRACTURE_DEFAULT_IMPULSE_STRENGTH: config macro, and the default origin is the instance center.

::: tip
If :FRACTURE_AUTO_RESET: is enabled, this is called automatically after any core Fracture method.
:::

## Rendering

Controls the layer or depth all Pieces render on, persisting until changed.

### `.Layer()`

> `Fracture.Layer(layer)` ➜ :Struct:.:Fracture:

Sets the layer to render **all** Fracture Pieces on.

| Parameter | Type | Description |
| --- | --- | --- |
| `layer` | :Id.Layer: or :String: | The layer ID or name to render all Fracture Pieces on |

:::code-group
```js [Example]
// Render Pieces on the "Debris" layer, by name or by ID
Fracture.Layer("Debris"); // [!code highlight]
Fracture.Layer(layer_get_id("Debris")); // [!code highlight]
```
:::

---
### `.Depth()`

> `Fracture.Depth(depth)` ➜ :Struct:.:Fracture:

Sets the depth to render **all** Fracture Pieces at.

| Parameter | Type | Description |
| --- | --- | --- |
| `depth` | :Real: | The depth value to render all Fracture Pieces at |

:::code-group
```js [Example]
// Somewhere in your macros script
#macro DEPTH_DEBRIS 1000

// Render Pieces at 'DEPTH_DEBRIS'
Fracture.Depth(DEPTH_DEBRIS); // [!code highlight]
```
:::