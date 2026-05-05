
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
					var _index = array_find_index(shapes, method({_shape}, function(_shapeClass) {
						return (_shape.object_index == _shapeClass.object);
					}));
					var _shapeClass = shapes[_index];
					
					var _impulseForce = __FractureSystem().__impulseForce;
					_shapeClass.Fracture(_shape);
					FractureImpulse(_impulseForce);
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
		DbgSelector("Shape", shapes);
		shape.RefreshInterface();
		
		dbg_text_separator("");
		dbg_slider(ref_create(__FractureSystem(), "__impulseForce"), 0, 2, "Impulse Force", 0.1);
	};
	
	// Custom
	shapes = [
		new DemoGeneralShape("Box", [
			new DemoGeneralBoxGrid(),
			new DemoGeneralBoxZigzag(),
			new DemoGeneralBoxBrick(),
			new DemoGeneralBoxDiamond(),
			new DemoGeneralBoxHex(),
			new DemoGeneralBoxRadial(),
			new DemoGeneralBoxSlice(),
			new DemoGeneralBoxVoronoi(),
		]),
		new DemoGeneralShape("Circle", [
			new DemoGeneralCircleRadial(),
			new DemoGeneralCircleVoronoi(),
		]),
		new DemoGeneralShape("Convex", [
			new DemoGeneralConvexVoronoi(),
		]),
	];
	shape = array_first(shapes);
	prevShape = shape;
	impulse = {
		force: 0.5,
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
