
function DemoGeneralConvexVoronoi() : DemoGeneralPattern("Voronoi") constructor {
    bodyCount = 10;
	
    static Init = function() {
        dbg_slider_int(ref_create(self, "bodyCount"), 3, 20, "Body Count");
    };
    static GetArguments = function() {
        return [bodyCount];
    };
}
