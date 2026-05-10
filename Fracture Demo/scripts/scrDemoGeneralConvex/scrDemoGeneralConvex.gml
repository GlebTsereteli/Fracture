// feather ignore all

function DemoGeneralConvexGrid() : DemoGeneralPattern("Grid") constructor {
	static Init = function() {
		cols = 4;
		rows = 4;
		noiseX = 1;
		noiseY = 1;
		
		dbg_slider_int(ref_create(self, "cols"), 1, 20, "Cols");
		dbg_slider_int(ref_create(self, "rows"), 1, 20, "Rows");
		dbg_slider(ref_create(self, "noiseX"), 0, 1, "Noise X");
		dbg_slider(ref_create(self, "noiseY"), 0, 1, "Noise Y");
	}
	
	static GetArguments = function() {
		return [cols, rows, noiseX, noiseY];
	}
}
function DemoGeneralConvexRadial() : DemoGeneralPattern("Radial") constructor {
	pieceCount = 8;
	angleNoise = 0.5;

	static Init = function() {
		dbg_slider_int(ref_create(self, "pieceCount"), 3, 15, "Piece Count");
		dbg_slider(ref_create(self, "angleNoise"), 0, 1, "Angle Noise", 0.05);
	};
	static GetArguments = function() {
		return [pieceCount, angleNoise, mouse_x, mouse_y];
	};
}
function DemoGeneralConvexVoronoi() : DemoGeneralPattern("Voronoi") constructor {
    pieceCount = 10;
	
    static Init = function() {
        dbg_slider_int(ref_create(self, "pieceCount"), 3, 20, "Piece Count");
    };
    static GetArguments = function() {
        return [pieceCount];
    };
}
