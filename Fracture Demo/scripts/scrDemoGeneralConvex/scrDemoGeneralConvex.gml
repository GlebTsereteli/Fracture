
function DemoGeneralConvex() : DemoGeneralShape("Convex") constructor {
	// shared
	static Update = function() {
		if (type != prevType) {
			prevType = type;
			objDemoControl.RefreshInterface();
		}
	};
	static RefreshInterface = function() {
		var _names = array_map(types, function(_type) {
			return _type.name;
		});
		dbg_drop_down(ref_create(self, "type"), types, _names, "Type");
			
		dbg_same_line();
		var _size = 19;
		dbg_button("-", function() {
			var _index = Mod2(array_get_index(types, type) - 1, array_length(types));
			type = types[_index];
		}, _size, _size);
		dbg_same_line();
		dbg_button("+", function() {
			var _index = Mod2(array_get_index(types, type) + 1, array_length(types));
			type = types[_index];
		}, _size, _size);
			
		type.Init();
	};
	static Fracture = function(_inst) {
		var _t = get_timer();
		
		var _args = type.GetArguments(_inst);
		array_insert(_args, 0, _inst);
		method_call(type.func, _args);
		
		show_debug_message((get_timer() - _t) / 1000);
	};
	
	// custom
	types = [
		new DemoGeneralConvexVoronoi(),
	];
	type = array_first(types);
	prevType = type;
}

function DemoGeneralConvexType(_name) constructor {
	name = _name;
	func = asset_get_index($"FractureConvex{name}");
	
	static Init = Noop;
	static GetArguments = function() {
		return [];
	};
}
function DemoGeneralConvexVoronoi() : DemoGeneralConvexType("Voronoi") constructor {
    bodyCount = 10;
	
    static Init = function() {
        dbg_slider_int(ref_create(self, "bodyCount"), 3, 20, "Body Count");
    };
    static GetArguments = function() {
        return [bodyCount];
    };
}
