
function DemoPhysics() constructor {
	settings = {
		density: FRACTURE_DEFAULT_DENSITY,
		restitution: FRACTURE_DEFAULT_RESTITUTION,
		friction: FRACTURE_DEFAULT_FRICTION,
		linearDamping: FRACTURE_DEFAULT_LINEAR_DAMPING,
		angularDamping: FRACTURE_DEFAULT_ANGULAR_DAMPING,
	};
	
	static Set = function() {
		Fracture.Physics(settings);
	};
	static RefreshInterface = function() {
		dbg_section("Physics");
		
		var _step = 0.05;
		dbg_slider(ref_create(settings, "density"), _step, 2, "Density", _step);
		dbg_slider(ref_create(settings, "restitution"), 0, 1, "Restitution", _step);
		dbg_slider(ref_create(settings, "friction"), 0, 1, "Friction", _step);
		dbg_slider(ref_create(settings, "linearDamping"), 0, 2, "Linear Damping", _step);
		dbg_slider(ref_create(settings, "angularDamping"), 0, 2, "Angular Damping", _step);
	};
}
