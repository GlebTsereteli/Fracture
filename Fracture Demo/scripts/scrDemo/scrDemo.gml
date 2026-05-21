
function Demo(_name) constructor {
	name = _name;
	rm = asset_get_index($"rmDemo{name}");
	
	static Init = Noop;
	static Update = Noop;
	static Draw = Noop;
	static RefreshInterface = Noop;
}
