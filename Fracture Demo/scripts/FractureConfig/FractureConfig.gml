// feather ignore all
// Documentation: https://glebtsereteli.github.io/Fracture/api/config

#region Defaults: General

// Default depth to render all Fracture Pieces at. 
// Defaults to a high value close to the '-16000' depth limit so Pieces are initially visible in most cases.
// Change it with Fracture.RenderAt() to target the desired depth (or layer) target.
#macro FRACTURE_DEFAULT_DEPTH -15000

// Default outward impulse strength applied to each Piece after fracturing.
#macro FRACTURE_DEFAULT_IMPULSE_STRENGTH 0

#endregion
#region Defaults: Physics

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

#endregion
#region Defaults: Fade

// Default fade timing: begin fading only once a Piece has come to rest (true) or immediately after its delay (false).
#macro FRACTURE_DEFAULT_FADE_AFTER_SETTLE true

// Default minimum random delay in steps before a Piece begins fading.
#macro FRACTURE_DEFAULT_FADE_DELAY_FROM 25

// Default maximum random delay in steps before a Piece begins fading.
#macro FRACTURE_DEFAULT_FADE_DELAY_TO 45

// Default minimum random alpha decrease per step while a Piece fades.
// Set both speed values to 0 to disable fading.
#macro FRACTURE_DEFAULT_FADE_SPEED_FROM 0.02

// Default maximum random alpha decrease per step while a Piece fades.
#macro FRACTURE_DEFAULT_FADE_SPEED_TO 0.03

#endregion
#region Miscellaneous

// Log the time taken for each fracture call to the Output window (true) or not (false).
// Defaults to enabled when running the game from the IDE.
#macro FRACTURE_BENCHMARK (GM_build_type == "run")

#endregion
