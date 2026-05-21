// feather ignore all

function DemoSandboxShape(_name, _patterns) constructor {
	name = _name;
	object = asset_get_index($"objDemoSandboxShape{name}");
	patterns = undefined;
	pattern = undefined;
	prevPattern = undefined;
	
	static Init = function() {
		pattern = array_first(patterns);
		prevPattern = pattern;
	};
	static Update = function() {
		if (pattern != prevPattern) {
			prevPattern = pattern;
			objDemoControl.RefreshInterface();
		}
		pattern.Update();
	};
	static Draw = function() {
		pattern.Draw();
	};
	
	static Fracture = function(_inst) {
		pattern.Fracture(_inst);
	};
	static RefreshInterface = function() {
		DbgSelector("Pattern", patterns);
		pattern.RefreshInterface();
	};
}
