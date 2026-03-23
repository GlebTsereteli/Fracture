
function DemoGeneralCircle() : DemoGeneralShape("Circle") constructor {
	// shared
	static Update = function() {
		if (type != prevType) {
			prevType = type;
			objDemoControl.RefreshInterface();
		}
		
		//if (keyboard_check_pressed(ord("3"))) {
		//	FractureAll();
		//}
		//if (keyboard_check_pressed(ord("4"))) {
		//	DestroyAll();
		//}
	};
	static RefreshInterface = function() {
		var _names = array_map(types, function(_type) {
			return _type.name;
		});
		dbg_drop_down(ref_create(self, "type"), types, _names, "Type");
			
		dbg_same_line();
		var _size = 19;
		dbg_button("-", function() {
			var _index = Mod2(array_get_index(types, type) - 1, array_length(types));
			type = types[_index];
		}, _size, _size);
		dbg_same_line();
		dbg_button("+", function() {
			var _index = Mod2(array_get_index(types, type) + 1, array_length(types));
			type = types[_index];
		}, _size, _size);
			
		type.Init();
	};
	static Fracture = function(_inst) {
		var _t = get_timer();
		
		var _args = type.GetArguments(_inst);
		array_insert(_args, 0, _inst);
		method_call(type.func, _args);
		
		show_debug_message((get_timer() - _t) / 1000);
	};
	
	// custom
	types = [
		new DemoGeneralCircleRadial(),
		new DemoGeneralCircleVoronoi(),
	];
	type = array_first(types);
	prevType = type;
}

function DemoGeneralCircleType(_name) constructor {
	name = _name;
	func = asset_get_index($"FractureCircle{name}");
	
	static Init = Noop;
	static GetArguments = function() {
		return [];
	};
}
function DemoGeneralCircleRadial() : DemoGeneralCircleType("Radial") constructor {
    slices = 8;
    angleNoise = 0.5;
    centerNoise = 0.15;
	
    static Init = function() {
        dbg_slider_int(ref_create(self, "slices"), 3, 20, "Slices");
        dbg_slider(ref_create(self, "angleNoise"), 0, 1, "Angle Noise", 0.05);
        dbg_slider(ref_create(self, "centerNoise"), 0, 0.3, "Center Noise", 0.01);
    };
    static GetArguments = function() {
        return [slices, angleNoise, centerNoise];
    };
}
function DemoGeneralCircleVoronoi() : DemoGeneralCircleType("Voronoi") constructor {
    bodyCount = 10;
    noise = 0.25;
	
    static Init = function() {
        dbg_slider_int(ref_create(self, "bodyCount"), 3, 50, "Body Count");
        dbg_slider(ref_create(self, "noise"), 0, 1, "Noise", 0.05);
    };
    static GetArguments = function() {
        return [bodyCount, noise];
    };
}
