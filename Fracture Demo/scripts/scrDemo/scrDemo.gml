
function Demo(_name) constructor {
	name = _name;
	rm = asset_get_index($"rmDemo{name}");
	
	Init = Noop;
	Update = Noop;
	Draw = Noop;
	RefreshInterface = Noop;
}
