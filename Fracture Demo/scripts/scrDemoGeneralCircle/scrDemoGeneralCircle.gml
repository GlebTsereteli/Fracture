
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
function DemoGeneralCircleVoronoi() : DemoGeneralPattern("Voronoi") constructor {
    bodyCount = 10;
	
    static Init = function() {
        dbg_slider_int(ref_create(self, "bodyCount"), 3, 20, "Body Count");
    };
    static GetArguments = function() {
        return [bodyCount];
    };
}
