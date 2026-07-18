# Frequently Asked Questions

This page contains answers to frequently asked questions about Fracture.

## What platforms does Fracture support?

| Platform | Status |
| --- | --- |
| Windows | ✅ Fully supported |
| macOS | ✅ Fully supported |
| Linux | ✅ Fully supported |
| GX.games | ✅ Fully supported |
| HTML5 | ❌ Not planned |
| Android | 🚧 Untested |
| iOS | 🚧 Untested |
| PS5 | 🚧 Untested |
| Xbox | 🚧 Untested |
| Nintendo Switch | 🚧 Untested |

## What versions of GameMaker does Fracture support?

Fracture supports GameMaker version [LTS 2026.0](https://releases.gamemaker.io/release-notes/2026/0) and above.

## How is Fracture licensed? Can I use it in commercial projects?

Fracture is licensed under the [MIT license](https://github.com/glebtsereteli/Fracture/blob/main/LICENSE), granting you full freedom to use it for any purpose, including commercial projects. The only requirement is to include the `Fracture License.txt` file that comes with the library package.

Mentioning my name (Gleb Tsereteli) in your game's credits would be greatly appreciated and would totally make my day, but it's entirely optional 🙂

## How is Fracture versioned?

Fracture follows the [Semantic Versioning](https://semver.org/) (often called **SemVer**) versioning scheme using the `vMAJOR.MINOR.PATCH` format, where:
- **MAJOR** increases when incompatible API changes are introduced. Updating to a new major version may require you to update your code.
- **MINOR** increases when new features are added in a backward-compatible way, so it's always safe to update.
- **PATCH** increases when backward-compatible bug fixes are made. These are also always safe to update to.

## How do I update to the latest version of Fracture?

1. Back up your settings from the `FractureConfig` script.
2. Delete the `Fracture` folder from your project.
3. Repeat the [Installation](/home/gettingStarted/gettingStarted#installation) process.
4. Reapply your config changes in the `FractureConfig` script.

## Can I use Fracture without physics?

Not currently. Fracture is a physics-centric library at this time. Every fracture call creates physics-powered :Piece: instances, and there's no mode that skips physics and returns only the generated geometry.

This will be extended in the future by exposing piece geometry for custom processing. See the [Looking Ahead](/topics/performance.md#looking-ahead) section for more detail.

## Do my objects need to be physics-enabled to fracture them?

No. Fracture works on any instance regardless of its physics state, and creates the physics bodies for you. If the source instance is itself physics-enabled, its linear and angular velocity carry over to the resulting :Pieces:.

This means Fracture integrates cleanly even into games that don't otherwise use :Physics:.

## HELP!

Stuck on something or need a hand with Fracture?

You can get help through any of these channels:
- Reach out on the [GameMaker Kitchen](https://discord.gg/gamemakerkitchen) Discord server.
- Start a topic on the [itch.io board](https://glebtsereteli.itch.io/fracture/community).
- Open a :New Issue: on GitHub with the `help` label.

:::warning DISCLAIMER
Before asking, please read the relevant documentation pages first, and check this FAQ and the [Requirements](/topics/requirements) page to see if your question is already answered there.

My support is limited to questions directly related to Fracture. When it comes to physics setups, gameplay integration, or other general topics, I'm happy to discuss ideas, but not implementation specifics. For those, use any of these:
- The `#help` channels on the [GameMaker](https://discord.com/invite/gamemaker) Discord server.
- The [r/GameMaker](https://www.reddit.com/r/gamemaker/) subreddit.
- The GameMaker [Community Forums](https://forum.gamemaker.io/).
:::
:::tip PERSONAL HELP
If you need a tailored solution for your project, I'm happy to take on both short commissions and longer-term work. DM me to discuss the details:
- Discord `@GlebTsereteli`
- [Twitter](https://x.com/glebtsereteli)
- [Bluesky](https://bsky.app/profile/glebtsereteli.bsky.social)
:::

Found a bug or have a feature request? Please open a :New Issue: with the `bug` or `feature` label.

## Bugs & Feature Requests

- Found a bug? Please open a :New Issue: on GitHub with the `bug` label.
- Got a feature request for something you'd like to see added? Please open a :New Issue: on GitHub with the `feature` label.
