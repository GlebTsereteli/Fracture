
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
