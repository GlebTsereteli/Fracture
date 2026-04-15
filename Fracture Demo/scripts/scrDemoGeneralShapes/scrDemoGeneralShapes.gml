
function DemoGeneralShape(_name, _patterns) constructor {
	name = _name;
	object = asset_get_index($"objDemoShape{string_replace_all(name, " ", "")}");
	patterns = _patterns;
	pattern = array_first(patterns);
	prevPattern = pattern;
	
	array_foreach(patterns, function(_pattern) {
		_pattern.func = asset_get_index($"Fracture{name}{_pattern.name}");
	});
	
	static Update = function() {
		if (pattern != prevPattern) {
			prevPattern = pattern;
			objDemoControl.RefreshInterface();
		}
	};
	static RefreshInterface = function() {
		var _names = array_map(patterns, function(_pattern) {
			return _pattern.name;
		});
		dbg_drop_down(ref_create(self, "pattern"), patterns, _names, "Pattern");
			
		dbg_same_line();
		var _size = 19;
		dbg_button("-", function() {
			var _index = Mod2(array_get_index(patterns, pattern) - 1, array_length(patterns));
			pattern = patterns[_index];
		}, _size, _size);
		dbg_same_line();
		dbg_button("+", function() {
			var _index = Mod2(array_get_index(patterns, pattern) + 1, array_length(patterns));
			pattern = patterns[_index];
		}, _size, _size);
		
		pattern.Init();
	};
	static Fracture = function(_inst) {
		var _args = pattern.GetArguments(_inst);
		array_insert(_args, 0, _inst);
		var _result = method_call(pattern.func, _args);
	};
}
