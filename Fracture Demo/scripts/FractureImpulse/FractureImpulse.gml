// feather ignore all

function FractureImpulse(_force, _x = undefined, _y = undefined) {
	with (__FractureSystem()) {
		__impulseForce = _force;
		__impulseX = _x;
		__impulseY = _y;
	}
}

function FractureImpulseReset() {
	with (__FractureSystem()) {
		__impulseForce = __FRACTURE_IMPULSE_FORCE;
		__impulseX = __FRACTURE_IMPULSE_X;
		__impulseY = __FRACTURE_IMPULSE_Y;
	}
}
