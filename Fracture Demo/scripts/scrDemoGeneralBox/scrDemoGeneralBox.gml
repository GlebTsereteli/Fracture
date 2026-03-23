
function DemoGeneralBox() : DemoGeneralShape("Box") constructor {
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
		new DemoGeneralBoxGrid(),
		new DemoGeneralBoxZigzag(),
		new DemoGeneralBoxBrick(),
		new DemoGeneralBoxVoronoi(),
	];
	pattern = array_first(patterns);
	prevPattern = pattern;
}

function DemoGeneralBoxGrid() : DemoGeneralPattern("Grid") constructor {
	cols = 4;
	rows = 4;
	noiseX = 1;
	noiseY = noiseX;
	
	static Init = function() {
		dbg_slider_int(ref_create(self, "cols"), 2, 20, "Columns");
		dbg_slider_int(ref_create(self, "rows"), 2, 20, "Rows");
		dbg_slider(ref_create(self, "noiseX"), 0, 1, "Noise X", 0.05);
		dbg_slider(ref_create(self, "noiseY"), 0, 1, "Noise Y", 0.05);
	};
	static GetArguments = function() {
		return [cols, rows, noiseX, noiseY];
	};
}
function DemoGeneralBoxZigzag() : DemoGeneralPattern("Zigzag") constructor {
	count = 8;
	horizontal = true;
	noise = 0.5;
	
	static Init = function() {
		dbg_slider_int(ref_create(self, "count"), 2, 20, "Count");
		dbg_checkbox(ref_create(self, "horizontal"), "Horizontal");
		dbg_slider(ref_create(self, "noise"), 0, 1, "Noise", 0.05);
	};
	static GetArguments = function() {
		return [count, horizontal, noise];
	};
}
function DemoGeneralBoxBrick() : DemoGeneralPattern("Brick") constructor {
	cols = 3;
	rows = 5;
	horizontal = true;
	
	static Init = function() {
		dbg_slider_int(ref_create(self, "cols"), 2, 20, "Columns");
		dbg_slider_int(ref_create(self, "rows"), 2, 20, "Rows");
		dbg_checkbox(ref_create(self, "horizontal"), "Horizontal");
	};
	static GetArguments = function() {
		return [cols, rows, horizontal];
	};
}
function DemoGeneralBoxVoronoi() : DemoGeneralPattern("Voronoi") constructor {
	bodyCount = 10;
	
	static Init = function() {
		dbg_slider_int(ref_create(self, "bodyCount"), 2, 20, "Body Count");
	};
	static GetArguments = function() {
		return [bodyCount];
	};
}
