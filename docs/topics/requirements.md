# Requirements

Fracture is a fairly specific library. It makes certain assumptions about how your project is structured, and expects a few things to be prepared before you fracture anything.

---

Keep the following in mind for it to work as expected:

- Room Physics must be enabled in any room where Fracture is used.
- Only instances with a valid sprite assigned can be fractured.
- Instances with negative `image_xscale` or `image_yscale` can not currently be fractured. Negative scale support is planned for a future version.
- All Pieces render on a single shared layer and depth. This generally isn't an issue for side-scrolling or space-like top-down games. Depth sorting with other instances is not supported.
- Fracture doesn't create any world geometry for you., and you'll need walls or colliders with physics fixtures for Pieces to collide and bounce against. If your walls aren't physics-enabled, Pieces will only collide with each other and fall straight through the map.
