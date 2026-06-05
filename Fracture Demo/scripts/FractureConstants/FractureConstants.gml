// feather ignore all

// This script lists all constants provided by Fracture and describes what they do.
// It is used internally by the library, and its contents should not be modified.

#region Convex Shapes

// Convex module shape constants. Passed as the shape argument to FractureConvex<Pattern>() functions.
// Use the shape that best matches the target sprite. BOX is fastest and suits rectangles, CIRCLE suits
// circular areas, and HULL suits convex polygons that are neither.

// Rectangle, fills the full sprite area. No clipping, fastest.
#macro FRACTURE_CONVEX_BOX 0

// Circle, radius is half the largest sprite dimension. Clips pieces to the circle boundary, slower than BOX.
#macro FRACTURE_CONVEX_CIRCLE 1

// Convex polygon, clipped to the sprite's convex hull. Clips pieces to the hull boundary, slowest.
#macro FRACTURE_CONVEX_HULL 2

#endregion
