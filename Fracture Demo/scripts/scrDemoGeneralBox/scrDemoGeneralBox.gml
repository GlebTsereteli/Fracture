
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
	cols = 4;
	rows = 8;
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
function DemoGeneralBoxDiamond() : DemoGeneralPattern("Diamond") constructor {
	cols = 3;
	rows = 3;
	
	static Init = function() {
		dbg_slider_int(ref_create(self, "cols"), 2, 20, "Columns");
		dbg_slider_int(ref_create(self, "rows"), 2, 20, "Rows");
	};
	static GetArguments = function() {
		return [cols, rows];
	};
}
function DemoGeneralBoxHex() : DemoGeneralPattern("Hex") constructor {
    cols = 4;
    rows = 4;
    pointy = false;
	
    static Init = function() {
        dbg_slider_int(ref_create(self, "cols"), 3, 10, "Columns");
        dbg_slider_int(ref_create(self, "rows"), 3, 10, "Rows");
        dbg_checkbox(ref_create(self, "pointy"), "Pointy");
    };
    static GetArguments = function() {
        return [cols, rows, pointy];
    };
}
function DemoGeneralBoxRadial() : DemoGeneralPattern("Radial") constructor {
    bodyCount = 8;
    angleNoise = 0.5;
    
    static Init = function() {
        dbg_slider_int(ref_create(self, "bodyCount"), 3, 20, "Body Count");
        dbg_slider(ref_create(self, "angleNoise"), 0, 1, "Angle Noise", 0.05);
    };
    static GetArguments = function() {
        return [bodyCount, angleNoise, mouse_x, mouse_y];
    };
}
function DemoGeneralBoxSlice() : DemoGeneralPattern("Slice") constructor {
    count = 8;
    angle = 45;
    
    static Init = function() {
        dbg_slider_int(ref_create(self, "count"), 2, 20, "Count");
        dbg_slider_int(ref_create(self, "angle"), 0, 180, "Angle", 5);
    };
    static GetArguments = function() {
        return [count, angle];
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
