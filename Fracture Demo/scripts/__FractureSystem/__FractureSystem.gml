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
		__impulseDir: __FRACTURE_IMPULSE_DIR,
	}
	return _system;
}
