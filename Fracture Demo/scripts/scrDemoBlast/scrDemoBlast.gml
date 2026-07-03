
function DemoBlast() constructor {
	x = undefined;
	y = undefined;
	radius = 150;
	strength = 2;
	showTimer = 0;
	
	static Update = function() {
		static _fx = (function() {
			var _fx = physics_fixture_create();
			physics_fixture_set_sensor(_fx, true);
			return _fx;
		})();
		
		showTimer = max(showTimer - 1, 0);
		
		if (keyboard_check_pressed(ord("B"))) {
			with (instance_create_depth(mouse_x, mouse_y, 0, objDemoBlast)) {
			    physics_fixture_set_circle_shape(_fx, other.radius);
			    physics_fixture_set_collision_group(_fx, Fracture.__physics.__collisionGroup);
			    fixture = physics_fixture_bind(_fx, id);
				strength = other.strength;
			}
			
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
		dbg_section("Blast");
		
		dbg_slider_int(ref_create(self, "radius"), 50, 500, "Radius", 25);
		dbg_slider(ref_create(self, "strength"), -2, 2, "Strength", 0.1);
		dbg_text(" Press [B] to Blast Pieces around the mouse.");
	};
}
