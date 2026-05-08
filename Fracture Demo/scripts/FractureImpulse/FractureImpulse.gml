// feather ignore all

/// @func FractureImpulse()
/// @param {Real} force The force of the impulse applied to Fracture pieces.
/// @param {Real} x The world x position of the impulse origin. [Default: undefined, instance center]
/// @param {Real} y The world y position of the impulse origin. [Default: undefined, instance center]
/// 
/// @desc Sets the impulse force and origin applied to all future Fracture pieces. Existing pieces are not affected.
/// 
/// NOTE: If FRACTURE_AUTO_RESET is enabled, the impulse resets automatically after any core Fracture method.
function FractureImpulse(_force, _x = undefined, _y = undefined) {
	__FRACTURE_PARAMS {
		__impulseForce = _force;
		__impulseX = _x;
		__impulseY = _y;
	}
}

/// @func FractureImpulseReset()
/// 
/// @desc Resets the impulse force and origin to their default values. Existing pieces are not affected.
/// When undefined, the impulse originates from the center of the fractured instance.
/// 
/// NOTE: If FRACTURE_AUTO_RESET is enabled, this is called automatically after any core Fracture method.
function FractureImpulseReset() {
	__FRACTURE_PARAMS {
		__impulseForce = FRACTURE_IMPULSE_FORCE;
		__impulseX = undefined;
		__impulseY = undefined;
	}
}
