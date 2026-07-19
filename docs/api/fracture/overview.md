# Fracture

## Overview
`Fracture` is the main interface of the library. It handles most library operations and is organized into the following modules:
- :Convex Fracturing: breaks convex-shaped instances (:Box:, :Circle:, or :Hull:) into :Pieces: using one of the available patterns: :Grid:, :Brick:, :Diamond:, :Hex:, :Radial:, :Slice:, and :Voronoi:.
- :Settings: configure the :Physics:, :Mass:, :Impulse:, and :Fade: properties applied to subsequent Fracture calls, plus the :Rendering: layer or depth for all Pieces.
- :Lifecycle: methods control existing :Piece: instances, covering :.Clear():, :.ForceFade():, :.Pause():, and :.Resume():.
- [Config](/api/config) macros set library-wide defaults and behavior.

---

## Syntax
`Fracture` is a global function containing static data variables and methods, effectively acting as a makeshift [namespace](https://learn.microsoft.com/en-us/cpp/cpp/namespaces-cpp?view=msvc-170)-like construct. It's initialized internally and requires no additional setup.

All methods are accessed using the `Fracture.MethodName(arguments...)` syntax:
- Fracture a convex instance: `Fracture.ConvexGrid(inst, FRACTURE_CONVEX_BOX, 4, 4);`.
- Clear all Pieces: `Fracture.Clear();`.

Note the lack of parentheses after `Fracture`. Unlike the classic `function_name()` calls you're used to in GML, this accesses static methods within the `Fracture` interface.

This design offers a single, clean entry point for the entire library, with all internal data and public methods contained within a single "namespace".

Fracture utilizes a [Fluent Interface](https://en.wikipedia.org/wiki/Fluent_interface) pattern, so chainable methods (like :Settings:) can be combined in a single expression before a fracturing call.

::: warning
Don't call `Fracture` methods directly from scripts. GameMaker doesn't guarantee script init order, so `Fracture` may not be initialized when your script runs.

This isn't a real limitation in practice. There's no reason to fracture anything before the first room loads, so you can safely call `Fracture` methods once your target room is initialized.
:::