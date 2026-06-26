// feather ignore all
// Documentation: https://glebtsereteli.github.io/Fracture/pages/api/config

#region Parameters

// Default collision group assigned to all Piece fixtures.
#macro FRACTURE_DEFAULT_COLLISION_GROUP 1

// Default density assigned to all Piece fixtures.
#macro FRACTURE_DEFAULT_DENSITY 0.5

// Default restitution (bounciness) assigned to all Piece fixtures.
#macro FRACTURE_DEFAULT_RESTITUTION 0

// Default friction assigned to all Piece fixtures.
#macro FRACTURE_DEFAULT_FRICTION 0.2

// Default linear damping assigned to all Piece fixtures.
#macro FRACTURE_DEFAULT_LINEAR_DAMPING 0.1

// Default angular damping assigned to all Piece fixtures.
#macro FRACTURE_DEFAULT_ANGULAR_DAMPING 0.1

// Default outward impulse force applied to each Piece after fracturing.
#macro FRACTURE_DEFAULT_IMPULSE_FORCE 0

// Automatically reset Piece and Impulse parameters after each fracture call (true) or not (false).
#macro FRACTURE_AUTO_RESET true

#endregion
#region Piece Fade

// Automatically fade out and destroy Pieces over time (true) or not (false).
#macro FRACTURE_FADE_ENABLED true

// Begin fading only once a Piece has come to rest (true) or immediately after its delay (false).
#macro FRACTURE_FADE_SETTLED true

// Minimum random delay in steps before a Piece begins fading.
#macro FRACTURE_FADE_DELAY_FROM 30

// Maximum random delay in steps before a Piece begins fading.
#macro FRACTURE_FADE_DELAY_TO 40

// Minimum random alpha decrease per step while a Piece fades.
#macro FRACTURE_FADE_SPEED_FROM 0.02

// Maximum random alpha decrease per step while a Piece fades.
#macro FRACTURE_FADE_SPEED_TO 0.03

#endregion
#region Miscellaneous

// Log the time taken for each fracture call to the Output window (true) or not (false).
#macro FRACTURE_BENCHMARK true

#endregion
