# Configuration

This page provides an overview of all Fracture configuration macros. These settings control the default :Physics(): properties applied to Fracture Pieces, how Pieces fade out and destroy themselves, and runtime logging.

## Default Settings

### `FRACTURE_DEFAULT_DEPTH`
> Default: `-15000`.

Default depth to render all Fracture Pieces at. Defaults to a high value close to the `-16000` depth limit so Pieces are initially visible in most cases.

Change it with :.Layer(): or :.Depth(): to target the desired layer/depth target.

---
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

---
### `FRACTURE_DEFAULT_IMPULSE_STRENGTH`
> Default: `0`.

Default outward impulse strength applied to each Piece after fracturing.

::: tip
Read about setting the impulse strength and origin in :Impulse():.
:::

## Fade

### `FRACTURE_FADE_ENABLED`
> Default: `true`.

Whether to automatically fade out Pieces over time and destroy them when faded (`true`) or not (`false`).

---
### `FRACTURE_FADE_SETTLED`
> Default: `true`.

Whether to begin fading only once a Piece has come to rest (`true`) or immediately after its delay (`false`).

---
### `FRACTURE_FADE_DELAY_FROM`
> Default: `30`.

Minimum random delay in steps before a Piece begins fading.

---
### `FRACTURE_FADE_DELAY_TO`
> Default: `40`.

Maximum random delay in steps before a Piece begins fading.

---
### `FRACTURE_FADE_SPEED_FROM`
> Default: `0.02`.

Minimum random alpha decrease per step while a Piece fades.

---
### `FRACTURE_FADE_SPEED_TO`
> Default: `0.03`.

Maximum random alpha decrease per step while a Piece fades.

## Miscellaneous

### `FRACTURE_AUTO_RESET`
> Default: `true`.

Whether to automatically reset :Physics(): and :Impulse(): parameters after each fracture call (`true`) or not (`false`).

---
### `FRACTURE_BENCHMARK`
> Default: `(GM_build_type == "run")`.

Whether to log the time taken for each fracture call to the Output window (`true`) or not (`false`).
By default, this is enabled when running the game from the IDE and disabled when running from an EXE.