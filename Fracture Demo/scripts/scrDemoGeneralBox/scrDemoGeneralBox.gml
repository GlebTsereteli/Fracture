
function DemoGeneralBox() : DemoGeneralShape("Box") constructor {
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
		new DemoGeneralBoxGrid(),
		new DemoGeneralBoxZigzag(),
		new DemoGeneralBoxBrick(),
		new DemoGeneralBoxVoronoi(),
	];
	type = array_first(types);
	prevType = type;
}

function DemoGeneralBoxType(_name) constructor {
	name = _name;
	func = asset_get_index($"FractureBox{name}");
	
	static Init = Noop;
	static GetArguments = function() {
		return [];
	};
}
function DemoGeneralBoxGrid() : DemoGeneralBoxType("Grid") constructor {
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
function DemoGeneralBoxZigzag() : DemoGeneralBoxType("Zigzag") constructor {
	count = 4;
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
function DemoGeneralBoxBrick() : DemoGeneralBoxType("Brick") constructor {
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
function DemoGeneralBoxVoronoi() : DemoGeneralBoxType("Voronoi") constructor {
	count = 10;
	noise = 0.4;
	
	static Init = function() {
		dbg_slider_int(ref_create(self, "count"), 2, 20, "Count");
		dbg_slider(ref_create(self, "noise"), 0, 1, "Noise", 0.05);
	};
	static GetArguments = function() {
		return [count, noise];
	};
}
