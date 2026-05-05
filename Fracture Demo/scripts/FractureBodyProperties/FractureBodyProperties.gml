// feather ignore all

function FractureBodyConfigure(_config) {
	static _params = __FractureBodyParams();
	
	with (_params) {
		collisionGroup = _config[$ "collisionGroup"] ?? collisionGroup;
		density = _config[$ "density"] ?? density;
		restitution = _config[$ "restitution"] ?? restitution;
		friction = _config[$ "friction"] ?? friction;
		linearDamping = _config[$ "linearDamping"] ?? linearDamping;
		angularDamping = _config[$ "angularDamping"] ?? angularDamping;
	}
}

function FractureBodyReset() {
	static _params = __FractureBodyParams();
	static _defaults = __FractureBodyDefaultParams();
	
	with (_params) {
		collisionGroup = _defaults.collisionGroup;
		density = _defaults.density;
		restitution = _defaults.restitution;
		friction = _defaults.friction;
		linearDamping = _defaults.linearDamping;
		angularDamping = _defaults.angularDamping;
	}
}
