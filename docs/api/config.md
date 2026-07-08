# Configuration

This page provides an overview of all Fracture configuration macros. These settings control the default render depth, :.Physics():, :.Impulse():, and :.Fade(): behavior, plus runtime logging.

## Defaults: General

General Piece defaults that don't belong to a specific settings group.

### `FRACTURE_DEFAULT_DEPTH`
> Default: `-15000`.

Default depth to render all Fracture :Pieces: at. Defaults to a high value close to the `-16000` depth limit so Pieces are initially visible in most cases.

Change it with :.Layer(): or :.Depth(): to render on the desired layer or depth.

---
### `FRACTURE_DEFAULT_IMPULSE_STRENGTH`
> Default: `0`.

Default outward impulse strength applied to each Piece after fracturing.

::: tip
Read about setting the impulse strength and origin in :.Impulse():.
:::

## Defaults: Physics

Default physics properties assigned to Piece fixtures. Set these at runtime with :.Physics():.

### `FRACTURE_DEFAULT_COLLISION_GROUP`
> Default: `1`.

Default collision group assigned to all Piece fixtures.

---
### `FRACTURE_DEFAULT_DENSITY`
> Default: `0.5`.

Default density assigned to all Piece fixtures.

---
### `FRACTURE_DEFAULT_RESTITUTION`
> Default: `0`.

Default restitution (bounciness) assigned to all Piece fixtures.

---
### `FRACTURE_DEFAULT_FRICTION`
> Default: `0.2`.

Default friction assigned to all Piece fixtures.

---
### `FRACTURE_DEFAULT_LINEAR_DAMPING`
> Default: `0.1`.

Default linear damping assigned to all Piece fixtures.

---
### `FRACTURE_DEFAULT_ANGULAR_DAMPING`
> Default: `0.1`.

Default angular damping assigned to all Piece fixtures.

## Defaults: Fade

Defaults controlling how Pieces fade out and destroy themselves over time. Set these at runtime with :.Fade():.

### `FRACTURE_DEFAULT_FADE_AFTER_SETTLE`
> Default: `true`.

Whether to begin fading only once a Piece has come to rest (`true`) or immediately after its delay (`false`).

---
### `FRACTURE_DEFAULT_FADE_DELAY_FROM`
> Default: `30`.

Minimum random delay in steps before a Piece begins fading.

Each Piece picks a random delay between this and :FRACTURE_DEFAULT_FADE_DELAY_TO: on creation.

---
### `FRACTURE_DEFAULT_FADE_DELAY_TO`
> Default: `40`.

Maximum random delay in steps before a Piece begins fading.

Each Piece picks a random delay between :FRACTURE_DEFAULT_FADE_DELAY_FROM: and this on creation.

---
### `FRACTURE_DEFAULT_FADE_SPEED_FROM`
> Default: `0.02`.

Minimum random alpha decrease per step while a Piece fades. Each Piece picks a random fade speed between this and :FRACTURE_DEFAULT_FADE_SPEED_TO: on creation.

Set both speed values to `0` to disable fading.

---
### `FRACTURE_DEFAULT_FADE_SPEED_TO`
> Default: `0.03`.

Maximum random alpha decrease per step while a Piece fades. Each Piece picks a random fade speed between :FRACTURE_DEFAULT_FADE_SPEED_FROM: and this on creation.

Set both speed values to `0` to disable fading.

## Miscellaneous

Runtime behavior toggles for auto-resetting settings and benchmark logging.

### `FRACTURE_AUTO_RESET`
> Default: `true`.

Whether to automatically reset :.Physics():, :.Impulse(): and :.Fade(): parameters after each fracture call (`true`) or not (`false`).

---
### `FRACTURE_BENCHMARK`
> Default: `(GM_build_type == "run")`.

Whether to log the time taken for each fracture call to the Output window (`true`) or not (`false`).
By default, this is enabled when running the game from the IDE and disabled when running from an EXE.