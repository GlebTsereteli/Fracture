// feather ignore all

function FracturePiece(_config) {
	with (__FractureParams()) {
		__collisionGroup = _config[$ "collisionGroup"] ?? __collisionGroup;
		__density = _config[$ "density"] ?? __density;
		__restitution = _config[$ "restitution"] ?? __restitution;
		__friction = _config[$ "friction"] ?? __friction;
		__linearDamping = _config[$ "linearDamping"] ?? __linearDamping;
		__angularDamping = _config[$ "angularDamping"] ?? __angularDamping;
	}
}

function FracturePieceReset() {
	with (__FractureParams()) {
		__collisionGroup = FRACTURE_COLLISION_GROUP;
		__density = FRACTURE_DENSITY;
		__restitution = FRACTURE_RESTITUTION;
		__friction = FRACTURE_FRICTION;
		__linearDamping = FRACTURE_LINEAR_DAMPING;
		__angularDamping = FRACTURE_ANGULAR_DAMPING;
	}
}
