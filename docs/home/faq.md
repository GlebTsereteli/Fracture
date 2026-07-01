# Frequently Asked Questions

This page contains answers to frequently asked questions about Fracture.

## What platforms does Fracture support?

| Platform | Status |
| --- | --- |
| Windows | ✅ Fully supported |
| macOS | ✅ Fully supported |
| Linux | ✅ Fully supported |
| GX.games | ✅ Fully supported |
| Android | 🚧 Untested |
| iOS | 🚧 Untested |
| PS5 | 🚧 Untested |
| Xbox | 🚧 Untested |
| Nintendo Switch | 🚧 Untested |
| HTML5 | ❌ Not planned |

## What versions of GameMaker does Fracture support?

Fracture supports GameMaker version [LTS 2026.0](https://releases.gamemaker.io/release-notes/2026/0) and above.

## How is Fracture licensed? Can I use it in commercial projects?

Fracture is licensed under the [MIT license](https://github.com/glebtsereteli/Fracture/blob/main/LICENSE), granting you full freedom to use it for any purpose, including commercial projects. The only requirement is to include the `Fracture License.txt` file that comes with the library package.

Mentioning my name (Gleb Tsereteli) in your game's credits would be greatly appreciated and would totally make my day, but it's entirely optional 🙂

## How is Fracture versioned?

Fracture follows Semantic Versioning using the `vMAJOR.MINOR.PATCH` format, where:
- **MAJOR** increases when incompatible API changes are introduced. Updating to a new major version may require you to update your code.
- **MINOR** increases when new features are added in a backward-compatible way, so it's always safe to update.
- **PATCH** increases when backward-compatible bug fixes are made. These are also always safe to update to.

## How do I update to the latest version of Fracture?

1. Back up your settings from the `FractureConfig` script.
2. Delete the `Fracture` folder from your project.
3. Repeat the [Installation](/pages/home/gettingStarted/gettingStarted#installation) process.
4. Reapply your config changes in the `FractureConfig` script.

## Can I use Fracture without physics?

No. Fracture is a physics-centric library at this time. Every fracture call creates physics-powered :Piece: instances, and there's no mode that skips physics and returns only the generated geometry.

This may be extended in the future to also expose just piece geometry for custom processing, but that's not a guarantee.

## Do my objects need to be physics-enabled to fracture them?

No. Fracture works on any instance regardless of its physics state, scale, or rotation, and creates the physics bodies for you. If the source instance is itself physics-enabled, its linear and angular velocity carry over to the resulting :Pieces:.

This means Fracture integrates cleanly even into games that don't otherwise use :Physics:.

## What happens to the original instance when I fracture it?

It's destroyed automatically. Every fracture call returns an :Array: of the created :Piece: instances, so you can keep working with them afterwards if needed.
