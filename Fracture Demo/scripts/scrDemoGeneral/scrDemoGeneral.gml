
function DemoGeneral() : Demo("General") constructor {
	// shared
	Update = function() {
		if (shape != prevShape) {
			prevShape = shape;
			objDemoControl.RefreshInterface();
		}
		
		if (not is_mouse_over_debug_overlay()) {
			// spawn & fracture
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
					_shapeClass.Fracture(_shape);
				}
			}
			// destroy
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
	};
	
	// custom
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
}
function DemoGeneralPattern(_name) constructor {
	name = _name;
	func = undefined;
	
	static Init = Noop;
	static GetArguments = function() {
		return [];
	};
}
