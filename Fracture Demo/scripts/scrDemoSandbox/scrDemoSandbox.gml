// feather ignore all

function DemoSandbox() : Demo("Sandbox") constructor {
    // Shared
	Update = function() {
        if (pattern != prevPattern or shape != prevShape) {
            prevPattern = pattern;
            prevShape = shape;
            objDemoControl.RefreshInterface();
        }
        
        pattern.Update();
        blast.Update();
        
        if (not is_mouse_over_debug_overlay()) {
			// Spawn
            if (mouse_check_button_pressed(mb_left)) {
                instance_create_depth(mouse_x, mouse_y, -1000, shape.object);
            }
            
			// Fracture
            if (mouse_check_button_pressed(mb_right)) {
                with (instance_position(mouse_x, mouse_y, objDemoSandboxShapeParent)) {
                    other.Fracture(id);
                }
            }
        }
    };
    Draw = function() {
        pattern.Draw();
        blast.Draw();
    };
    RefreshInterface = function() {
        var _w = 90;
        var _h = 20;
        dbg_button("Spawn", function() {
            var _pad = 150;
            repeat (5) {
                var _x = random_range(_pad, room_width - _pad);
                var _y = random_range(_pad, room_height - _pad);
                instance_create_depth(_x, _y, 0, shape.object);
            }
        }, _w, _h);
        dbg_same_line();
        dbg_button("Fracture", function() {
            var _prevOnMouse = impulse.onMouse;
            impulse.onMouse = false;
            
            with (objDemoSandboxShapeParent) {
                other.Fracture(id);
            }
            
            impulse.onMouse = _prevOnMouse;
        }, _w, _h);
        dbg_same_line();
        dbg_button("Fade", function() {
			Fracture.Fade();
        }, _w, _h);
        dbg_same_line();
        dbg_button("Clear", function() {
            instance_destroy(objDemoSandboxShapeParent);
			Fracture.Clear();
        }, _w, _h);
        
        dbg_text(" Press [LMB] to spawn a shape.");
        dbg_text(" Press [RMB] on a shape to fracture it.");
        
		dbg_text_separator("Pattern & Shape");
        DbgSelector("Pattern", patterns);
        DbgSelector("Shape", shapes);
        pattern.RefreshInterface();
		
        physics.RefreshInterface();
        impulse.RefreshInterface();
        blast.RefreshInterface();
    };
    
    // Custom
    patterns = [
        new DemoSandboxPatternGrid(),
        new DemoSandboxPatternBrick(),
        new DemoSandboxPatternDiamond(),
        new DemoSandboxPatternHex(),
        new DemoSandboxPatternRadial(),
        new DemoSandboxPatternSlice(),
        new DemoSandboxPatternVoronoi(),
    ];
    pattern = array_first(patterns);
    prevPattern = pattern;
    
    shapes = [
        new DemoSandboxShape("Box", FRACTURE_CONVEX_BOX),
        new DemoSandboxShape("Circle", FRACTURE_CONVEX_CIRCLE),
        new DemoSandboxShape("Hull", FRACTURE_CONVEX_HULL),
    ];
    shape = array_first(shapes);
    prevShape = shape;
    
	physics = new DemoPhysics();
    impulse = new DemoImpulse();
	blast = new DemoBlast();
    
    Fracture = function(_inst) {
		physics.Set();
        impulse.Set(mouse_x, mouse_y);
        pattern.Fracture(_inst, shape.constant);
    };
}
