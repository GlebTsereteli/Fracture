
function DemoGeneralConvexVoronoi() : DemoGeneralPattern("Voronoi") constructor {
    pieceCount = 10;
	
    static Init = function() {
        dbg_slider_int(ref_create(self, "pieceCount"), 3, 20, "Piece Count");
    };
    static GetArguments = function() {
        return [pieceCount];
    };
}
