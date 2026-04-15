
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
		DbgSelector("Pattern", patterns);
		
		pattern.Init();
	};
	static Fracture = function(_inst) {
		var _args = pattern.GetArguments(_inst);
		array_insert(_args, 0, _inst);
		var _result = method_call(pattern.func, _args);
	};
}
