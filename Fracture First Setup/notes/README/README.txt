# Welcome

Welcome to Fracture v1.0.0 First Setup!

This project is the example built in the [Getting Started](https://glebtsereteli.github.io/Fracture/home/gettingStarted/gettingStarted) page of the documentation, which walks you through installing Fracture and fracturing your first instance step by step.

For a more complete picture of what Fracture can do, check out the demo project. It can be downloaded or played in the browser on the [itch page](https://glebtsereteli.itch.io/fracture).

## What's Included

- `objShape` is the object we're breaking. It randomizes its scale and frame, and fractures itself on mouse click.
- `objControl` sets the Fracture [rendering layer](https://glebtsereteli.github.io/Fracture/topics/rendering) and restarts the room.
- `objWall` seals the room so Pieces have something to collide against. Physics enabled with Density `0`.
- `rmDemo` is the example room. It has Room Physics enabled and Pixels To Meters set to `0.01`.

## Instructions

- Click a shape to fracture it. Each click picks a random pattern (Grid, Radial, or Voronoi) and applies an impulse from the mouse.
- Press `R` to restart the room.

## Need Help?

If you have questions or need help implementing Fracture into your game, feel free to contact me on the [GameMaker Kitchen](https://discord.gg/8krYCqr) Discord server.