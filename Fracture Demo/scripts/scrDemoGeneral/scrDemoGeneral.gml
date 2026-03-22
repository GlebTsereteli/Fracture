
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
		var _names = array_map(shapes, function(_shape) {
			return _shape.name;
		});
		dbg_drop_down(ref_create(self, "shape"), shapes, _names, "Shape");
		
		dbg_same_line();
		var _size = 19;
		dbg_button("-", function() {
			var _index = Mod2(array_get_index(shapes, shape) - 1, array_length(shapes));
			shape = shapes[_index];
		}, _size, _size);
		dbg_same_line();
		dbg_button("+", function() {
			var _index = Mod2(array_get_index(shapes, shape) + 1, array_length(shapes));
			shape = shapes[_index];
		}, _size, _size);
		
		shape.RefreshInterface();
	};
	
	// custom
	shapes = [
		new DemoGeneralBox(),
		new DemoGeneralCircle(),
		//new DemoGeneralConvexSprite(),
		//new DemoGeneralConcaveSprite(),
	];
	shape = array_first(shapes);
	prevShape = shape;
}
