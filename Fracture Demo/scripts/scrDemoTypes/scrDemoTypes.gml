
function DemoType(_name) constructor {
	name = _name;
	func = asset_get_index($"FractureBox{name}");
	
	static Init = Noop;
	static GetArguments = function() {
		return [];
	};
}
function DemoTypeGrid() : DemoType("Grid") constructor {
	cols = 3;
	rows = 3;
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
function DemoTypeZigzag() : DemoType("Zigzag") constructor {
	count = 5;
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
function DemoTypeBrick() : DemoType("Brick") constructor {
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
function DemoTypeVoronoi() : DemoType("Voronoi") constructor {
	count = 10;
	
	static Init = function() {
		dbg_slider_int(ref_create(self, "count"), 2, 20, "Count");
	};
	static GetArguments = function() {
		return [count];
	};
}
