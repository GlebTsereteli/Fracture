
function DemoSandboxBlast() constructor {
	x = undefined;
	y = undefined;
	radius = 100;
	force = 2;
	showTimer = 0;
	
	static Update = function() {
		showTimer = max(showTimer - 1, 0);
		
		if (keyboard_check_pressed(ord("B"))) {
			FractureBlast(mouse_x, mouse_y, radius, force);

			x = mouse_x;
			y = mouse_y;
			showTimer = 5;
		}
	};
	static Draw = function() {
		if (showTimer > 0) {
			draw_set_color(c_red);
			draw_set_alpha(0.3);
			draw_circle(x, y, radius, false);
			draw_set_alpha(1);
			draw_circle(x, y, radius, true);
			draw_set_color(c_white);
		}
	};
	static RefreshInterface = function() {
		dbg_text_separator("Blast");
		
		dbg_slider_int(ref_create(self, "radius"), 50, 300, "Radius", 25);
		dbg_slider(ref_create(self, "force"), -2, 2, "Force", 0.1);
	};
}
