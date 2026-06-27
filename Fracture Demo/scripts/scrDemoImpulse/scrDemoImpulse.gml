
function DemoImpulse(_power = 0) constructor {
	powerr = _power;
	onMouse = true;
	
	static Set = function(_x, _y) {
		Fracture.Impulse(powerr,
			onMouse ? _x : undefined,
			onMouse ? _y : undefined
		);
	}
	static RefreshInterface = function() {
		dbg_text_separator("Impulse");
		dbg_slider(ref_create(self, "powerr"), 0, 2, "Power", 0.1);
		dbg_checkbox(ref_create(self, "onMouse"), "Mouse Origin");
	};
}
