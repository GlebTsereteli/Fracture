# Pieces

## What Is a Piece?

A Piece is a physics-enabled instance of the internal `__FracturePiece` object created by all fracturing methods. Each Piece gets a Box2D fixture matching the region it was clipped to, and draws its own portion of the [shared vertex buffer](/topics/rendering#the-vertex-buffer) built at fracture time.

Piece behaviors are controlled through :Settings:, :Lifecycle:, and :Config:.

---

When Pieces are created at fracture time, the original instance is destroyed as part of that call, and the method returns an array of Piece instances created in its place.

:Physics: Settings are assigned to each Piece's fixture at the moment it's created, and :Impulse: is applied to explode Pieces outwards from the origin.

:::tip
If :FRACTURE_AUTO_RESET: is enabled (the default), Physics and Impulse Settings reset to their defaults automatically after every fracturing method.

Call :.Physics(): or :.Impulse(): again before each fracture if you want custom values to carry over, or set :FRACTURE_AUTO_RESET: to `false` to disable auto resetting.
:::

## Settling and Fading

By default, Pieces don't last forever. Every Piece runs through a fade timer and is destroyed automatically once it finishes fading.

Fade behavior is configured per-fracture with :.Fade():, which sets the settle, delay, and speed values for the next batch of Pieces.

Default values are defined in the [Defaults: Fade](/api/config#defaults-fade) config macros.

- If `afterSettle` is enabled (the default), a Piece waits until its physics body [settles](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/Physics_Variables/phy_sleeping.htm) before starting its fade delay.
- If disabled, the fade delay starts immediately after creation, regardless of whether the Piece is still moving.
- The delay itself is a random value between the configured `delayFrom` and `delayTo` steps.
- Once the delay elapses, the Piece's alpha decreases each step by a random value between `speedFrom` and `speedTo`, until it reaches zero and the Piece is destroyed.

Call :.ForceFade(): to skip straight to fading on all existing Pieces, bypassing the settle check and delay entirely.

## Pausing

Most games need to be paused at some point, and you probably don't want Pieces flying around while the rest of the game is frozen.

- :.Pause(): stops all existing Pieces from progressing through settling and fading, freezing their fade timers and settle checks in place.
- :.Resume(): continues them from where they left off.

::: warning PHYSICS SIMULATION
These methods don't affect the Box2D simulation itself, so Pieces will keep moving as normal.

The physics simulation can be paused and resumed via the [`physics_pause_enable()`](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/The_Physics_World/physics_pause_enable.htm) function, which should be a part of your overall game pausing workflow.
:::

## Cleanup

A Piece is destroyed by finishing its fade, or immediately via :.Clear():. :.ForceFade(): triggers fading early but still fades over the Piece's speed value.

Each Piece holds a reference to the vertex buffer it shares with the other Pieces from the same fracture call. Once every Piece from that call has been destroyed, the buffer itself is freed automatically.