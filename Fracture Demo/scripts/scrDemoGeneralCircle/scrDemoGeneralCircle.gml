
function DemoGeneralCircle() : DemoGeneralShape("Circle") constructor {
	// shared
	static Update = function() {
		if (pattern != prevPattern) {
			prevPattern = pattern;
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
		var _names = array_map(patterns, function(_pattern) {
			return _pattern.name;
		});
		dbg_drop_down(ref_create(self, "pattern"), patterns, _names, "Pattern");
			
		dbg_same_line();
		var _size = 19;
		dbg_button("-", function() {
			var _index = Mod2(array_get_index(patterns, pattern) - 1, array_length(patterns));
			pattern = patterns[_index];
		}, _size, _size);
		dbg_same_line();
		dbg_button("+", function() {
			var _index = Mod2(array_get_index(patterns, pattern) + 1, array_length(patterns));
			pattern = patterns[_index];
		}, _size, _size);
			
		pattern.Init();
	};
	static Fracture = function(_inst) {
		var _t = get_timer();
		
		var _args = pattern.GetArguments(_inst);
		array_insert(_args, 0, _inst);
		method_call(pattern.func, _args);
		
		show_debug_message((get_timer() - _t) / 1000);
	};
	
	// custom
	patterns = [
		new DemoGeneralCircleRadial(),
		new DemoGeneralCircleVoronoi(),
	];
	pattern = array_first(patterns);
	prevPattern = pattern;
}

function DemoGeneralCircleRadial() : DemoGeneralPattern("Radial") constructor {
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
function DemoGeneralCircleVoronoi() : DemoGeneralPattern("Voronoi") constructor {
    bodyCount = 10;
	
    static Init = function() {
        dbg_slider_int(ref_create(self, "bodyCount"), 3, 20, "Body Count");
    };
    static GetArguments = function() {
        return [bodyCount];
    };
}
