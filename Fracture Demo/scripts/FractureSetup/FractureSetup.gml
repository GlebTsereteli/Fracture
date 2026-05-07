// feather ignore all

function FractureDepth(_depth) {
	__FRACTURE_CATCH_RENDERER;
	__objFractureRenderer.depth = _depth;
}

function FractureLayer(_layer) {
	__FRACTURE_CATCH_RENDERER;
	__objFractureRenderer.layer = _layer;
}

function FracturePieceConfig(_config) {
	with (__FractureSystem()) {
		__collisionGroup = _config[$ "collisionGroup"] ?? __collisionGroup;
		__density = _config[$ "density"] ?? __density;
		__restitution = _config[$ "restitution"] ?? __restitution;
		__friction = _config[$ "friction"] ?? __friction;
		__linearDamping = _config[$ "linearDamping"] ?? __linearDamping;
		__angularDamping = _config[$ "angularDamping"] ?? __angularDamping;
	}
}

function FracturePieceReset() {
	with (__FractureSystem()) {
		__collisionGroup = FRACTURE_COLLISION_GROUP;
		__density = FRACTURE_DENSITY;
		__restitution = FRACTURE_RESTITUTION;
		__friction = FRACTURE_FRICTION;
		__linearDamping = FRACTURE_LINEAR_DAMPING;
		__angularDamping = FRACTURE_ANGULAR_DAMPING;
	}
}

function FractureImpulse(_force, _direction = undefined) {
	with (__FractureSystem()) {
		__impulseForce = _force;
		__impulseDir = _direction;
	}
}

function FractureImpulseReset() {
	with (__FractureSystem()) {
		__impulseForce = __FRACTURE_IMPULSE_FORCE;
		__impulseDir = __FRACTURE_IMPULSE_DIR;
	}
}
