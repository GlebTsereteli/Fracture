
function DemoGeneralCircleRadial() : DemoGeneralPattern("Radial") constructor {
    slices = 8;
    angleNoise = 0.5;
	
    static Init = function() {
        dbg_slider_int(ref_create(self, "slices"), 3, 20, "Slices");
        dbg_slider(ref_create(self, "angleNoise"), 0, 1, "Angle Noise", 0.05);
    };
    static GetArguments = function() {
        return [slices, angleNoise, mouse_x, mouse_y];
    };
}
function DemoGeneralCircleBrick() : DemoGeneralPattern("Brick") constructor {
	cols = 4;
	rows = 8;
	horizontal = true;
	
	static Init = function() {
		dbg_slider_int(ref_create(self, "cols"), 1, 16, "Columns");
		dbg_slider_int(ref_create(self, "rows"), 1, 16, "Rows");
		dbg_checkbox(ref_create(self, "horizontal"), "Horizontal");
	}
	
	static GetArguments = function() {
		return [cols, rows, horizontal];
	}
}
function DemoGeneralCircleVoronoi() : DemoGeneralPattern("Voronoi") constructor {
    pieceCount = 10;
	
    static Init = function() {
        dbg_slider_int(ref_create(self, "pieceCount"), 3, 20, "Piece Count");
    };
    static GetArguments = function() {
        return [pieceCount];
    };
}
