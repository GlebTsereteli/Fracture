// feather ignore all

function FractureImpulse(_force, _x = undefined, _y = undefined) {
	with (__FractureParams()) {
		__impulseForce = _force;
		__impulseX = _x;
		__impulseY = _y;
	}
}

function FractureImpulseReset() {
	with (__FractureParams()) {
		__impulseForce = FRACTURE_IMPULSE_FORCE;
		__impulseX = undefined;
		__impulseY = undefined;
	}
}
