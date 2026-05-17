// feather ignore all

function DemoGeneral() : Demo("General") constructor {
	// Shared
	Update = function() {
		if (pattern != prevPattern) {
			prevPattern = pattern;
			objDemoControl.RefreshInterface();
		}
		
		blast.Update();
		
		if (not is_mouse_over_debug_overlay()) {
			// Spawn & fracture
			if (mouse_check_button_pressed(mb_left)) {
				var _shape = instance_position(mouse_x, mouse_y, objDemoShapeParent);
				if (_shape == noone) {
					instance_create_depth(mouse_x, mouse_y, -1000, shape.object);
				}
				else {
					Fracture(_shape);
				}
			}
			// Destroy
			if (mouse_check_button_pressed(mb_right)) {
				with (instance_position(mouse_x, mouse_y, objDemoShapeParent)) {
					instance_destroy();
				}
			}
		}
	};
	Draw = function() {
		blast.Draw();
	};
	RefreshInterface = function() {
		var _w = 123;
		var _h = 25;
		dbg_button("Spawn", function() {
			var _pad = 150;
			repeat (5) {
				var _x = random_range(_pad, room_width - _pad);
				var _y = random_range(_pad, room_height - _pad);
				instance_create_depth(_x, _y, 0, shape.object);
			}
		}, _w, _h);
		dbg_same_line();
		dbg_button("Fracture", function() {
			var _prevOnMouse = impulse.onMouse;
			impulse.onMouse = false;
			
			with (objDemoShapeParent) {
				other.Fracture(id);
			}
			
			impulse.onMouse = _prevOnMouse;
		}, _w, _h);
		dbg_same_line();
		dbg_button("Clear", function() {
			instance_destroy(objDemoShapeParent);
			instance_destroy(__objFracturePiece);
		}, _w, _h);
		
		DbgSelector("Pattern", patterns);
		DbgSelector("Shape", shapes);
		pattern.RefreshInterface();
		
		dbg_text_separator("Impulse");
		dbg_slider(ref_create(impulse, "force"), 0, 2, "Force", 0.1);
		dbg_checkbox(ref_create(impulse, "onMouse"), "Mouse Origin?");
		
		blast.RefreshInterface();
	};
	
	// Custom
	patterns = [
		new DemoGeneralPatternGrid(),
		new DemoGeneralPatternBrick(),
		new DemoGeneralPatternDiamond(),
		new DemoGeneralPatternHex(),
		new DemoGeneralPatternRadial(),
		new DemoGeneralPatternSlice(),
		new DemoGeneralPatternVoronoi(),
	];
	pattern = array_first(patterns);
	prevPattern = pattern;

	shapes = [
		new DemoGeneralShape("Box"),
		new DemoGeneralShape("Circle"),
		new DemoGeneralShape("Convex"),
	];
	shape = array_first(shapes);
	impulse = {
		force: 0,
		onMouse: true,
	};
	blast = new DemoGeneralBlast();
	
	array_foreach(patterns, function(_pattern) {
		_pattern.Init();
	});
	
	Fracture = function(_shape) {
		var _impulseX = impulse.onMouse ? mouse_x : undefined;
		var _impulseY = impulse.onMouse ? mouse_y : undefined;
		FractureImpulse(impulse.force, _impulseX, _impulseY);
		
		var _index = array_find_index(shapes, method({_shape}, function(_shapeClass) {
			return (_shape.object_index == _shapeClass.object);
		}));
		pattern.Fracture(shapes[_index], _shape);
	};
}
