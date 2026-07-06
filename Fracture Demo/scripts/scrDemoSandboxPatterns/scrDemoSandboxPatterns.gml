// feather ignore all

function DemoSandboxPattern(_name) constructor {
    name = _name;
    methodName = $"Convex{name}";
    
    static Update = Noop;
    static Draw = Noop;
    
    static RefreshInterface = Noop;
    static GetArguments = function() {
        return [];
    };
    
    static Fracture = function(_inst, _shape) {
		var _args = GetArguments();
        array_insert(_args, 0, _inst, _shape);
		
		var _method = static_get(Fracture)[$ methodName];
        method_call(_method, _args);
    };
}

function DemoSandboxPatternGrid() : DemoSandboxPattern("Grid") constructor {
    cols = 4;
    rows = 4;
    noiseX = 1;
    noiseY = noiseX;
    
    static RefreshInterface = function() {
        dbg_slider_int(ref_create(self, "cols"), 2, 10, "Columns");
        dbg_slider_int(ref_create(self, "rows"), 2, 10, "Rows");
        dbg_slider(ref_create(self, "noiseX"), 0, 1, "Noise X", 0.05);
        dbg_slider(ref_create(self, "noiseY"), 0, 1, "Noise Y", 0.05);
    };
    static GetArguments = function() {
        return [cols, rows, noiseX, noiseY];
    };
}
function DemoSandboxPatternBrick() : DemoSandboxPattern("Brick") constructor {
    cols = 4;
    rows = 8;
    horizontal = true;
    
    static RefreshInterface = function() {
        dbg_slider_int(ref_create(self, "cols"), 1, 10, "Columns");
        dbg_slider_int(ref_create(self, "rows"), 1, 10, "Rows");
        dbg_checkbox(ref_create(self, "horizontal"), "Horizontal");
    };
    static GetArguments = function() {
        return [cols, rows, horizontal];
    };
}
function DemoSandboxPatternDiamond() : DemoSandboxPattern("Diamond") constructor {
    cols = 3;
    rows = 3;
    
    static RefreshInterface = function() {
        dbg_slider_int(ref_create(self, "cols"), 2, 10, "Columns");
        dbg_slider_int(ref_create(self, "rows"), 2, 10, "Rows");
    };
    static GetArguments = function() {
        return [cols, rows];
    };
}
function DemoSandboxPatternHex() : DemoSandboxPattern("Hex") constructor {
    cols = 4;
    rows = 4;
	flat = true;
    
    static RefreshInterface = function() {
        dbg_slider_int(ref_create(self, "cols"), 3, 10, "Columns");
        dbg_slider_int(ref_create(self, "rows"), 3, 10, "Rows");
		dbg_checkbox(ref_create(self, "flat"), "Flat");
	};
    static GetArguments = function() {
        return [cols, rows, flat];
    };
}
function DemoSandboxPatternRadial() : DemoSandboxPattern("Radial") constructor {
    pieceCount = 8;
    angleNoise = 0.5;
    
    static RefreshInterface = function() {
        dbg_slider_int(ref_create(self, "pieceCount"), 3, 15, "Piece Count");
        dbg_slider(ref_create(self, "angleNoise"), 0, 1, "Angle Noise", 0.05);
    };
    static GetArguments = function() {
        return [pieceCount, angleNoise, mouse_x, mouse_y];
    };
}
function DemoSandboxPatternSlice() : DemoSandboxPattern("Slice") constructor {
    pieceCount = 8;
    cutAngle = 45;
    
    static RefreshInterface = function() {
        dbg_slider_int(ref_create(self, "pieceCount"), 2, 20, "Piece Count");
        dbg_slider_int(ref_create(self, "cutAngle"), 0, 180, "Angle", 5);
    };
    static GetArguments = function() {
        return [pieceCount, cutAngle];
    };
}
function DemoSandboxPatternVoronoi() : DemoSandboxPattern("Voronoi") constructor {
    pieceCount = 10;
    noise = 1;
    
    static RefreshInterface = function() {
        dbg_slider_int(ref_create(self, "pieceCount"), 2, 30, "Piece Count");
        dbg_slider(ref_create(self, "noise"), 0, 1, "Noise", 0.05);
    };
    static GetArguments = function() {
        return [pieceCount, noise];
    };
}
