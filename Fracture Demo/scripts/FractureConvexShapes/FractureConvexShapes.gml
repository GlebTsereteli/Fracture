// feather ignore all

// This script defines the shape constants for the Convex fracturing module.
// They are used internally by the library, and their values MUST NOT be modified.
// Pass these as the 'shape' argument to 'Fracture.Convex<Pattern>()' methods.

// Rectangle, fills the full sprite area. No clipping, fastest. Best for rectangular sprites.
#macro FRACTURE_CONVEX_BOX 0

// Circle, radius is half the largest sprite dimension.
// Clips pieces to the circle boundary, slower than Box. Best for circular sprites.
#macro FRACTURE_CONVEX_CIRCLE 1

// Convex polygon. Clips pieces to the sprite's convex hull, slower than Box and Circle.
// Best for sprites that are neither rectangular nor circular.
#macro FRACTURE_CONVEX_HULL 2
