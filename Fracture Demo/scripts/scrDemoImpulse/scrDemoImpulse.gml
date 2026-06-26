
function DemoImpulse(_force = 0) constructor {
	force = _force;
	onMouse = true;
	
	static Set = function(_x, _y) {
		Fracture.Impulse(force,
			onMouse ? _x : undefined,
			onMouse ? _y : undefined
		);
	}
	static RefreshInterface = function() {
		dbg_text_separator("Impulse");
		dbg_slider(ref_create(self, "force"), 0, 2, "Force", 0.1);
		dbg_checkbox(ref_create(self, "onMouse"), "Mouse Origin");
	};
}
