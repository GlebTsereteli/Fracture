// feather ignore all

function DemoGeneral() : Demo("General") constructor {
	// Shared
	Update = function() {
		if (shape != prevShape) {
			prevShape = shape;
			objDemoControl.RefreshInterface();
		}
		
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
		
		shape.Update();
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
		
		DbgSelector("Shape", shapes);
		shape.RefreshInterface();
		
		dbg_text_separator("Impulse");
		dbg_slider(ref_create(impulse, "force"), 0, 2, "Force", 0.1);
		dbg_checkbox(ref_create(impulse, "onMouse"), "Mouse Origin?");
	};
	
	// Custom
	shapes = [
		new DemoGeneralShape("Box", [
			new DemoGeneralBoxGrid(),
			new DemoGeneralBoxBrick(),
			new DemoGeneralBoxZigzag(),
			new DemoGeneralBoxDiamond(),
			new DemoGeneralBoxHex(),
			new DemoGeneralBoxRadial(),
			new DemoGeneralBoxSlice(),
			new DemoGeneralBoxVoronoi(),
		]),
		new DemoGeneralShape("Circle", [
			new DemoGeneralCircleGrid(),
			new DemoGeneralCircleBrick(),
			//new DemoGeneralCircleZigzag(),
			//new DemoGeneralCircleDiamond(),
			//new DemoGeneralCircleHex(),
			new DemoGeneralCircleRadial(),
			//new DemoGeneralCircleSlice(),
			new DemoGeneralCircleVoronoi(),
		]),
		new DemoGeneralShape("Convex", [
			new DemoGeneralConvexGrid(),
			new DemoGeneralConvexBrick(),
			//new DemoGeneralConvexZigzag(),
			//new DemoGeneralConvexDiamond(),
			//new DemoGeneralConvexHex(),
			new DemoGeneralConvexRadial(),
			//new DemoGeneralConvexSlice(),
			new DemoGeneralConvexVoronoi(),
		]),
	];
	shape = array_first(shapes);
	prevShape = shape;
	impulse = {
		force: 0,
		onMouse: true,
	};
	
	Fracture = function(_shape) {
		var _index = array_find_index(shapes, method({_shape}, function(_shapeClass) {
			return (_shape.object_index == _shapeClass.object);
		}));
		var _shapeClass = shapes[_index];
		
		var _impulseX = impulse.onMouse ? mouse_x : undefined;
		var _impulseY = impulse.onMouse ? mouse_y : undefined;
		FractureImpulse(impulse.force, _impulseX, _impulseY);
		_shapeClass.Fracture(_shape);
	};
}
function DemoGeneralPattern(_name) constructor {
	name = _name;
	func = undefined;
	
	static Init = Noop;
	static GetArguments = function() {
		return [];
	};
}
