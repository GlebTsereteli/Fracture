// feather ignore all

/// @func FracturePiece()
/// @param {Struct} config The physics configuration struct for Fracture pieces.
/// 
/// @desc Sets the physics properties applied to all future Fracture pieces. Existing pieces are not affected.
/// Accepted fields: collisionGroup, density, restitution, friction, linearDamping, and angularDamping.
/// Any omitted fields remain at their current values.
/// 
/// NOTE: If FRACTURE_AUTO_RESET is enabled, piece properties reset automatically after any core Fracture method.
function FracturePiece(_config) {
	__FRACTURE_PARAMS {
		__collisionGroup = _config[$ "collisionGroup"] ?? __collisionGroup;
		__density = _config[$ "density"] ?? __density;
		__restitution = _config[$ "restitution"] ?? __restitution;
		__friction = _config[$ "friction"] ?? __friction;
		__linearDamping = _config[$ "linearDamping"] ?? __linearDamping;
		__angularDamping = _config[$ "angularDamping"] ?? __angularDamping;
	}
}

/// @func FracturePieceReset()
/// 
/// @desc Resets all Fracture piece physics properties to their default values. Existing pieces are not affected.
/// 
/// NOTE: If FRACTURE_AUTO_RESET is enabled, this is called automatically after any core Fracture method.
function FracturePieceReset() {
	__FRACTURE_PARAMS {
		__collisionGroup = FRACTURE_COLLISION_GROUP;
		__density = FRACTURE_DENSITY;
		__restitution = FRACTURE_RESTITUTION;
		__friction = FRACTURE_FRICTION;
		__linearDamping = FRACTURE_LINEAR_DAMPING;
		__angularDamping = FRACTURE_ANGULAR_DAMPING;
	}
}
