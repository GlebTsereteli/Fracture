// feather ignore all

function DemoSandbox() : Demo("Sandbox") constructor {
	// Shared
	Update = function() {
		if (shape != prevShape) {
			prevShape = shape;
			objDemoControl.RefreshInterface();
		}
		
		shape.Update();
		blast.Update();
		
		if (not is_mouse_over_debug_overlay()) {
			// Spawn
			if (mouse_check_button_pressed(mb_left)) {
				instance_create_depth(mouse_x, mouse_y, -1000, shape.object);
			}
			
			// Fracture
			if (mouse_check_button_pressed(mb_right)) {
				with (instance_position(mouse_x, mouse_y, objDemoSandboxShapeParent)) {
					other.Fracture(id);
				}
			}
		}
	};
	Draw = function() {
		shape.Draw();
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
			
			with (objDemoSandboxShapeParent) {
				other.Fracture(id);
			}
			
			impulse.onMouse = _prevOnMouse;
		}, _w, _h);
		dbg_same_line();
		dbg_button("Clear", function() {
			instance_destroy(objDemoSandboxShapeParent);
			instance_destroy(__objFracturePiece);
		}, _w, _h);
		
		dbg_text(" Press [LMB] to spawn a shape.");
		dbg_text(" Press [RMB] on a shape to fracture it.");
		dbg_text_separator("");
		
		DbgSelector("Shape", shapes);
		shape.RefreshInterface();
		
		impulse.RefreshInterface();
		blast.RefreshInterface();
	};
	
	// Custom
	shapes = [
		new DemoSandboxShapeBox(),
		new DemoSandboxShapeCircle(),
		new DemoSandboxShapeConvex(),
	];
	shape = array_first(shapes);
	prevShape = shape;
	
	impulse = new DemoImpulse();
	blast = new DemoSandboxBlast();
	
	array_foreach(shapes, function(_shape) {
		_shape.Init();
	});
	
	Fracture = function(_inst) {
		impulse.Set(mouse_x, mouse_y);
		
		var _index = array_find_index(shapes, method({_inst}, function(_shapeClass) {
			return (_inst.object_index == _shapeClass.object);
		}));
		with (shapes[_index]) {
			Fracture(_inst);
		}
	};
}
