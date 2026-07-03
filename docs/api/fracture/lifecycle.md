# Lifecycle

## Overview

This section covers the Lifecycle methods that manage existing Fracture Pieces after they've been created.
* [Clear](#clear) destroys all Pieces instantly.
* [Fade](#fade) begins fading all Pieces out.
* [Pause](#pause) and [Resume](#resume) freeze and unfreeze Piece fade processing.

All Lifecycle methods apply to all existing Pieces.

## Methods

### `.Clear()`

> `Fracture.Clear()` ➜ :Struct:.:Fracture:

Destroys all existing Fracture Pieces immediately.

Use it to wipe debris whenever you need a clean slate.

---
### `.Fade()`

> `Fracture.Fade()` ➜ :Struct:.:Fracture:

Begins fading out all existing Fracture Pieces immediately.

Use it for a soft clear that lets debris fade out gradually instead of instantly vanishing.

::: warning
:FRACTURE_FADE_ENABLED: must be enabled for this to work. It is enabled by default.
:::

---
### `.Pause()`

> `Fracture.Pause()` ➜ :Struct:.:Fracture:

Pauses fade processing on all existing Fracture Pieces.

This only halts fading. It does not pause the physics world itself, so Pieces keep moving. Pair it with [physics_pause_enable(true)](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/The_Physics_World/physics_pause_enable.htm) to completely freeze Pieces in place.

:::code-group
```js [Example]
// A function for pausing the game
function PauseGame() {
	global.paused = true;

	physics_pause_enable(true);
	Fracture.Pause(); // [!code highlight]
	audio_pause_all();

	// Other pausing logic...
}
```
:::

---
### `.Resume()`

> `Fracture.Resume()` ➜ :Struct:.:Fracture:

Resumes fade processing on all paused Fracture Pieces.

Pair it with [physics_pause_enable(false)](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/The_Physics_World/physics_pause_enable.htm) to resume the physics simulation alongside fading.

:::code-group
```js [Example]
// A function for resuming the game
function ResumeGame() {
	global.paused = false;

	physics_pause_enable(false);
	Fracture.Resume(); // [!code highlight]
	audio_resume_all();

	// Other resuming logic...
}
```
:::