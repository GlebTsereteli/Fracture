
function DemoGeneral() : Demo("General") constructor {
	// shared
	Update = function() {
		if (shape != prevShape) {
			prevShape = shape;
			objDemoControl.RefreshInterface();
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
		new DemoGeneralConvexSprite(),
		new DemoGeneralConcaveSprite(),
	];
	shape = array_first(shapes);
	prevShape = shape;
}
