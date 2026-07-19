// feather ignore all
// Documentation: https://glebtsereteli.github.io/Fracture/api/constants

// This script defines constants used internally by the Fracture library.
// Their values MUST NOT be modified.

#region Convex Shapes

// Shape constants passed as the 'shape' argument to 'Fracture.Convex<Pattern>()' methods.

// Rectangle, fills the full sprite area. No clipping, fastest. Best for rectangular sprites.
#macro FRACTURE_CONVEX_BOX 0

// Circle, radius is half the largest sprite dimension.
// Clips pieces to the circle boundary, slower than Box. Best for circular sprites.
#macro FRACTURE_CONVEX_CIRCLE 1

// Convex polygon. Clips pieces to the sprite's convex hull, slower than Box and Circle.
// Best for sprites that are neither rectangular nor circular.
#macro FRACTURE_CONVEX_HULL 2

#endregion
