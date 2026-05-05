// feather ignore all

function __FractureBodyDefaultParams() {
	static _params = {
		collisionGroup: FRACTURE_COLLISION_GROUP,
		density: FRACTURE_DENSITY,
		restitution: FRACTURE_RESTITUTION,
		friction: FRACTURE_FRICTION,
		linearDamping: FRACTURE_LINEAR_DAMPING,
		angularDamping: FRACTURE_ANGULAR_DAMPING,
	};
	return _params;
}
function __FractureBodyParams() {
	static _params = variable_clone(__FractureBodyDefaultParams());
	return _params;
}
