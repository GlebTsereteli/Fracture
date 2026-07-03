
function DemoImpulse(_strength = 0) constructor {
	strength = _strength;
	onMouse = true;
	
	static Set = function(_x, _y) {
		Fracture.Impulse(strength,
			onMouse ? _x : undefined,
			onMouse ? _y : undefined
		);
	}
	static RefreshInterface = function() {
		dbg_text_separator("Impulse");
		dbg_slider(ref_create(self, "strength"), 0, 3, "Strength", 0.1);
		dbg_checkbox(ref_create(self, "onMouse"), "Mouse Origin");
	};
}
