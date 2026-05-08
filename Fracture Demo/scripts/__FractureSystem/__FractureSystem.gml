// feather ignore all

function __FractureSystem() {
	static _system = {
		__collisionGroup: FRACTURE_COLLISION_GROUP,
		__density: FRACTURE_DENSITY,
		__restitution: FRACTURE_RESTITUTION,
		__friction: FRACTURE_FRICTION,
		__linearDamping: FRACTURE_LINEAR_DAMPING,
		__angularDamping: FRACTURE_ANGULAR_DAMPING,
		
		__impulseForce: __FRACTURE_IMPULSE_FORCE,
		__impulseX: __FRACTURE_IMPULSE_X,
		__impulseY: __FRACTURE_IMPULSE_Y,
	}
	return _system;
}
