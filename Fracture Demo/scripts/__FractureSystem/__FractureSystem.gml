// feather ignore all

function __FractureSystem() {
	static _system = {
		__collisionGroup: FRACTURE_COLLISION_GROUP,
		__density: FRACTURE_DENSITY,
		__restitution: FRACTURE_RESTITUTION,
		__friction: FRACTURE_FRICTION,
		__linearDamping: FRACTURE_LINEAR_DAMPING,
		__angularDamping: FRACTURE_ANGULAR_DAMPING,
		
		__impulseForce: FRACTURE_IMPULSE_FORCE,
		__impulseX: undefined,
		__impulseY: undefined,
	}
	return _system;
}
